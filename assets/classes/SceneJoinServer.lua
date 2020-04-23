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
	local title = TextField.new(font, "Client mode - available servers: ")
	title:setTextColor(COLOR_YELLOW)	
	title:setPosition(0, 100)
	self:addChild(title)
	
	self.servers = {}
	
	function self:onJoin(e)
		local text = TextField.new(font, e.data.host)
		text:setAnchorPoint(0.5,0.5)
		text:setTextColor(COLOR_YELLOW)	
		local lastHeight = #self.servers*100 + 300
		text:setPosition(APP_WIDTH / 4, lastHeight)
		self:addChild(text)
		
		--join button
		local joinButton = TextButton.new(font, "Join", "Join")	
		joinButton:setPosition(APP_WIDTH - 200, lastHeight)
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
	end
	
	--create client instance
	serverlink = Client.new({username = "IAmAClient"})
	DEBUG("Client started")
	DEBUG_C("Client started")
	
	serverlink:addEventListener("device", function(e)
		DEBUG_C("Device", e.data.id, e.data.ip, e.data.host)
	end)

	--create event to monitor when new server starts broadcasting
	serverlink:addEventListener("newServer", self.onJoin, self)
	--event to listen if server accepted our connection
	serverlink:addEventListener("onAccepted", function()
		--draw button
		local drawButton = TextButton.new(font, "Draw", "Draw")
		drawButton:setPosition(APP_WIDTH - 100, BUTTON_Y)				
		self:addChild(drawButton)
	
		drawButton:addEventListener("click", 
			function()	
				sceneManager:changeScene(SCENE_DRAW, TRANSITION_TIME, TRANSITION)  
			end
		)
		
		--battle button
		local battleButton = TextButton.new(font, "Battle", "Battle")
		battleButton:setPosition(APP_WIDTH / 2, BUTTON_Y)
		self:addChild(battleButton)

		battleButton:addEventListener("click", 
			function()	
				sceneManager:changeScene(SCENE_PLAY, TRANSITION_TIME, TRANSITION, nil, {userData = "client"})  
			end
		)
	end)
	
	--start listening for server broadcasts
	serverlink:startListening()

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