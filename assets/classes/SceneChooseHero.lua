SceneChooseHero = Core.class(Sprite)

function SceneChooseHero:init()

	local basicGui = BasicGui.new("Choose a Hero", 
					true, SCENE_LOBBY, 
					"text1", SCENE_CHOOSE_HERO, 
					"text2", SCENE_CHOOSE_HERO)
	self:addChild(basicGui)
	
	for i=1,4 do
		local heroFileName = "|D|hero"..i
		DEBUG(heroFileName)
		local hero = dataSaver.load(heroFileName)	
		if hero then
			DEBUG(i, "found " .. hero.name .. " level " .. hero.level)
			hero.hp = hero.maxHP -- heal whatever hero we found
			self:displayHero(hero, i)	
		else
			hero = Player.new() 
			DEBUG(i, "made " .. hero.name .. " level " .. hero.level)		
			self:displayHero(hero, i)
		end
	end

	basicGui:drawGrid()

end

function SceneChooseHero:displayHero(hero, slot)

	group = Sprite.new()
	
	local yGap = BUTTON_MARGIN
	local heroWidth = (APP_WIDTH - 2 * BUTTON_MARGIN - 3 * yGap)/4
	local heroHeight = 500


	local back = Pixel.new(COLOR_BROWN, 1, heroWidth, heroHeight)
	back:setAnchorPoint(0, 1)

	local front = Pixel.new(COLOR_DKBROWN, 1, heroWidth - 10, heroHeight - 10)
	front:setAnchorPoint(0, 1)
	front:setPosition(5,-5)

	group:setAnchorPoint(0,1)


	group:addChild(back)
	group:addChild(front)

	group:setPosition(BUTTON_MARGIN + (heroWidth + yGap) * (slot-1) , MENU_MARGIN+200)

	self:addChild(group)
	
	


	local heroDescription = ""
	heroDescription = heroDescription .. "Name: " .. hero.name .."\n"
	heroDescription = heroDescription .. "Level: " .. hero.level .."\n"
	heroDescription = heroDescription .. "Health: " .. hero.hp .."\n"
	heroDescription = heroDescription .. "Experience: " .. hero.xp .."\n"
	heroDescription = heroDescription .. "Kills: " .. hero.kills .."\n"

	local title = TextField.new(FONT_MEDIUM, heroDescription)
	title:setTextColor(COLOR_YELLOW)	
	title:setAnchorPoint(0.5,0.5)
	--title:setPosition(APP_WIDTH * 0.2 * slot , APP_HEIGHT * 0.3) 
	--group:addChild(title)

--[[
	local iconTexture = Texture.new("images/texturepack-icons-144px.png", true)
	up = Bitmap.new(TextureRegion.new(iconTexture, 288, 144, 144, 144))
	down = Bitmap.new(TextureRegion.new(iconTexture, 432, 144, 144, 144))

	local newButton = {}
	newButton = Button.new(up, down)
	newButton:setAnchorPoint(0.5,0.5)
	newButton:setPosition(APP_WIDTH * 0.2 * slot , APP_HEIGHT / 3 * 2)  
	self:addChildAt(newButton,1)
	newButton:addEventListener("click", function() 
		dataSaver.save("|D|hero", hero)	
	    sceneManager:changeScene(SCENE_PLAY, TRANSITION_TIME, SceneManager.overFromRight) 
	end)
]]

end