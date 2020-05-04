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

function BasicGui:drawGrid()

	-- left, middle, right
	local pixel = Pixel.new(COLOR_RED, 1, 2, APP_HEIGHT)
	self:addChild(pixel)
	pixel = Pixel.new(COLOR_RED, 1, 2, APP_HEIGHT)
	pixel:setPosition(APP_WIDTH / 2, 0)
	self:addChild(pixel)
	pixel = Pixel.new(COLOR_RED, 1, 2, APP_HEIGHT)
	pixel:setPosition(APP_WIDTH, 0)
	self:addChild(pixel)
	
	pixel = Pixel.new(COLOR_GREEN, 0.5, APP_WIDTH, 2)
	pixel:setPosition(0, BUTTON_MARGIN)	
	self:addChild(pixel)
	pixel = Pixel.new(COLOR_GREEN, 0.5, APP_WIDTH, 2)
	pixel:setPosition(0, APP_HEIGHT - BUTTON_MARGIN)	
	self:addChild(pixel)
	pixel = Pixel.new(COLOR_GREEN, 0.5, 2, APP_HEIGHT)
	pixel:setPosition(BUTTON_MARGIN, 0)
	self:addChild(pixel)
	pixel = Pixel.new(COLOR_GREEN, 0.5, 2, APP_HEIGHT)
	pixel:setPosition(APP_WIDTH-BUTTON_MARGIN, 0)
	self:addChild(pixel)	

	pixel = Pixel.new(COLOR_BLUE, 0.5, APP_WIDTH, 2)
	pixel:setPosition(0, MENU_MARGIN)	
	self:addChild(pixel)
	pixel = Pixel.new(COLOR_BLUE, 0.5, APP_WIDTH, 2)
	pixel:setPosition(0, APP_HEIGHT - MENU_MARGIN)	
	self:addChild(pixel)
	pixel = Pixel.new(COLOR_BLUE, 0.5, 2, APP_HEIGHT)
	pixel:setPosition(MENU_MARGIN, 0)
	self:addChild(pixel)
	pixel = Pixel.new(COLOR_BLUE, 0.5, 2, APP_HEIGHT)
	pixel:setPosition(APP_WIDTH-MENU_MARGIN, 0)
	self:addChild(pixel)

--[[
	local x,y,w,h = self.backButton:getBounds(self)
	pixel = Pixel.new(COLOR_APRICOT, 0.5, w-10, h-10)
	pixel:setPosition(x+5, y+5)
	--self:addChild(pixel)
	x,y,w,h = self.button1:getBounds(self)
	pixel = Pixel.new(COLOR_APRICOT, 0.5, w-10, h-10)
	pixel:setPosition(x+5, y+5)
	self:addChild(pixel)
	x,y,w,h = self.button2:getBounds(self)
	pixel = Pixel.new(COLOR_APRICOT, 0.5, w-10, h-10)
	pixel:setPosition(x+5, y+5)
	--self:addChild(pixel)
]]

end