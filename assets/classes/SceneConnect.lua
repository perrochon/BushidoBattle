SceneConnect = Core.class(Sprite)

function SceneConnect:init()
	--here we'd probably want to set up a background picture
	--local screen = Bitmap.new(Texture.new("images/gideros_mobile.png"))
	--self:addChild(screen)
	--screen:setPosition((application:getContentWidth()-screen:getWidth())/2, (application:getContentHeight()-screen:getHeight())/2)

	--create start button
	local startButton = TextButton.new(font, "Start", "Start")
	startButton:setPosition((application:getContentWidth()-startButton:getWidth())/2, ((application:getContentHeight()-startButton:getHeight())/2)-(startButton:getHeight()+20))
	self:addChild(startButton)

	--start button on click event
	startButton:addEventListener("click", 
		function()
			--go to client select scene
			sceneManager:changeScene(SCENE_START_SERVER, TRANSITION_TIME, TRANSITION) 
		end
	)
	
	--create start button
	local optionsButton = TextButton.new(font, "Join", "Join")
	optionsButton:setPosition((application:getContentWidth()-optionsButton:getWidth())/2, ((application:getContentHeight()-optionsButton:getHeight())/2))
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
	backButton:setPosition((application:getContentWidth()-backButton:getWidth())/2, application:getContentHeight()-backButton:getHeight()*2)
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