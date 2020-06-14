--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
WorldMap class and all the functions associated with it: changing tiles, generating the arrays, querying locations, etc..
]]

WorldMap = Core.class(Sprite)

function WorldMap:init(level, monsters)

	--Create tables for map content (self.mapArrays) and for each TileMap (self.mapLayers)	
	--self.level = Level.new(currentMapFileName) -- read the file
	
	self.level = level

	self.mapArrays = {} -- a numeric key indicating what's in this place - defined in tiled maps and constants.lua
	self.mapLayers = {} -- the actual tile that is painted


	self.camera = Camera.new({maxZoom=3,friction=.95}) -- higher seems to make it "more slippery" (documentation says lower).

	-- assign TileMaps to self.mapLayers. table.insert ads at the end, so the order here matters
	-- needs to be consistent with Constants.lua, but also rendering.
	
	local layer1,array1 = self.level:layerFromMap(LAYER_TERRAIN)
	self.camera:addChild(layer1) 
	table.insert(self.mapLayers, layer1)
	table.insert(self.mapArrays, array1)
	--self:debugMapInfo(LAYER_TERRAIN)

	local layer2,array2 = self.level:layerFromMap(LAYER_ENVIRONMENT)
	self.camera:addChild(layer2) 
	table.insert(self.mapLayers, layer2)
	table.insert(self.mapArrays, array2)
	--self:debugMapInfo(LAYER_ENVIRONMENT)

	-- TODD FIX ANIMATION LAYER_HP can soon go away
	self.mapArrays[LAYER_MONSTERS] = self:placeCharacters(monsters)
	layer = self:returnTileMap(self.mapArrays[LAYER_MONSTERS], "monsters")
	layer:setAlpha(0.6)

	local where = self.camera:getChildIndex(layer2)
	self.camera:addChildAt(layer, where) 

	table.insert(self.mapLayers, layer)
	--self:debugMapInfo(LAYER_MONSTERS)	

	-- TODD FIX ANIMATION LAYER_HP can soon go away
	self.mapArrays[LAYER_HP] = self:addHP()
	self.mapArrays[LAYER_LIGHT] = self:addLight()
    self:shiftWorld(heroes[localHero])

	layer = self:returnTileMap(self.mapArrays[LAYER_HP], "health")
	--self.camera:addChild(layer) 
	table.insert(self.mapLayers, layer)

	layer = self:returnTileMap(self.mapArrays[LAYER_LIGHT], "light")
	self.camera:addChild(layer) 
	table.insert(self.mapLayers, layer)	

	self:addChild(self.camera)
end

function WorldMap:index(c, r) --index of cell (c,r)
	return c + (r - 1) * LAYER_COLUMNS 
end


function WorldMap:placeCharacters(monsters)
	--[[Return an array to represent the characters tiles. 
		Returns a table of size LAYER_COLUMNS * LAYER_ROWS
	--]]

	local mArray = {}

	for r = 1, LAYER_ROWS do
		for c = 1, LAYER_COLUMNS do
			mArray[self:index(c, r)] = 0
		end
	end
	
	for _, monster in pairs(monsters.list) do
		mArray[self:index(monster.c, monster.r)] = monster.entry
		self.camera:addChild(monster.mc)
	end

	for _, hero in pairs(heroes) do
		if hero.active then
			mArray[self:index(hero.c, hero.r)] = hero.entry
			self.camera:addChild(hero.mc)
		end
	end
	
	return mArray
end

function WorldMap:addHP()

  --tiles are 0 at the start
  local hArray = {}
  for y = 1, LAYER_ROWS do
    for x = 1, LAYER_COLUMNS do
      hArray[self:index(x, y)] = 0
    end
  end
  return hArray
end

function WorldMap:addLight() 
	--[[Logic:  returns an array filled with light tile values with the area near the hero visible
		Returns a table of size LAYER_COLUMNS * LAYER_ROWS
	--]]
	
	local hero = heroes[localHero] 	-- TODO HEROFIX loop through all active heroes

	--this is the array filled with darkness of unexplored tiles
	local lArray = {}
	for y = 1, LAYER_ROWS do
		for x = 1, LAYER_COLUMNS do
			lArray[self:index(x, y)] = LIGHT_UNEXPLORED -- TODO such constants should really not be hard coded...
		end
	end
	
	--this overlays the hero with a torch array
	--torch array is overkill if lightsources are symmetric. Could be computed
	local torchIndex = 0
	for r = hero.r - hero.light.radius, hero.r + hero.light.radius do
		for c = hero.c - hero.light.radius, hero.c + hero.light.radius do
			torchIndex = torchIndex + 1
			--only change the light array if on the screen
			if c > 0 and c <= LAYER_COLUMNS and r > 0 and r <= LAYER_ROWS and hero.light.array[torchIndex] ~= 0 then
				local i = self:index(c, r)
				lArray[i] = hero.light.array[torchIndex]
				--DEBUG(r, c, hero.light.array[torchIndex])
			end
		end
	end
	return lArray
end

function WorldMap:returnTileMap(mapArray, layer)
	--[[Logic:  return a TileMap for a given tileset	
		Returns a TileMap
	--]]

	local pack = manual.lists[layer].pack

	local tilemap = TileMap.new(LAYER_COLUMNS, LAYER_ROWS, pack, TILE_WIDTH, TILE_HEIGHT)
	
	--use setTile to assign a tile based on the mapArray index
	for y = 1, LAYER_ROWS do
		for x = 1, LAYER_COLUMNS do

			local key = mapArray[self:index(x, y)]

			if layer == "monsters" then
				--only setTiles if the mapArray value isn't 0
				if key ~= 0 then
					local monster = manual:getEntry("monsters", key)	
					--DEBUG(monster.name, monster.tC, monster.tR)
					tilemap:setTile(x, y, monster.tC, monster.tR)
				end
			elseif layer == "light" then
				--DEBUG(x, y, self:index(x, y), key )
				tilemap:setTile(x, y, key, 1)
			elseif layer == "health" then
				-- do nothing at creation
			end
		end
	end
	
	return tilemap
end


function WorldMap:getTileInfo(c, r, layer) 
	--[[Return the tile key, layer and tile information for a location on the map. 
				if no TileMap layer is specified, it returns the highest layer with a value.  
				i.e. monster #3, environment #2, or terrain #1
		Returns key, layer, tile
	--]]

	local i = self:index(c, r)

	--DEBUG(("(%d, %d) %d 1: %d 2:%d 3:%d"):format(c, r, layer and layer or -1, self.mapArrays[1][i], self.mapArrays[2][i], self.mapArrays[3][i]))
	
	if layer then
		local array = self.mapArrays[layer]
		local tile = nil
		--return the value for the given layer
		if layer > 2 then
			-- get tile information from constants
			tile = manual:getEntry(manual:getEntry("layers", layer), array[i])
		else
			tile = self.level.tiles[array[i]] -- FIX replace with getFunction
		end
		if tile ~= nil then
			--DEBUG(c, r, layer, array[i], tile.id, tile.name, tile.blocked)
		else
			--DEBUG(c, r, layer, array[i], "no tile")		
		end			
		return array[i], layer, tile
	else
		--go through remaining layers - which come from tiled
		for n = 3, 1, -1 do		
			local array = self.mapArrays[n]
			--find the first value that isn't 0
			if array[i] ~= 0 then
				if n == 3 then
					-- get tile information from constants
					local tile = manual:getEntry(manual:getEntry("layers", n), array[i])
					--DEBUG(c, r, n, tile.id, tile.name, tile.blocked)
					return array[i], n, tile			
				else
					local tile = self.level.tiles[array[i]] -- FIX replace with getFunction
					--DEBUG(c, r, n, tile.id, tile.name, tile.blocked)
					return array[i], n, tile
				end
			end
		end
		ERROR("There is no tile in the ground layer at", c, r)
		return 1,1,{id = 1, name = "no tile", blocked = true} 
	end
end

function WorldMap:changeTile(layerId, entry, x, y)
	--Change both the self.mapArrays entry and the tile in self.mapLayers

	local array = self.mapArrays[layerId]
	array[self:index(x, y)] = entry
	self.mapLayers[layerId]:setTile(x, y, entry, 1)
end

function WorldMap:shiftWorld(hero)
	--[[Moves the camera to the hero's location
		May require more complexity with multiple heroes
		May need changes after user testing. E.g. if user pans the map, should we not re-center on hero?
	--]]
	
	self.camera:centerPoint(hero.c * TILE_WIDTH, hero.r * TILE_HEIGHT)
	--DEBUG("Hero:", hero.c * TILE_WIDTH, hero.r * TILE_HEIGHT, hero.c, hero.r, 
	--      "camera:", self.camera.anchorX, self.camera.anchorY, 
	--		"Position", self.camera:getPosition(), "Scale:", self.camera:getScale()) 
end

function WorldMap:shiftWorld2()
	--[[Moves the camera to the hero's location
		May require more complexity with multiple heroes
		May need changes after user testing. E.g. if user pans the map, should we not re-center on hero?
	--]]
	
	self.camera:centerPoint(heroes[localHero].mc:getX(), heroes[localHero].mc:getY())
	--DEBUG("Hero:", hero.c * TILE_WIDTH, hero.r * TILE_HEIGHT, hero.c, hero.r, 
	--      "camera:", self.camera.anchorX, self.camera.anchorY, 
	--		"Position", self.camera:getPosition(), "Scale:", self.camera:getScale()) 
end


function WorldMap:moveHero(hero, dc, dr)
	--[[change the mapArrays and mapLayers location of a hero and 
		if it's the local hero, shift the TileMap and the light

		Changes hero.c, hero.r, position of the world
	--]]

	--DEBUG("Moving Hero", hero.name, hero.c, hero.r, dc, dr, "to", hero.c+dc, hero.r+dr)

	if hero.id == localHero then 
		--move the torchlight
		self:adjustLight(hero, dc, dr)
	end

	--for purposes of moving around the map, the hero is just another monster
	local tween = self:moveMonster(hero, dc, dr)
	
	tween.onChange = function()
		self:shiftWorld2()
	end
	
end

function WorldMap:adjustLight(hero, dc, dr)
	--[[change the light array tiles as the hero moves
		Uses the hero's old position and the hero.light.radius to create darkness there, and the new position to light up
	--]]	
	
	ASSERT_EQUAL(hero.id, localHero, "Trying to adjust light for the wrong hero")
		
	local lArray = self.mapArrays[LAYER_LIGHT]
	local i = 0

	--[[ -- TODO FIX This doesn't look good with smooth scrolling, need different solution or remove
	--set all previously lit tiles to 3
	for r = hero.r - hero.light.radius, hero.r + hero.light.radius do
		for c = hero.c - hero.light.radius, hero.c + hero.light.radius do
			--only change the light array and tile if on screen 
			if c > 0 and c <= LAYER_COLUMNS and r > 0 and r <= LAYER_ROWS then
				i = self:index(c, r)
				--only change if previously lit 
				if lArray[i] ~= LIGHT_UNEXPLORED then
					lArray[i] = LIGHT_DARK
					self.mapLayers[LAYER_LIGHT]:setTile(c, r, 3, 1)
				end
			end
		end
	end
	--]]

	local torchIndex = 0
	--overlay the torchArray tiles over the hero's new spot
	--TODO why can this not just be self:addLight (with modification)
	for r = hero.r + dr - hero.light.radius, hero.r + dr + hero.light.radius do
		for c = hero.c + dc - hero.light.radius, hero.c + dc + hero.light.radius do
			torchIndex = torchIndex + 1
			i = self:index(c, r)
			--only change the light array if on screen
			if c > 0 and c <= LAYER_COLUMNS and r > 0 and r <= LAYER_ROWS then
				--and needs to be updated
				if hero.light.array[torchIndex] ~= 0 then
					if lArray[i] > hero.light.array[torchIndex] then
						lArray[i] = hero.light.array[torchIndex]
						self.mapLayers[LAYER_LIGHT]:setTile(c, r, hero.light.array[torchIndex], 1)
					end
				end
			end
		end
	end
end

function WorldMap:moveMonster(monster, dc, dr)
	--[[change the mapArrays and mapLayers location of the monster 
	--]]

	--DEBUG("Moving Monster", monster.name, monster.c, monster.r, dc, dr, "to", monster.c+dc, monster.r+dr)

	--get the array and entry
	local array = self.mapArrays[LAYER_MONSTERS]
	
	--erase the monster in the array and TileMap

	-- DEBUG Getting non-reproducible errors on the next line in HTML - Checking for possible conditions
	if monster.c > LAYER_COLUMNS or monster.r > LAYER_ROWS or monster.c < 1 or monster.r < 1 then
		ERROR("Monster current location out of bounds", monster.name, monster.c, monster.r, dc, dr)
	elseif monster.c+dc > LAYER_COLUMNS or monster.r+dr > LAYER_ROWS or monster.c+dc < 1 or monster.r+dr < 1 then
		ERROR("Monster new location out of bounds", monster.name, monster.c, monster.r, dc, dr)
	else
		array[self:index(monster.c, monster.r)] = 0
		self.mapLayers[LAYER_MONSTERS]:clearTile(monster.c, monster.r)
		
		--place the monster at the new position
		array[self:index(monster.c + dc, monster.r + dr)] = monster.entry
		self.mapLayers[LAYER_MONSTERS]:setTile(monster.c + dc, monster.r + dr, monster.tC, monster.tR) 

		--remove and move the HPbar
		array = self.mapArrays[LAYER_HP]
		array[self:index(monster.c, monster.r)] = 0
		self.mapLayers[LAYER_HP]:clearTile(monster.c, monster.r) 	
		array[self:index(monster.c + dc, monster.r + dr)] = monster.HPbar
		if monster.HPbar ~= 0 then
			self.mapLayers[LAYER_HP]:setTile(monster.c + dc, monster.r + dr, monster.HPbar, 1) 
		end

		--update r and c
		local tween = monster:moveTo(monster.c + dc, monster.r + dr)
		return tween
	end
end

function WorldMap:removeMonster(x, y)
	local array = self.mapArrays[LAYER_MONSTERS]
	array[self:index(x, y)] = 0
	self.mapLayers[LAYER_MONSTERS]:clearTile(x, y) 	
	array = self.mapArrays[LAYER_HP]
	array[self:index(x, y)] = 0
	self.mapLayers[LAYER_HP]:clearTile(x, y) 	
end

function WorldMap:addMonster(monster)
	--[[ 
	--]]

	local x = monster.c
	local y = monster.r
	
	--get the array and entry
	local array = self.mapArrays[LAYER_MONSTERS]

	--DEBUG(x, y)
	--place the monster at the new position
	array[self:index(monster.c, monster.r)] = monster.entry
	self.mapLayers[LAYER_MONSTERS]:setTile(monster.c, monster.r, monster.entry, 1) 

	--add the HPbar
	array = self.mapArrays[LAYER_HP]
	array[self:index(monster.c, monster.r)] = monster.HPbar
	if monster.HPbar ~= 0 then
		self.mapLayers[LAYER_HP]:setTile(monster.c, monster.r, monster.HPbar, 1) 
	end
end


function WorldMap:blocked(x, y)
	--[[uses getTileInfo to determine if the tile is blocked or not
		returns true or false
	--]]
	--local i = self:index(x, y)
	--return (self.mapLayers[LAYER_MONSTERS] ~= 0) or tilemap:blocked(x,y)

	--getTileInfo returns the highest level layer key that isn't 0

	if x < 1 or x > LAYER_COLUMNS or y < 1 or y > LAYER_ROWS then
		DEBUG("x,y outside bounds", x,y)
		ERROR("Testing blocked on tile outside bound", x, y)
		return true
	end

	local key, layer, tile = self:getTileInfo(x, y)
	--DEBUG(x, y, key, layer, tile.name, tile.blocked)
	
	if layer == LAYER_MONSTERS then
		return true
	elseif layer == LAYER_ENVIRONMENT and tile.blocked then
		return true
	else
		return false
	end
end

function WorldMap:flee(monster, target)
	--[[ Return the direction (dx, dy) to move away from target. 
		 Chooses neighbouring tile furthest away from target
	--]]

	local c, r = monster.c, monster.r
	local dc, dr = 0, 0	-- the direction variables to return and the default values 0, 0
	local moves = {{-1, 0}, {0, 1}, {0, -1}, {1, 0}, {1, 1}, {-1, 1}, {1, -1}, {-1, -1} } -- the table of directions to try

	-- Sort by distance from the hero
	table.sort(moves, function (p1, p2) 
		return distance({c = c + p1[1], r = r + p1[2]},target) > distance({c = c + p2[1], r = r + p2[2]},target) 
	end) 

	-- Choose a non-blocked move
	for i, move in ipairs(moves) do
		dc, dr = move[1], move[2]
		--DEBUG(monster.id, monster.name, dc, dr, c+dc, r+dr, self:blocked(c + dc, r + dr))
		if not self:blocked(c + dc, r + dr) then		-- if not blocked then move in that direction 
			return dc, dr
		end
	end
	
	return 0, 0
end

function WorldMap:line(from, to)
	--	The classic Bresenham integer only line algorithm all Roguelikes use.
	--	Pick one tile along the direction of the line (one c for horizontal, one r for vertical)
	--  Return a table of {c, r} pairs on the line including {from.c, from.r} and {to.c, to.r}

	local line = {}							-- A line is series of c, r values. This gets returned
	local deltaC = math.abs(to.c - from.c)	-- The difference between the c's
	local deltaR = math.abs(to.r - from.r)	-- The difference between the r's
	local c = from.c			   			-- Start x off at the first point
	local r = from.r			   			-- Start y off at the first point

	--different increments of x and y are needed for each octant of LOS
	local incC1 = 0	
	local incC2 = 0
	local incR1 = 0
	local incR2 = 0

	if to.c >= from.c then			-- the x-values are increasing
		incC1, incC2 = 1, 1
	else						 	-- the x-values are decreasing
		incC1, incC2 = -1, -1
	end
	if to.r >= from.r then			-- the y-values are increasing
		incR1, incR2 = 1, 1
	else						  	-- the y-values are decreasing
		incR1, incR2 = -1, -1
	end
	
	--these variables are used to calculate the next points in the main loop
	local den = 0					-- denominator used to convert real number to integer
	local num = 0					-- numerator used to convert real number to integer
	local numAdd = 0				-- how much to add to the numerator
	local numPoints = 0	 			-- how many points (sometimes more x points than y points)
	
	if deltaC >= deltaR then	 	
	-- there is at least one x-value for every y-value
		incC1 = 0				  	-- don't change the x when numerator >= denominator
		incR2 = 0				  	-- don't change the y for every iteration
		den = deltaC	
		num = deltaC / 2
		numAdd = deltaR
		numPoints = deltaC	 		-- there are more x-values than y-values
	else						  
	-- there is at least one y-value for every x-value
		incC2 = 0				  	-- don't change the x for every iteration
		incR1 = 0				  	-- don't change the y when numerator >= denominator
		den = deltaR
		num = deltaR / 2
		numAdd = deltaC
		numPoints = deltaR		 	-- there are more y-values than x-values
	end

	--this is the main loop.  add x, y to the table called line
	for i = 0, numPoints do
		table.insert(line, {c, r})	-- add to the line table
		num = num + numAdd			-- increase the numerator by the top of the fraction
		if num >= den then		 	-- check if numerator >= denominator
			num = num - den		   	-- calculate the new numerator value
			c = c + incC1		   	-- change the x as appropriate
			r = r + incR1		   	-- change the y as appropriate
		end
		c = c + incC2			 	-- change the x as appropriate
		r = r + incR2			 	-- Change the y as appropriate
	end
	return line
end

function WorldMap:lineOfCover(from, to)
	-- Check tile.cover values until they go below -5 or we reach to
	-- Return totalCover, to if totalCover >= -5
	-- Return totalCover, <coordinates of blocker> if totalCover < -5 with 

	local totalCover = 0
	local line = self:line(from, to)

	-- remove the starting c, r
	table.remove(line, 1)
	for key, coordinates in pairs(line) do
		local c, r = coordinates[1], coordinates[2]

		-- Environment
		local key, layer, tile = self:getTileInfo(c, r, LAYER_ENVIRONMENT)
		if key ~= 0 then	
			totalCover = totalCover + tile.cover 
			--DEBUG("ENVIR", c, r, tile.cover, totalCover)
		end

		-- Light
		local key, layer, tile = self:getTileInfo(c, r, LAYER_LIGHT)	
		totalCover = totalCover + tile.cover
		--DEBUG("LIGHT", c, r, tile.cover, totalCover)

		if totalCover < -5 then 
			--DEBUG("Blocked", totalCover, c, r)
			return totalCover, c, r
		end
	end
	--DEBUG("Not blocked", totalCover, c, r)
	return totalCover, to.c, to.r
end


function WorldMap:setMarker(point, type, grade)

	if not self.path then
		self.path = Sprite.new()
		self.camera:addChild(self.path)
	end
	
	local types = { 
		["s"] = {color = COLOR_BLUE, alpha = 0.7},
		["e"] = {color = COLOR_GREEN, alpha = 0.7},
		["f"] = {color = COLOR_RED, alpha = 1},
		}

	local color
	if grade then
		f = 25
		grade = grade * f
		local r = grade><256
		local g = ((grade-256)<>0) >< 256
		local b = ((grade-512)<>0) >< 256
		color = ((r*256)+g)*256+b
		--DEBUG("Color", r, g, b, color)
	else
		color = types[type].color
	end
	local marker = Pixel.new(color, types[type].alpha, 20, 20)
	marker:setAnchorPoint(0.5,0.5)
	marker:setPosition((point.c - 0.5) * TILE_WIDTH, (point.r - 0.5) * TILE_HEIGHT)
	self.path:addChild(marker)
end

function WorldMap:clearMarkers()
	if self.path then
		self.camera:removeChild(self.path)
		self.path= nil
	end
end

function WorldMap:shortestPath(from, to)
	--self:clearMarkers()
	--self:setMarker(from, "s")
	--self:setMarker(to, "e")

	queue = {}
	found = {}
	for i = 1, LAYER_COLUMNS * LAYER_ROWS do
		found[i] = false
	end
	iterations = 0
	
	from.dc = 0
	from.dr = 0
	from.steps = 0 
	from.incoming = from
	table.insert(queue, from)
	found[self:index(from.c, from.r)] = true	
	--DEBUG("Starting with", from.c, from.r, from.dc, from.dr, to.c, to.r, from.incoming.c, from.incoming.r, #queue)

	while #queue > 0 and iterations < 100 do
	
		-- Sort by possible shortest path. 
		table.sort(queue, function (p1, p2)
			local d1 = distance(p1, to)/1.41 + p1.steps
			local d2 = distance(p2, to)/1.41 + p2.steps
			return d1 < d2
		end) 

		current = queue[1]
		table.remove(queue, 1)
		iterations = iterations + 1
		--DEBUG("Visiting", current.c, current.r, current.dc, current.dr, current.steps, to.c, to.r, #queue)			
		--self:setMarker(current, "f", current.steps + 1)

 		if current.c == to.c and current.r == to.r then
			--DEBUG("Found Target", from.c, from.r, "-", current.c, current.r, "-", current.dc, current.dr)
			
			local walker, s = current, 0
			while walker.c ~= from.c or walker.r ~= from.r and s < 100 do
				walker = walker.incoming
				--DEBUG(s, ":", from.c, from.r, "-", current.c, current.r, "-",  walker.c, walker.r)
				--self:setMarker(walker, "f")
				s = s + 1
			end
			
			return current.dc, current.dr
		end
		
		for dr = -1, 1 do
			for dc = -1 , 1 do
				next = {c = current.c + dc, r = current.r + dr, steps = current.steps + 1}
				if not found[self:index(next.c, next.r)] 
					and (dr or dc) 
					and next.c > 1 and next.c < LAYER_COLUMNS 
					and next.r > 1 and next.r < LAYER_ROWS then
					
					found[self:index(next.c, next.r)] = true	

					key, layer, tile = self:getTileInfo(next.c, next.r)

					local blocked  = (layer == LAYER_ENVIRONMENT and tile.blocked)
	
					if current.dc ~= 0 or current.dr ~= 0  then -- carry forward on original direction
						next.dc = current.dc
						next.dr = current.dr
					else -- first set of nodes, set initial direction
						next.dc = dc
						next.dr = dr					
						-- A monster next to source stops this path of exploration...
						blocked = blocked or (layer == LAYER_MONSTERS)
					end
					
					next.incoming = current
					
					if not blocked then
						table.insert(queue, next)
						--DEBUG("ADDING", next.c, next.r, "|", next.dc, next.dr, "|", next.incoming.c, next.incoming.r)
					end
				end
			end
		end
	end

	-- naive
	--DEBUG("Giving up BFS after", iterations) -- TODO
	local dc = (to.c - from.c)>0 and 1 or (to.c - from.c)<0 and -1 or 0
	local dr = (to.r - from.r)>0 and 1 or (to.r - from.r)<0 and -1 or 0
		
	if not self:blocked(from.c + dc, from.r + dr) then
		return dc, dr
	else
		return 0, 0
	end
end

-- Debug functions


function WorldMap:debugMapInfo(id)
	DEBUG(("Array %d layers, %d arrays"):format(#self.mapLayers, #self.mapArrays))
	DEBUG(("Layer %d %dx%d at %d %d %d"):format(id, self.mapLayers[id]:getWidth(), 
		self.mapLayers[id]:getHeight(), 
		self.mapLayers[id]:getPosition()))
	array = self.mapArrays[id]

	DEBUG(("Array %d %d"):format(id, #array)) 
	for y = 1, LAYER_ROWS do
		local s = ""
		for x = 1, LAYER_COLUMNS do
			local i = self:index(x,y)
			s = s .. array[i] .. " "
		end
		DEBUG(s)
	end

end
