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
		- Camera Follow Update
			- line to move only does ortho moves, no diagonal. Need to update that
			- click on enemies within range put a target on their head?
		- Fog of war
			- Should not be able to drag/click into the darkness and learn what's there
			- Hero shouldn't know shortest route through dark areas
			- Monsters shouldn't block shortest path, unless they are right next to the hero
		- Don't require killing of peasants anymore. Maybe negative experience?
		- Remote Play
			-- Monster AI with multiple heroes
			-- Ensure same map on client
			-- Client should not draw map before it gets sync. Or wipe lights at that time.
		- Settings Screen with AutoConnect
		- Something wrong with light layer on large map going to beyond and back doesn't remember...
		- >2 devices
		- remote attack update
		- Sockets don't export well to HTML. Fix, either export, or don't use feature (will it workin browser?)
		- http://forum.giderosmobile.com/discussion/6880/gideros-2017-3-1-is-out-now/p1
		- Tiles: fix cover, especially make walls arrow proof
		- Fix HP layer
		- Monsters with no way to move should not move (left Samurai on map 6)
		- check for obstacles on diagonal moves. 
		- update routefinding for diagonal and more complex maps
		- New graphics for monsters, environment, terrain, projectiles
		- limit ranged attacks in number (no unlimited javelins)
		- ranged attack friendly fire (for monsters). Hit a monster if it's in the way...
		- Performance
			- Shortest path. Sort next candidates by distance from target to find direct routes quicker?

	Dev Stuff
		- Automated Tests
		- Style Guide: http://lua-users.org/wiki/LuaStyleGuide
		
	Deployment
		build.gradle (app)
			Update compileSDK and build tools version
		upgrade version code!
		need to re-enter key information each time	
		
	Assets
		https://craftpix.net/product/2d-fantasy-samurai-sprite-sheets/
		https://craftpix.net/product/ninja-and-assassin-chibi-2d-game-sprites/
		https://craftpix.net/product/2d-fantasy-ninja-sprite-sheets/
		https://craftpix.net/product/2d-fantasy-asassin-sprite-sheets/
		https://craftpix.net/product/2d-fantasy-archer-sprite-sheets/
		https://craftpix.net/product/2d-fantasy-ghosts-sprite-sheets/
		
]]


--set up the global variables and functions
manual = Cyclopedia.new()

currentHero = 1 -- index pointing to the 4 slots we can save, not the array of heroes
currentHeroFileName = "|D|hero"..currentHero

currentMap = 1 -- index pointing to the maps we have saved
currentMapFileName = string.format("%s%02d", MAP_FILE_NAME, currentMap)

localHero = 1 -- This hero gets moved, and the map centers around her

-- Reset all heroes
--SceneChooseHero:resetAllHeroes()

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

drawVersion()

--drawGrid()

--dofile("classes/Tests.lua")

--go to start scene 
INFO("\n**********************\nBushido Battle Started\n**********************\n")
sceneManager:changeScene(SCENE_START, TRANSITION_TIME, TRANSITION)

