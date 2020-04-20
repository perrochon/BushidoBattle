--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

MainScreen = Core.class(Sprite)

MAIN_SCREEN_WIDTH @ \(APP_WIDTH - FG_X)\
HALFX @ \(FG_X + MAIN_SCREEN_WIDTH / 2)\
COMPASS_Y @ 928
COMPASS_OFFSET @ 166

function MainScreen:init(hero)

	self.hero = hero
	
--	local MAIN_SCREEN_WIDTH = APP_WIDTH - FG_X
--	local halfX = FG_X + MAIN_SCREEN_WIDTH / 2
	local actionY = 520
--	local COMPASS_Y = 928
--	local COMPASS_OFFSET = 166
	local cheatY = 230

	-- Compass
	--local fg = Bitmap.new(Texture.new("images/foreground.png", true))
	local fg = Pixel.new(COLOR_BLACK, 1, APP_WIDTH - FG_X + FG_BLEED, APP_HEIGHT + 2 * FG_BLEED)
	fg:setPosition(FG_X, -FG_BLEED)
	self:addChild(fg)

	local title = TextField.new(FONT_MEDIUM, "Bushido Battle")
	title:setTextColor(COLOR_YELLOW)	
	title:setAnchorPoint(0.5,0.5)
	title:setPosition(HALFX, 150) -- halfway
	self:addChild(title)

	self.tagLine = TextField.new(FONT_SMALL, "No Talk. Only Death.")
	self.tagLine:setTextColor(COLOR_YELLOW)	
	self.tagLine:setAnchorPoint(0.5,0.5)
	self.tagLine:setPosition(HALFX, 190 ) -- halfway
	self:addChild(self.tagLine)

	local level = TextField.new(FONT_SMALL, "Level: " .. self.hero.level)
	level:setTextColor(COLOR_LTGREY)	
	level:setAnchorPoint(0.5,0.5)
	level:setPosition(HALFX, 300) 
	self:addChild(level)

	self.kills = TextField.new(FONT_SMALL, "Kills: " .. self.hero.kills)
	self.kills:setTextColor(COLOR_LTGREY)	
	self.kills:setAnchorPoint(0.5,0.5)
	self.kills:setPosition(HALFX, 350) 
	self:addChild(self.kills)

	self.xp = TextField.new(FONT_SMALL, "Experience: " .. self.hero.xp)
	self.xp :setTextColor(COLOR_LTGREY)	
	self.xp :setAnchorPoint(0.5,0.5)
	self.xp :setPosition(HALFX, 400) 
	self:addChild(self.xp)

	self.hp = TextField.new(FONT_SMALL, "Health: " .. self.hero.xp)
	self.hp :setTextColor(COLOR_LTGREY)	
	self.hp :setAnchorPoint(0.5,0.5)
	self.hp :setPosition(HALFX, 450) 
	self:addChild(self.hp)

	self.xy = TextField.new(FONT_SMALL, self.hero.x .. ",".. self.hero.y)
	self.xy :setTextColor(COLOR_DKGREY)	
	self.xy :setAnchorPoint(0,1)
	self.xy :setPosition(FG_X, APP_HEIGHT) 
	self:addChild(self.xy)


	self:addEventListener(Event.ENTER_FRAME, function(event)
		self.kills:setText("Kills: " .. self.hero.kills )
		self.xp:setText("Experience: " .. self.hero.xp)
		self.hp:setText("Health: " .. self.hero.hp)
		self.xy:setText(self.hero.x .. ",".. self.hero.y)
	end)

	--these variables are for the buttons that respond to user input
	local compass = Sprite.new()
	self.north = {}
	self.south = {}
	self.west = {}
	self.east = {}
	self.center = {}
	self.northwest = {}
	self.northeast = {}
	self.southwest = {}
	self.southeast = {}
	local actions = Sprite.new()
	self.look = {}
	self.move = {}
	self.melee = {}
	self.ranged = {}
	self.cheats = Sprite.new()
	self.death = {}
	self.victory = {}
	self.reset = {}
	
	-- Movement Buttons
	self.north      = MainScreen:movementButton(compass, 0, 144, 144, 144, 144, 144, 144, 144, 0, -1,    0)
	self.south      = MainScreen:movementButton(compass, 0, 144, 144, 144, 144, 144, 144, 144, 0,  1,  180)
	self.west       = MainScreen:movementButton(compass, 0, 144, 144, 144, 144, 144, 144, 144,-1,  0,  -90)
	self.east       = MainScreen:movementButton(compass, 0, 144, 144, 144, 144, 144, 144, 144, 1,  0,   90)
	self.center     = MainScreen:movementButton(compass, 0, 288, 144, 144, 144, 288, 144, 144, 0,  0,    0)
	self.northwest  = MainScreen:movementButton(compass, 0, 144, 144, 144, 144, 144, 144, 144,-1, -1,  -45)
	self.northeast  = MainScreen:movementButton(compass, 0, 144, 144, 144, 144, 144, 144, 144, 1, -1,   45)
	self.southwest  = MainScreen:movementButton(compass, 0, 144, 144, 144, 144, 144, 144, 144,-1,  1, -135)
	self.southeast  = MainScreen:movementButton(compass, 0, 144, 144, 144, 144, 144, 144, 144, 1,  1,  135)
	self:addChild(compass)

	local iconTexture = Texture.new("images/texturepack-icons-144px.png", true)

	
	-- Mode Buttons
	local up = Bitmap.new(TextureRegion.new(iconTexture, 0, 0, 144, 144))
	local down = Bitmap.new(TextureRegion.new(iconTexture, 144, 0, 144, 144))
	self.look = Button.new(up, down)
	self.look:setPosition(HALFX-self.look:getWidth()*2, actionY)  
	actions:addChild(self.look)
	up = Bitmap.new(TextureRegion.new(iconTexture, 864, 0, 144, 144))
	down = Bitmap.new(TextureRegion.new(iconTexture, 1008, 0, 144, 144))
	self.move = Button.new(up, down)
	self.move:setPosition(HALFX-self.move:getWidth(), actionY)  
	actions:addChild(self.move)
	up = Bitmap.new(TextureRegion.new(iconTexture, 288, 0, 144, 144))
	down = Bitmap.new(TextureRegion.new(iconTexture, 432, 0, 144, 144))
	self.melee = Button.new(up, down)
	self.melee:setPosition(HALFX, actionY)  
	actions:addChild(self.melee)
	up = Bitmap.new(TextureRegion.new(iconTexture, 576, 0, 144, 144))
	down = Bitmap.new(TextureRegion.new(iconTexture, 720, 0, 144, 144))
	self.ranged = Button.new(up, down)
	self.ranged:setPosition(HALFX+self.melee:getWidth(), actionY)  
	actions:addChild(self.ranged)
	self:addChild(actions)

	-- Cheat Buttons
	up = TextField.new(FONT_MEDIUM, "D", true)
	down = TextField.new(FONT_MEDIUM, "D", true)
	up:setTextColor(COLOR_WHITE) 
	down:setTextColor(COLOR_BLACK)
	self.death = Button.new(up, down)
	self.death:setAnchorPoint(0.5,0.5)
	self.death:setPosition(HALFX - 150, cheatY) 
	self.cheats:addChild(self.death)
	up = TextField.new(FONT_MEDIUM, "V", true)
	down = TextField.new(FONT_MEDIUM, "V", true)
	up:setTextColor(COLOR_WHITE) 
	down:setTextColor(COLOR_BLACK)
	self.victory = Button.new(up, down)
	self.victory:setAnchorPoint(0.5,0.5)
	self.victory:setPosition(HALFX, cheatY) 
	self.cheats:addChild(self.victory)
	up = TextField.new(FONT_MEDIUM, "R", true)
	down = TextField.new(FONT_MEDIUM, "R", true)
	up:setTextColor(COLOR_WHITE) 
	down:setTextColor(COLOR_BLACK)
	self.reset = Button.new(up, down)
	self.reset:setAnchorPoint(0.5,0.5)
	self.reset:setPosition(HALFX + 150, cheatY) 
	self.cheats:addChild(self.reset)
	
	--exit properly if user hits the back button
	self:addEventListener(Event.KEY_DOWN, function(event)
		if event.keyCode == KeyCode.BACK then
			if application:getDeviceInfo() == "Android" then
				application:exit()
			end
		end
	end)

end

function MainScreen:movementButton(compass, a,b,c,d,e,f,g,h, dx, dy, r)
	local iconTexture = Texture.new("images/texturepack-icons-144px.png", true)
	local up = Bitmap.new(TextureRegion.new(iconTexture, a, b, c, d))
	local down = Bitmap.new(TextureRegion.new(iconTexture, e, f, g, h))
	local button = Button.new(up, down)
	button:setAnchorPoint(0.5, 0.5)
	button:setPosition(HALFX + dx*COMPASS_OFFSET, COMPASS_Y + dy*COMPASS_OFFSET)
	button:setRotation(r)
	compass:addChild(button)	
	return(button)
end

function MainScreen:displayCheats() 
	self:addChild(self.cheats)
    self:removeChild(self.tagLine)	
end


