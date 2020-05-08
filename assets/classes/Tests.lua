--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
Various tests for Bushido Battle
]]

RUN_TESTS @ true

if RUN_TESTS then
	DEBUG("Tests are running")
	-- Can we read all level files successfully?
	for i = 1, 6 do
		local mapFile = string.format("%s%02d", MAP_FILE_NAME, i)

		mapData=MapData.new(mapFile)
		mapData:layerFromMap(1)
		mapData:layerFromMap(2)
		monsters = Monsters.new(mapData)
		monsters:Test1()
		monsters:Test2()
	end
	DEBUG("Tests completed")
else
	INFO("Not running tests")
end