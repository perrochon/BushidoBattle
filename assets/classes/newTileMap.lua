NewTileMap = Core.class(Sprite)

function NewTileMap:init(levelName)
	--[[ Reads a level .lua file and a texture pack
		-- some inspiration from here: https://wiki.giderosmobile.com/index.php/CBump_Template
	]]

	-- TODO FIX parametrize file names
	local texturePack = "bushidobattle.png"
	local textureIndex = "bushidobattle.txt"
	
	INFO("Map File:    ", levelName)
	INFO("Texture Pack:", texturePack)
	-- load .lua file exported from tiled
	self.map = loadfile(levelName)() -- error "attempt to call nil value" means file not found. Check spelling and refresh
	
	INFO(self.map.properties["Title"])
	INFO(("Size: %dx%d\n  Tile size: %dx%d"):format(self.map.width, self.map.height, self.map.tilewidth, self.map.tileheight))
	INFO("Number of tilesets: ", #self.map.tilesets)
	INFO("Number of layers: ", #self.map.layers)

	-- load texture pack exported from Gideros Texture Packer
	--DEBUG("Loading texture pack", texturePack)
	self.pack = TexturePack.new(textureIndex, texturePack)

	-- Get all tiles from the editor map and look them up in the texture pack
	self.tileset = self.map.tilesets[1] -- Only one tile set (for now?)
	self.tiles = {}
	for i = 1, self.tileset.tilecount do
		--DEBUG(i, self.tileset.tiles[i].id, self.tileset.tiles[i].image:sub(7))
		--DEBUG((pack:getTextureRegion(tileset.tiles[i].image:sub(7))):getRegion())
		local tile = {}
		tile.id = self.tileset.tiles[i].id
		tile.blocked = self.tileset.tiles[i].properties.blocked == "true" and true or false
		tile.name = self.tileset.tiles[i].properties.description
		tile.image = self.tileset.tiles[i].image:sub(16) --- TODO FIX the path issue
		tile.cover = self.tileset.tiles[i].blocked and self.tileset.tiles[i].blocked or 0 -- TODO FIX cover info into tilemap
		self.tiles[tile.id] = tile                        
	end

	-- Make sure we got everything, move this code into separate function
	for k, v in pairs(self.tiles) do
		--DEBUG(k, v.id, v.name, v.image, v.blocked, v.cover)
		if v.image == nil or v.name == nil or v.blocked == nil or v.cover == nil then
			ERROR("ERROR: newTileMap:init Missing Data in tile", key, v.image, v.name)
			if v.image == nil then v.image = "Floor_Grass.png" end -- TODO create error image and show here
			if v.name == nil then v.name = "thing" end
			if v.blocked == nil then v.blocked = false end
			if v.cover == nil then v.cover = 0 end
			if self.pack:getTextureRegion(v.image) == nil then
				ERROR("ERROR: newTileMap:init no image found in texture pack", key, v.image, v.name)
				v.image = "Floor_Grass.png" -- TODO create error image and show here. Also merge with above
			end
		end
	end
end

function NewTileMap:LayerFromMap(number)
	-- Layer 1 Terrain with basic ground tiles like grass, water, stone, etc.
	
	--DEBUG(number)

	local FLIPPED_HORIZONTALLY_FLAG = 0x80000000;
	local FLIPPED_VERTICALLY_FLAG   = 0x40000000;
	local FLIPPED_DIAGONALLY_FLAG   = 0x20000000;

	local array  = {} -- array contains id's of the tiles
	local usedTiles = {} -- DEBUG set of used tiles in this layer

	local layerData = self.map.layers[number]	
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
			local i = x + (y - 1) * layerData.width -- TODO FIX use index() ? 
			local gid = layerData.data[i] - 1 -- TODO FIX Get correct offset from map's ("firstgid")
			--DEBUG(i, x, y, gid)
			if gid > 0 then 
			
				-- Read flipping flags
				flipHor = gid & FLIPPED_HORIZONTALLY_FLAG
				flipVer = gid & FLIPPED_VERTICALLY_FLAG
				flipDia = gid & FLIPPED_DIAGONALLY_FLAG
				-- Convert flags to gideros style
				if(flipHor ~= 0) then flipHor = TileMap.FLIP_HORIZONTAL end
				if(flipVer ~= 0) then flipVer = TileMap.FLIP_VERTICAL end
				if(flipDia ~= 0) then flipDia = TileMap.FLIP_DIAGONAL end
				-- Clear the flags from gid so other information is healthy
				gid = gid & ~ (
					FLIPPED_HORIZONTALLY_FLAG |
					FLIPPED_VERTICALLY_FLAG |
					FLIPPED_DIAGONALLY_FLAG
				)
				array[i] = gid
				image = self.tiles[gid].image
				region = self.pack:getTextureRegion(image)
				tx, ty = region:getRegion()
				
				--DEBUG(i, x, y, gid, image, tx/100+1, ty/100+1)
				layer:setTile(x, y, tx/100+1, ty/100+1,(flipHor | flipVer | flipDia))
				--DEBUG(i, x, y, terrain:getTile(x, y))
				
				usedTiles[image] = usedTiles[image] and usedTiles[image]+1 or 0
				--usedTiles[image] = gid
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

--[[	-- Layer 2 Environment on top of the basic ground tiles in layer 1 with walls, trees, etc.
	layer = map.layers[2]	
	local environment = TileMap.new(layer.width, 
								layer.height,
								pack,
								tileset.tilewidth,
								tileset.tileheight,
								tileset.spacing,
								tileset.spacing,
								tileset.margin,
								tileset.margin,
								tileset.tilewidth,
								tileset.tileheight)

	for y=1,layer.height do
		for x=1,layer.width do
			local i = x + (y - 1) * layer.width
			local gid = layer.data[i] - 1 -- TODO FIX Get correct offset from map's ("firstgid")
			--DEBUG(i, x, y, gid)
			if gid > 0 then
				self.myGround[i] = gid
				image = self.myTiles[gid].image
				region = pack:getTextureRegion(image)
				tx, ty = region:getRegion()
				
				--DEBUG(i, x, y, gid, image, tx/100+1, ty/100+1)
				environment:setTile(x, y, tx/100+1, ty/100+1,(flipHor | flipVer | flipDia))
				--DEBUG(i, x, y, tilemap:getTile(x, y))
				
				usedTiles[image] = usedTiles[image] and usedTiles[image]+1 or 0
				--usedTiles[image] = gid
			end
		end
	end
	ground:addChild(environment)
	self:addChild(ground)

]]

--[[


function NewTileMap:getProperty(item, name)
	
	-- if we have an item and 
	if item and name and type(item) == 'table' and type(name) == 'string' then
		
		for k, v in pairs(item.properties) do 
			
			if k == name then  
				
				return v
				
			end	
			
		end
		
	end
	
end

]]