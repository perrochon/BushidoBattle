--[[
	this is the class that creates the player character
--]]

SceneLobby = Core.class(Sprite)

function SceneLobby:init()

	local basicGui = BasicGui.new("Bushido Battle", 
						true, nil, 
						"Connect", SCENE_CONNECT, 
						"Hero", SCENE_CHOOSE_HERO)
	self:addChild(basicGui)
	
	basicGui.backButton:addEventListener("click", 
		function()
			if serverlink then
				serverlink:close()
				serverlink = nil
			end
			if event.keyCode == KeyCode.BACK then
				if application:getDeviceInfo() == "Android" then
					application:exit()
				end
			end
		end
	) 
	
	--exit properly if user hits the back button
	self:addEventListener(Event.KEY_DOWN, function(event)
		if event.keyCode == KeyCode.BACK then
			if application:getDeviceInfo() == "Android" then
				application:exit()
			end
		end
	end)	
end
