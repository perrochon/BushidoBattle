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
 
function ScenePlay:init()

	application:setBackgroundColor(COLOR_LTBLACK)

	self.sounds = Sounds.new("game")

	-- read the level file
	self.mapData= MapData.new(currentMapFileName) 

	-- FIX move the hero creation/placement stuff out of init into Heroes.lua

	-- TODO HEROFIX remove
	--ScenePlay.heroes = {} 

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
		--DEBUG("This device is a server")
	elseif self.client then 
		--DEBUG("This device is a client")
	else 
		--DEBUG("This device is playing locally") 
	end

	-- get heroes ready for next battle
	local r, c
	for _, v in pairs(self.mapData.spawns) do
		if v.type == 1 then
			r = v.r
			c = v.c
			break
		end
	end

	for i = 1,4 do
		heroes[i].mc:setScale(1)
		-- TODO HEROFIX how to place multiple heroes? For now, they all go on top of each other...
		-- options: define in map, pile up, find empty spot close, either here, or in character:setPosition
		-- Problems is we haven't loaded maps yet, and WorldMap.new wants the heroes array
		heroes[i]:setPosition(c,r)
		if heroes[i].active then
			heroes[i].turn = true
		end
	end
	
	if self.remote then
		-- TODO HEROFIX
	end
		
	-- load monsters -- TODO HEROFIX double monsters when there are two players.
	self.monsters = Monsters.new(self.mapData)

	-- Create the TileMaps and the arrays
	self.world = WorldMap.new(self.mapData, self.monsters)

	self.msg = Messages.new()

	--add methods for remote play
	if self.remote then
		--serverlink:addMethod(MOVE_HERO, self.remoteMoveHero, self)
		serverlink:addMethod(SYNC_TURN, self.syncTurn, self)
		serverlink:addMethod(SYNC_STATE, self.syncState, self)	
		--serverlink:addMethod(MONSTER_MOVED, self.syncMonster, self)
	end

	--get everything on the screen
	self:addChild(self.world)

	self:addChild(self.msg)
	self.main = MainScreen.new(heroes[currentHero])
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
	self.main.north:addEventListener("click", function() ScenePlay:cheater(0) self:checkMove(heroes[currentHero], 0, -1) end)
	self.main.south:addEventListener("click", function() ScenePlay:cheater(1) self:checkMove(heroes[currentHero], 0, 1)  end)
	self.main.west:addEventListener("click", function() ScenePlay:cheater(2) self:checkMove(heroes[currentHero], -1, 0)  end)
	self.main.east:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(heroes[currentHero], 1, 0)  end)
	self.main.northwest:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(heroes[currentHero], -1, -1)  end)
	self.main.northeast:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(heroes[currentHero], 1, -1)  end)
	self.main.southwest:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(heroes[currentHero], -1, 1)  end)
	self.main.southeast:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(heroes[currentHero], 1, 1)  end)
	self.main.center:addEventListener("click", function()
		if ScenePlay:cheater(4) then self.main:displayCheats() end
		if not heroes[currentHero].heroTurn  then return end
		self:checkMove(heroes[currentHero], 0, 0)
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
		if event.keyCode == KeyCode.UP or event.keyCode == KeyCode.W or event.keyCode == KeyCode.NUM_8 then
			self:checkMove(heroes[currentHero], 0, -1)
		elseif event.keyCode == KeyCode.DOWN or event.keyCode == KeyCode.S or event.keyCode == KeyCode.NUM_2 then
			self:checkMove(heroes[currentHero], 0, 1)
		elseif event.keyCode == KeyCode.LEFT or event.keyCode == KeyCode.A or event.keyCode == KeyCode.NUM_4 then
			self:checkMove(heroes[currentHero], -1, 0)
		elseif event.keyCode == KeyCode.RIGHT or event.keyCode == KeyCode.D or event.keyCode == KeyCode.NUM_6 then
			self:checkMove(heroes[currentHero], 1, 0)
			
		elseif event.keyCode == KeyCode.C or event.keyCode == KeyCode.NUM_3 then
			self:checkMove(heroes[currentHero], 1, 1)
		elseif event.keyCode == KeyCode.E or event.keyCode == KeyCode.NUM_9 then
			self:checkMove(heroes[currentHero], 1, -1)
		elseif event.keyCode == KeyCode.Z or event.keyCode == KeyCode.NUM_1 then
			self:checkMove(heroes[currentHero], -1, 1)
		elseif event.keyCode == KeyCode.Q or event.keyCode == KeyCode.NUM_7 then
			self:checkMove(heroes[currentHero], -1, -1)
			
		elseif event.keyCode == KeyCode.SPACE or event.keyCode == KeyCode.NUM_5 then
			if not heroes[currentHero].heroTurn  then return end
			self:checkMove(heroes[currentHero], 0, 0)
		elseif event.keyCode == KeyCode.M then
			self.world.camera:setScale(self.world.camera:getScaleX()*1.2,self.world.camera:getScaleY()*1.2) 
			self.world.camera:centerAnchor()
		elseif event.keyCode == KeyCode.N then
			self.world.camera:setScale(self.world.camera:getScaleX()*0.8,self.world.camera:getScaleY()*0.8) 
			self.world.camera:centerAnchor()
		end
	end)
	
	--set the default action to move
	self.activeAction = "move"
	self.main.move:updateVisualState(true)
	 --respond to the action buttons
	 self.main.look:addEventListener("click", function() 
	   self.activeAction = "look"
	   self.main.look:updateVisualState(true)
	   self.main.move:updateVisualState(false)
	   self.main.ranged:updateVisualState(false)
	   self.main.melee:updateVisualState(false)
	 end)
	 self.main.move:addEventListener("click", function() 
	   self.activeAction = "move"
	   self.main.move:updateVisualState(true)
	   self.main.look:updateVisualState(false)
	   self.main.ranged:updateVisualState(false)
	   self.main.melee:updateVisualState(false)
	 end)
	 self.main.melee:addEventListener("click", function() 
	   self.activeAction = "attack"
	   heroes[currentHero].weapon = heroes[currentHero].weapons[1]
	   self.main.melee:updateVisualState(true)
	   self.main.move:updateVisualState(false)
	   self.main.look:updateVisualState(false)
	   self.main.ranged:updateVisualState(false)
	 end)
	 self.main.ranged:addEventListener("click", function() 
	   self.activeAction = "attack"
	   heroes[currentHero].weapon = heroes[currentHero].weapons[2]
	   self.main.ranged:updateVisualState(true)
	   self.main.move:updateVisualState(false)
	   self.main.look:updateVisualState(false)
	   self.main.melee:updateVisualState(false)
	 end)	
	 
	 
	--respond to mouse and touch events. Add this on top of the world
	local nav = MapNavigation.new(self.world)
	self:addChild(nav)
	
	nav:addEventListener("line", self.onLine, self)
	
	self.ready = true
	if self.remote then self:syncState() end
end

function ScenePlay:checkMove(hero, dc, dr)
	--[[move the hero if the tile isn't blocked
	--]]

	ASSERT_TRUE(hero.active, "Hero not active: "..hero.name)
	ASSERT_TRUE(hero.turn, "Not hero's turn: "..hero.name)

	local pass = dc == 0 and dr == 0
	-- first we need the tile key and layer for where the hero wants to move
	--DEBUG(hero, dc, dr, pass)
	--DEBUG("Hero", hero.name, dc, dr, pass, hero.c + dc, hero.r + dr, self.activeAction)
	
	

	if not hero.turn then return end

	local entry, layer, tile = self.world:getTileInfo(hero.c + dc, hero.r + dr)
	--DEBUG("Tile", entry, layer, tile.id, tile.name, tile.blocked, tile.cover)

	if self.activeAction == "look" and not pass then 
		self.msg:add("A " .. tile.name, MSG_DESCRIPTION) 
		return
	elseif self.activeAction == "attack" and not pass then 
		if layer == LAYER_MONSTERS then
			self:attackMonster(hero.c + dc, hero.r + dr)
			return
		else -- change mode to "move" on the fly
			-- self.msg:add("Not a monster", MSG_DESCRIPTION)
			self.activeAction = "move"
			self.main.melee:updateVisualState(false)
			self.main.move:updateVisualState(true)
			self.main.look:updateVisualState(false)
			self.main.ranged:updateVisualState(false)
			-- drop out of two ifs and continue with move
		end
	end

	if self.activeAction == "move" then
		if layer == LAYER_MONSTERS and not pass then -- LAYER_MONSTERS contains the hero itself...
			-- allow them to bump and melee attack when moving			
			self.activeAction = "attack"
			hero.weapon = hero.weapons[1]
			self.main.melee:updateVisualState(true)
			self.main.move:updateVisualState(false)
			self.main.look:updateVisualState(false)
			self.main.ranged:updateVisualState(false)
			self:attackMonster(hero.c + dc, hero.r + dr)
			return
		elseif layer == LAYER_ENVIRONMENT then
			-- check for blocked tiles
			if tile.blocked then
				--DEBUG(self.activeAction, hero.x + dc, hero.r + dr, entry, layer, tile.id, tile.name, tile.blocked, tile.cover)
				self.msg:add("A " .. tile.name, MSG_DESCRIPTION) 
			return
			else
				-- drop out of two if's and continue move
			end
		end

		-- we move
		self.world:moveHero(hero, dc, dr)

		if self.remote then
			DEBUG("MOVE", "Hero", hero.id, hero.x, hero.r, "Monster", nil, nil)
			self:syncTurn(hero.heroIdx, hero.x, hero.r, 0, 0, 0) 
		else
			heroes[currentHero].heroTurn = true
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
		
		self.world:moveHero(heroes[heroIdx], x-heroes[heroIdx].x, y-heroes[heroIdx].r)
		self.sounds:play("hero-steps")
		
		if monsterIdx ~= 0 then
			m = self.monsters:getMonster(monsterIdx)
			m.hp = monsterHp
			m.HPbar = monsterHpBar
			self.world:changeTile(LAYER_HP, m.HPbar, m.x, m.r)
			self:removeDeadMonsters(heroIdx)
		end
		
		if self.client then 
			heroes[3-localHero].heroTurn = false
			heroes[currentHero].heroTurn = true
			self:enableArrows(true)
			
			-- for debugging - wait a little, then client hero decides to do nothing
			if CLIENT_REST then
				Timer.delayedCall(300, function () self.main.center:dispatchEvent(Event.new("click")) end)
			end
			
		else
			heroes[3-localHero].heroTurn = false
			self:heroesTurnOver()
		end
		
	else -- this is a local call - ignoring parameters
		if not ASSERT_EQUAL(heroIdx, localHero, "Trying to update remote hero's position remotely") then return end
		DEBUG_C(SYNC_TURN, "Updating local move on remote.")

		serverlink:callMethod(SYNC_TURN, localHero, x, y, monsterIdx, monsterHp, monsterHpBar)
		
		heroes[3-localHero].heroTurn = true
		heroes[currentHero].heroTurn = false
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
			self.world:moveMonster(m, x-m.x, y-m.r)
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
					self.world:removeMonster(m.c, m.r)	
				end
				self.monsters.list = {} -- TODO FIX there must be a more elegant way to replace the list
				self.monsters:initFromServer(monstersInfo)
				--DEBUG("newmonsters", self.monsters:serialize())
				for id, m in pairs(self.monsters.list) do
					self.world:addMonster(m)
				end
				self.world:moveHero(heroes[1], hero1X-heroes[1].c, hero1Y-heroes[1].r)
				self.world:moveHero(heroes[2], hero2X-heroes[2].c, hero2Y-heroes[2].r)
			else -- client requests update. Ignore any parameters and send out update
				monstersInfo = self.monsters:serialize()
				DEBUG_C(SYNC_STATE, heroes[1].c, heroes[1].r, heroes[2].c, heroes[2].r, monstersInfo)
				serverlink:callMethod(SYNC_STATE, heroes[1].c, heroes[1].r, heroes[2].c, heroes[2].r, monstersInfo)
			end
		end		
	else -- this is a local call.
		ASSERT_TRUE(self.ready, "should not be called locally before ready")
		if self.server then -- ignore parameters and send update to client
			monstersInfo = self.monsters:serialize()
			DEBUG_C(SYNC_STATE, heroes[1].c, heroes[1].r, heroes[2].c, heroes[2].r, monstersInfo)
			serverlink:callMethod(SYNC_STATE, heroes[1].c, heroes[1].r, heroes[2].c, heroes[2].r, monstersInfo)
		else -- request update from server. Parameters don't matter
			DEBUG_C(SYNC_STATE, -1, -1, -1)
			serverlink:callMethod(SYNC_STATE, -1, -1, -1, -1, -1)
		end
	end 
 end

function ScenePlay:removeDeadMonsters(heroIdx)

	--find the monster being attacked and their index in monsters.list 
	for id, m in pairs(self.monsters.list) do
		if m.hp < 1 then		
			self.msg:add(heroes[heroIdx].name, " killed the " .. m.name, MSG_DEATH)
			heroes[heroIdx].xp = heroes[currentHero].xp + m.xp
			heroes[heroIdx].kills = heroes[heroIdx].kills + 1
			
			if m.entry == 4 then
				for id, m in pairs(self.monsters.list) do
					if m.entry == 3 then
						m.sentry = false
						m.berserk = true
					end
				end
			end
			
			--remove the monster from the monsters.list and the map
			table.remove(self.monsters.list, id)	
			self.world:removeMonster(m.c, m.r)
		end
	end
end


function ScenePlay:heroesTurnOver()
	--[[puts in one place all the things we want to keep track of after the heroes' turn is done 
	--]]
		
	-- check if the players won 
	
	local targets = 0
	for i, m in pairs(self.monsters.list) do
		if m.entry ~= 2 then targets = targets + 1 end
	end
	
	--DEBUG("Targets left", targets)
	
	if targets == 0 or self.cheat == "V" then
		heroes[currentHero]:save(currentHeroFileName)
		sceneManager:changeScene(SCENE_VICTORY, TRANSITION_TIME, TRANSITION)
	end
	
	--ASSERT_TRUE(not self.client, "called on client")
	--ASSERT_TRUE(not heroes[1].heroTurn, "Hero 1's turn - Is this why monsters attack twice?")
	--if self.remote then ASSERT_TRUE(not heroes[2].heroTurn, "Hereo 2's turn") end


	-- first set all monsters to not done
	for id, m in pairs(self.monsters.list) do
		m.done = false
	end	
	--each monster gets a turn
	for id, m in pairs(self.monsters.list) do
		m.done = false
		self.monsters:updateState(m, id, self.remote)
		if (m.hp > 0) then -- redundant, as we remove dead monsters now explicitely
			--DEBUG("Playing " .. m.name .. " at " .. m.c .. " " .. m.r)
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
	if heroes[currentHero].hp < 1 or self.cheat == "D" then
		self.msg:add("you died", MSG_DEATH)
		heroes[currentHero]:save(currentHeroFileName)
		sceneManager:changeScene(SCENE_DEATH, TRANSITION_TIME, TRANSITION)
	end

	-- enable hero again
	heroes[currentHero].heroTurn  = true
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
			dx, dy = self.world:shortestPath({c = monster.c, r = monster.r}, {c = monster.target.c, r = monster.target.r})
		else
			--move randomly in one of eight directions
			local directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {1, 1}, {-1, -1}, {-1, 1}, {1, -1}}
			--try to move four times
			local tries = 0
			local successful = false
			while not successful do
				local d = directions[math.random(1, 8)]
				dx, dy = d[1], d[2]
				if not self.world:blocked(monster.c + dx, monster.r + dy) then
					successful = true
				end
				tries = tries + 1
				if tries == 4 then 
					successful = true 
					dx = 0 
					dy = 0
					--DEBUG("Not moving this turn", monster.id, monster.name, monster.c,monster.r)
				end
			end
		end
		self.world:moveMonster(monster, dx, dy)
		if self.server then
			--DEBUG_C("Attempting to remote move", monster, monster.id, monster.entry, monster.c, monster.r)
			--self:syncMonster(monster.id, monster.c, monster.r)
		end
		monster.done = true
		self:monsterTurnOver()
	elseif monster.state == "flee" then
		--move away from the hero.
		dx, dy = self.world:flee(monster, monster.target)
		
		if dx == 0 and dy == 0 then
			-- can't flee, might as well fight
			self:basicAttack(monster, monster.target)
		else
		
			self.world:moveMonster(monster, dx, dy)
			if self.remote then
				--DEBUG_C("Attempting to remote move", monster, monster.id, monster.entry, monster.c, monster.r)
				--self:syncMonster(monster.id, m.c, m.r)
			end
			monster.done = true
			self:monsterTurnOver()
		end
	elseif monster.state == "attack" then
		--attack the hero
		self:basicAttack(monster, monster.target)

	elseif monster.state == "wait" then 
		monster.done = true
		self:monsterTurnOver()
	end
end

function ScenePlay:basicAttack(attacker, defender)
	--[[resolve the to hit and damage rolls based on the attacker's weapon
		takes into account attacker's and defender's conditions
		Called from attackMonster and monsterAI
		Calls roll, world:changeTile, 
		Changes defender.hp, .HPbar
	--]]
	
	--if ASSERT_TRUE(attacker.entry == 1 and defender.entry == 1, "Hero attacking hero") then return end

	-- this is the weapon
	local weapon = attacker.weapon
	
	attacker.mc:attack() -- TODO ANIMATION request the correct attack animation attackRange(), attackMelee()

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
				self.msg:add(weapon.missSound, MSG_ATTACK)
			end
		else
			self.sounds:play("melee-hit")
			self:rollDamage(weapon, attacker, defender, crit)
		end
		if heroes[currentHero].heroTurn  then 		
			if self.remote then
				DEBUG("Basic Attack", "Hero", attacker.heroIdx, attacker.c, attacker.r, "Monster", defender.id, defender.hp)	
				self:syncTurn(attacker.heroIdx, attacker.c, attacker.r, defender.id, defender.hp, defender.HPbar) 
				self:removeDeadMonsters(localHero)
			else
				self:removeDeadMonsters(localHero)
				heroes[currentHero].heroTurn = false
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
--]]

	local p = nil
	local cover, blockedC, blockedR = self.world:lineOfCover(attacker.c, attacker.r, defender.c, defender.r)
	if blockedC then 
		-- launch a projectile that hits something along the way
		-- TODO: FIX projectil should move direction defender, not direction obstacle
		--       they are sometimes slightly different and it looks weird
		p = Projectile.new(weapon.projectile, attacker.c, attacker.r, blockedC, blockedR)
		DEBUG("launching (blocked)",weapon.name, attacker.c, attacker.r, blockedC, blockedR) 
	else
		-- launch a projectile towards the defender
		p = Projectile.new(weapon.projectile, attacker.c, attacker.r, defender.c, defender.r)	
		--DEBUG("launching (free)",weapon.name, attacker.c, attacker.r, blockedC, blockedR) 
	end

	-- Add the projectile to the world which takes care of scaling and dragging.
	-- TODO this smells (encapsulation violation), so maybe projectiles should be managed by WorldMap?
	self.world.camera:addChild(p)
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
					self.msg:add(weapon.missSound, MSG_ATTACK)
				end
			else
				self.sounds:play(weapon.projectile .. "-hit")
				self:rollDamage(weapon, attacker, defender, crit)
			end
		end

		if heroes[currentHero].heroTurn  then 		
			if self.remote then
				DEBUG("Range Attack", "Hero", attacker.heroIdx, attacker.c, attacker.r, "Monster", defender.id, defender.hp)	
				self:syncTurn(attacker.heroIdx, attacker.c, attacker.r, defender.id, defender.hp, defender.HPbar) 
				self:removeDeadMonsters(localHero)
			else
				self:removeDeadMonsters(localHero)
				heroes[currentHero].heroTurn = false
				self:heroesTurnOver()
			end
		else
			attacker.done = true
			self:monsterTurnOver()
		end

--[[

		if heroes[currentHero].heroTurn  then 
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

	if defender.berserk then roll = roll / 2 end
	
	--adjust the defender's hp except for any resistances
	defender:setHealth(defender.hp - roll + defender.resist[weapon.type])
	
	--DEBUG(attacker.name, "hits", defender.name, defender.hp)
	
	if defender.hp <= 0 then
		defender.hp = 0
		defender.mc:die(defender.entry > 1) -- Monsters fade out
	end

	-- TODO FIX ANIMATION won't be needed much longer
	--[[
	if defender.hp > 0 then
		self.world:changeTile(LAYER_HP, defender.HPbar, defender.c, defender.r)
	end
	--]]
end

function ScenePlay:attackMonster(c, r)
--[[targets a monster at c, r
--]]

	--find the monster being attacked and their index in monsters.list 
	local monster = nil	
	local id = 0	
	for i = 1, #self.monsters.list do
		monster = self.monsters.list[i] 
		id = i
		if monster.c == c and monster.r == r then 
			break 
		end
	end
	
	--DEBUG("Attacking monster, at, with", monster.name, c, r, heroes[currentHero].weapon.name)
	
	--call the attack function
	self:basicAttack(heroes[currentHero], monster)
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


 function ScenePlay:onLine(event)
	--[[respond to the user click/touch event on the map.
		From is expected to be a hero, either the one of this line, or the same from the last line on the device
		event contains two points from/to each with row/colum of the action.
	--]]

	local from = event.from
	local to = event.to
	
	local keyFrom, layerFrom, tileFrom = self.world:getTileInfo(from.c, from.r)
	local keyTo, layerTo, tileTo = self.world:getTileInfo(to.c, to.r)

	--DEBUG("Line from", manual:getEntry("layers", layerFrom), keyFrom, from.c, from.r, "to", manual:getEntry("layers", layerTo), keyTo, to.c, to.r)
	
	--ASSERT_TRUE(layerFrom == LAYER_MONSTERS and keyFrom == 1, "Line doesn't start on a hero")

	--[[
	local hero = nil
	for key, value in ipairs(heroes) do
		DEBUG("Looking for hero", key, value.c, value.r)
		if value.c == from.c and value.r == from.r then
			hero = value
		end
	end
	if not ASSERT_TRUE(hero, "Layers say there is a hero, but no hero has these coordinates") then return end
	--]]

	-- TODO FIX PARTY need to use something like code above when we support parties
	hero = heroes[currentHero]
	--ASSERT_TRUE(hero.c == from.c and hero.r == from.r, "Line not originating at local hero")

	from.c, from.r = hero.c, hero.r
	
	-- Look
	if self.activeAction == "look" then
		self.msg:add("A " .. tileTo.name, MSG_DESCRIPTION)
		return
	end

	-- Click on hero (same, or different) -> Look, no matter the currently active action
	if keyTo == 1 then
		self.msg:add("A " .. tileTo.name, MSG_DESCRIPTION)
		return
	end
	
	-- Now we know that we either walk, melee or range, and to/from are distinct

	-- Target a monster
	if layerTo == LAYER_MONSTERS then
		local distance = distance(from, to)
		--DEBUG("Line leads to monster at distance", distance)
	
		-- Can they melee/range, let them melee/range
		if distance < hero.weapons[1].reach then
			self.activeAction = "attack"
			hero.weapon = hero.weapons[1]
			self.main.melee:updateVisualState(true)
			self.main.move:updateVisualState(false)
			self.main.look:updateVisualState(false)
			self.main.ranged:updateVisualState(false)
			self:attackMonster(to.c, to.r)
			return
		elseif distance < hero.weapons[2].reach then
			self.activeAction = "attack"
			hero.weapon = hero.weapons[2]
			self.main.melee:updateVisualState(false)
			self.main.move:updateVisualState(false)
			self.main.look:updateVisualState(false)
			self.main.ranged:updateVisualState(true)
			self:attackMonster(to.c, to.r)
			return
		else -- change mode to "move" on the fly
			self.activeAction = "move"
			self.main.melee:updateVisualState(false)
			self.main.move:updateVisualState(true)
			self.main.look:updateVisualState(false)
			self.main.ranged:updateVisualState(false)
			-- no return, drop out of two ifs and continue with move
		end
	end

	-- All that's left is moving towards to

	local dc, dr = self.world:shortestPath(from, to)
	
	--DEBUG(("Hero is at %d,%d walking %d,%d"):format(hero.c, hero.r, dc, dr))
	self:checkMove(hero, dc, dr)


--[[
		if self.activeAction == "attack" then
			--calculate the reach, check if it's the monster layer and make sure it wasn't the hero who was clicked
			-- FIX remove commented line below, as the next one seems to work
			--local inReach = math.abs(heroes[currentHero].c - x) <= heroes[currentHero].weapon.reach and math.abs(heroes[currentHero].r - y) <= heroes[currentHero].weapon.reach and
			--				layer == LAYER_MONSTERS and not (heroes[currentHero].c == x and heroes[currentHero].r == y)
			local inReach = distance({x=event.from.c,y=event.from.r},{x=event.to.r,y=event.to.r}) < heroes[currentHero].weapon.reach
			if layer == LAYER_MONSTERS and inReach then
				self:checkMove(heroes[currentHero], event.to.c - heroes[currentHero].c, event.to.r - heroes[currentHero].r)
			elseif (not tile.tactics == "player") and layer == LAYER_MONSTERS then
				self.msg:add(tile.name .. "is out of range", MSG_DESCRIPTION)	
			end
		elseif self.activeAction == "look" then
			self.msg:add("A " .. tile.name, MSG_DESCRIPTION)	
		elseif self.activeAction == "move" then
			--if a move action is selected, move the hero towards the tile 
			local deltaX = math.abs(heroes[currentHero].c - event.to.c)
			local deltaY = math.abs(heroes[currentHero].r - event.to.r)
			local dx, dy = 0, 0
			if deltaX > 0 or deltaY > 0 then
				--calculate the optimal dx, dy 
				if deltaX > deltaY then
					if event.to.c > heroes[currentHero].c then dx, dy = 1, 0 else dx, dy = -1, 0 end
				else
					if event.to.r > heroes[currentHero].r then dx, dy = 0, 1 else dx, dy = 0, -1 end
				end
				--DEBUG(("Hero is at %d,%d walking %d,%d"):format(heroes[currentHero].c, heroes[currentHero].r, dx, dy))
				self:checkMove(heroes[currentHero],dx, dy)
			end
		end
--]]
--[[


	if visibleMapTouched then
		--find the tile that was touched
		--local key, layer, tile = self.world:getTileInfo(x, y)
		local key, layer, tile = self.world:getTileInfo(x, y)
		
		--DEBUG("Touch at " .. event.c .. ", " .. event.r .. " / " .. x .. ", " .. y )
		
		if self.activeAction == "attack" then
			--calculate the reach, check if it's the monster layer and make sure it wasn't the hero who was clicked
			-- FIX remove commented line below, as the next one seems to work
			--local inReach = math.abs(heroes[currentHero].c - x) <= heroes[currentHero].weapon.reach and math.abs(heroes[currentHero].r - y) <= heroes[currentHero].weapon.reach and
			--				layer == LAYER_MONSTERS and not (heroes[currentHero].c == x and heroes[currentHero].r == y)
			local inReach = distance(heroes[currentHero], event) < heroes[currentHero].weapon.reach and
							layer == LAYER_MONSTERS and not (heroes[currentHero].c == x and heroes[currentHero].r == y)
			if inReach then
				self:checkMove(heroes[currentHero], x - heroes[currentHero].c, y - heroes[currentHero].r)
			elseif (not tile.tactics == "player") and layer == LAYER_MONSTERS then
				self.msg:add(tile.name .. "is out of range", MSG_DESCRIPTION)	
			end
		elseif self.activeAction == "look" then
			self.msg:add("A " .. tile.name, MSG_DESCRIPTION)	
		elseif self.activeAction == "move" then
			--if a move action is selected, move the hero towards the tile 
			local deltaX = math.abs(heroes[currentHero].c - x)
			local deltaY = math.abs(heroes[currentHero].r - y)
			local dx, dy = 0, 0
			if deltaX > 0 or deltaY > 0 then
				--calculate the optimal dx, dy 
				if deltaX > deltaY then
					if x > heroes[currentHero].c then dx, dy = 1, 0 else dx, dy = -1, 0 end
				else
					if y > heroes[currentHero].r then dx, dy = 0, 1 else dx, dy = 0, -1 end
				end
				--DEBUG(("Hero is at %d,%d walking %d,%d"):format(heroes[currentHero].c, heroes[currentHero].r, dx, dy))
				self:checkMove(heroes[currentHero],dx, dy)
			end
		end
	else
		--DEBUG(("Touch outside visible map at %d,%d"):format(event.c, event.r))
	end
	
	--]]
end

