--[[
	this is the class that creates the first scene the player sees when the game loads.
--]]

SceneStart = Core.class(Sprite)

function SceneStart:init()

	--first, start out with a dark screen
	application:setBackgroundColor(COLOR_BLACK)
	
	self.time = 0	--cycles of time that have passed
	self.a = 0		--setAlpha value for the words on this screen
	
	--play the music of the scene
	local sounds = Sounds.new("title")
	self.music = sounds:play("music-title")
	
	--fade in the words
	self.words = TextField.new(FONT_MEDIUM, "All you want to do is kill...")
	self.words:setTextColor(COLOR_YELLOW)	
	self.words:setPosition(APP_WIDTH/2 - self.words:getWidth()/2, APP_HEIGHT/2 - 300)
	self.words:setAlpha(0)
	self:addChild(self.words)

	-- TODO This code creates a second Version number ons screen. But where is the first one drawn?
	--self.version = TextField.new(FONT_SMALL, VERSION)
	--self.version:setTextColor(COLOR_YELLOW)	
	--self.version:setPosition(APP_WIDTH - self.version:getWidth(), APP_HEIGHT- self.version:getHeight())
	--self.version:setAlpha(0.2)
	--self:addChild(self.version)

	if FBInstant then
		local text = TextField.new(FONT_SMALL, "FBInstant")
		text:setTextColor(COLOR_YELLOW)	
		text:setPosition(100, 1000)
		text:setAlpha(0.2)
		self:addChild(text)
		INFO("SceneStart: FBInstant loaded")

		if FBInstantAPI then
			local text = TextField.new(FONT_SMALL, "FBInstantAPI")
			text:setTextColor(COLOR_YELLOW)	
			text:setPosition(100, 200)
			text:setAlpha(0.2)
			self:addChild(text)
		INFO("SceneStart: FBInstantAPI loaded")
		else
			local text = TextField.new(FONT_SMALL, "FBInstantAPI not loaded")
			text:setTextColor(COLOR_YELLOW)	
			text:setPosition(200, 200)
			text:setAlpha(0.2)
			self:addChild(text)
		ERROR("SceneStart: FBInstantAPI not loaded")
		end
	else
		local text = TextField.new(FONT_SMALL, "FBInstant not loaded")
		text:setTextColor(COLOR_YELLOW)	
		text:setPosition(100, 100)
		text:setAlpha(0.2)
		--self:addChild(text)
		--DEBUG("SceneStart: FBInstant not loaded")
	end


	--set up the onEnterFrame and onMouseUp EventListeners
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
    self:addEventListener("exitBegin", self.onExitBegin, self)
end	

function SceneStart:onEnterFrame()

	self.a = self.a + 0.01			--adjust a to slowly fade in
	self.words:setAlpha(self.a)		
	if self.a >= 1 then				--then reset
		self.time = self.time + 1	--keep track of the number of cycles	
		self.a = 0
	end
	
	if self.time == 1 then
		--when the first words have finished appearing, display
		self.words = TextField.new(FONT_MEDIUM, "not arguing with your party.")	
		self.words:setTextColor(COLOR_YELLOW)
		self.words:setPosition(APP_WIDTH/2 - self.words:getWidth()/2, APP_HEIGHT/2 - 200)
		self.words:setAlpha(0)
		self:addChild(self.words)
	elseif self.time == 2 then
		--then display this
		self.words = TextField.new(FONT_XL, "Bushido Battle")
		self.words:setTextColor(COLOR_YELLOW)
		self.words:setPosition(APP_WIDTH/2 - self.words:getWidth()/2, APP_HEIGHT/2)
		self.words:setAlpha(0)
		self:addChild(self.words)
	elseif self.time == 3 then
		--then display this
		self.words = TextField.new(FONT_MEDIUM, "Touch the screen to begin!")	
		self.words:setTextColor(COLOR_WHITE)
		self.words:setPosition(APP_WIDTH/2 - self.words:getWidth()/2, APP_HEIGHT/2 + 200)
		self.words:setAlpha(0)
		self:addChild(self.words)
	end
end
	
function SceneStart:onMouseUp()
	--this will be called when they're ready to play
	self.music:stop()
	self.words = TextField.new(FONT_MEDIUM, "Good luck!")	
	self.words:setTextColor(COLOR_RED)
	self.words:setPosition(APP_WIDTH/2 - self.words:getWidth()/2, APP_HEIGHT/2 + 400)
	self.words:setAlpha(1)
	self:addChild(self.words)
	sceneManager:changeScene(SCENE_LOBBY, TRANSITION_TIME, TRANSITION)
end

--removing event on exiting scene
function SceneStart:onExitBegin()
    self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:removeEventListener(Event.MOUSE_UP, self.onMouseUp, self)
end
