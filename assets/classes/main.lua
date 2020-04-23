--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
Main for Bushido Battle, Bushido without the talk
]]

--[[ TODO 
		- Initial Monster Placement (sync)
		- Sockets don't export well to HTML. Fix, either export, or don't use feature (will it workin browser?)
		- Fix hero selection model
		- Tiles: fix cover, especially make walls arrow proof
		- Fix HP layer
		- monster placed in tiled
		- check for obstacles on diagonal moves. 
		- update routefinding for diagonal
		- New graphics for monsters, environment, terrain, projectiles
		- limit ranged attacks in number (no unlimited javelins)
		- ranged attack friendly fire (for monsters). Hit a monster if it's in the way...
		- use debug.getinfo in DEBUG statements
		
	Deployment
		build.gradle (app)
			Update compileSDK and build tools version
		upgrade version code!
		need to re-enter key information each time	
]]

--Logical resolution and handling physical resolution
application:setLogicalDimensions(APP_HEIGHT, APP_WIDTH) 
application:setOrientation(Application.LANDSCAPE_LEFT)
application:setScaleMode("letterbox")					
--application:setBackgroundColor(COLOR_GREY)

--local pixel = Pixel.new(COLOR_BLUE, 1, 200,200)
--pixel:setPosition(275,275)
--stage:addChild(pixel)

--local layer = NewTileMap.new()
--stage:addChild(layer)

--set up the global variables and functions
manual = Cyclopedia.new()

-- TODO FIX - used by the connect classes
font = TTFont.new("fonts/IMMORTAL.ttf", 96);

--define the scenes
sceneManager = SceneManager.new({
--these are all the separate screens in the game

[SCENE_START] = SceneStart,		--first thing the player sees
[SCENE_LOBBY] = SceneLobby,		--the character creation scene
[SCENE_PLAY] = ScenePlay,			--the main game scene
--[SCENE_PLAY_CLIENT] = ScenePlayClient,		--play as a client, rely on model on server
[SCENE_DEATH] = SceneDeath,			--when the player dies
[SCENE_VICTORY] = SceneVictory,		--when the player wins

[SCENE_CONNECT] = SceneConnect,		-- Connect to other player(s)
[SCENE_START_SERVER] = SceneStartServer,
[SCENE_JOIN_SERVER] = SceneJoinServer,
[SCENE_DRAW] = SceneDraw,
})

stage:addChild(sceneManager)
--go to start scene 
sceneManager:changeScene(SCENE_CONNECT, TRANSITION_TIME, TRANSITION)

--local pixel = Pixel.new(COLOR_GREEN, 1, 200,200)
--pixel:setPosition(650,650)
--stage:addChild(pixel)

INFO("\n\nBushido Battle Started.")
