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

	local title = TextField.new(font, "Server mode - clients connected: ")
	title:setTextColor(COLOR_YELLOW)	
	title:setPosition(0, 100)
	self:addChild(title)
	
	self.clients = {}
	
	function self:onAccept(e)
		local text = TextField.new(font, e.data.host)
		text:setAnchorPoint(0.5,0.5)
		text:setTextColor(COLOR_YELLOW)	
		local lastHeight = #self.clients*100 + 300
		text:setPosition(APP_WIDTH / 4, lastHeight)
		self:addChild(text)
		
		--join button
		local acceptButton = TextButton.new(font, "Accept", "Accept")
		acceptButton:setPosition(APP_WIDTH - 200, lastHeight)
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
	DEBUG("Server started")
	DEBUG_C("Server started")

	serverlink:addEventListener("device", function(e)
		DEBUG_C("Device", e.data.id, e.data.ip, e.data.host)
	end)

	--add event to monitor when new client wants to join
	serverlink:addEventListener("newClient", self.onAccept, self)
	--start broadcasting to discover devices


	serverlink:startBroadcast()
	
	--draw button
	local drawButton = TextButton.new(font, "Draw", "Draw")
	drawButton:setPosition(APP_WIDTH - 100, BUTTON_Y)
		
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

	--battle button
	local battleButton = TextButton.new(font, "Battle", "Battle")
	battleButton:setPosition(APP_WIDTH / 2, BUTTON_Y)
	self:addChild(battleButton)

	battleButton:addEventListener("click", 
		function()
			--if we are ready to battle we
			--stop broadcasting
			serverlink:stopBroadcast()
			--and start listening to clients
			serverlink:startListening()
			sceneManager:changeScene(SCENE_PLAY, TRANSITION_TIME, TRANSITION, nil, {userData = "server"}) 
		end
	)

	--back button
	local backButton = TextButton.new(font, "Back", "Back")
	backButton:setPosition(100, BUTTON_Y)
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