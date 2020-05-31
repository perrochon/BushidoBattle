--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[Based on the fade class in the Gideros examples. Messages fade in alpha intensity every frame. 
--]]

Messages = Core.class(Sprite)
 
function Messages:init()
	--[[Logic:  create a table to display all messages
				set up an EventListener
	--]]

	self.board = {}
	--set up a background for the messageboard
	self.bg = Pixel.new(COLOR_DKBLUE, 1, MSG_BOARD_WIDTH, 300)
	self.bg:setPosition(MSG_X, MSG_Y)
	self:addChild(self.bg)
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

function Messages:add(text, type)
	--[[Logic:  new messages are placed on the screen 
				The height of all the previous messages assigns a good position
				The type assigns the color
	--]]
	
	INFO("Message                           " .. text)
	
	local t = tostring(text)
	local msg = TextField.new(FONT_SMALL, t, true)
	
	--add up all the heights of the current messages in the sidebar
	local height = 0
	if self.board then
		for key, m in pairs(self.board) do
			height = height + m:getHeight()
		end
	end
	msg:setPosition(MSG_X + 10, MSG_Y + 10+ height + msg:getHeight())
	
	--assign color based on type
	if type == MSG_DESCRIPTION then
		msg:setTextColor(COLOR_WHITE)
	elseif type == MSG_ATTACK then
		msg:setTextColor(COLOR_YELLOW)
	elseif type == MSG_DEATH then
		msg:setTextColor(COLOR_RED)
	end
	
	--assign the class variables
	table.insert(self.board, msg)
	self.bg:setAlpha(0.25)
	
    self:addChild(msg)
end

function Messages:onEnterFrame()
	--[[Logic:  Look for messages and fade their alpha values
				Remove alphas are 0 to remove from the stage
	--]]

	--check for messages to fade and remove
	if self.board then	
		--id is the message to be removed when self.board[id]:getAlpha() = 0
		local id = nil	
		--dy is the height of id
		local dy = 0	
		--go through the list
		for key, msg in pairs(self.board) do
			--slowly fade each message to 0
			local a = msg:getAlpha() - MSG_FADE
			msg:setAlpha(a)
			--if faded, tag for removal
			if a < MSG_FADE then
				id = key
				dy = msg:getHeight()	
			end
		end
		--if found, remove from self.board
		if id then							
			self.board[id]:removeFromParent()	
			table.remove(self.board, id)
			--move the remaining messages up
			for key, msg in pairs(self.board) do	
				msg:setY(msg:getY() - dy)
			end
		end
	end
	--remove the background if there are no messages to display
	if #self.board == 0 then
		self.bg:setAlpha(0)
	end
end



