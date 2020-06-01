--[[
	this is the class that creates the player character
--]]

SceneLobby = Core.class(Sprite)

function SceneLobby:init()

	--play the music of the scene
	-- local sounds = Sounds.new("lobby")
	-- self.music = sounds:play("music-lobby")

	application:setBackgroundColor(COLOR_BLACK)

	local basicGui = BasicGui.new("Bushido Battle", 
						"Quit", nil, 
						"Hero", SCENE_CHOOSE_HERO,
						"Map", SCENE_CHOOSE_MAP)
	self:addChild(basicGui)
	
	basicGui.backButton:addEventListener("click", 
		function(event)
			application:exit()
		end
	) 
	
	self.play = TextButton.new("Battle")
	self.play:setAnchorPoint(0.5,0)
	self.play:setPosition(APP_WIDTH / 3, APP_HEIGHT / 2)
	self:addChild(self.play)
	self.play:addEventListener("click", 
		function()
			sceneManager:changeScene(SCENE_PLAY, TRANSITION_TIME, TRANSITION) 
		end
	)

	self.map = TextButton.new("Connect")
	self.map:setAnchorPoint(0.5,0)
	self.map:setPosition(APP_WIDTH / 3 * 2, APP_HEIGHT / 2)
	self:addChild(self.map)
	self.map:addEventListener("click", 
		function()
			sceneManager:changeScene(SCENE_CONNECT, TRANSITION_TIME, TRANSITION) 
		end
	)

	self.map = TextButton.new("S")
	self.map:setAlpha(0)
	self.map:setPosition(MINX,150)
	self.map:setAnchorPoint(0,0)
	self:addChild(self.map)
	self.map:addEventListener("click", 
		function()
			sceneManager:changeScene(SCENE_SPRITES, TRANSITION_TIME, TRANSITION) 
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
