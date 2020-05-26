--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
Main for Bushido Battle, Bushido without the talk
]]

--[[ TODO
		- auto connect all the way to Battle...
		- Camera Follow Update
		- Bugs
			- After ranged action, hitting center icon for pass shoots an arrow to nowhere.
		- Game Logic
			- shortest path optimization? distance 1.4 can be done in 1 step... so need to multiply with sqrt 2.
			- (low) Diagonal moves only possible when one side open? Not if both sides are blocked (requires maze map fix)
			- (low) limit ranged attacks in number (no unlimited javelins)
			- (low) ranged attack friendly fire (for monsters). Hit a monster if it's in the way...
		- Fog of war
			- Hero shouldn't know shortest route through dark areas, i.e. darkness blocks heroes, not monsters
			- Block line of sight at walls?
		- Graphics
			- Load monster graphics into cyclopedia
			- Fix HP layer. Wrong size. Maybe different graphics?
			- New graphics for monsters, environment, terrain, projectiles
		- Remote Play
			- fix basic mechanism. Let anyone move any hero. Once all heroes are moved once (or pass), monsters move.
			- Monster AI with multiple heroes
			- Ensure same map on client
			- >2 devices
			- remote attack update
		- Settings Screen with 
			- AutoConnect, sounds, music, (fog of war?)
		- TODO (w/o FIX) in the code base
		- Refactor
			- (low) move keyboard zoom to Camera itself, so it can zoom other stuff, too.
			- (medium) TODO FIX in the code base
			- (medium) factor out remaining data and constants from init.lua to separate files
		- (low) HTML (Web) Sockets
			- http://forum.giderosmobile.com/discussion/6880/gideros-2017-3-1-is-out-now/p1 (search for "sockets")

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
INFO("\n**********************\n Bushido Battle "..VERSION.."\n**********************\n")
sceneManager:changeScene(SCENE_START, TRANSITION_TIME, TRANSITION)

-- Use the below when debugging issues with sprite loading
--stage:addChild(manual:displayAllSprites())
