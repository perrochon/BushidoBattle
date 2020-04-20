--[[
	this is the class that creates the player character
--]]

SceneLobby = Core.class(Sprite)

function SceneLobby:init()

	local newHero = Player.new() 
	--DEBUG("made " .. newHero.name .. " level " .. newHero.level)		

	local heroDescription = "Fresh Hero\n\n"
	heroDescription = heroDescription .. "Name: " .. newHero.name .."\n"
	heroDescription = heroDescription .. "Level: " .. newHero.level .."\n"
	heroDescription = heroDescription .. "Health: " .. newHero.hp .."\n"
		heroDescription = heroDescription .. "Experience: " .. newHero.xp .."\n"
	heroDescription = heroDescription .. "Kills: " .. newHero.kills .."\n"
	local title = TextField.new(FONT_MEDIUM, heroDescription)
	title:setTextColor(COLOR_YELLOW)	
	title:setAnchorPoint(0.5,0.5)
	title:setPosition(APP_WIDTH * 0.2 , APP_HEIGHT * 0.3) 
	self:addChild(title)

	local iconTexture = Texture.new("images/texturepack-icons-144px.png", true)
	up = Bitmap.new(TextureRegion.new(iconTexture, 288, 144, 144, 144))
	down = Bitmap.new(TextureRegion.new(iconTexture, 432, 144, 144, 144))

	local newButton = {}
	newButton = Button.new(up, down)
	newButton:setAnchorPoint(0.5,0.5)
	newButton:setPosition(APP_WIDTH * 0.15 , APP_HEIGHT / 3 * 2)  
	self:addChildAt(newButton,1)
	newButton:addEventListener("click", function() 
		dataSaver.save("|D|hero", newHero)	
	    sceneManager:changeScene(SCENE_PLAY, TRANSITION_TIME, SceneManager.overFromRight) 
	end)

	local hero = dataSaver.load("|D|hero")	
	if hero then
		--DEBUG("SceneLobby: Found " .. hero.name .. " level " .. hero.level)	
		hero.hp = hero.maxHP -- heal whatever hero we found
		
		local heroDescription = "Saved Hero\n\n"
		heroDescription = heroDescription .. "Name: " .. hero.name .."\n"
		heroDescription = heroDescription .. "Level: " .. hero.level .."\n"
		heroDescription = heroDescription .. "Health: " .. hero.hp .."\n"
		heroDescription = heroDescription .. "Experience: " .. hero.xp .."\n"
		heroDescription = heroDescription .. "Kills: " .. hero.kills .."\n"
		local title = TextField.new(FONT_MEDIUM, heroDescription)
		title:setTextColor(COLOR_YELLOW)	
		title:setAnchorPoint(0.5,0.5)
		title:setPosition(APP_WIDTH * 0.7, APP_HEIGHT *0.3) 
		self:addChild(title)

		up = Bitmap.new(TextureRegion.new(iconTexture, 288, 144, 144, 144))
		down = Bitmap.new(TextureRegion.new(iconTexture, 432, 144, 144, 144))

		local savedButton = {}
		savedButton = Button.new(up, down)
		savedButton:setAnchorPoint(0.5,0.5)
		savedButton:setPosition(APP_WIDTH * 0.65 , APP_HEIGHT / 3 * 2)  
		self:addChild(savedButton)
		savedButton:addEventListener("click", function() 
			dataSaver.save("|D|hero", hero)	
			sceneManager:changeScene(SCENE_PLAY, TRANSITION_TIME, SceneManager.overFromRight) 
		end)

	else
		INFO("No saved hero found.")
	end
	
end
