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

	self.basicGui = BasicGui.new("Server mode - clients:", 
						"Back", SCENE_CONNECT, 
						"Battle", nil, 
						"Draw", nil)
	self:addChild(self.basicGui)

	--battle button
	self.basicGui.button1:addEventListener("click", 
		function()
			--if we are ready to battle we
			--stop broadcasting
			serverlink:stopBroadcast()
			--and start listening to clients
			serverlink:startListening()
			sceneManager:changeScene(SCENE_PLAY, TRANSITION_TIME, TRANSITION, nil, {userData = "server"}) 
		end
	)

	--draw button
	self.basicGui.button2:addEventListener("click", 
		function()
			--if we are ready to draw we
			--stop broadcasting
			serverlink:stopBroadcast()
			--and start listening to clients
			serverlink:startListening()
			sceneManager:changeScene(SCENE_DRAW, TRANSITION_TIME, TRANSITION) 
		end
	)

	self.clients = {}
	
	
	function self:onAccept(e)
		local text = TextField.new(FONT_MEDIUM, e.data.host)
		text:setTextColor(COLOR_YELLOW)	
		text:setLayout({flags = FontBase.TLF_REF_MEDIAN |FontBase.TLF_LEFT|FontBase.TLF_NOWRAP})
		local lastHeight = #self.clients*200 + MENU_MARGIN+50
		text:setPosition(MENU_MARGIN, lastHeight)
		self:addChild(text)

		--join button
		local acceptButton = TextButton.new("Accept")
		acceptButton:setAnchorPoint(1,-0.5)
		acceptButton:setScale(0.5)
		acceptButton:setPosition(APP_WIDTH - MENU_MARGIN, lastHeight)
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
			
			if AUTO_CONNECT then
				sceneManager:changeScene(SCENE_PLAY, TRANSITION_TIME * 5, TRANSITION)
			end
			
			
		end

		acceptButton:addEventListener("click", acceptButton.click, acceptButton)

		if AUTO_CONNECT then
			acceptButton:dispatchEvent(Event.new("click"))
		end

	end
	
	--create a server instance
	local os, sdk, mfg, model = application:getDeviceInfo()
	local name = "ServerOn" .. os .. (model and model or "")
	name = name:gsub("%s+", "")
	serverlink = Server.new({username = name, maxClients = 1})
	DEBUG_C(name, "started")

	serverlink:addEventListener("device", function(e)
		DEBUG_C("Device", e.data.id, e.data.ip, e.data.host)
	end)

	--add event to monitor when new client wants to join
	serverlink:addEventListener("newClient", self.onAccept, self)
	--start broadcasting to discover devices

	serverlink:startBroadcast()
	


end