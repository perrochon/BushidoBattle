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
		function(event)
			application:exit()
		end
	) 
	
	self.play = TextButton.new("Battle")
	self.play:setAnchorPoint(0.5,0)
	self.play:setPosition(APP_WIDTH / 2, APP_HEIGHT / 2)
	self:addChild(self.play)
	self.play:addEventListener("click", 
		function()
			sceneManager:changeScene(SCENE_PLAY, TRANSITION_TIME, TRANSITION) 
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
