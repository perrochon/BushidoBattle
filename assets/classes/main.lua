--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
Main for Bushido Battle, Bushido without the talk
]]

--[[ TODO 
		- Environment layer only from tiled
		- monster placed in tiled
		- check for obstacles on diagonal moves. 
		- update routefinding for diagonal
		- New graphics for monsters, environment, terrain, projectiles
		- limit ranged attacks in number (no unlimited javelins)
		- ranged attack friendly fire (for monsters). Hit a monster if it's in the way...
		- use debug.getinfo in DEBUG statements
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

--define the scenes
sceneManager = SceneManager.new({
--these are all the separate screens in the game

[SCENE_START] = SceneStart,		--first thing the player sees
[SCENE_LOBBY] = SceneLobby,		--the character creation scene
[SCENE_PLAY] = ScenePlay,			--the main game scene
[SCENE_DEATH] = SceneDeath,			--when the player dies
[SCENE_VICTORY] = SceneVictory,		--when the player wins
})

stage:addChild(sceneManager)
--go to start scene 
sceneManager:changeScene(SCENE_START, TRANSITION_TIME, TRANSITION)

--local pixel = Pixel.new(COLOR_GREEN, 1, 200,200)
--pixel:setPosition(650,650)
--stage:addChild(pixel)

print("\n\nBushido Battle Started.")
