--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
Main for Bushido Battle
]]

--set up the global variables and functions
manual = Cyclopedia.new()

currentMap = 1 -- index pointing to the maps we have saved
currentMapFileName = string.format("%s%02d", MAP_FILE_NAME, currentMap)
numberOfMaps = 9 -- TODO FIX look in directory and see how many we have...

heroes = {} -- We support 4 heroes that will go in this array

-- Reset all heroes
Hero.resetAllHeroes()
currentHero = 1 -- currently playing hero
localHero = currentHero -- The map centers around her
heroes[currentHero].active = true

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
[SCENE_SPRITES] = SceneSprites,
})

stage:addChild(sceneManager)

drawVersion()

--drawGrid()

--dofile("classes/Tests.lua")

--go to start scene 
print("\n**********************\n Bushido Battle "..VERSION.."\n**********************\n\n")
sceneManager:changeScene(SCENE_LOBBY, TRANSITION_TIME, TRANSITION)
