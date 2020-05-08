--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2010 - 2020 Louis Perrochon
]]

print("init.lua")
VERSION = "0.6"

-- Sockets are not supported in HTML. Load sockets and unite manually if not HTML
SOCKETS = (application:getDeviceInfo() ~= "Web")
if SOCKETS then
	err = dofile("classes/socket.lua")
	err = dofile("classes/Unite.lua")
else
	print("HTML version. Not loading multi-player support")
end

-- Screen Sizes
-- http://forum.giderosmobile.com/discussion/comment/62021/#Comment_62021
-- KEEP APP_HEIGHT and APP_WIDTH, but shift UX on the map out if letterboxed...
-- TODO if letterboxed on the side, move FG_X to the right, and lobby button to the left
-- 11 tiles high and wide + 712 to get to 1920. Image is 920 wide for wide-screen 			

-- Logical App screen - We will letterbox this
APP_HEIGHT @ 1188
APP_WIDTH @ 1920
BUTTON_MARGIN @ 50
MENU_MARGIN @ 200
PLAY_UX_WIDTH @ 700

print("Logical Screen", APP_WIDTH, APP_HEIGHT)

MINX, MINY, MAXX, MAXY = application:getDeviceSafeArea(true)

MINX = math.floor(MINX + 0.5)
MINY = math.floor(MINY + 0.5)
MAXX = math.floor(MAXX + 0.5)
MAXY = math.floor(MAXY + 0.5)

print("Device Safe Area", MINX, MINY, MAXX, MAXY)

FG_X @ \(MAXX-PLAY_UX_WIDTH)\

FG_BLEED @ 1000 -- 500 should be enough, but HTML can be really wide...

--Logical resolution and handling physical resolution
application:setLogicalDimensions(APP_HEIGHT, APP_WIDTH) 
application:setOrientation(Application.LANDSCAPE_LEFT)
application:setScaleMode("letterbox")					


--[[
Constants and Global Functions
--]]

-- Colors
COLOR_BLACK @ 0x000000   -- slightly off black is 0x140C1C
COLOR_DKGREY @ 0x4E4A4E  -- dark grey
COLOR_GREY @ 0x757161    -- light grey, brown hint (main background)
COLOR_LTGREY @ 0x8595A1  -- lighter grey, blue hint
COLOR_DKBLUE @ 0x30346D  -- dark blue, night sky?
COLOR_BLUE @ 0x597DCE    -- medium to light blue
COLOR_LTBLUE @ 0x6DC2CA  -- light teal
COLOR_DKBROWN @ 0x442434 -- purple/brown
COLOR_BROWN @ 0x854C30   -- medium to light brown
COLOR_GREEN @ 0x346524   -- leaf green
COLOR_LTGREEN @ 0x6DAA2C -- light green
COLOR_RED @ 0xD04648     -- reddish pink
COLOR_APRICOT @ 0xD2AA99 -- white skin flesh tone
COLOR_ORANGE @ 0xD27D2C
COLOR_YELLOW @ 0xDAD45E
COLOR_WHITE @ 0xF9FAFA   -- slightly creamy white

application:setBackgroundColor(COLOR_BLACK)

MSG_FADE = 0.005
MSG_DESCRIPTION @ 1
MSG_ATTACK @ 2
MSG_DEATH @ 3
MSG_BOARD_WIDTH @ 680
MSG_X @ 0  -- \APP_HEIGHT - MSG_BOARD_WIDTH\
MSG_Y @ \APP_HEIGHT - 300\

-- Fonts
FONT_XL @ \Font.new("fonts/immortal_XL.txt", "fonts/immortal_XL.png")\
FONT_LARGE @ \Font.new("fonts/immortal_large.txt", "fonts/immortal_large.png")\
FONT_MEDIUM @ \Font.new("fonts/immortal_medium.txt", "fonts/immortal_medium.png")\
FONT_SMALL @ \Font.new("fonts/immortal_small.txt", "fonts/immortal_small.png")\

-- Terrain Size
TILE_WIDTH @ 100
TILE_HEIGHT @ 100
LAYER_COLUMNS = -1		--the number of columns in each array of tiles. Set when map is loaded
LAYER_ROWS = -1			--the number of rows in each array of tile. Set when map is loaded

MAP_FILE_NAME @ "map"


-- Facebook code to remove the loader
-- Here to run early, maybe that makes it work
pcall(function() FBInstant=require "FBInstant" end)
if FBInstant then
	DEBUG("FBInstant loaded")
	FBInstant.startGameAsync(function() 
		DEBUG("Loading screen removed. FBInstantAPI loaded")
		FBInstantAPI=true
	end)
else
	--DEBUG("FBInstant not loaded")
end


-- don't change these, as layers are inserted in this order in TileMap.lua
LAYER_TERRAIN @ 1		-- terrain layer (dirt, floors, water)
LAYER_ENVIRONMENT @ 2	-- the enivornment layer (doors, pillars, walls)
LAYER_MONSTERS @ 3		-- the monster layer (including the hero and NPCs)
LAYER_HP @ 4			--the HP bar layer
LAYER_LIGHT @ 5			--the light layer (clear, dim, previously-seen, fog-of-war, white, black)

MONSTERS_2 @ 2
MONSTERS_3 @ 1
MONSTERS_4 @ 1

-- Scene Manager Settings
TRANSITION_TIME @ 0.5
TRANSITION @ \SceneManager.fade\
SCENE_START @ "sceneStart"
SCENE_LOBBY @ "sceneLobby"
SCENE_PLAY @ "sceneGame"
SCENE_CHOOSE_HERO @ "sceneChooseHero"
SCENE_CHOOSE_MAP @ "sceneChooseMap"
SCENE_DEATH @ "sceneDeath"
SCENE_VICTORY @ "sceneVictory"
-- Remote Play
SCENE_CONNECT @ "sceneConnect"
SCENE_START_SERVER @ "sceneStartServer"
SCENE_JOIN_SERVER @ "sceneJoinServer"
SCENE_DRAW @ "sceneDraw"

-- Unite Remote Constants
SYNC_TURN @ "syncTurn"
MONSTER_MOVED @ "monsterMoved"
SYNC_STATE @ "syncState"
AUTO_CONNECT @ true

-- The layer lookup "table"
Cyclopedia = Core.class()

function Cyclopedia:init()

	local projectilesTexture = Texture.new("images/texturepack-projectiles-108px.png", true)

	--the manuals and lists. 
	--make sure the numbers here match up with their positions in the tileset images.
	local manual = {
		["layers"] = {
			[1] = "terrain",
			[2] = "environment",
			[3] = "monsters",
			[4] = "health",
			[5] = "light",
			},
		["terrainDEPRECATED"] = {
			[1] = {id = -1, name = "1 patch of grass", texture = "Dungeon_Floor_2x2.png"},
			[2] = {id = -2, name = "1 road", texture = "Dungeon_Floor_2x2.png"},
			[3] = {id = -3, name = "1 creek", texture = "Dungeon_Floor_2x2.png"},
			[4] = {id = -4, name = "1 thing", texture = "Dungeon_Floor_2x2.png"},
			},
		["environmentDEPRECATED"] = {
			[1] = {id = -5, name = "2 forest", blocked = true, cover = -6, texture = "Tree_Crown_06.png"},
			[2] = {id = -6, name = "2 forest", blocked = true, cover = -6, texture = "Tree_Crown_07.png"},
			[3] = {id = -7, name = "2 new tree", blocked = true, cover = -2, texture = "Tree_Crown_01.png"},
			[4] = {id = -8, name = "2 tree", blocked = true, cover = -4, texture = "Tree_Crown_02.png"},
			[5] = {id = -9, name = "2 new rock", blocked = true, cover = 0, texture = "Light_Moss_Rough_Well_2x2_B.png"},
			[6] = {id = -10, name = "2 rock", blocked = false, cover = -2, texture = "Light_Moss_Rough_Well_2x2_B.png"},
			},
		["light-source"] = {
			[1] = {name = "torch", radius = 3, array = {
						0, 0, 2, 1, 2, 0, 0, 
						0, 1, 1, 1, 1, 1, 0, 
						2, 1, 1, 1, 1, 1, 2, 
						1, 1, 1, 1, 1, 1, 1, 
						2, 1, 1, 1, 1, 1, 2, 
						0, 1, 1, 1, 1, 1, 0, 
						0, 0, 2, 1, 2, 0, 0}},
			[2] = {name = "daylight", radius = 4, array = {
						2, 1, 1, 1, 1, 1, 1, 1, 2, 
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						2, 1, 1, 1, 1, 1, 1, 1, 2}},
			},
		["light"] = {
			[1] = {name = "bright", cover = 0},
			[2] = {name = "dim", cover = -1},
			[3] = {name = "dark/remembered", cover = -2},
			[4] = {name = "unexplored", cover = -6},
			[5] = {name = "white", cover = -6},
			[6] = {name = "black", cover = -6},
			},
		["monsters"] = {
			[1] = {name = "hero", weapon1 = "shortsword", weapon2 = "shortbow",},
				--[[monster stats explained:
					xp			how much xp the hero gets
					hp			how many hp the monster has
					bloodied	half the hp 
					AC			defense against physical attacks
					Fort		their Fortitude stat
					Will		their  Will stat
					Refl		their  Reflex stat 
					resist		all the resistances against types of magic (from Magic the Gathering)
					attacks		simple monsters have one attack
					reach		how many squares away to hitTestPoint
					modifier	attack modifier
					defense		which defense is being attacked
					dice, damage, bonus = 1d6+2 = 1, d6, 2
					type		nil is physical damage, the others could be green, red, blue, white or black
					projectile	the projectile animation used for the attack, either spear, arrow or magic
					missSound   what the program reports for close misses
					--]]
			[2] = {name = "peasant", xp = 1, hp = 4, bloodied = 2, 
					defense = {AC = 10, Fort = 12, Refl = 14, Will = 11}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "stick", weapon2 = nil,
					},
			[3] = {name = "soldier", xp = 3, hp = 15, bloodied = 7,  
					defense = {AC = 12, Fort = 13, Refl = 15, Will = 12}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "javelin", weapon2 = "shortsword",
					},
			[4] = {name = "samurai", xp = 4, hp = 25, bloodied = 12, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "katana", weapon2 = "spear",
					},
			},
		["weapons"] = {
			[1] = {name = "katana", reach = 1, modifier = 6, defense = "AC", damage = 'd10', dice = 1, bonus = 5, 
						    type = "Physical", projectile = nil, missSound = "clang"},
			[2] = {name = "spear", reach = 1, modifier = 8, defense = "AC", damage = 6, dice = 1, bonus = 2, 
						    type = "Physical", projectile = "spear", missSound = "swish"},
			[3] = {name = "shortsword", reach = 1, modifier = 4, defense = "AC", damage = 'd6', dice = 1, bonus = 2, 
						    type = "Physical", projectile = nil, missSound = "clang"},
			[4] = {name = "javelin", reach = 4, modifier = 6, defense = "AC", damage = 'd8', dice = 1, bonus = 2, 
						    type = "Physical", projectile = "spear", missSound = "swish"},
			[5] = {name = "stick", reach = 1, modifier = 2, defense = "AC", damage = 'd4', dice = 1, bonus = 3, 
						    type = "Physical", projectile = nil, missSound = "clang"},
			[6] = {name = "shortbow", reach = 5, modifier = 5, defense = "AC", damage = 'd6', dice = 1, bonus = 2,
							type = "Physical", projectile = "arrow", missSound = "swish"},
			},
		["projectiles"] = {
			[1] = {name = "arrow", image = TextureRegion.new(projectilesTexture, 0, 0, 108, 108), speed = 5},
			[2] = {name = "spear", image = TextureRegion.new(projectilesTexture, 108, 0, 108, 108), speed = 5},
			[3] = {name = "fireball", image = TextureRegion.new(projectilesTexture, 216, 0, 108, 108), speed = 5},
			[4] = {name = "hammer", image = TextureRegion.new(projectilesTexture, 324, 0, 108, 108), speed = 5},
			},
		}
	self.lists = {}
	for key, val in pairs(manual) do
		self.lists[key] = val
	end
end

--get value for specific manual
function Cyclopedia:getEntry(list, entry)
	local cyclopedia = self.lists[list]
	local isNumber = tonumber(entry)
	if isNumber then
		return cyclopedia[entry]
	else
		for key, val in pairs(cyclopedia) do
			if val.name == entry then
				return val
			end
		end
	end
end



