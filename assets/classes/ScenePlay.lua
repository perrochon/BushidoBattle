--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
	Game Logic
--]]

ScenePlay = Core.class(Sprite)
 
function ScenePlay:init()

	self.heroTurn = true

	--the major gaming variables
	self.hero = dataSaver.load("|D|hero")
	self.monsters = Monsters.new(self.hero.level)
	self.world = WorldMap.new(self.hero, self.monsters)	
	self.msg = Messages.new()
	self.sounds = Sounds.new("game")

	--get everything on the screen
	self:addChild(self.world)
	self:addChild(self.msg)
	self.main = MainScreen.new(self.hero)
	self:addChild(self.main)
	
	--respond to the compass directions
	self.main.north:addEventListener("click", function() ScenePlay:cheater(0) self:checkMove(0, -1) end)
	self.main.south:addEventListener("click", function() ScenePlay:cheater(1) self:checkMove(0, 1)  end)
	self.main.west:addEventListener("click", function() ScenePlay:cheater(2) self:checkMove(-1, 0)  end)
	self.main.east:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(1, 0)  end)
	self.main.northwest:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(-1, -1)  end)
	self.main.northeast:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(1, -1)  end)
	self.main.southwest:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(-1, 1)  end)
	self.main.southeast:addEventListener("click", function() ScenePlay:cheater(3) self:checkMove(1, 1)  end)
	self.main.center:addEventListener("click", function()
		if ScenePlay:cheater(4) then 
			self.main:displayCheats()
		end
		if not self.heroTurn then return end
		self:heroTurnOver() 
	end)

	self.cheat = ""
	self.main.death:addEventListener("click", function () self.cheat = "D" end)
	self.main.victory:addEventListener("click", function () self.cheat = "V" end)
	self.main.reset:addEventListener("click", function () 			
		os.remove("|D|hero.json")
		sceneManager:changeScene(SCENE_LOBBY, TRANSITION_TIME, SceneManager.flip) 
	end)

	-- respond to keys pressed (mainly for easier testing on desktop)
	self:addEventListener(Event.KEY_DOWN, function(event)
		if event.keyCode == KeyCode.UP or event.keyCode == KeyCode.W then
			self:checkMove(0, -1)
		elseif event.keyCode == KeyCode.DOWN or event.keyCode == KeyCode.S then
			self:checkMove(0, 1)
		elseif event.keyCode == KeyCode.LEFT or event.keyCode == KeyCode.A then
			self:checkMove(-1, 0)
		elseif event.keyCode == KeyCode.RIGHT or event.keyCode == KeyCode.D then
			self:checkMove(1, 0)
		elseif event.keyCode == KeyCode.SPACE then
			if not self.heroTurn then return end
			self:heroTurnOver()
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
	   self.hero.weapon = self.hero.weapons[1]
	   self.main.melee:updateVisualState(true)
	   self.main.move:updateVisualState(false)
	   self.main.look:updateVisualState(false)
	   self.main.ranged:updateVisualState(false)
	 end)
	 self.main.ranged:addEventListener("click", function() 
	   self.active = "attack"
	   self.hero.weapon = self.hero.weapons[2]
	   self.main.ranged:updateVisualState(true)
	   self.main.move:updateVisualState(false)
	   self.main.look:updateVisualState(false)
	   self.main.melee:updateVisualState(false)
	 end)	
	 
	 
	--respond to touch events
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
	
end

function ScenePlay:checkMove(dx, dy)
	--[[move the hero if the tile isn't blocked
	--]]
	-- first we need the tile key and layer for where the hero wants to move
	
	--DEBUG("ScenePlay: checkMove")
	
	local entry, layer, tile = self.world:getTileInfo(self.hero.x + dx, self.hero.y + dy)

	DEBUG("ScenePlay:checkMove", self.hero.x + dx, self.hero.y + dy, entry, layer, tile.id, tile.name, tile.blocked, tile.cover)

	if not self.heroTurn then return end

  if self.active == "look" then 
    self.msg:add("A " .. tile.name, MSG_DESCRIPTION) 
  elseif self.active == "attack" then 
    if layer == LAYER_MONSTERS then
      self:attackMonster(self.hero.x + dx, self.hero.y + dy)
    else
	  -- self.msg:add("Not a monster", MSG_DESCRIPTION)
	  self.active = "move"
      self.main.melee:updateVisualState(false)
      self.main.move:updateVisualState(true)
      self.main.look:updateVisualState(false)
      self.main.ranged:updateVisualState(false)
    end
  end
  if self.active == "move" then
    if layer == LAYER_MONSTERS then
      -- allow them to bump and melee attack when moving
      self.active = "attack"
      self.hero.weapon = self.hero.weapons[1]
      self.main.melee:updateVisualState(true)
      self.main.move:updateVisualState(false)
      self.main.look:updateVisualState(false)
      self.main.ranged:updateVisualState(false)
      self:attackMonster(self.hero.x + dx, self.hero.y + dy)
    elseif layer == LAYER_ENVIRONMENT then
	

	
      -- check for blocked tiles
      if tile.blocked then
        self.msg:add("A " .. tile.name, MSG_DESCRIPTION) 
      else
        self.world:moveHero(self.hero, dx, dy)
        self.sounds:play("hero-steps")
        self:heroTurnOver()
      end
    else
      self.world:moveHero(self.hero, dx, dy)
      self.sounds:play("hero-steps")
      self:heroTurnOver()
    end
  end
 end
 
 function ScenePlay:onMouseUp(event)
	--[[respond to the user touching the map.  Checks if the map part of the screen was touched, the responds depending on which button is activeButton
		Called from Event.MOUSE_UP
		Calls checkMove, messages:add, world:getTileInfo
	--]]


	DEBUG("ScenePlay:onMouseUp")

	--only check visible parts of the map
	local x = self.hero.x + math.ceil(event.x / TILE_WIDTH) - 6
	local y = self.hero.y + math.ceil(event.y / TILE_HEIGHT) - 6
	local key, layer = 0, 0
	local visibleMapTouched = (event.x < FG_X and x >= 0 and x <= LAYER_COLUMNS and y >= 0 and y <= LAYER_ROWS)
	
	if visibleMapTouched then
		--find the tile that was touched
		--local key, layer, tile = self.world:getTileInfo(x, y)
		local key, layer, tile = self.world:getTileInfo(x, y)
		
		DEBUG("ScenePlay:onMouseUp Touch at " .. event.x .. ", " .. event.y .. " / " .. x .. ", " .. y )
		
		if self.active == "attack" then
			--calculate the reach, check if it's the monster layer and make sure it wasn't the hero who was clicked
			local inReach = math.abs(self.hero.x - x) <= self.hero.weapon.reach and math.abs(self.hero.y - y) <= self.hero.weapon.reach and
							layer == LAYER_MONSTERS and not (self.hero.x == x and self.hero.y == y)
			if inReach then
				self:checkMove(x - self.hero.x, y - self.hero.y)
			elseif (not tile.tactics == "player") and layer == LAYER_MONSTERS then
				self.msg:add(tile.name .. "is out of range", MSG_DESCRIPTION)	
			end
		elseif self.active == "look" then
			self.msg:add("A " .. tile.name, MSG_DESCRIPTION)	
		elseif self.active == "move" then
			--if a move action is selected, move the hero towards the tile 
			local deltaX = math.abs(self.hero.x - x)
			local deltaY = math.abs(self.hero.y - y)
			local dx, dy = 0, 0
			if deltaX > 0 or deltaY > 0 then
				--calculate the optimal dx, dy 
				if deltaX > deltaY then
					if x > self.hero.x then dx, dy = 1, 0 else dx, dy = -1, 0 end
				else
					if y > self.hero.y then dx, dy = 0, 1 else dx, dy = 0, -1 end
				end
				DEBUG(("ScenePlay:onMouseUp Hero is at %d,%d walking %d,%d"):format(self.hero.x, self.hero.y, dx, dy))
				self:checkMove(dx, dy)
			end
		end
	else
		DEBUG(("ScenePlay:onMouseUp Touch outside visible map at %d,%d"):format(event.x, event.y))
	end
end

function ScenePlay:heroTurnOver()
	--[[puts in one place all the things we want to keep track of after the hero's turn is done 
	--]]

	--DEBUG("ScenePlay:heroTurnOver")

	--find the monster being attacked and their index in monsters.list 
	for id, m in pairs(self.monsters.list) do
		if m.hp < 1 then		
			self.msg:add("you killed the " .. m.name, MSG_DEATH)
			self.hero.xp = self.hero.xp + m.xp
			self.hero.kills = self.hero.kills + 1
			--remove the monster from the monsters.list and the map
			table.remove(self.monsters.list, id)	
			self.world:removeMonster(m.x, m.y)	
		end
	end
	
	-- check if the player won 
	if #self.monsters.list == 0 or self.cheat == "V" then
		dataSaver.save("|D|hero", self.hero)
		sceneManager:changeScene(SCENE_VICTORY, TRANSITION_TIME, TRANSITION)
	end

	-- prepare for monster's turn
	self.heroTurn = false
	self.main.north:setAlpha(0.5)	
	self.main.south:setAlpha(0.5)
	self.main.east:setAlpha(0.5)
	self.main.west:setAlpha(0.5)
	self.main.center:setAlpha(0.5)

	-- first set all monsters to not done
	for id, m in pairs(self.monsters.list) do
		m.done = false
	end	
	--each monster gets a turn
	for id, m in pairs(self.monsters.list) do
		m.done = false
		self.monsters:updateState(m, id, self.hero)
		if (m.hp > 0) then -- redundant, as we remove dead monsters now explicitely
			--DEBUG("ScenePlay: Playing " .. m.name .. " at " .. m.x .. " " .. m.y)
			self:monsterAI(m)
		end	
	end	
end

function ScenePlay:monsterTurnOver()

	-- make sure all the monsters attacked
	local done = true
	for id, m in pairs(self.monsters.list) do
		done = done and m.done
	end
	if not done then 
		--DEBUG("ScenePlay: monsterTurnOver - not done")
		return
	else
		--DEBUG("ScenePlay: monsterTurnOver - done -------------------------------")
	end
	
	--after all the monsters attacked, check if the hero lost
	if self.hero.hp < 1 or self.cheat == "D" then
		self.msg:add("you died", MSG_DEATH)
		dataSaver.save("|D|hero", self.hero)
		sceneManager:changeScene(SCENE_DEATH, TRANSITION_TIME, TRANSITION)
	end

	-- enable hero again
	self.heroTurn = true
	self.main.north:setAlpha(1)	
	self.main.south:setAlpha(1)
	self.main.east:setAlpha(1)
	self.main.west:setAlpha(1)
	self.main.center:setAlpha(1)
	
end
  
function ScenePlay:monsterAI(monster)
	--[[Logic: attack or move based on monster.state
		Called from heroTurnOver 
		Calls world:blocked, world:moveMonster, world:whichWay, basicAttack
	--]]

	if monster.state == "move" then
		--dx, dy are the direction coordinates where the monster will move
		local dx, dy = 0, 0
		if monster.seesHero then
			--move towards the hero
			self.sounds:play("monster-steps")
			dx, dy = self.world:whichWay(monster, self.hero.x, self.hero.y)
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
				if tries == 4 then successful = true end
			end
		end
		self.world:moveMonster(monster, dx, dy)
		monster.done = true
		self:monsterTurnOver()
	elseif monster.state == "flee" then
		--move away from the hero
		dx, dy = self.world:whichWay(monster, self.hero.x, self.hero.y)
		self.world:moveMonster(monster, dx, dy)
		monster.done = true
		self:monsterTurnOver()
	elseif monster.state == "attack" then
		--attack the hero
		self:basicAttack(monster, self.hero)
	end
end

function ScenePlay:basicAttack(attacker, defender)
	--[[resolve the to hit and damage rolls based on the attacker's weapon
		takes into account attacker's and defender's conditions
		Called from attackMonster and monsterAI
		Calls roll, world:changeTile, 
		Changes defender.hp, .HPbar
	--]]

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
		if self.heroTurn then 
			self:heroTurnOver() 
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
		p = Projectile.new(weapon.projectile, attacker.x - self.hero.x, attacker.y - self.hero.y,
							blockedX - self.hero.x, blockedY - self.hero.y)
	else
		-- launch a projectile towards the defender
		p = Projectile.new(weapon.projectile, attacker.x - self.hero.x, attacker.y - self.hero.y,
							defender.x - self.hero.x, defender.y - self.hero.y)	
	end
	self:addChild(p)
	p:addEventListener("animation finished", function(event)
		--DEBUG("ScenePlay: EventListener called")
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
		--DEBUG("ScenePlay: EventListener heroTurn is " .. boolToString(true))
		if self.heroTurn then 
			self:heroTurnOver() 
		else
			attacker.done = true
			self:monsterTurnOver()
		end
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
	self:basicAttack(self.hero, monster)
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

	if self.cheatcount == want then
		self.cheatcount += 1
		--DEBUG("ScenePlay: cheatcount increase to " .. self.cheatcount)
		return true
	else
		self.cheatcount = 0
		--DEBUG("ScenePlay: cheatcount reset to 0")
		return false
	end
end



