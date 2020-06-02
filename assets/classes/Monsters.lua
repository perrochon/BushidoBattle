--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
	Monsters and their attributes
	There are two classes here: 
		Monster class with stats for each monster 
		Monsters class which is a list of the monsters in play
--]]

if not json then
	require "json"
end

Monster = Core.class(Character)

function Monster:init(entry, id)
	--[[variable to hold the monster's stats
		entry is the monster # that is created.  The # in the MANUAL and in the tileset
	--]]
	
	ASSERT_TRUE(self.entry > 1) -- Heroes are 1, monsters are > 1

	-- TODO REFACTOR superclass should call this
	self:loadSprite()
	DEBUG(self.entry, self.id, self.name, self.sprite, self.xp, self.hp, self.see, self.alone)


	--Monster additional fields
	
	--possible states: attack, flee, move
	self.state = "move"
	self.bloodied = false
	self.inrange = false 
	self.friends = false
	self.seesHero = false

	-- TODO REFACTOR remove the rest...
	--position/key in the MM and tileset-monsters
	-- temporary coordinates when first created
	--self.x, self.y = 0, 0
	--self.blocked = true 								-- is this used anywhere?
	--info is the entry in the monster manual 
	--self.info = manual:getEntry("monsters", entry)	
	--self.name = self.info.name
	--self.xp = self.info.xp 
	--self.attacks = self.info.attacks
	--these variables help keep track of health
	--self.hp = self.info.hp
	--self.maxHP = self.hp
	--self.HPbar = 0
	--these are used by basicAttack
	--self.prof = self.info.prof
	--self.weapons = info.weapons
	
	--self.weapons = {}
	--self.weapons[1] = manual:getEntry("weapons", self.info.weapon1)
	--if self.info.weapon2 then 
		--self.weapons[2] = manual:getEntry("weapons", self.info.weapon2)
	--end
	
	--self.weapon = self.weapons[1]	
	-- resistances. vulnerabilities would be listed as negative (-5, etc..)
	--self.resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}
	
	--these are used by the AI
	--self.tactics = self.info.tactics
	--self.see = self.info.see
	--self.alone = self.info.alone

	--possible states: attack, flee, move
	self.state = "move"
	self.bloodied = false
	self.inrange = false 
	self.friends = false
	self.seesHero = false
	
end


function Monster:serialize()
	local array = {}
	array["id"] = self.id
	array["entry"] = self.entry
	array["x"] = self.x
	array["y"] = self.y
	array["hp"] = self.hp
	array["HPbar"] = self.HPbar
	return array
end

function Monster:deserialize(m)
	if (self.id ~= m["id"]) then DEBUG("Monster mismatch", self.id, m["id"]) return end
	self.entry = m["entry"]
	self.x = tonumber(m["x"])
	self.y = tonumber(m["y"])
	self.hp = tonumber(m["hp"])
	self.HPbar = tonumber(m["HPbar"])
end

Monsters = Core.class(Sprite)

function Monsters:init(mapData)
--creates the Monsters variable self.list, a table of all the monsters

    self.list = {}
	local id = 1 -- FIX we are inserting at the end, why do we need i?
	
	--DEBUG(json.encode(mapData.spawns))

	for _, v in pairs(mapData.spawns) do
		if v.type ~= 1 then
			--DEBUG(json.encode(v))
			local m = Monster.new(v.type, id)
			m:setPosition(v.x, v.y)
			m.sentry = v.sentry
			m.berserk = v.berserk
			table.insert(self.list, m)
			id += 1
		end
	end
	
	--[[

	--place #2 monsters 
	for i = 1, MONSTERS_2 + level*5 do
		table.insert(self.list, Monster.new(2,id))
		id += 1
	end
	--place #3 monsters 
	for i = 1, MONSTERS_3 + level do
		table.insert(self.list, Monster.new(3,id))
		id += 1
	end
	--place #4 monster
	for i = 1, MONSTERS_4 do
		table.insert(self.list, Monster.new(4,id))
		id += 1
	end
	
	--]]

end

function Monsters:initFromServer(monstersInfo)
	DEBUG(monstersInfo)
	local info = json.decode(monstersInfo)
	self.list = {}
	for k, m in pairs(info) do
		DEBUG(k, m, m == NULL)
		local monster = Monster.new(m["entry"], m["id"])
		monster:deserialize(m)
		table.insert(self.list, monster)
	end
end

function Monsters:Test1()
	info1 = self:serialize()
	self:deserialize(info1)
	info2 = self:serialize()
	if info1 == info2 then 
		--DEBUG("Test 1 Passed")
	else
		DEBUG ("Serialization/Deserializatin failed")
	end	
end


function Monsters:Test2()
	--DEBUG(self:serialize())
	table.remove(self.list, 2)
	--DEBUG(self:serialize())
	local array = {}
	for key, m in pairs(self.list) do
		--DEBUG(key, m, m.id)
		table.insert(array, m:serialize())
	end
	--DEBUG(json.encode(array))
	local array = {}
	for key, m in pairs(self.list) do
		--DEBUG(key, m, m.id)
		array[tostring(m.id)] = m:serialize()
	end
	--DEBUG(json.encode(array))

end

function Monsters:serialize()
	local array = {}
	for key, m in pairs(self.list) do
		--DEBUG(key, m, m.id)
		table.insert(array, m:serialize())
	end
	local string = json.encode(array)
	--DEBUG(string)
	return string
end

function Monsters:deserialize(monstersInfo)
	local info = json.decode(monstersInfo)
	for k, m in pairs(info) do
		local monster = self:getMonster(m["id"])
		monster:deserialize(m)
	end
end

function Monsters:getMonster(id)
  for _, m in ipairs(self.list) do
    if m.id == id then
      return m
    end
  end
  ERROR("No monster with id", id)
  return nil
end

function Monsters:updateState(monster, id, heroes, remote)
--[[update the 'State' variables for each monster:
		.bloodied 
		.inrange  
		.friends 
		.seesHero 
		.state = "move", not fleeing and not in range
				 "attack", not fleeing and in range
				 "flee", bloodied
		Also, change weapons based on .info.tactics
--]]

	--update the bloodied variable
	monster.bloodied = (monster.hp <= monster.bloodiedHP)

	--check if there are friends around
	for i = 1, #self.list do
		if id ~= i then
			local other = self.list[i] 
			if distance(monster, other) < monster.alone then 
				monster.friends = true
			end
		end
	end

	--check if the hero can been seen
	do
		local hero
		if not remote then
			hero = heroes[1]
		else
			local closerHero = distance(monster, heroes[1]) < distance(monster, heroes[2]) and 1 or 2
			hero = heroes[closerHero]
		end
		monster.seesHero = distance(monster, hero) < monster.see or monster.berserk
		monster.target = monster.seesHero and hero or nil
	end
	
	if not monster.seesHero then
			monster.state = "move"
	else
		--update based on their tactical role
		if monster.tactics == "minion" then
			--minions flee if bloodied or alone, unless berserk
			if not monster.berserk and (monster.bloodied or not monster.friends) then
				monster.state = "flee"
			else
				monster.state = "move"
			end
		elseif monster.tactics == "soldier" then
			--soldiers change to their melee weapon if the hero is close
			if distance(monster, monster.target) <= monster.weapons[1].reach then
				monster.weapon = monster.weapons[1]
			else
				monster.weapon = monster.weapons[2]
			end
			monster.state = "move"
		else
			monster.state = "move"
		end
				
		--next check if the hero is in range
		monster.inrange = distance(monster, monster.target) <= monster.weapon.reach

		--so far the states have been changed to flee or move or wait. update to attack if in range.
		if monster.inrange and not (monster.state == 'flee') then
			monster.state = 'attack'
		end		
	end
	
	if monster.sentry and monster.state == "move" then
			monster.state = "wait"
	end

	
	--DEBUG(monster.name, monster.x, monster.y, monster.state, distance(monster, monster.target), monster.inrange)
end
