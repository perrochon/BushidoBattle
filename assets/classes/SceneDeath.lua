
SceneDeath = Core.class(Sprite)

function SceneDeath:init(hero)

	self.hero = dataSaver.load("|D|hero")
	--cycles of time/touches that have passed
	self.time = 0	
	--setAlpha value for the words on this screen
	self.a = 0			

	--first, start out with a dark screen
	application:setBackgroundColor(COLOR_BLACK)
	
	--play the music of the scene
	local sounds = Sounds.new("death")
	self.music = sounds:play("music-death")
	
	--then fade in the "You died" words
	self.words = TextField.new(FONT_XL, "You died!")
	self.words:setTextColor(COLOR_WHITE)	
	self.words:setPosition(APP_WIDTH/2 - self.words:getWidth()/2, APP_HEIGHT/2)
	self.words:setAlpha(self.a)
	self:addChild(self.words)
	
	local hero = dataSaver.load("|D|hero")
	dataSaver.save("|D|hero", hero)


	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
end

function SceneDeath:onEnterFrame(event)
	self.a = self.words:getAlpha()
	if self.a < 1 then
		self.words:setAlpha(self.a + 0.01)
	else
		self.a = 0
	end
end

function SceneDeath:onMouseUp(event)
	self.time = self.time + 1
	--if they touch the screen, make sure the previous words are full Alpha
	self.words:setAlpha(1)
	if self.time == 1 then
		--after the first touch, report the score
		local s = self.hero.kills .. " monsters killed."
		if score == 1 then 
			s = self.hero.kills .. " monster killed." 
		end
		self.words = TextField.new(FONT_XL, s)	
		self.words:setTextColor(COLOR_YELLOW)	
		self.words:setPosition(APP_WIDTH/2 - self.words:getWidth()/2, APP_HEIGHT/2 + 200)
		self.words:setAlpha(self.a)
		self:addChild(self.words)
	elseif self.time == 2 then
		--after the second touch, ask to try again
		self.words = TextField.new(FONT_LARGE, "touch to try again.")	
		self.words:setTextColor(COLOR_WHITE)	
		self.words:setPosition(APP_WIDTH/2 - self.words:getWidth()/2, APP_HEIGHT/2 + 400)
		self.words:setAlpha(self.a)
		self:addChild(self.words)
	else
		--after the last touch, exit the scene
		self.music:stop()
		sceneManager:changeScene(SCENE_LOBBY, TRANSITION_TIME, TRANSITION)
	end
end