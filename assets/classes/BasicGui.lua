BasicGui = Core.class(Sprite)

function BasicGui:init(title, back, backToScene, text1, scene1, text2, scene2)

	local title = TextField.new(FONT_LARGE, title)
	title:setTextColor(COLOR_YELLOW)	
	title:setLayout({flags = FontBase.TLF_REF_MEDIAN |FontBase.TLF_LEFT|FontBase.TLF_NOWRAP})
	title:setPosition(BUTTON_MARGIN, (BUTTON_MARGIN + MENU_MARGIN) / 2)
	self:addChild(title)

	--back button
	if back then
		self.backButton = TextButton.new(back)
		self.backButton:setAnchorPoint(0,0)
		self.backButton:setPosition(BUTTON_MARGIN,APP_HEIGHT - BUTTON_MARGIN)
		self:addChild(self.backButton)

		if backToScene then
			self.backButton:addEventListener("click", 
				function()	-- TODO we may not need to do this on all BACK
					--if we are heading back, we can close the server
					if serverlink then
						serverlink:close()
						serverlink = nil
					end
					sceneManager:changeScene(backToScene, TRANSITION_TIME, TRANSITION) 
				end
			)
		end
	end

	if text1 then
		--create button 1
		self.button1 = TextButton.new(text1)
		self.button1:setAnchorPoint(0.5,0)
		self.button1:setPosition(APP_WIDTH / 2, APP_HEIGHT - BUTTON_MARGIN)
		self:addChild(self.button1)
		if scene1 then
			self.button1:addEventListener("click", 
				function()
					sceneManager:changeScene(scene1, TRANSITION_TIME, TRANSITION) 
				end
			)
		end
	end
	
	if text2 then
		--create button 2
		self.button2 = TextButton.new(text2)
		self.button2:setAnchorPoint(1,0)
		self.button2:setPosition(APP_WIDTH - BUTTON_MARGIN, APP_HEIGHT - BUTTON_MARGIN)
		self:addChild(self.button2)
		if scene2 then
			self.button2:addEventListener("click", 
				function()	
					sceneManager:changeScene(scene2, TRANSITION_TIME, TRANSITION) 
				end
			)
		end
	end

	--self:drawGrid()

end

function drawVersion()
	-- Add version number on top of everything
	version = TextField.new(FONT_SMALL, VERSION)
	version:setTextColor(COLOR_YELLOW)	
	version:setPosition(MAXX - version:getWidth() - BUTTON_MARGIN, MAXY- version:getHeight())
	version:setAlpha(0.2)
	stage:addChild(version)
end

function drawGrid()

	-- RED = left, middle, right, top, bottom app area
	local pixel = Pixel.new(COLOR_RED, 1,2, APP_HEIGHT)
	pixel:setPosition(0, 0)
	stage:addChild(pixel)
	pixel = Pixel.new(COLOR_RED, 1, 2, APP_HEIGHT)
	pixel:setPosition(APP_WIDTH / 2, 0)
	stage:addChild(pixel)
	pixel = Pixel.new(COLOR_RED, 1, 2, APP_HEIGHT)
	pixel:setPosition(APP_WIDTH-1, 0)
	stage:addChild(pixel)
	pixel = Pixel.new(COLOR_RED, 1, APP_WIDTH, 2)
	pixel:setPosition(0, 0)	
	stage:addChild(pixel)
	pixel = Pixel.new(COLOR_RED, 1, APP_WIDTH, 2)
	pixel:setPosition(1, APP_HEIGHT-2)	
	stage:addChild(pixel)

	-- GREEN = the area we use for UX: BUTTON_MARGIN away from the edge
	pixel = Pixel.new(COLOR_GREEN, 1, APP_WIDTH - 2 * BUTTON_MARGIN, 2)
	pixel:setPosition(BUTTON_MARGIN, BUTTON_MARGIN)	
	stage:addChild(pixel)
	pixel = Pixel.new(COLOR_GREEN, 1, APP_WIDTH - 2 * BUTTON_MARGIN, 2)
	pixel:setPosition(BUTTON_MARGIN, APP_HEIGHT - BUTTON_MARGIN-1)	
	stage:addChild(pixel)
	pixel = Pixel.new(COLOR_GREEN, 1, 2, APP_HEIGHT - 2 * BUTTON_MARGIN)
	pixel:setPosition(APP_WIDTH - BUTTON_MARGIN - 2, BUTTON_MARGIN)
	stage:addChild(pixel)
	pixel = Pixel.new(COLOR_GREEN, 1, 2, APP_HEIGHT - 2 * BUTTON_MARGIN)
	pixel:setPosition(BUTTON_MARGIN, BUTTON_MARGIN)
	stage:addChild(pixel)
	
	-- BLUE = sides, APRICOT = top
	pixel = Pixel.new(COLOR_BLUE, 0.5, -MINX, MAXY)
	pixel:setPosition(MINX, MINY)	
	stage:addChild(pixel)
	pixel = Pixel.new(COLOR_BLUE, 0.5, -MINX, MAXY)
	pixel:setPosition(APP_WIDTH, MINY)	
	stage:addChild(pixel)

	pixel = Pixel.new(COLOR_APRICOT, 0.5, MAXX, -MINY)
	pixel:setPosition(MINX, MINY)	
	stage:addChild(pixel)
	pixel = Pixel.new(COLOR_APRICOT, 0.5, MAXX, -MINY)
	pixel:setPosition(MINX, APP_HEIGHT)	
	stage:addChild(pixel)
	

end