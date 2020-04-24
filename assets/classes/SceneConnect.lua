SceneConnect = Core.class(Sprite)

function SceneConnect:init()

	local title = TextField.new(font, "Connect with Friends")
	title:setTextColor(COLOR_YELLOW)	
	title:setAnchorPoint(0,0)
	title:setPosition(BUTTON_MARGIN, BUTTON_MARGIN)
	self:addChild(title)

	--create start button
	local startButton = TextButton.new(font, "Server", "Server")
	startButton:setAnchorPoint(0.5,0)
	startButton:setPosition(APP_WIDTH - BUTTON_MARGIN, BUTTON_Y)
	self:addChild(startButton)

	--start button on click event
	startButton:addEventListener("click", 
		function()
			--go to client select scene
			sceneManager:changeScene(SCENE_START_SERVER, TRANSITION_TIME, TRANSITION) 
		end
	)
	
	--create start button
	local optionsButton = TextButton.new(font, "Client", "Client")
	optionsButton:setAnchorPoint(0.5,0)
	optionsButton:setPosition(APP_WIDTH / 2, BUTTON_Y)
	self:addChild(optionsButton)
	
	--start button on click event
	optionsButton:addEventListener("click", 
		function()	
			--go to server select scene
			sceneManager:changeScene(SCENE_JOIN_SERVER, TRANSITION_TIME, TRANSITION) 
		end
	)
	
	--back button
	local backButton = TextButton.new(font, "Back", "Back")
	backButton:setAnchorPoint(0,0)
	backButton:setPosition(BUTTON_MARGIN,APP_HEIGHT - BUTTON_MARGIN)
	self:addChild(backButton)

	backButton:addEventListener("click", 
		function()	
			--if we are heading back, we can close the server
			if serverlink then
				serverlink:close()
				serverlink = nil
			end
			sceneManager:changeScene(SCENE_LOBBY, TRANSITION_TIME, TRANSITION) 
		end
	)

end