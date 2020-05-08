
RUN_TESTS @ false

if RUN_TESTS then
	DEBUG("Tests are running")
	-- Can we read all level files successfully?
	for i = 1, 6 do
		local mapFile = string.format("level%02d", i)
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