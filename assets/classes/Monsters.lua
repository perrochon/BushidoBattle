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
Monster = Core.class()

function Monster:init(entry, id)
	--[[variable to hold the monster's stats
		entry is the monster # that is created.  The # in the MANUAL and in the tileset
	--]]

	--position/key in the MM and tileset-monsters
	self.entry = entry
	self.id = id
	-- temporary coordinates when first created
	self.x, self.y = 0, 0
	self.blocked = true
	--info is the entry in the monster manual 
	local info = manual:getEntry("monsters", entry)	
	self.name = info.name
	self.xp = info.xp 
	self.attacks = info.attacks

	--these variables help keep track of health
	self.hp = info.hp
	self.maxHP = self.hp
	self.bloodiedHP = math.ceil(self.hp / 2)
	self.HPbar = 0
	
	--these are used by basicAttack
	self.prof = info.prof
	self.defense = info.defense
	--self.weapons = info.weapons
	
	self.weapons = {}
	self.weapons[1] = manual:getEntry("weapons", info.weapon1)
	if info.weapon2 then 
		self.weapons[2] = manual:getEntry("weapons", info.weapon2)
	end
	
	self.weapon = self.weapons[1]	
	-- resistances. vulnerabilities would be listed as negative (-5, etc..)
	self.resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}
	
	--these are used by the AI
	self.tactics = info.tactics

	--possible states: attack, flee, move
	self.state = "move"
	self.bloodied = false
	self.inrange = false 
	self.friends = false
	self.seesHero = false
end

Monsters = Core.class(Sprite)

function Monsters:init(level)
--creates the Monsters variable self.list, a table of all the monsters

    self.list = {}
	local id = 1

	--place #2 monsters 
	for i = 1, MONSTERS_2 + level*2 do
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

function Monsters:updateState(monster, id, hero)
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
			if math.abs(monster.x - other.x) <= 6 or math.abs(monster.y - other.y) <= 6 then 
				monster.friends = true
			end
		end
	end
	--check if the hero can been seen
	monster.seesHero = (math.abs(monster.x - hero.x) <= 6 or math.abs(monster.y - hero.y) <= 6)
	--if not, just move
	if not monster.seesHero then
		monster.state = "move"
	else
		--update based on their tactical role
		if monster.tactics == "minion" then
			--minions flee if bloodied or alone
			if monster.bloodied or not monster.friends then
				monster.state = "flee"
			else
				monster.state = "move"
			end
		elseif monster.tactics == "skirmisher" then
			--skirmishers flee if bloodied and alone
			if monster.bloodied and not monster.friends then
				monster.state = "flee"
			else
				monster.state = "move"
			end 
			--skirmishers change to their melee weapon if the hero is close
			if (math.abs(monster.x - hero.x) == 1 and math.abs(monster.y - hero.y) == 1) then
				monster.weapon = monster.weapons[2]
			end
		elseif monster.tactics == "soldier" and monster.bloodied then
			--soldiers change to their berserk weapon if bloodied
			monster.weapon = monster.weapons[2]
		else
			monster.state = "move"
		end
		
		--next check if the hero is in range
		monster.inrange = math.sqrt(math.pow(monster.x - hero.x,2) + math.pow(monster.y - hero.y,2)) <= monster.weapon.reach 

		--so far the states have been changed to flee or move. update to attack if in range.
		if monster.inrange and not (monster.state == 'flee') then
			monster.state = 'attack'
		end
	end
	local inrange
	if monster.inrange then inrange = "yes" else inrange = "no" end
	--DEBUG("Monster " .. monster.name .. " state is " .. monster.state .. " - inrange " .. inrange)
end