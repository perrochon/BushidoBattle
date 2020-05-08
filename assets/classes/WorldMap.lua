--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
WorldMap class and all the functions associated with it: changing tiles, generating the arrays, querying locations, etc..
]]

WorldMap = Core.class(Sprite)

function WorldMap:init(level, heroes, monsters)

	--Create tables for map content (self.mapArrays) and for each TileMap (self.mapLayers)	
	--self.level = Level.new(currentMapFileName) -- read the file
	
	self.level = level

	self.mapArrays = {} -- a numeric key indicating what's in this place - defined in tiled maps and constants.lua
	self.mapLayers = {} -- the actual tile that is painted

	-- assign TileMaps to self.mapLayers. table.insert ads at the end, so the order here matters
	-- needs to be consistent with Constants.lua, but also rendering.
	local group = Sprite.new() -- self is a sprite, so could just add to self, no?
	
	local layer1,array1 = self.level:layerFromMap(1)
	group:addChild(layer1) 
	table.insert(self.mapLayers, layer1)
	table.insert(self.mapArrays, array1)

	--self:debugMapInfo(LAYER_TERRAIN)

	local layer2,array2 = self.level:layerFromMap(2)
	group:addChild(layer2) 
	table.insert(self.mapLayers, layer2)
	table.insert(self.mapArrays, array2)

	--self:debugMapInfo(LAYER_ENVIRONMENT)

	self.mapArrays[LAYER_MONSTERS] = self:placeMonsters(heroes, monsters)
	layer = self:returnTileMap(self.mapArrays[LAYER_MONSTERS], "images/tileset-monsters-108px.png", true)
	group:addChild(layer) 
	table.insert(self.mapLayers, layer)

	--self:debugMapInfo(LAYER_MONSTERS)

	self.mapArrays[LAYER_HP] = self:addHP()
	self.mapArrays[LAYER_LIGHT] = self:addLight(heroes[1])


	layer = self:returnTileMap(self.mapArrays[LAYER_HP], "images/tileset-health-108px.png", false)
	group:addChild(layer) 
	table.insert(self.mapLayers, layer)

	layer = self:returnTileMap(self.mapArrays[LAYER_LIGHT], "images/tileset-light-108px.png", false)
	group:addChild(layer) 
	table.insert(self.mapLayers, layer)	

	self:addChild(group)
	
	--this is the initial location of the TileMaps, centered around the hero
	self:shiftWorld(heroes[1].x - 6, heroes[1].y - 6)

	-- TODO FIX why no return self here?
end

function WorldMap:idx(x, y) --index of cell (x,y)
	return x + (y - 1) * LAYER_COLUMNS 
end


function WorldMap:placeMonsters(heroes, monsters)
	--[[Return an array to represent the monsters tiles. 
		Returns a table of size LAYER_COLUMNS * LAYER_ROWS
		Changes heroes[].x, heroes[].y and each monster.x, monster.y
	--]]

	--this is the array without monsters
	local mArray = {}

	for y = 1, LAYER_ROWS do
		for x = 1, LAYER_COLUMNS do
			mArray[self:idx(x, y)] = 0
		end
	end
	
	for _, m in pairs(monsters.list) do
		mArray[self:idx(m.x, m.y)] = m.entry
	end
	
	mArray[self:idx(heroes[localHero].x, heroes[localHero].y)] = heroes[localHero].entry -- TODO HEROFIX all heroes are the same entry for now

	if heroes[3-localHero] then -- TODO HEROFIX only works for 2 Heroes
		mArray[self:idx(heroes[3-localHero].x, heroes[3-localHero].y)] = heroes[3-localHero].entry -- TODO HEROFIX all heroes are the same entry for now
	end
	
	return mArray
end

function WorldMap:addHP()

  --tiles are 0 at the start
  local hArray = {}
  for y = 1, LAYER_ROWS do
    for x = 1, LAYER_COLUMNS do
      hArray[self:idx(x, y)] = 0
    end
  end
  return hArray
end

function WorldMap:addLight(hero) 
	-- TODO HEROFIX how to handle light for two players?
	-- Maybe remote player is in heroes[1] on their end and switch on transfer? heroes[2] is the other guy?
	-- Or save index of the hero displayed on this device?
	-- Either way, addLight only takes one hero, just pass in heroes[localHero]

	--[[Logic:  returns an array filled with light tile values with the area near the hero visible
		Returns a table of size LAYER_COLUMNS * LAYER_ROWS
	--]]
	--this is the array filled with darkness of unexplored tiles
	local lArray = {}
	for y = 1, LAYER_ROWS do
		for x = 1, LAYER_COLUMNS do
			lArray[self:idx(x, y)] = 4 -- TODO such constants should really not be hard coded...
		end
	end
	
	--this overlays the hero with a torch array
	--torch array is overkill if lightsources are symmetric. Could be computed
	local torchIndex = 0
	for y = hero.y - hero.light.radius, hero.y + hero.light.radius do
		for x = hero.x - hero.light.radius, hero.x + hero.light.radius do
			torchIndex = torchIndex + 1
			local i = self:idx(x, y)
			--only change the light array if on the screen
			if i > 0 and i < #lArray and hero.light.array[torchIndex] ~= 0 then
				lArray[i] = hero.light.array[torchIndex]
			end
		end
	end
	return lArray
end

function WorldMap:returnTileMap(mapArray, tileset)
	--[[Logic:  return a TileMap for a given tileset	
		Returns a TileMap
	--]]

	local t = Texture.new(tileset, true)
	local tilemap = TileMap.new(LAYER_COLUMNS, LAYER_ROWS, t, TILE_WIDTH, TILE_HEIGHT, 8, 8, 0, 0)
	
	--use setTile to assign a tile based on the mapArray index
	for y = 1, LAYER_ROWS do
		for x = 1, LAYER_COLUMNS do
			local tX = mapArray[self:idx(x, y)] 
			--only setTiles if the mapArray value isn't 0
			if tX ~= 0 then
				--our tileset images are a maximum of 16 tiles wide so values > 16 need a tY > 1
					-- (as of now, no tileset images are actually that big)
				local tY = math.ceil(tX / 16) 
				--and tX values < 16
				tX = tX - (tY - 1) * 16
				tilemap:setTile(x, y, tX, tY, f)
			end
		end
	end
	return tilemap
end

function WorldMap:getTileInfo(x, y, layer) 
	--[[Return the tile key, layer and tile information for a location on the map. 
				if no TileMap layer is specified, it returns the highest layer with a value.  
				i.e. monster #3, environment #2, or terrain #1
		Returns key, layer, tile
	--]]

	local i = self:idx(x, y)

	--DEBUG(("%d,%d %d %d %d %d"):format(x, y, layer and layer or -1, self.mapArrays[1][i], self.mapArrays[2][i], self.mapArrays[3][i]))
	
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
			--DEBUG(x, y, layer, array[i], tile.id, tile.name, tile.blocked)
		else
			--DEBUG(x, y, layer, array[i], "no tile")		
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
					--DEBUG(x, y, n, tile.id, tile.name, tile.blocked)
					return array[i], n, tile			
				else
					local tile = self.level.tiles[array[i]] -- FIX replace with getFunction
					--DEBUG(x, y, n, tile.id, tile.name, tile.blocked)
					return array[i], n, tile
				end
			end
		end
	end
	-- TODO Understand this. Basically if there is no tile, we return nothing?
end

function WorldMap:changeTile(layer, entry, x, y)
--Change both the self.mapArrays entry and the tile in self.mapLayers

  local array = self.mapArrays[layer]
  array[self:idx(x, y)] = entry
  self.mapLayers[layer]:setTile(x, y, entry, 1)
end

function WorldMap:shiftWorld(dx, dy)
	--[[shift all the TileMaps by dx and dy by changing the X,Y position of the sprite
		This is tile-based movement
	--]]
	
	local count = 1
	local ddx = dx * TILE_WIDTH / count
	local ddy = dy *TILE_HEIGHT / count
	
	for i = 1, #self.mapLayers do
		local layer = self.mapLayers[i]
		layer:setX(layer:getX() - (dx * TILE_WIDTH))	
		layer:setY(layer:getY() - (dy * TILE_HEIGHT))
	end
	
end


function WorldMap:moveHero(hero, dx, dy)
	--[[change the mapArrays and mapLayers location of a hero and 
		if it's the local hero, shift the TileMap and the light

		Changes hero.x, hero.y, position of the world
	--]]

	--DEBUG("Moving Hero", hero, hero.heroIdx, dx, dy, "to", hero.x+dx, hero.y+dy)

	if hero.heroIdx == localHero then 
		--move the torchlight
		self:adjustLight(hero, dx, dy)
		--keep the hero centered on the screen by shifting all the TileMaps  
		self:shiftWorld(dx, dy)
	end
	--for purposes of moving around the map, the hero is just another monster
	self:moveMonster(hero, dx, dy)
end

function WorldMap:adjustLight(hero, dx, dy)
	--[[change the light array tiles as the hero moves
		Uses the hero's old position and the hero.light.radius to change array values
		Called from moveHero
	--]]	
	
	if hero.heroIdx ~= localHero then
		ERROR("Trying to adjust light for the wrong hero")
		return
	end
	
	local lArray = self.mapArrays[LAYER_LIGHT]
	local i = 0

	--set all previously lit tiles to 3
	for y = hero.y - hero.light.radius, hero.y + hero.light.radius do
		for x = hero.x - hero.light.radius, hero.x + hero.light.radius do
			i = self:idx(x, y)
			--only change the light array and tile if on screen 
			if x > 0 and x <= LAYER_COLUMNS and y > 0 and y <= LAYER_ROWS then
				--only change if previously lit 
				if lArray[i] ~= 4 then
					lArray[i] = 3
					self.mapLayers[LAYER_LIGHT]:setTile(x, y, 3, 1)
				end
			end
		end
	end

	local torchIndex = 0
	--overlay the torchArray tiles over the hero's new spot
	--TODO why can this not just be self:addLight (with modification)
	for y = hero.y + dy - hero.light.radius, hero.y + dy + hero.light.radius do
		for x = hero.x + dx - hero.light.radius, hero.x + dx + hero.light.radius do
			torchIndex = torchIndex + 1
			i = self:idx(x, y)
			--only change the light array if on screen
			if x > 0 and x <= LAYER_COLUMNS and y > 0 and y <= LAYER_ROWS then
				--and needs to be updated
				if hero.light.array[torchIndex] ~= 0 then
					lArray[i] = hero.light.array[torchIndex]
					self.mapLayers[LAYER_LIGHT]:setTile(x, y, hero.light.array[torchIndex], 1)
				end
			end
		end
	end
end

function WorldMap:moveMonster(monster, dx, dy)
	--[[change the mapArrays and mapLayers location of the monster 
	--]]

	--get the array and entry
	local array = self.mapArrays[LAYER_MONSTERS]
	
	--erase the monster in the array and TileMap

	-- DEBUG Getting non-reproducible errors on the next line in HTML - Checking for possible conditions
	if monster.x > LAYER_COLUMNS or monster.y > LAYER_ROWS or monster.x < 1 or monster.y < 1 then
		ERROR("Monster current location out of bounds", monster.name, monster.x, monster.y, dx, dy)
	elseif monster.x+dx > LAYER_COLUMNS or monster.y+dy > LAYER_ROWS or monster.x+dx < 1 or monster.y+dy < 1 then
		ERROR("Monster new location out of bounds", monster.name, monster.x, monster.y, dx, dy)
	else
		array[self:idx(monster.x, monster.y)] = 0
		self.mapLayers[LAYER_MONSTERS]:clearTile(monster.x, monster.y)
		
		--place the monster at the new position
		array[self:idx(monster.x + dx, monster.y + dy)] = monster.entry
		self.mapLayers[LAYER_MONSTERS]:setTile(monster.x + dx, monster.y + dy, monster.entry, 1, monster.flip) 

		--remove and move the HPbar
		array = self.mapArrays[LAYER_HP]
		array[self:idx(monster.x, monster.y)] = 0
		self.mapLayers[LAYER_HP]:clearTile(monster.x, monster.y) 	
		array[self:idx(monster.x + dx, monster.y + dy)] = monster.HPbar
		if monster.HPbar ~= 0 then
			self.mapLayers[LAYER_HP]:setTile(monster.x + dx, monster.y + dy, monster.HPbar, 1) 
		end

		--update x and y
		monster.x = monster.x + dx
		monster.y = monster.y + dy
	end
end

function WorldMap:removeMonster(x, y)
	local array = self.mapArrays[LAYER_MONSTERS]
	array[self:idx(x, y)] = 0
	self.mapLayers[LAYER_MONSTERS]:clearTile(x, y) 	
	array = self.mapArrays[LAYER_HP]
	array[self:idx(x, y)] = 0
	self.mapLayers[LAYER_HP]:clearTile(x, y) 	
end

function WorldMap:addMonster(monster)
	--[[ 
	--]]

	local x = monster.x
	local y = monster.y
	
	--get the array and entry
	local array = self.mapArrays[LAYER_MONSTERS]

	DEBUG(x, y)
	--place the monster at the new position
	array[self:idx(monster.x, monster.y)] = monster.entry
	self.mapLayers[LAYER_MONSTERS]:setTile(monster.x, monster.y, monster.entry, 1) 

	--remove and move the HPbar
	array = self.mapArrays[LAYER_HP]
	array[self:idx(monster.x, monster.y)] = monster.HPbar
	if monster.HPbar ~= 0 then
		self.mapLayers[LAYER_HP]:setTile(monster.x, monster.y, monster.HPbar, 1) 
	end
end


function WorldMap:blocked(x, y)
	--[[uses getTileInfo to determine if the tile is blocked or not
		returns true or false
	--]]
	--local i = self:idx(x, y)
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

function WorldMap:whichWay(monster, tX, tY)
	--[[return the direction (dx, dy) to move based on monster.state == 'flee' or 'wander' and the target coordinates (tX, tY)
		this is a pathfinding function used by the monsters.  
		. . .		The main logic is move M toward T unless a W(all) is in the way
		T W M		Then choose left or right. Or back up.
		. . .		A list of 4 moves are generated and the first not blocked one is chosen.
	--]]

	local x, y = monster.x, monster.y
	local dx, dy = 0, 0			-- the direction variables to return and the default values 0, 0
	local moves = nil			-- the table of directions to try
	local second = true			-- the second best move to make
	
	--one of these directions is true
	if x > tX and math.abs(y - tY) <= math.abs(x - tX) then 		-- forward is west 	
		if y == tY then second = (math.random(2) == 1)				-- directly west
		else 			second = (y > tY)							-- NW so second best move is (0, -1)
		end				
		if second then 	moves = {{-1, 0}, {0, -1}, {0, 1}, {1, 0}}	--second choice is north
		else 			moves = {{-1, 0}, {0, 1}, {0, -1}, {1, 0}}	
		end
	elseif tX > x and math.abs(y - tY) <= math.abs(x - tX) then		-- forward is east 
		if y == tY then second = (math.random(2) == 1)				-- directly east
		else 			second = (y > tY)							-- NE so second best move is (0, -1)
		end	
		if second then	moves = {{1, 0}, {0, -1}, {0, 1}, {-1, 0}}	--second choice is north
		else			moves = {{1, 0}, {0, 1}, {0, -1}, {-1, 0}}	--second choice is south
		end	
	elseif tY > y then												-- forward is south 
		if x == tX then second = (math.random(2) == 1)				-- directly south
		else 			second = (x > tX)							-- SW so second best move is (-1, 0)
		end	
		if second then	moves = {{0, 1}, {-1, 0}, {1, 0}, {0, -1}}	--second choice is west
		else			moves = {{0, 1}, {1, 0}, {-1, 0}, {0, -1}}	--second choice is east
		end
	else															-- forward is north
		if x == tX then second = (math.random(2) == 1)				-- directly north
		else 			second = (x > tX)							-- SE so second best move is (-1, 0)
		end	
		if second then 	moves = {{0, -1}, {-1, 0}, {1, 0}, {0, 1}}	--second choice is west
		else			moves = {{0, -1}, {1, 0}, {-1, 0}, {0, 1}}	--second choice is east
		end
	end
	
	--the last move is backup so if fleeing just reserve the possible moves and choose backup first
	if monster.state == "flee" then
		local reverseMoves = {}
		for i,v in ipairs(moves) do
		  reverseMoves[v] = i
		end
		moves = reverseMoves
	end
	
	--finally choose a non-blocked move
	for i, move in ipairs(moves) do
		dx, dy = move[1], move[2]
		--DEBUG(monster.id, monster.name, dx, dy, x+dx, y+dy, self:blocked(x + dx, y + dy))
		if not self:blocked(x + dx, y + dy) then		-- if not blocked then move in that direction 
			break
		end
	end
	
	return dx, dy
end

function WorldMap:line(fromX, fromY, toX, toY)
	--[[Return a table of {x, y} pairs on the line including {fromX, fromY} and {toX, toY}
		The classic Bresenham integer only line algorithm all Roguelikes use.
		Pick one tile along the direction of the line (one x for horizontal, one y for vertical)
		Returns a table of x, y coordinates
	--]]

	local line = {}							-- a line is series of x, y values. this gets returned
	local deltaX = math.abs(toX - fromX)	-- the difference between the x's
	local deltaY = math.abs(toY - fromY)	-- The difference between the y's
	local x = fromX				   			-- Start x off at the first point
	local y = fromY				   			-- Start y off at the first point

	--different increments of x and y are needed for each octant of LOS
	local incX1 = 0	
	local incX2 = 0
	local incY1 = 0
	local incY2 = 0

	if toX >= fromX then			-- the x-values are increasing
		incX1, incX2 = 1, 1
	else						 	-- the x-values are decreasing
		incX1, incX2 = -1, -1
	end
	if toY >= fromY then			-- the y-values are increasing
		incY1, incY2 = 1, 1
	else						  	-- the y-values are decreasing
		incY1, incY2 = -1, -1
	end
	
	--these variables are used to calculate the next points in the main loop
	local den = 0					-- denominator used to convert real number to integer
	local num = 0					-- numerator used to convert real number to integer
	local numAdd = 0				-- how much to add to the numerator
	local numPoints = 0	 			-- how many points (sometimes more x points than y points)
	
	if deltaX >= deltaY then	 	
	-- there is at least one x-value for every y-value
		incX1 = 0				  	-- don't change the x when numerator >= denominator
		incY2 = 0				  	-- don't change the y for every iteration
		den = deltaX	
		num = deltaX / 2
		numAdd = deltaY
		numPoints = deltaX	 		-- there are more x-values than y-values
	else						  
	-- there is at least one y-value for every x-value
		incX2 = 0				  	-- don't change the x for every iteration
		incY1 = 0				  	-- don't change the y when numerator >= denominator
		den = deltaY
		num = deltaY / 2
		numAdd = deltaX
		numPoints = deltaY		 	-- there are more y-values than x-values
	end

	--this is the main loop.  add x, y to the table called line
	for i = 0, numPoints do
		table.insert(line, {x, y})	-- add to the line table
		num = num + numAdd			-- increase the numerator by the top of the fraction
		if num >= den then		 	-- check if numerator >= denominator
			num = num - den		   	-- calculate the new numerator value
			x = x + incX1		   	-- change the x as appropriate
			y = y + incY1		   	-- change the y as appropriate
		end
		x = x + incX2			 	-- change the x as appropriate
		y = y + incY2			 	-- Change the y as appropriate
	end
	return line
end

function WorldMap:lineOfCover(fromX, fromY, toX, toY)
	--[[find all the tile.cover values between from and to on the environment and light layer
		Return blockedX, blockedY if totalCover <-5
		Return totalCover, blockedX, blockedY 
	--]]
	local totalCover = 0
	local blockedX, blockedY = nil, nil
	local x, y = 0, 0
	local line = self:line(fromX, fromY, toX, toY)

	--remove the starting x, y
	table.remove(line, 1)
	--DEBUG(fromX, fromY, toX, toY, " for cover")
	for key, coordinates in pairs(line) do
		x, y = coordinates[1], coordinates[2]
		--DEBUG(x, y)

		--figure out the cover for what's in the way
		local key, layer, tile = self:getTileInfo(x, y, LAYER_ENVIRONMENT)
		if key ~= 0 then	
			totalCover = totalCover + tile.cover 
		end

		--account for lighting too
		local key, layer, tile = self:getTileInfo(x, y, LAYER_LIGHT)		
		totalCover = totalCover + tile.cover 
		if totalCover < -5 then -- removed redundant? or tile.cover < -5
			if not blockedX then -- return first block
				blockedX, blockedY = x, y
			end
		end
	end
	if blockedX then
		--DEBUG("cover is  ", totalCover, " blocked at ", blockedX, blockedY )
	else
		--DEBUG("cover is  ", totalCover, " not blocked")
	end
	return totalCover, blockedX, blockedY
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
			local i = self:idx(x,y)
			s = s .. array[i] .. " "
		end
		DEBUG(s)
	end

end
