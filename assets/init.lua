--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2010 - 2020 Louis Perrochon
]]
VERSION = "0.8.4"

MUSIC @ true
MUSIC_VOLUME @ 0
EFFECTS @ false
EFFECTS_VOLUME @ 0

MOVE_SPEED @ 0.5
ANIMATION_SLOWDOWN = 1 	

COVER = -5 -- if cover on line of sight is less than COVER then can't see through at all

-- Sockets are not supported in HTML. Load sockets and unite manually if not HTML
SOCKETS = (application:getDeviceInfo() ~= "Web")
if SOCKETS then
	err = dofile("classes/socket.lua")
	err = dofile("classes/Unite.lua")
else
	print("HTML version. Not loading multi-player support")
end

-- Logical App size that we will letterbox
APP_HEIGHT @ 1188 -- TODO is this really what we want?
APP_WIDTH @ 1920
BUTTON_MARGIN @ 50
MENU_MARGIN @ 200
PLAY_UX_WIDTH @ 700

-- Get the physical screen size so we can use all of it, e.g. in ScenePlay
--DEBUG("Logical Screen", APP_WIDTH, APP_HEIGHT)
MINX, MINY, MAXX, MAXY = application:getDeviceSafeArea(true)

MINX = math.floor(MINX + 0.5)
MINY = math.floor(MINY + 0.5)
MAXX = math.floor(MAXX + 0.5)
MAXY = math.floor(MAXY + 0.5)

--DEBUG("Device Safe Area", MINX, MINY, MAXX, MAXY)

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
COLOR_LTBLACK @ 0x343234 -- color of unexplored tiles
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

-- Order matters as we search high number to low. We insert from low to high, so light is on top.
-- Loot gets added to the camera on the fly at position 3, i.e. above Environment, below monsters
LAYER_TERRAIN @ 1		-- terrain layer (dirt, floors, water)
LAYER_ENVIRONMENT @ 2	-- the enivornment layer (doors, pillars, walls)
LAYER_MONSTERS @ 3		-- the monster layer (including the hero and NPCs)
LAYER_LIGHT @ 5			-- the light layer (clear, dim, previously-seen, fog-of-war, white, black)

LIGHT_BRIGHT @ 1
LIGHT_DIM @ 2
LIGHT_DARK @ 3
LIGHT_UNEXPLORED @ 4

MSG_FADE = 0.005
MSG_DESCRIPTION @ 1
MSG_ATTACK @ 2
MSG_DEATH @ 3
MSG_BOARD_WIDTH @ 680
MSG_X @ 0  -- \APP_HEIGHT - MSG_BOARD_WIDTH\
MSG_Y @ \APP_HEIGHT - 300\

-- Fonts
--FONT_XL @ \Font.new("fonts/immortal_XL.txt", "fonts/immortal_XL.png")\
--FONT_LARGE @ \Font.new("fonts/immortal_large.txt", "fonts/immortal_large.png")\
--FONT_MEDIUM @ \Font.new("fonts/immortal_medium.txt", "fonts/immortal_medium.png")\
--FONT_SMALL @ \Font.new("fonts/immortal_small.txt", "fonts/immortal_small.png")\
-- TODO PERFORMANCE use bitmap fonts or cache True Type Fonts https://wiki.giderosmobile.com/index.php/Fonts_and_Text
FONT_XL @ \TTFont.new("fonts/nuku1.ttf", 200)\
FONT_LARGE @ \TTFont.new("fonts/nuku1.ttf", 140)\
FONT_MEDIUM @ \TTFont.new("fonts/nuku1.ttf", 90)\
FONT_SMALL @ \TTFont.new("fonts/nuku1.ttf", 50)\
FONT_DEBUG @ \TTFont.new("fonts/nuku1.ttf", 30)\

-- Terrain Size
TILE_WIDTH @ 100
TILE_HEIGHT @ 100
LAYER_COLUMNS = -1		--the number of columns in each array of tiles. Set when map is loaded
LAYER_ROWS = -1			--the number of rows in each array of tile. Set when map is loaded

MAP_FILE_NAME @ "maps/map"

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
SCENE_SPRITES @ "sceneSprites"

-- Unite Remote Constants
SYNC_TURN @ "syncTurn"
MONSTER_MOVED @ "monsterMoved"
SYNC_STATE @ "syncState"
AUTO_CONNECT @ true

--[[
function distance(o1, o2)
	if not o1 or not o2 then return nil end
	return math.floor(10*math.sqrt(math.pow(tonumber(o1.c) - tonumber(o2.c),2) + math.pow(tonumber(o1.r) - tonumber(o2.r),2)))/10
end
]]--

function distance(o1, o2)
	if not o1 or not o2 then return nil end
	if o1.c and o1.r and o2.c and o2.r then
		return math.sqrt((o1.c - o2.c)*(o1.c - o2.c) + (o1.r - o2.r)*(o1.r - o2.r))
	elseif o1.x and o1.y and o2.x and o2.y then
		return math.sqrt((o1.x - o2.x)*(o1.x - o2.x) + (o1.y - o2.y)*(o1.y - o2.y))
	end
	return nil
end

DISTANCE @ (|
	print("math.sqrt((" .. (...)[1] .. ".c - " .. (...)[3] .. ".c) *  (" .. (...)[1] .. ".c - " .. (...)[3] .. ".c) + "
		        ..   "(" .. (...)[1] .. ".r - " .. (...)[3] .. ".r) * (" .. (...)[1] .. ".r - " .. (...)[3] .. ".r))" )
	return "math.sqrt((" .. (...)[1] .. ".c - " .. (...)[3] .. ".c) * ( " .. (...)[1] .. ".c - " .. (...)[3] .. ".c) + "
		        ..   "(" .. (...)[1] .. ".r - " .. (...)[3] .. ".r) * (" .. (...)[1] .. ".r - " .. (...)[3] .. ".r))"
	--return ("math.sqrt((%s.c - %s.c) * ( %s.c - %s.c) + (%s.r - %s.r) * (%s.r - %s.r))"):format(
	--	(...)[1], (...)[3], (...)[1], (...)[3], (...)[1], (...)[3], (...)[1], (...)[3])
|)