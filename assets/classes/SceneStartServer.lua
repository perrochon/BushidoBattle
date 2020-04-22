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

SceneStartServer = gideros.class(Sprite)

function SceneStartServer:init()

	local title = TextField.new(font, "Clients connected: ")
	title:setTextColor(COLOR_YELLOW)	
	title:setPosition(0, 200)
	self:addChild(title)
	
	self.clients = {}
	
	function self:onAccept(e)
		local text = TextField.new(font, e.data.host)
		local lastHeight = #self.clients*50 + 100
		text:setPosition(30, lastHeight)
		self:addChild(text)
		
		--join button
		local acceptButton = TextButton.new(font, "Accept", "Accept")
		acceptButton.upState:setScale(0.6)
		acceptButton.downState:setScale(0.6)
		acceptButton:setPosition((application:getContentWidth()-acceptButton:getWidth()), lastHeight - acceptButton:getHeight()/2)
		self:addChild(acceptButton)
		--store id which server to accept
		acceptButton.id = e.data.id
		local cnt = #self.clients + 1
		self.clients[cnt] = {}
		self.clients[cnt].text = text
		self.clients[cnt].button = acceptButton
		function acceptButton:click()
			--accept client with this id
			serverlink:accept(self.id)
			local parent = self:getParent()
			self:removeFromParent()
		end
	
		acceptButton:addEventListener("click", acceptButton.click, acceptButton)
	end
	
	--create a server instance
	serverlink = Server.new({username = "myServer"})
	--add event to monitor when new client wants to join
	serverlink:addEventListener("newClient", self.onAccept, self)
	--start broadcasting to discover devices
	serverlink:startBroadcast()
	
	--draw button
	local drawButton = TextButton.new(font, "Play", "Play")
	drawButton:setPosition((application:getContentWidth()-drawButton:getWidth())/2, application:getContentHeight()-drawButton:getHeight()*5)
	self:addChild(drawButton)

	drawButton:addEventListener("click", 
		function()
			--if we are ready to draw we
			--stop broadcasting
			serverlink:stopBroadcast()
			--and start listening to clients
			serverlink:startListening()
			sceneManager:changeScene(SCENE_DRAW, TRANSITION_TIME, TRANSITION) 
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
end