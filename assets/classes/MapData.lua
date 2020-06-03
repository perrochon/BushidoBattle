MapData = Core.class(Object)

function MapData:init(mapDataFile)
	--[[ Create MapData from files, including tiles and textures and monsters.
		Reads the MapData .lua file exported from tile and a 
		texture pack exported from Gideros Texture Packer
	]]

	self.file = self:loadMapFile(mapDataFile)
	self.spawns = self:spawnsFromMap()
	self.pack, self.tileset, self.tiles = self:loadTiles("images/map.png", "images/map.txt")
end

function MapData:loadMapFile(mapDataFile)
	--[[ Reads the MapData .lua file exported from tile and a 
	]]

	-- error "attempt to call nil value" means file not found. Check spelling and refresh
	INFO("Map File:    ", mapDataFile)
	local file = loadfile(mapDataFile..".lua")() 
	
	LAYER_COLUMNS = file.width
	LAYER_ROWS = file.height

	INFO("Title: " .. file.properties["Title"])
	INFO(("Size: %dx%d\n  Tile size: %dx%d"):format(file.width, file.height, file.tilewidth, file.tileheight))
	INFO("Number of tilesets: ", #file.tilesets)
	INFO("Number of map layers: ", #file.layers)
	ASSERT_EQUAL(file.layers[1].name, "Ground", "Layer 1 needs to be 'Ground'")
	ASSERT_EQUAL(file.layers[2].name, "Environment", "Layer 2 needs to be 'Environment'")
	ASSERT_EQUAL(file.layers[3].name, "Monsters", "Layer 3 needs to be 'Monsters'")
	-- TODO ASSERT Each tile has a ground tile
	-- TODO ASSERT Border tiles are all blocked
	return file
end

function MapData:loadTiles(texturePack, textureIndex)
	--[[ load texture pack exported from Gideros Texture Packer
	--]]
	
	INFO("  Texture Pack:", texturePack, "Texture Index:", textureIndex)
	local pack = TexturePack.new(textureIndex, texturePack)

	-- Get all tiles from the editor map and look them up in the texture pack
	local tileset = self.file.tilesets[1] -- Only one tile set (for now?)
	local tiles = {}
	for i = 1, tileset.tilecount do

		-- remove path from tile names (Tiled "helpfully" puts in a long path to the orgiinal file)
		tileset.tiles[i].image = tileset.tiles[i].image:gsub("[\.%a/]*/", "")
		--DEBUG("Getting tile", i, tileset.tiles[i].id, tileset.tiles[i].image)
		--DEBUG((pack:getTextureRegion(tileset.tiles[i].image)):getRegion())
		local tile = {}
		tile.id = tileset.tiles[i].id
		tile.blocked = stringToBoolean(tileset.tiles[i].properties.blocked) or false
		tile.name = tileset.tiles[i].properties.description or "thing"
		tile.image = tileset.tiles[i].image
		tile.cover = tileset.tiles[i].properties.cover or 0
		tiles[tile.id] = tile                        
	end

	-- Make sure we got everything, move this code into separate function
	for k, v in pairs(tiles) do
		--DEBUG(k, v.id, v.name, v.image, v.blocked, v.cover)
		if v.image == nil or v.name == nil or v.blocked == nil or v.cover == nil then
			ERROR("ERROR: Missing Data in tile", key, v.image, v.name)
			if v.image == nil then v.image = "Floor_Grass.png" end -- TODO create error image and show here
			if v.name == nil then v.name = "thing" end
			if v.blocked == nil then v.blocked = false end
			if v.cover == nil then v.cover = 0 end
			if pack:getTextureRegion(v.image) == nil then
				ERROR("ERROR: No image found in texture pack", key, v.image, v.name)
				v.image = "Floor_Grass.png" -- TODO create error image and show here. Also merge with above
			end
		end
	end
	
	return pack, tileset, tiles	
end

function MapData:spawnsFromMap()
	--[[ returns a table with all the monster data in the current map
	--]]
	local layerData = self.file.layers[3]	
	local spawns = {}
	local found = {}

	for _,v in ipairs(layerData.objects) do 
		m = {type = tonumber(v.type % 100), name = v.name, c = v.x // 100 + 1, r = v.y // 100 + 1, 
			sentry = tonumber(v.type) > 100 and tonumber(v.type) < 200,
			berserk = tonumber(v.type) > 200 and tonumber(v.type) < 300,
			}
		table.insert(spawns,m)
		local type = v.type % 100
		found[tonumber(type)] = found[tonumber(type)] and found[tonumber(type)] + 1 or 1
	end
	-- FIX pull names of monsters from manual
	INFO("  Number of spawns", "Hero", found[1],"Peasants", found[2], "Soldiers", found[3],"Samurais", found[4],"Wolves", found[5])
	--DEBUG(json.encode(spawns))
	return spawns
end

function MapData:layerFromMap(number)
	--[[ Return a Gidero TileMap with layer 1 or 2 from the file
	--]]
	
	ASSERT_TRUE(number == 1 or number == 2)
	
	local array  = {} -- array contains id's of the tiles
	local usedTiles = {} -- DEBUG set of used tiles in this layer

	local layerData = self.file.layers[number]	
	local layer = TileMap.new(layerData.width, 
								layerData.height,
								self.pack,
								self.tileset.tilewidth,
								self.tileset.tileheight,
								self.tileset.spacing,
								self.tileset.spacing,
								self.tileset.margin,
								self.tileset.margin,
								self.tileset.tilewidth,
								self.tileset.tileheight)		

	for y=1,layerData.height do
		for x=1,layerData.width do
			local i = x + (y - 1) * LAYER_COLUMNS 
			local gid = layerData.data[i] - 1 -- TODO FIX Get correct offset from map's ("firstgid")
			if gid > 0 then 
							
				local flip = 0
				if gid > 1000000 then 
					-- skip bitwise comparison for non rotated tiles. Will break at 1 million tiles
					-- Documentation on tile flipping: http://doc.mapeditor.org/en/stable/reference/tmx-map-format/#tile-flipping
					gid64 = int64.new(gid)
					-- Read flipping flags
					if gid64[31] ~= gid64[28] then flip = flip | TileMap.FLIP_HORIZONTAL end -- TODO FIX there must be a better way for condition
					if gid64[30] ~= gid64[28] then flip = flip | TileMap.FLIP_VERTICAL end
					if gid64[29] ~= gid64[28] then flip = flip | TileMap.FLIP_DIAGONAL end							
					-- Clear the flags from gid so other information is healthy
					gid64[31]=0
					gid64[30]=0
					gid64[29]=0
					gid = gid64()
					--DEBUG("rotating tile", x, y, gid, gid64[31], gid64[31], gid64[31], flip)
				end
				
				array[i] = gid
				if gid ~= 0 then
					image = self.tiles[gid].image
					if image ~= nil then
						local region = self.pack:getTextureRegion(image)
						if not region then
							ERROR("Tile not in tilemap", x, y, image)
						end
						tx, ty = region:getRegion()
					
						--DEBUG(i, x, y, gid, image, tx/100+1, ty/100+1)
						layer:setTile(x, y, tx/100+1, ty/100+1, flip)
						--DEBUG(i, x, y, terrain:getTile(x, y))
					
						usedTiles[image] = usedTiles[image] and usedTiles[image]+1 or 0
						--usedTiles[image] = gid
					end
				end
			else
				array[i] = 0
			end
		end
	end

	-- DEBUG print out used tiles
	--DEBUG("Tiles used in Map:")
	for k, v in pairs(usedTiles) do
		--DEBUG(k, v)
	end
	
	return layer, array
end	
