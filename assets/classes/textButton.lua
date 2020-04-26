 --[[
A generic text button class
 
Adapted from the generic button class
 
This code is MIT licensed, see <a href="http://www.opensource.org/licenses/mit-license.php" target="_blank" rel="nofollow">http://www.opensource.org/licenses/mit-license.php</a>
(C) 2010 - 2012 Gideros Mobile 
]]
 
TextButton = gideros.class(Sprite)

function TextButton:init(text)

	self.back = Pixel.new(COLOR_YELLOW, 1, 400, MENU_MARGIN - BUTTON_MARGIN)
	self.back:setAnchorPoint(0, 1)
	self:addChild(self.back)

	self.front = Pixel.new(COLOR_BROWN, 1, 400 - 10, MENU_MARGIN - BUTTON_MARGIN - 10)
	self.front:setAnchorPoint(0, 1)
	self.front:setPosition(5,-5)
	self:addChild(self.front)

	--self:DrawGrid()

 	local title = TextField.new(FONT_MEDIUM, text)
	title:setTextColor(COLOR_YELLOW)	
	title:setLayout({flags = FontBase.TLF_REF_MEDIAN |FontBase.TLF_CENTER|FontBase.TLF_NOWRAP})
	title:setPosition(200, - (MENU_MARGIN - BUTTON_MARGIN) / 2)
	self:addChild(title)

	self:updateVisualState(false)
	self.focus = false 
	self:addEventListener(Event.MOUSE_DOWN, self.onMouseDown, self)
	self:addEventListener(Event.MOUSE_MOVE, self.onMouseMove, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
 
	--self:addEventListener(Event.TOUCHES_BEGIN, self.onTouchesBegin, self)
	--self:addEventListener(Event.TOUCHES_MOVE, self.onTouchesMove, self)
	--self:addEventListener(Event.TOUCHES_END, self.onTouchesEnd, self)
	--self:addEventListener(Event.TOUCHES_CANCEL, self.onTouchesCancel, self)

end

function TextButton:onMouseDown(event)
	if self:hitTestPoint(event.x, event.y) then
		self.focus = true
		self:updateVisualState(true)
		event:stopPropagation()
	end
end

function TextButton:onMouseMove(event)
	if self.focus then
		if not self:hitTestPoint(event.x, event.y) then
			self.focus = false;
			self:updateVisualState(false)
		end
		event:stopPropagation()
	end
end

function TextButton:onMouseUp(event)
	if self.focus then
		self.focus = false;
		self:updateVisualState(false)
		self:dispatchEvent(Event.new("click"))
		event:stopPropagation()
	end
end

--[[

-- if button is on focus, stop propagation of touch events
function TextButton:onTouchesBegin(event)
	if self.focus then
		event:stopPropagation()
	end
end

-- if button is on focus, stop propagation of touch events
function TextButton:onTouchesMove(event)
	if self.focus then
		event:stopPropagation()
	end
end

-- if button is on focus, stop propagation of touch events
function TextButton:onTouchesEnd(event)
	if self.focus then
		event:stopPropagation()
	end
end

-- if touches are cancelled, reset the state of the button
function TextButton:onTouchesCancel(event)
	if self.focus then
		self.focus = false;
		self:updateVisualState(false)
		event:stopPropagation()
	end
end

]]

-- if state is true show downState else show upState
function TextButton:updateVisualState(state)
	if state then
		self.front:setColor(COLOR_DKBROWN)
	else
		self.front:setColor(COLOR_BROWN)
	end
end


function TextButton:DrawGrid()
	local 
	pixel = Pixel.new(COLOR_WHITE, 1, 10,10) pixel:setAnchorPoint(0,1) pixel:setPosition(0,0) self:addChild(pixel)
	pixel = Pixel.new(COLOR_RED, 1, 10,10) pixel:setAnchorPoint(1,0) pixel:setPosition(100,-100) self:addChild(pixel)
	pixel = Pixel.new(COLOR_GREEN, 1, 10,10) pixel:setAnchorPoint(0,0) pixel:setPosition(0,-100) self:addChild(pixel)
	pixel = Pixel.new(COLOR_BLUE, 1, 10,10) pixel:setAnchorPoint(1,1) pixel:setPosition(100,0) self:addChild(pixel)
end
 

