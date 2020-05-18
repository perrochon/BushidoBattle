--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
	Game Logic
	
	Remote Play:
	- Supports 2 players (for now), one on Server, one on client
	- Turn based. Server player goes first every turn.
	- Both devices have full game state and sync every turn.
	- Hero Moves and Attacks are calculated locally on player's device and synced
	- Monster Moves and Attacks are calculated on server, and synced 
	- On both devices, ScenePlay.heroes[1] is hero on Server, #2 is hero on client
	  1. Both devices start up, load map (and monsters, for now)
	  2. Server syncs hero and monster location to client
			syncState()
	  3. Server player plays. Results calculated on server and sent to client
			Player turn passes with this call.
			syncTurn()
	  4. Client player plays. Results calculated on client and sent to server
			Player turn passes with this call.
			remoteMoveHero() TODO HEROFIX why not the same as above?
	  5. Monsters calculated on server
	  6. Goto 3
	  
	  7. Ranged attack animation are sent separately TODO HEROFIX
			remoteRangedAttack
	  
	  Victory, death, or quitting ends the remote session and a new one needs to be 
	  started from the lobby. TODO HEROFIX
	  
	  Music from: https://soundimage.org/ need attribution
--]]


ScenePlay = Core.class(Sprite)

ScenePlay.camera = nil -- This smells. TODO FIX. Possibly move camera into WorldMap, so this global goes
 
function ScenePlay:init()

	application:setBackgroundColor(COLOR_LTBLACK)

	-- read the level file
	self.mapData= MapData.new(currentMapFileName) 

	-- FIX move the hero creation/placement stuff out of init into Heroes.lua

	ScenePlay.heroes = {} 
	-- HEROFIX > 2 - heroes[1] will be on the server. heroes[2] on the client

	-- determine if we play locally, as server, or as client
	if serverlink then
		self.remote = true
		if serverlink.servers then
			self.client = true
		else
			self.server = true
		end
	else
	end

	self.ready = false
	
	if self.server then 
		DEBUG("This device is a server")
		localHero = 1
		self.heroes[2] = Player.new(5) -- TOTO HEROFIX this only works for 2 devices
	elseif self.client then 
		DEBUG("This device is a client")
		localHero = 2
		self.heroes[1] = Player.new(5) -- TOTO HEROFIX this only works for 2 devices
	else 
		DEBUG("This device is playing locally") 
		localHero = 1
	end
	
		--the major gaming variables
	self.heroes[localHero] = dataSaver.load(currentHeroFileName)
	
	local x, y
	for _, v in pairs(self.mapData.spawns) do
		if v.type == 1 then
			x = v.x
			y = v.y
			break
		end
	end
	
	DEBUG("Hero Spawn", x, y)

	self.heroes[1].heroTurn = true	
	self.heroes[1].heroIdx = 1
	self.heroes[1].x = x
	self.heroes[1].y = y	
	if self.remote then
		self.heroes[2].heroIdx = 2
		self.heroes[2].heroTurn = false
		self.heroes[2].x = x+1
		self.heroes[2].y = y+1	
	end
		
	-- load monsters -- TODO HEROFIX double monsters when there are two players.
	self.monsters = Monsters.new(self.mapData)

	-- Create the TileMaps and the arrays
	self.world = WorldMap.new(self.mapData, self.heroes, self.monsters)

	self.msg = Messages.new()
	self.sounds = Sounds.new("game")

	--add methods for remote play
	if self.remote then
		--serverlink:addMethod(MOVE_HERO, self.remoteMoveHero, self)
		serverlink:addMethod(SYNC_TURN, self.syncTurn, self)
		serverlink:addMethod(SYNC_STATE, self.syncState, self)	
		--serverlink:addMethod(MONSTER_MOVED, self.syncMonster, self)
	end

	--get everything on the screen
	-- Camera
	self.camera = Camera.new({maxZoom=3,friction=.95}) -- higher seems to make it "more slippery" (documentation says lower).
	self:addChild(self.camera)
	self.camera:addChild(self.world)
	ScenePlay.camera = self.camera -- FIX
	self.world:shiftWorld(self.heroes[localHero])


	self:addChild(self.msg)
	self.main = MainScreen.new(self.heroes[localHero])
	self:addChild(self.main)
	
	if self.remote then
		self.cs = TextField.new(FONT_SMALL, self.server and "S" or "C")
		self.cs :setTextColor(COLOR_DKGREY)	
		self.cs :setPosition(MINX + 20, MAXY - self.cs:getHeight()) 
		self:addChild(self.cs)
	end
	
	if self.client then
		self:enableArrows(false)
	end

	--respond to the compass directions
	self.main.north:addEventListener("click", function() ScenePlay:cheater(0) self:checkMove(self.heroes[localHero], 0, -1) end)
	self.main.south:addEventListener("click", function() ScenePlay:cheater(1) self:checkMove(self.heroes[localHero], 0, 1)  end)
	self.main.west:addEventListener("click", function() ScenePlay:cheater(2) self:checkMove(self.heroes[localHero], -1, 0)  end)
	self.main.east:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(self.heroes[localHero], 1, 0)  end)
	self.main.northwest:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(self.heroes[localHero], -1, -1)  end)
	self.main.northeast:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(self.heroes[localHero], 1, -1)  end)
	self.main.southwest:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(self.heroes[localHero], -1, 1)  end)
	self.main.southeast:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(self.heroes[localHero], 1, 1)  end)
	self.main.center:addEventListener("click", function()
		if ScenePlay:cheater(4) then self.main:displayCheats() end
		if not self.heroes[localHero].heroTurn  then return end
		self:checkMove(self.heroes[localHero], 0, 0)
	end)

	self.cheat = ""
	self.main.death:addEventListener("click", function () self.cheat = "D" end)
	self.main.victory:addEventListener("click", function () self.cheat = "V" end)
	self.main.reset:addEventListener("click", function () 			
		os.remove(currentHeroFileName)
		sceneManager:changeScene(SCENE_LOBBY, TRANSITION_TIME, SceneManager.flip) 
	end)

	-- respond to keys pressed (mainly for easier testing on desktop)
	self:addEventListener(Event.KEY_DOWN, function(event)
		if event.keyCode == KeyCode.UP or event.keyCode == KeyCode.W then
			self:checkMove(self.heroes[localHero], 0, -1)
		elseif event.keyCode == KeyCode.DOWN or event.keyCode == KeyCode.S then
			self:checkMove(self.heroes[localHero], 0, 1)
		elseif event.keyCode == KeyCode.LEFT or event.keyCode == KeyCode.A then
			self:checkMove(self.heroes[localHero], -1, 0)
		elseif event.keyCode == KeyCode.RIGHT or event.keyCode == KeyCode.D then
			self:checkMove(self.heroes[localHero], 1, 0)
		elseif event.keyCode == KeyCode.SPACE then
			if not self.heroes[localHero].heroTurn  then return end
			self:checkMove(self.heroes[localHero], 0, 0)
		end
	end)
	
	--set the default action to move
	self.active = "move"
	self.main.move:updateVisualState(true)
	 --respond to the action buttons
	 self.main.look:addEventListener("click", function() 
	   self.active = "look"
	   self.main.look:updateVisualState(true)
	   self.main.move:updateVisualState(false)
	   self.main.ranged:updateVisualState(false)
	   self.main.melee:updateVisualState(false)
	 end)
	 self.main.move:addEventListener("click", function() 
	   self.active = "move"
	   self.main.move:updateVisualState(true)
	   self.main.look:updateVisualState(false)
	   self.main.ranged:updateVisualState(false)
	   self.main.melee:updateVisualState(false)
	 end)
	 self.main.melee:addEventListener("click", function() 
	   self.active = "attack"
	   self.heroes[1].weapon = self.heroes[1].weapons[1]
	   self.main.melee:updateVisualState(true)
	   self.main.move:updateVisualState(false)
	   self.main.look:updateVisualState(false)
	   self.main.ranged:updateVisualState(false)
	 end)
	 self.main.ranged:addEventListener("click", function() 
	   self.active = "attack"
	   self.heroes[1].weapon = self.heroes[1].weapons[2]
	   self.main.ranged:updateVisualState(true)
	   self.main.move:updateVisualState(false)
	   self.main.look:updateVisualState(false)
	   self.main.melee:updateVisualState(false)
	 end)	
	 
	 
	--respond to touch events
	-- TODO FIX needs to be more refined. Need to listen for MOUSE_DOWN first.
	--self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
	
	self.ready = true
	if self.remote then self:syncState() end
end

function ScenePlay:checkMove(hero, dx, dy)
	--[[move the hero if the tile isn't blocked
	--]]

	local pass = dx == 0 and dy == 0
	-- first we need the tile key and layer for where the hero wants to move
	--DEBUG(hero, dx, dy, pass)
	--DEBUG(hero, dx, dy, pass, hero.x + dx, hero.y + dy, self.active)

	if not hero.heroTurn then return end
	ASSERT_EQUAL(hero.heroIdx, localHero, "Called with remote hero")

	local entry, layer, tile = self.world:getTileInfo(hero.x + dx, hero.y + dy)
	--DEBUG(entry, layer, tile.id, tile.name, tile.blocked, tile.cover)

	if self.active == "look" then 
		self.msg:add("A " .. tile.name, MSG_DESCRIPTION) 
		return
	elseif self.active == "attack" then 
		if layer == LAYER_MONSTERS then
			self:attackMonster(hero.x + dx, hero.y + dy)
			return
		else -- change mode to "move" on the fly
			-- self.msg:add("Not a monster", MSG_DESCRIPTION)
			self.active = "move"
			self.main.melee:updateVisualState(false)
			self.main.move:updateVisualState(true)
			self.main.look:updateVisualState(false)
			self.main.ranged:updateVisualState(false)
			-- drop out of two ifs and continue with move
		end
	end

	if self.active == "move" then
		if layer == LAYER_MONSTERS and not pass then -- LAYER_MONSTERS contains the hero itself...
			-- allow them to bump and melee attack when moving
			self.active = "attack"
			hero.weapon = hero.weapons[1]
			self.main.melee:updateVisualState(true)
			self.main.move:updateVisualState(false)
			self.main.look:updateVisualState(false)
			self.main.ranged:updateVisualState(false)
			self:attackMonster(hero.x + dx, hero.y + dy)
			return
		elseif layer == LAYER_ENVIRONMENT then
			-- check for blocked tiles
			if tile.blocked then
				--DEBUG(self.active, hero.x + dx, hero.y + dy, entry, layer, tile.id, tile.name, tile.blocked, tile.cover)
				self.msg:add("A " .. tile.name, MSG_DESCRIPTION) 
			return
			else
				-- drop out of two if's and continue move
			end
		end

		-- we move
		self.world:moveHero(hero, dx, dy)

		if self.remote then
			DEBUG("MOVE", "Hero", hero.heroIdx, hero.x, hero.y, "Monster", nil, nil)
			self:syncTurn(hero.heroIdx, hero.x, hero.y, 0, 0, 0) 
		else
			self.heroes[localHero].heroTurn = true
			self:enableArrows()
			self:heroesTurnOver()
		end
	end
end
 

 function ScenePlay:syncTurn(heroIdx, x, y, monsterIdx, monsterHp, monsterHpBar, sender)
	-- Update the other device about the player turn. If the player 
		-- moved: id and location of hero
		-- attacked: id and location of here, id and new hp of monster
	
	-- TODO There must be a better way for this
	heroIdx = tonumber(heroIdx)
	x = tonumber(x)
	y = tonumber(y)
	monsterIdx = tonumber(monsterIdx)
	monsterHp = tonumber(monsterHp)
	monsterHpBar = tonumber(monsterHpBar)

	--DEBUG_C(SYNC_TURN, "Hero:", heroIdx, x, y, "Monster", monsterIdx, monsterHp, monsterHpBar, sender)	

	if sender then -- this is an incoming remote call
		if not ASSERT_NOT_EQUAL(heroIdx, localHero, "Remote trying to update local hero") then return end
		DEBUG_C(SYNC_TURN, "Updating remote hero's move locally.")
		
		self.world:moveHero(self.heroes[heroIdx], x-self.heroes[heroIdx].x, y-self.heroes[heroIdx].y)
		self.sounds:play("hero-steps")
		
		if monsterIdx ~= 0 then
			m = self.monsters:getMonster(monsterIdx)
			m.hp = monsterHp
			m.HPbar = monsterHpBar
			self.world:changeTile(LAYER_HP, m.HPbar, m.x, m.y)
			self:removeDeadMonsters(heroIdx)
		end
		
		if self.client then 
			self.heroes[3-localHero].heroTurn = false
			self.heroes[localHero].heroTurn = true
			self:enableArrows(true)
			
			-- for debugging - wait a little, then client hero decides to do nothing
			if CLIENT_REST then
				Timer.delayedCall(300, function () self.main.center:dispatchEvent(Event.new("click")) end)
			end
			
		else
			self.heroes[3-localHero].heroTurn = false
			self:heroesTurnOver()
		end
		
	else -- this is a local call - ignoring parameters
		if not ASSERT_EQUAL(heroIdx, localHero, "Trying to update remote hero's position remotely") then return end
		DEBUG_C(SYNC_TURN, "Updating local move on remote.")

		serverlink:callMethod(SYNC_TURN, localHero, x, y, monsterIdx, monsterHp, monsterHpBar)
		
		self.heroes[3-localHero].heroTurn = true
		self.heroes[localHero].heroTurn = false
		self:enableArrows(false)
	end
 end

 function ScenePlay:syncMonster(id, x, y, sender)
 
	ERROR("No longer needed as we synch everything after monster turn ")

	-- TODO There must be a better way for this
	id = tonumber(id)
	x = tonumber(x)
	y = tonumber(y)

	DEBUG_C(MONSTER_MOVED, id, x, y, sender)	

	if sender then -- this is an incoming remote call
		if self.client then
			local m = self.monsters:getMonster(id)
			DEBUG_C(MONSTER_MOVED, m.id, m.name, x, y, sender)
			self.world:moveMonster(m, x-m.x, y-m.y)
		else
			ERROR(MONSTER_MOVED, "should not be called remotely on server")
		end
	else -- this is a local call
		if self.server then
			local m = self.monsters:getMonster(id) -- debug
			DEBUG_C(MONSTER_MOVED, m.id, m.name, x, y, sender)
			serverlink:callMethod(MONSTER_MOVED, id, x, y)
		else
			ERROR(MONSTER_MOVED, "should not be called locally on client")
		end
	end
 end

 function ScenePlay:syncState(hero1X, hero1Y, hero2X, hero2Y, monstersInfo, sender) -- HEROFIX for >2 heroes
	-- Used by server to send full game state to client and by client to request initial sync

	-- TODO There must be a better way for this
	hero1X = tonumber(hero1X)
	hero1Y = tonumber(hero1Y)
	hero2X = tonumber(hero2X)
	hero2Y = tonumber(hero2Y)


	DEBUG_C(SYNC_STATE, hero1X, hero1Y, hero2X, hero2Y, monstersInfo, sender)
	
	if sender then  -- this is an incoming remote call.
		if self.ready then
			if self.client then -- server sent update to client
				--DEBUG("old monsters: ", self.monsters:serialize())
				for id, m in pairs(self.monsters.list) do
					self.world:removeMonster(m.x, m.y)	
				end
				self.monsters.list = {} -- TODO FIX there must be a more elegant way to replace the list
				self.monsters:initFromServer(monstersInfo)
				--DEBUG("newmonsters", self.monsters:serialize())
				for id, m in pairs(self.monsters.list) do
					self.world:addMonster(m)
				end
				self.world:moveHero(self.heroes[1], hero1X-self.heroes[1].x, hero1Y-self.heroes[1].y)
				self.world:moveHero(self.heroes[2], hero2X-self.heroes[2].x, hero2Y-self.heroes[2].y)
			else -- client requests update. Ignore any parameters and send out update
				monstersInfo = self.monsters:serialize()
				DEBUG_C(SYNC_STATE, self.heroes[1].x, self.heroes[1].y, self.heroes[2].x, self.heroes[2].y, monstersInfo)
				serverlink:callMethod(SYNC_STATE, self.heroes[1].x, self.heroes[1].y, self.heroes[2].x, self.heroes[2].y, monstersInfo)
			end
		end		
	else -- this is a local call.
		ASSERT_TRUE(self.ready, "should not be called locally before ready")
		if self.server then -- ignore parameters and send update to client
			monstersInfo = self.monsters:serialize()
			DEBUG_C(SYNC_STATE, self.heroes[1].x, self.heroes[1].y, self.heroes[2].x, self.heroes[2].y, monstersInfo)
			serverlink:callMethod(SYNC_STATE, self.heroes[1].x, self.heroes[1].y, self.heroes[2].x, self.heroes[2].y, monstersInfo)
		else -- request update from server. Parameters don't matter
			DEBUG_C(SYNC_STATE, -1, -1, -1)
			serverlink:callMethod(SYNC_STATE, -1, -1, -1, -1, -1)
		end
	end 
 end

 
 function ScenePlay:onMouseUp(event)
	--[[respond to the user touching the map.  Checks if the map part of the screen was touched, the responds depending on which button is activeButton
		Called from Event.MOUSE_UP
		Calls checkMove, messages:add, world:getTileInfo
	--]]


	--only check visible parts of the map
	local x = self.heroes[localHero].x + math.ceil(event.x / TILE_WIDTH) - 6
	local y = self.heroes[localHero].y + math.ceil(event.y / TILE_HEIGHT) - 6
	local key, layer = 0, 0
	local visibleMapTouched = (event.x < FG_X and x >= 0 and x <= LAYER_COLUMNS and y >= 0 and y <= LAYER_ROWS)
	
	if visibleMapTouched then
		--find the tile that was touched
		--local key, layer, tile = self.world:getTileInfo(x, y)
		local key, layer, tile = self.world:getTileInfo(x, y)
		
		--DEBUG("Touch at " .. event.x .. ", " .. event.y .. " / " .. x .. ", " .. y )
		
		if self.active == "attack" then
			--calculate the reach, check if it's the monster layer and make sure it wasn't the hero who was clicked
			-- FIX remove commented line below, as the next one seems to work
			--local inReach = math.abs(self.heroes[localHero].x - x) <= self.heroes[localHero].weapon.reach and math.abs(self.heroes[localHero].y - y) <= self.heroes[localHero].weapon.reach and
			--				layer == LAYER_MONSTERS and not (self.heroes[localHero].x == x and self.heroes[localHero].y == y)
			local inReach = distance(self.heroes[localHero], event) < self.heroes[localHero].weapon.reach and
							layer == LAYER_MONSTERS and not (self.heroes[localHero].x == x and self.heroes[localHero].y == y)
			if inReach then
				self:checkMove(self.heroes[localHero], x - self.heroes[localHero].x, y - self.heroes[localHero].y)
			elseif (not tile.tactics == "player") and layer == LAYER_MONSTERS then
				self.msg:add(tile.name .. "is out of range", MSG_DESCRIPTION)	
			end
		elseif self.active == "look" then
			self.msg:add("A " .. tile.name, MSG_DESCRIPTION)	
		elseif self.active == "move" then
			--if a move action is selected, move the hero towards the tile 
			local deltaX = math.abs(self.heroes[localHero].x - x)
			local deltaY = math.abs(self.heroes[localHero].y - y)
			local dx, dy = 0, 0
			if deltaX > 0 or deltaY > 0 then
				--calculate the optimal dx, dy 
				if deltaX > deltaY then
					if x > self.heroes[localHero].x then dx, dy = 1, 0 else dx, dy = -1, 0 end
				else
					if y > self.heroes[localHero].y then dx, dy = 0, 1 else dx, dy = 0, -1 end
				end
				--DEBUG(("Hero is at %d,%d walking %d,%d"):format(self.heroes[localHero].x, self.heroes[localHero].y, dx, dy))
				self:checkMove(self.heroes[localHero],dx, dy)
			end
		end
	else
		--DEBUG(("Touch outside visible map at %d,%d"):format(event.x, event.y))
	end
end

function ScenePlay:removeDeadMonsters(heroIdx)

	--find the monster being attacked and their index in monsters.list 
	for id, m in pairs(self.monsters.list) do
		if m.hp < 1 then		
			self.msg:add(self.heroes[heroIdx].name, " killed the " .. m.name, MSG_DEATH)
			self.heroes[heroIdx].xp = self.heroes[localHero].xp + m.xp
			self.heroes[heroIdx].kills = self.heroes[heroIdx].kills + 1
			--remove the monster from the monsters.list and the map
			table.remove(self.monsters.list, id)	
			self.world:removeMonster(m.x, m.y)	
		end
	end
end


function ScenePlay:heroesTurnOver()
	--[[puts in one place all the things we want to keep track of after the heroes' turn is done 
	--]]
		
	-- check if the players won 
	if #self.monsters.list == 0 or self.cheat == "V" then
		dataSaver.save(currentHeroFileName, self.heroes[localHero])
		ScenePlay.camera = nil -- TODO FIX that global is really sucky...
		sceneManager:changeScene(SCENE_VICTORY, TRANSITION_TIME, TRANSITION)
	end
	
	ASSERT_TRUE(not self.client, "called on client")
	ASSERT_TRUE(not self.heroes[1].heroTurn, "Hero 1's turn - Is this why monsters attack twice?")
	if self.remote then ASSERT_TRUE(not self.heroes[2].heroTurn, "Hereo 2's turn") end


	-- first set all monsters to not done
	for id, m in pairs(self.monsters.list) do
		m.done = false
	end	
	--each monster gets a turn
	for id, m in pairs(self.monsters.list) do
		m.done = false
		self.monsters:updateState(m, id, self.heroes, self.remote)
		if (m.hp > 0) then -- redundant, as we remove dead monsters now explicitely
			--DEBUG("Playing " .. m.name .. " at " .. m.x .. " " .. m.y)
			self:monsterAI(m)
		end	
	end	
end

function ScenePlay:enableArrows(on)
	local alpha = on and 1 or 0.5
	
	self.main.north:setAlpha(alpha)	
	self.main.south:setAlpha(alpha)
	self.main.east:setAlpha(alpha)
	self.main.west:setAlpha(alpha)
	self.main.northwest:setAlpha(alpha)	
	self.main.southwest:setAlpha(alpha)
	self.main.northeast:setAlpha(alpha)
	self.main.southeast:setAlpha(alpha)
	self.main.center:setAlpha(alpha)
end

function ScenePlay:monsterTurnOver()

	-- make sure all the monsters attacked
	local done = true
	for id, m in pairs(self.monsters.list) do
		done = done and m.done
	end
	if not done then 
		--DEBUG("not done")
		return
	else
		--DEBUG("done -------------------------------")
	end
	
	--after all the monsters attacked, check if the hero lost
	if self.heroes[localHero].hp < 1 or self.cheat == "D" then
		self.msg:add("you died", MSG_DEATH)
		dataSaver.save(currentHeroFileName, self.heroes[localHero])
		sceneManager:changeScene(SCENE_DEATH, TRANSITION_TIME, TRANSITION)
	end

	-- enable hero again
	self.heroes[localHero].heroTurn  = true
	self:enableArrows(true)

	-- Push everything to client
	  -- takes care of all monsters that moved and any inconcistencies that might have accrued
	if self.remote then
		self:syncState()
	end
		
end
  
function ScenePlay:monsterAI(monster)
	--[[Logic: attack or move based on monster.state
	--]]

	if monster.state == "move" then
		--dx, dy are the direction coordinates where the monster will move
		local dx, dy = 0, 0
		if monster.seesHero then
			--move towards the hero
			self.sounds:play("monster-steps")
			dx, dy = self.world:whichWay(monster, monster.target.x, monster.target.y)
		else
			--move randomly in one of four directions
			local directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}}
			--try to move four times
			local tries = 0
			local successful = false
			while not successful do
				local d = directions[math.random(1, 4)]
				dx, dy = d[1], d[2]
				if not self.world:blocked(monster.x + dx, monster.y + dy) then
					successful = true
				end
				tries = tries + 1
				if tries == 4 then 
					successful = true 
					dx = 0 
					dy = 0
					--DEBUG("Not moving this turn", monster.id, monster.name, monster.x,monster.y)
				end
			end
		end
		self.world:moveMonster(monster, dx, dy)
		if self.server then
			--DEBUG_C("Attempting to remote move", monster, monster.id, monster.entry, monster.x, monster.y)
			--self:syncMonster(monster.id, monster.x, monster.y)
		end
		monster.done = true
		self:monsterTurnOver()
	elseif monster.state == "flee" then
		--move away from the hero
		dx, dy = self.world:whichWay(monster, monster.target.x, monster.target.y)
		self.world:moveMonster(monster, dx, dy)
		if self.remote then
			--DEBUG_C("Attempting to remote move", monster, monster.id, monster.entry, monster.x, monster.y)
			--self:syncMonster(monster.id, m.x, m.y)
		end
		monster.done = true
		self:monsterTurnOver()
	elseif monster.state == "attack" then
		--attack the hero
		self:basicAttack(monster, monster.target)
	end
end

function ScenePlay:basicAttack(attacker, defender)
	--[[resolve the to hit and damage rolls based on the attacker's weapon
		takes into account attacker's and defender's conditions
		Called from attackMonster and monsterAI
		Calls roll, world:changeTile, 
		Changes defender.hp, .HPbar
	--]]
	
	--if ASSERT_TRUE(attacker.heroIdx and defender.heroIdx, "Trying to attack other players") then return end

	-- this is the weapon
	local weapon = attacker.weapon

	if weapon.projectile then
		self:rangedAttack(weapon, attacker, defender)
	else
		--roll for the attack using the weapon and all modifiers
		local roll, crit = self:roll(weapon.modifier)
		if roll < defender.defense[weapon.defense] then
			--report misses and close misses
			self.sounds:play("melee-miss")
			if attacker.tactics ~= "player" then
				self.msg:add("The " .. weapon.name .. " misses", MSG_DEATH)
			else
				self.msg:add("Your " .. weapon.name .. " misses", MSG_ATTACK)			
			end
			if (defender.defense[weapon.defense] - roll) > 5 then
				-- silent for big misses
			else	
				-- self.msg:add(weapon.missSound, MSG_ATTACK)
			end
		else
			self.sounds:play("melee-hit")
			self:rollDamage(weapon, attacker, defender, crit)
		end
		if self.heroes[localHero].heroTurn  then 		
			if self.remote then
				DEBUG("Basic Attack", "Hero", attacker.heroIdx, attacker.x, attacker.y, "Monster", defender.id, defender.hp)	
				self:syncTurn(attacker.heroIdx, attacker.x, attacker.y, defender.id, defender.hp, defender.HPbar) 
				self:removeDeadMonsters(localHero)
			else
				self:removeDeadMonsters(localHero)
				self.heroes[localHero].heroTurn = false
				self:heroesTurnOver()
			end
		else
			attacker.done = true
			self:monsterTurnOver()
		end
	end
end

function ScenePlay:rangedAttack(weapon, attacker, defender)
--[[Logic:  resolves a ranged attack
	Called from basicAttack
	Calls world:lineOfCover, roll, projectile.new, messages:add, sounds:play, rollDamage, messages:add
--]]

	local p = nil
	local cover, blockedX, blockedY = self.world:lineOfCover(attacker.x, attacker.y, defender.x, defender.y)
	if blockedX then 
		-- launch a projectile that hits something along the way
		-- TODO: FIX projectil should move direction defender, not direction obstacle
		--       they are sometimes slightly different and it looks weird
		p = Projectile.new(weapon.projectile, attacker.x, attacker.y, blockedX, blockedY)
	else
		-- launch a projectile towards the defender
		p = Projectile.new(weapon.projectile, attacker.x, attacker.y, 
							self.heroes[localHero].x, self.heroes[localHero].y)	
	end
	self.camera:addChild(p)
	p:addEventListener("animation finished", function(event)
		--DEBUG("Anonymous EventListener")
		event:stopPropagation()
		if blockedX then
			local key, layer, tile = self.world:getTileInfo(blockedX, blockedY)
			self.sounds:play(weapon.projectile .. "-miss")	
			if attacker.tactics == "player" then
				if layer == LAYER_MONSTERS then
					self.msg:add("You missed in the dark", MSG_ATTACK)
				else
					self.msg:add("You hit the " .. tile.name, MSG_ATTACK)
				end
			end
		else
			--roll for the attack using the weapon and all modifiers, including cover
			local roll, crit = self:roll(weapon.modifier + cover)
			if defender.defense[weapon.defense] > roll then
				--report misses and close misses			
				self.sounds:play(weapon.projectile .. "-miss")	
				if attacker.tactics ~= "player" then
					self.msg:add("The " .. weapon.name .. " misses", MSG_DEATH)
				else
					self.msg:add("Your " .. weapon.name .. " misses", MSG_ATTACK)			
				end
				if (defender.defense[weapon.defense] - roll) > 5 then
					-- silent for big misses
				else	
					-- self.msg:add(weapon.missSound, MSG_ATTACK)
				end
			else
				self.sounds:play(weapon.projectile .. "-hit")
				self:rollDamage(weapon, attacker, defender, crit)
			end
		end

		if self.heroes[localHero].heroTurn  then 		
			if self.remote then
				DEBUG("Range Attack", "Hero", attacker.heroIdx, attacker.x, attacker.y, "Monster", defender.id, defender.hp)	
				self:syncTurn(attacker.heroIdx, attacker.x, attacker.y, defender.id, defender.hp, defender.HPbar) 
				self:removeDeadMonsters(localHero)
			else
				self:removeDeadMonsters(localHero)
				self.heroes[localHero].heroTurn = false
				self:heroesTurnOver()
			end
		else
			attacker.done = true
			self:monsterTurnOver()
		end

--[[

		if self.heroes[localHero].heroTurn  then 
			self:heroesTurnOver() 
		else
			attacker.done = true
			self:monsterTurnOver()
		end

]]
	end)
end

function ScenePlay:rollDamage(weapon, attacker, defender, crit)
--[[Logic:  resolve the damage rolls based on the attacker's weapon. Takes into account critical hits and the defender's resistances
	Called from basicAttack, rangedAttack
	Calls roll, world:changeTile
	Changes defender.hp, .HPbar
--]]

	--describe the action if it's the player getting hit
	--roll for damage
	local roll = 0
	if crit then 
		--critical hits do max damage
		roll = tonumber(string.sub(weapon.damage, 2)) + weapon.bonus
	else
		roll = self:roll(weapon.bonus, weapon.damage, weapon.dice)
	end
	--report the damage
	if defender.tactics == "player" then
		self.msg:add("You get hit by a " .. weapon.name .. " for " .. roll .. " damage", MSG_DEATH)
	else
		self.msg:add("Your " .. weapon.name .. " deals " .. roll .. " damage", MSG_DEATH)
	end
	
	--adjust the defender's hp except for any resistances
	defender.hp = defender.hp - roll + defender.resist[weapon.type]
	if defender.hp < 0 then
		defender.hp = 0
	end
	defender.HPbar = 8 - math.floor((defender.hp / defender.maxHP) * 8)
	if defender.hp > 0 then
		self.world:changeTile(LAYER_HP, defender.HPbar, defender.x, defender.y)
	end
end

function ScenePlay:attackMonster(x, y)
--[[targets a monster at x, y
--]]

	--find the monster being attacked and their index in monsters.list 
	local monster = nil	
	local id = 0	
	for i = 1, #self.monsters.list do
		monster = self.monsters.list[i] 
		id = i
		if monster.x == x and monster.y == y then 
			break 
		end
	end
	
	--call the attack function
	self:basicAttack(self.heroes[localHero], monster)
end


function ScenePlay:roll(modifier, maximum, die, crit)
--[[Logic:  returns a rolled value and a boolean value
			everything is optional.  Default is 1d20.
			modifier is added to the 1d20 roll
			maximum is the maximum roll:  d8, d10, d12, etc..
			die is how many
			crit is the critical hit minimum without the modifier (default is 20).
			Examples:  	roll(2)		1d20+2
						roll(2, d6)	1d6+2
						roll(2, d6, 2)	2d6+2
						roll(2, d6, 2, 18)	2d6+2, critical hit on a roll of 18-20
			critical == true is a critical hit
	Returns result, critical
--]]

	local mod = modifier or 0
	local max = maximum or "d20"
	--remove the 'd' from d4, d20, etc..
	local max = tonumber(string.sub(max, 2))
	local dice = die or 1
	local critical = crit or max

	local result = 0
	for roll = 1, dice do
		result = result + math.random(1, max)
	end
	
	if result >= critical then
		return result + mod, true
	else
		return result + mod, false
	end
end

function ScenePlay:cheater(want)

	if self.remote then return end -- no cheat codes on remote play (for now)

	if self.cheatcount == want then
		self.cheatcount += 1
		--DEBUG("cheatcount increase to " .. self.cheatcount)
		return true
	else
		self.cheatcount = 0
		--DEBUG("cheatcount reset to 0")
		return false
	end
end