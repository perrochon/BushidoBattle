--[[
*************************************************************
 * This script is developed by Arturs Sosins aka ar2rsawseen, http://appcodingeasy.com
 * Feel free to distribute and modify code, but keep reference to its creator
 *
 * Gideros Game Template for developing games. Includes: 
 * Start scene, pack select, level select, settings, score system and much more
 *
 * For more information, examples and online documentation visit: 
 * http://appcodingeasy.com/Gideros-Mobile/Gideros-Mobile-Game-Template
**************************************************************

Modified by Louis Perrochon

]]--

--at this phase, there is no difference if we have server or client instance
--all methods are the same, all server resending to client's thingy done internally
--we ca assume that we are comunicating directly between devices

SceneDraw = gideros.class(Sprite)

function SceneDraw:init()
	--for drawing logic
	self.draw = Shape.new()
	self:addChild(self.draw)
	
	--here we will assign each client (including ourselves) a some data
	self.data = {}
	--our color
	self.data.color = self:getColor()
	--other clients data
	self.others = {}
	
	--add methods, that could be called by other clients or server through network
	--draw something
	serverlink:addMethod("draw", self.drawLine, self)
	--end drawing
	serverlink:addMethod("end", self.stopDrawing, self)
	--clear drawing
	serverlink:addMethod("clear", self.reset, self)
	
	serverlink:addEventListener("device", function(e)
		print(e.data.id, e.data.ip, e.data.host)
	end)
	
	serverlink:getDevices()
	
	local dx = application:getLogicalTranslateX() / application:getLogicalScaleX()
	local dy = application:getLogicalTranslateY() / application:getLogicalScaleY()
	
	--reset button
	local resetButton = TextButton.new(font, "Reset", "Reset")
	resetButton:setAnchorPoint(0,0.5)
	resetButton:setPosition(100, APP_HEIGHT - 100)
	self:addChild(resetButton)

	resetButton:addEventListener("click", 
		function()
			--if button clear was pressed then
			--clear our drawing
			self:reset()
			--call this methid for all other clients
			serverlink:callMethod("clear")
		end
	)

	--back button
	local backButton = TextButton.new(font, "Back", "Back")
	backButton:setPosition((application:getContentWidth()-backButton:getWidth())/2, application:getContentHeight()-backButton:getHeight()*2)
	self:addChild(backButton)

	backButton:addEventListener("click", 
		function()	
			--if we are heading back, we can close the server
			if serverlink then
				serverlink:close()
				serverlink = nil
			end
			sceneManager:changeScene(SCENE_CONNECT, TRANSITION_TIME, TRANSITION) 
		end
	)

	self:addEventListener(Event.MOUSE_DOWN, self.Down, self)
	self:addEventListener(Event.MOUSE_MOVE, self.Move, self)
	self:addEventListener(Event.MOUSE_UP, self.Up, self)
	self.drawing = false
end

function SceneDraw:reset()
	self.draw:clear()
end

--this method is designed for assigning random colors from color table
function SceneDraw:getColor()
	if not self.colortable then
		self.colortable = {0xff0000, 0x00ff00, 0x0000ff, 0xff00ff, 0x00ffff, 0xffff00, 0xfff000}
	end
	local rand = math.random(#self.colortable)
	local color = self.colortable[rand]
	self.colortable[rand] = nil
	return color
end

function SceneDraw:getData(sender)
	--by default we will use our own data
	local data = self.data
	--but if sender is specified by this method
	--it means some one else on the networkd called this function
	if sender then
		--so we check if we already assigned data to this client
		if self.others[sender] == nil then
			--if not, let's assign it
			self.others[sender] = {}
			self.others[sender].color = self:getColor()
		end
		--lets store client's color in variable
		data = self.others[sender]
	end
	return data
end

function SceneDraw:drawLine(x, y, sender)
	local data = self:getData(sender)
	--and the we simply draw using specified color
	if data.drawing then
		self.draw:setLineStyle(10, data.color)
		self.draw:beginPath()
		self.draw:moveTo(data.lastX, data.lastY)
		self.draw:lineTo(x, y)
		self.draw:endPath()
	else
		self.draw:setLineStyle(10, data.color)
		data.drawing = true
	end
	data.lastX = x
	data.lastY = y
end

function SceneDraw:stopDrawing(sender)
	local data = self:getData(sender)
	data.drawing = false
end

--mouse down
function SceneDraw:Down(event)
	--and now everytime something is drawn in our application
	self:drawLine(event.x, event.y)
	--we call same method with same arguments on other client devices
	serverlink:callMethod("draw", event.x, event.y)
end

--mouse move
function SceneDraw:Move(event)
	--and now everytime something is drawn in our application
	self:drawLine(event.x, event.y)
	--we call same method with same arguments on other client devices
	serverlink:callMethod("draw", event.x, event.y)
end
--mouse up
function SceneDraw:Up(event)
	--same thing here
	self:stopDrawing()
	serverlink:callMethod("end")
end