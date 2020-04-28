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

--This is an example of how you can create a client, which will join to specific server
--and wait for acception

SceneJoinServer = gideros.class(Sprite)

function SceneJoinServer:init()

	self.basicGui = BasicGui.new("Client mode - servers:", 
						"Back", SCENE_CONNECT, 
						"Battle", SCENE_PLAY, 
						"Draw", SCENE_DRAW)
						
	self.battleButton = self.basicGui.button1
	self.drawButton = self.basicGui.button2
	self.basicGui:removeChild(self.battleButton)
	self.basicGui:removeChild(self.drawButton)						
	self:addChild(self.basicGui)
	
	self.servers = {}
	
	function self:onJoin(e)
		local text = TextField.new(FONT_MEDIUM, e.data.host)
		text:setTextColor(COLOR_YELLOW)	
		text:setLayout({flags = FontBase.TLF_REF_MEDIAN |FontBase.TLF_LEFT|FontBase.TLF_NOWRAP})
		local lastHeight = #self.servers*200 + MENU_MARGIN+50
		text:setPosition(MENU_MARGIN, lastHeight)
		self:addChild(text)
		
		--join button
		local joinButton = TextButton.new("Join")	
		joinButton:setAnchorPoint(1,-0.5)
		joinButton:setScale(0.5)
		joinButton:setPosition(APP_WIDTH - MENU_MARGIN, lastHeight)
		self:addChild(joinButton)

		--store id which server to accept
		joinButton.id = e.data.id
		local cnt = #self.servers + 1
		self.servers[cnt] = {}
		self.servers[cnt].text = text
		self.servers[cnt].button = joinButton
		function joinButton:click()
			--connect to server with this id
			serverlink:connect(self.id)
			local parent = self:getParent()
			self:removeFromParent()
		end

		joinButton:addEventListener("click", joinButton.click, joinButton)
		if AUTO_CONNECT then
			joinButton:dispatchEvent(Event.new("click"))
		end
	end
	
	--create client instance
	local os, sdk, mfg, model = application:getDeviceInfo()
	local name = "Client On" .. os .. (model and model or "")
	name = name:gsub("%s+", "")
	serverlink = Client.new({username = name})
	DEBUG_C(name, "started")
	
	serverlink:addEventListener("device", function(e)
		DEBUG_C("Device", e.data.id, e.data.ip, e.data.host)
	end)

	--create event to monitor when new server starts broadcasting
	serverlink:addEventListener("newServer", self.onJoin, self)
	--event to listen if server accepted our connection
	serverlink:addEventListener("onAccepted", function()

		self.basicGui:addChild(self.battleButton)
		self.basicGui:addChild(self.drawButton)
		
	end)
	
	--start listening for server broadcasts
	serverlink:startListening()

end