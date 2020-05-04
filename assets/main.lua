--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
Main for Bushido Battle, Bushido without the talk
]]
print("main.lua")

--[[ TODO
		- auto connect all the way to Battle...
		- Remote Play
			-- Monster AI with multiple heroes
			-- Ensure same map on client
			-- Client should not draw map before it gets sync. Or wipe lights at that time.
		- Settings Screen with AutoConnect
		- >2 devices
		- remote attack update
		- Sockets don't export well to HTML. Fix, either export, or don't use feature (will it workin browser?)
		- http://forum.giderosmobile.com/discussion/6880/gideros-2017-3-1-is-out-now/p1
		- Tiles: fix cover, especially make walls arrow proof
		- Fix HP layer
		- monster placed in tiled
		- check for obstacles on diagonal moves. 
		- update routefinding for diagonal and more complex maps
		- New graphics for monsters, environment, terrain, projectiles
		- limit ranged attacks in number (no unlimited javelins)
		- ranged attack friendly fire (for monsters). Hit a monster if it's in the way...

	Dev Stuff
		- Automated Tests
		
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
application:setBackgroundColor(COLOR_BLACK)


--set up the global variables and functions
manual = Cyclopedia.new()

currentHero = 1 -- index pointing to the 4 slots we can save, not the array of heroes
currentHeroFileName = "|D|hero"..currentHero

currentMap = 1 -- index pointing to the maps we have saved
currentMapFileName = "level01"

localHero = 1 -- This hero gets moved, and the map centers around her

-- Reset all heroes
SceneChooseHero:resetAllHeroes()

-- TODO FIX - used by the connect classes
font = TTFont.new("fonts/IMMORTAL.ttf", 96);

--define the scenes
sceneManager = SceneManager.new({
--these are all the separate screens in the game

[SCENE_START] = SceneStart,		--first thing the player sees
[SCENE_LOBBY] = SceneLobby,		--the character creation scene
[SCENE_PLAY] = ScenePlay,			--the main game scene
[SCENE_CHOOSE_HERO] = SceneChooseHero, -- Hero management
[SCENE_CHOOSE_MAP] = SceneChooseMap, -- Hero management
[SCENE_DEATH] = SceneDeath,			--when the player dies
[SCENE_VICTORY] = SceneVictory,		--when the player wins

[SCENE_CONNECT] = SceneConnect,		-- Connect to other player(s)
[SCENE_START_SERVER] = SceneStartServer,
[SCENE_JOIN_SERVER] = SceneJoinServer,
[SCENE_DRAW] = SceneDraw,
})

stage:addChild(sceneManager)

-- Add version number on top of everything
version = TextField.new(FONT_SMALL, VERSION)
version:setTextColor(COLOR_YELLOW)	
version:setPosition(APP_WIDTH - version:getWidth(), APP_HEIGHT- version:getHeight() - 100)
version:setAlpha(0.2)
stage:addChild(version)


--go to start scene 
sceneManager:changeScene(SCENE_START, TRANSITION_TIME, TRANSITION)



INFO("\n\nBushido Battle Started.")