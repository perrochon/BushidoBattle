--[[
	this is the class that is called when the player wins the game.
--]]

SceneVictory = Core.class(Sprite)

function SceneVictory:init()


	--local hero = dataSaver.load(currentHeroFileName)
    --local hero  = Player.new(1,1)

	--hero.level = hero.level + 1
	--hero.maxHP = hero.maxHP + 20
	--hero:save(currenHeroFileName)

	self.time = 0	--cycles of time that have passed
	self.a = 0		--setAlpha value for the words on this screen
	
	--first, start out with a light screen
	application:setBackgroundColor(COLOR_WHITE)
	
	--play the music of the scene
	local sounds = Sounds.new(SCENE_VICTORY)
	if music and music.name ~= SCENE_VICTORY then 
		music:stop() 
		self.music = sounds:play("music-victory",1)
		music.name = SCENE_VICTORY
	end 
	
	
	--then add "You did it"
	self.words = TextField.new(FONT_XL, "You did it!")
	self.words:setTextColor(COLOR_DKBLUE)	
	self.words:setPosition(APP_WIDTH/2 - self.words:getWidth()/2, APP_HEIGHT/2 - 200)
	self:addChild(self.words)
	
	--self.words = TextField.new(FONT_LARGE, "You are now level " .. hero.level .. ".")
	--self.words:setTextColor(COLOR_DKBLUE)	
	--self.words:setPosition(APP_WIDTH/2 - self.words:getWidth()/2, APP_HEIGHT/2)
	--self:addChild(self.words)

	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
end

function SceneVictory:onMouseUp(event)
	self.time = self.time + 1
	--if they touch the screen, make sure the previous words are full Alpha
	self.words:setAlpha(1)
	if self.time == 1 then
		--after the first touch, ask to try again
		self.words = TextField.new(FONT_LARGE, "touch to go back in.")	
		self.words:setTextColor(COLOR_BLACK)	
		self.words:setPosition(APP_WIDTH/2 - self.words:getWidth()/2, APP_HEIGHT/2 + 400)
		self.words:setAlpha(self.a)
		self:addChild(self.words)
	else	
		--after the final touch, exit the scene
		self.music:stop()
		application:setBackgroundColor(COLOR_BLACK)
		sceneManager:changeScene(SCENE_LOBBY, TRANSITION_TIME, TRANSITION)
	end
end

function SceneVictory:onEnterFrame(event)
	self.a = self.words:getAlpha()
	if self.a < 1 then
		self.words:setAlpha(self.a + 0.01)
	else
		self.a = 0
	end
end
