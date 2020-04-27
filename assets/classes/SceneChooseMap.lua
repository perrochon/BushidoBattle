SceneChooseMap = Core.class(Sprite)

function SceneChooseMap:init()

	local basicGui = BasicGui.new("Choose a Map", 
					"Lobby", SCENE_LOBBY, 
					"Battle", SCENE_PLAY, 
					"Hero", SCENE_CHOOSE_HERO)
	self:addChild(basicGui)
	
	self.panels = {}
	
	for i=1,4 do
		
		local fileName = "level0"..i..".lua"
		local map = loadfile(fileName)() 
		self.panels[i] = self:displayMap(map.properties["Title"], i)
		
	end
	
	self:updateVisualState(true, currentMap)

	--basicGui:drawGrid()

end

function SceneChooseMap:displayMap(map, slot)

	local yGap = BUTTON_MARGIN
	local mapWidth = (APP_WIDTH - 2 * BUTTON_MARGIN - 3 * yGap)/4
	local mapHeight = 400	

	panel = Sprite.new()
	panel:setAnchorPoint(0,1) -- TODO Why does it not matter what this is set to?
	panel:setPosition(BUTTON_MARGIN + (mapWidth + yGap) * (slot-1) , MENU_MARGIN + mapHeight)
	self:addChild(panel)
	
	panel.back = Pixel.new(COLOR_BROWN, 1, mapWidth, mapHeight)
	panel.back:setAnchorPoint(0, 1)
	panel:addChild(panel.back)

	panel.front = Pixel.new(COLOR_DKGREY, 1, mapWidth - 10, mapHeight - 10)
	panel.front:setAnchorPoint(0, 1)
	panel.front:setPosition(5,-5)
	panel:addChild(panel.front)

	local mapDescription = map

	local title = TextField.new(FONT_MEDIUM, mapDescription)
	title:setLayout({flags = FontBase.TLF_REF_TOP |FontBase.TLF_LEFT})
	title:setTextColor(COLOR_YELLOW)	
	title:setPosition(15, -mapHeight+20) 
	panel:addChild(title)

	local x,y,w,h = panel:getBounds(self)
	DEBUG(yGap, mapWidth, mapHeight, " : ", x, y, w, h)
	pixel = Pixel.new(COLOR_BLUE, 0.6, w+10, h+10)
	pixel:setPosition(x-5, y-5)
	--stage:addChild(pixel)

	panel.front.slot = slot

	self.focus = false 
	panel.front:addEventListener(Event.MOUSE_DOWN, SceneChooseMap.onMouseDown, panel.front)
	panel.front:addEventListener(Event.MOUSE_MOVE, SceneChooseMap.onMouseMove, panel.front)
	panel.front:addEventListener(Event.MOUSE_UP, SceneChooseMap.onMouseUp, panel.front)
 
	return panel
end

function SceneChooseMap:onMouseDown(event)
	if self:hitTestPoint(event.x, event.y) then
		DEBUG("Mouse down on panel", self.slot)
		self.focus = true
		self:getParent():getParent():updateVisualState(false, currentMap)
		self:getParent():getParent():updateVisualState(true, self.slot)
		event:stopPropagation()
	end
end

function SceneChooseMap:onMouseMove(event)
	if self.focus then
		DEBUG("Mouse move on panel", self.slot)
		if not self:hitTestPoint(event.x, event.y) then
			DEBUG("Mouse left panel", i)
			self.focus = false;
			self:getParent():getParent():updateVisualState(false, self.slot)
			self:getParent():getParent():updateVisualState(true, currentMap)
		end
		event:stopPropagation()
	end
end

function SceneChooseMap:onMouseUp(event)
	if self.focus then
		DEBUG("Mouse up on panel", self.slot)
		self.focus = false;
		self:getParent():getParent():updateVisualState(false, currentMap)
		self:getParent():getParent():updateVisualState(true, self.slot)
		currentMap = self.slot
		currentMapFileName = "level0"..self.slot -- TODO FIX will break with map 10
		
		event:stopPropagation()
	end
end

function SceneChooseMap:updateVisualState(state, slot)
	if state then
		self.panels[slot].front:setColor(COLOR_GREY)
	else
		self.panels[slot].front:setColor(COLOR_DKGREY)
	end
end