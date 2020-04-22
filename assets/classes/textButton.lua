 --[[
A generic text button class
 
Adapted from the generic button class
*Now includes Text and font support (added by <a href="/profile/joelghill%29">@joelghill)</a>
 
This code is MIT licensed, see <a href="http://www.opensource.org/licenses/mit-license.php" target="_blank" rel="nofollow">http://www.opensource.org/licenses/mit-license.php</a>
(C) 2010 - 2012 Gideros Mobile 
]]
 
TextButton = gideros.class(Sprite)
 
function TextButton:init(font, textUp, textDown, upState, downState)
 
--create the upState and downstate sprites
	self.upState = Sprite.new()
	self.downState = Sprite.new()
 
-- add images to up and down states if given
 
	if upState and downState then
		self.upImage = upState
		self.downImage = downState
		self.upState:addChild(self.upImage)
		self.downState:addChild(self.downImage)
	end
 
 
--add text and position in middle if necessary 	
	if textUp and textDown then
		self.textUp =TextField.new(font, textUp)
		self.textUp:setTextColor(COLOR_YELLOW)	
		self.textUp:setAnchorPoint(0.5,0.5)

		self.textDown = TextField.new(font, textDown)
		self.upState:addChild(self.textUp)
		self.downState:addChild(self.textDown)
		if upState and downState then -- center text in middle of images
			--set local variables
			local upimageLength = self.upImage:getWidth()
			local upimageHeight = self.upImage:getHeight()
 
			local downimageLength = self.downImage:getWidth()
			local downimageHeight = self.downImage:getHeight()
 
			local uptextLength = self.textUp:getWidth()
			local uptextHeight = self.textUp:getHeight()
 
			local downtextLength = self.textDown:getWidth()
			local downtextHeight = self.textDown:getHeight()
 
			self.textUp:setPosition((upimageLength-uptextLength)/2,(upimageHeight-uptextHeight)/2)
			self.textDown:setPosition((downimageLength-downtextLength)/2,(downimageHeight-downtextHeight)/2)
		end
 
	end
 
	self.focus = false
 
	self:updateVisualState(false)
 
	self:addEventListener(Event.MOUSE_DOWN, self.onMouseDown, self)
	self:addEventListener(Event.MOUSE_MOVE, self.onMouseMove, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
 
	self:addEventListener(Event.TOUCHES_BEGIN, self.onTouchesBegin, self)
	self:addEventListener(Event.TOUCHES_MOVE, self.onTouchesMove, self)
	self:addEventListener(Event.TOUCHES_END, self.onTouchesEnd, self)
	self:addEventListener(Event.TOUCHES_CANCEL, self.onTouchesCancel, self)
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

-- if state is true show downState else show upState
function TextButton:updateVisualState(state)
	if state then
		if self:contains(self.upState) then
			self:removeChild(self.upState)
		end
		
		if not self:contains(self.downState) then
			self:addChild(self.downState)
		end
	else
		if self:contains(self.downState) then
			self:removeChild(self.downState)
		end
		
		if not self:contains(self.upState) then
			self:addChild(self.upState)
		end
	end
end

