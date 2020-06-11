SceneChooseHero = Core.class(Sprite)

function SceneChooseHero:init()

	local basicGui = BasicGui.new("Choose a Hero", 
					"Lobby", SCENE_LOBBY, 
					"Battle", SCENE_PLAY, 
					"Map", SCENE_CHOOSE_MAP)
	self:addChild(basicGui)
	
	self.panels = {}
	
	for i=1,4 do
	
		self.panels[i] = self:displayHero(i)

		--[[ 
		
		-- TODO HEROFIX If heroes[i] is nil, load from file. If file is empty, create new
		-- TODO HEROFIX Support selection of multiple heroes (checkboxes, not radio buttons)
		
		local heroFileName = "|D|hero"..i
		--DEBUG("Loading", heroFileName)
		--local hero = dataSaver.load(heroFileName)	
		local hero = Hero.new(1,i)	
		--DEBUG(hero)
		if hero then
			--DEBUG(i, "found " .. hero.name .. " level " .. hero.level)
			-- hero.hp = hero.maxHP -- heal whatever hero we found. If we do, we have to save it back...
			self.panels[i] = self:displayHero(hero, i)	
		else
			hero = Hero.new(1,i) 
			--DEBUG(i, "made " .. hero.name .. " level " .. hero.level)
			hero:save(heroFileName)
			self.panels[i] = self:displayHero(hero, i)
		end
			--]]
	end
	
	self:updateVisualState(true, currentHero)

	self.timer = Timer.new(2000)
	self.timer:addEventListener(Event.TIMER, function ()
		if math.random(5) == 1 then
			heroes[math.random(4)].mc:flip()
		end
		if math.random(4) == 1 then
			heroes[math.random(4)].mc:jump()
		else
			if math.random(2) == 1 then
				heroes[math.random(4)].mc:attack1()
			else
				heroes[math.random(4)].mc:attack2()
			end
		end
		if math.random(30) == 1 then
			heroes[1].mc:jump()
			heroes[2].mc:jump()
			heroes[3].mc:jump()
			heroes[4].mc:jump()
		end
		self.timer:setDelay(math.random(5000))
	end)
	self.timer:start()

	self:addEventListener("exitEnd", self.onTransitionOutEnd, self)

	--basicGui:drawGrid()

end

function SceneChooseHero:onTransitionOutEnd()
	self.timer:stop()
end

function SceneChooseHero:displayHero(slot)

	local hero = heroes[slot]

	local yGap = BUTTON_MARGIN
	local heroWidth = (APP_WIDTH - 2 * BUTTON_MARGIN - 3 * yGap)/4
	local heroHeight = 400	

	panel = Sprite.new()
	panel:setAnchorPoint(0,1) -- TODO Why does it not matter what this is set to?
	panel:setPosition(BUTTON_MARGIN + (heroWidth + yGap) * (slot-1) , MENU_MARGIN + heroHeight)
	self:addChild(panel)
	
	panel.back = Pixel.new(COLOR_BROWN, 1, heroWidth, heroHeight)
	panel.back:setAnchorPoint(0, 1)
	panel:addChild(panel.back)

	panel.front = Pixel.new(COLOR_DKGREY, 1, heroWidth - 10, heroHeight - 10)
	panel.front:setAnchorPoint(0, 1)
	panel.front:setPosition(5,-5)
	panel:addChild(panel.front)

	heroName = TextButton.new(hero.name)
	heroName:setAnchorPoint(0,-1)
	heroName:setScale(0.5)
	heroName.back:setColor(COLOR_DKGREY)
	heroName.front:setColor(COLOR_BROWN)
	heroName.title:setLayout({flags = FontBase.TLF_REF_MEDIAN |FontBase.TLF_LEFT|FontBase.TLF_NOWRAP})
	heroName.title:setX(15)
	heroName.back:setWidth(heroWidth * 2 - 60) -- TODO This works, but makes no sense to me
	heroName.front:setWidth(heroName.back:getWidth() - 10)
	heroName:setPosition(15, -heroHeight+20)
	panel:addChild(heroName)

	panel:addChild(hero.mc)
	hero.mc:scaleUp(3)
	if hero.hp <=0 then
		hero.mc:setPosition(heroWidth - 180, -150)
	else
		hero.mc:setPosition(heroWidth - 120, - 150)
		if math.random(2) == 1 then
			hero.mc:flip()
		end
	end
	
	heroName:addEventListener("click", function ()
		local textInputDialog = TextInputDialog.new("Change Hero Name", "Enter Hero Name", 
			hero.name, "Cancel", "Save")
		textInputDialog:addEventListener(Event.COMPLETE, function(event)
			if event.buttonIndex ~= nil then
				hero.name = event.text:sub(1,8)
				hero:save()
				sceneManager:changeScene(SCENE_CHOOSE_HERO, 0, TRANSITION) 				
			end
		end)
		textInputDialog:show()
	end)

	local heroDescription = ""
	heroDescription = heroDescription .. "Level: " .. hero.level .."\n"
	heroDescription = heroDescription .. "HP: " .. hero.hp .."\n"
	heroDescription = heroDescription .. "XP: " .. hero.xp .."\n"
	heroDescription = heroDescription .. "Kills: " .. hero.kills .."\n"

	local title = TextField.new(FONT_SMALL, heroDescription)
	title:setLayout({flags = FontBase.TLF_REF_TOP |FontBase.TLF_LEFT|FontBase.TLF_NOWRAP})
	title:setTextColor(COLOR_YELLOW)	
	title:setPosition(15, -heroHeight+150) 
	panel:addChild(title)

	local x,y,w,h = panel:getBounds(self)
	--DEBUG(yGap, heroWidth, heroHeight, " : ", x, y, w, h)
	pixel = Pixel.new(COLOR_BLUE, 0.6, w+10, h+10)
	pixel:setPosition(x-5, y-5)
	--stage:addChild(pixel)

	resetButton = TextButton.new("Reset")
	resetButton:setAnchorPoint(0.5,1)
	resetButton:setScale(0.5)
	resetButton:setAlpha(0.5)
	resetButton:setPosition(heroWidth / 2, 300)
	panel:addChild(resetButton)

	resetButton:addEventListener("click", function()
		--DEBUG("Resetting", heroFileName)
		heroes[slot] = Hero.new(1,slot) 
		heroes[slot]:save()
		sceneManager:changeScene(SCENE_CHOOSE_HERO, 0, TRANSITION) 
	end)

	panel.front.slot = slot
	
	self.focus = false 
	panel.front:addEventListener(Event.MOUSE_DOWN, SceneChooseHero.onMouseDown, panel.front)
	panel.front:addEventListener(Event.MOUSE_MOVE, SceneChooseHero.onMouseMove, panel.front)
	panel.front:addEventListener(Event.MOUSE_UP, SceneChooseHero.onMouseUp, panel.front)
	
	return panel
end

function SceneChooseHero:onMouseDown(event)
	if self:hitTestPoint(event.x, event.y) then
		--DEBUG("Mouse down on panel", self.slot)
		self.focus = true
		self:getParent():getParent():updateVisualState(false, currentHero)
		self:getParent():getParent():updateVisualState(true, self.slot)
		event:stopPropagation()
	end
end

function SceneChooseHero:onMouseMove(event)
	if self.focus then
		--DEBUG("Mouse move on panel", self.slot)
		if not self:hitTestPoint(event.x, event.y) then
			--DEBUG("Mouse left panel", i)
			self.focus = false;
			self:getParent():getParent():updateVisualState(false, self.slot)
			self:getParent():getParent():updateVisualState(true, currentHero)
		end
		event:stopPropagation()
	end
end

function SceneChooseHero:onMouseUp(event)
	if self.focus then
		--DEBUG("Mouse up on panel", self.slot)
		self.focus = false;
		self:getParent():getParent():updateVisualState(false, currentHero)
		self:getParent():getParent():updateVisualState(true, self.slot)
		currentHero = self.slot
		localHero = self.slot
		for i = 1,4 do heroes[i]:setActive(false) end
		heroes[currentHero]:setActive(true)
		event:stopPropagation()
	end
end

function SceneChooseHero:updateVisualState(state, slot)
	if state then
		self.panels[slot].front:setColor(COLOR_GREY)
	else
		self.panels[slot].front:setColor(COLOR_DKGREY)
	end
end
