SceneConnect = Core.class(Sprite)

function SceneConnect:init()

	local title = TextField.new(font, "LAN/WiFi Connect")
	title:setTextColor(COLOR_YELLOW)	
	title:setPosition(0, 200)
	self:addChild(title)

	--create start button
	local startButton = TextButton.new(font, "Server", "Server")
	startButton:setPosition(APP_WIDTH - 100 , BUTTON_Y)
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
	backButton:setPosition(100, BUTTON_Y)
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