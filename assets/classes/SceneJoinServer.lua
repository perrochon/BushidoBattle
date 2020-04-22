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
	local title = TextField.new(font, "Available server: ")
	title:setTextColor(COLOR_YELLOW)	
	title:setPosition(0, 200)
	self:addChild(title)
	
	self.servers = {}
	
	function self:onJoin(e)
		local text = TextField.new(font, e.data.host)
		text:setTextColor(COLOR_YELLOW)	
		local lastHeight = #self.servers*100 + 100
		text:setPosition(200, lastHeight)
		self:addChild(text)
		
		--join button
		local joinButton = TextButton.new(font, "Join", "Join")	
		joinButton.upState:setScale(0.6)
		joinButton.downState:setScale(0.6)
		joinButton:setPosition((application:getContentWidth()-joinButton:getWidth()), lastHeight - joinButton:getHeight()/2)
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
	--create event to monitor when new server starts broadcasting
	serverlink:addEventListener("newServer", self.onJoin, self)
	--event to listen if server accepted our connection
	serverlink:addEventListener("onAccepted", function()
		--draw button
		local drawButton = TextButton.new(font, "Play", "Play")	
		drawButton:setPosition((application:getContentWidth()-drawButton:getWidth())/2, application:getContentHeight()-drawButton:getHeight()*5)
		self:addChild(drawButton)
	
		drawButton:addEventListener("click", 
			function()	
				sceneManager:changeScene(SCENE_DRAW, TRANSITION_TIME, TRANSITION)  
			end
		)
	end)
	--start listening for server broadcasts
	serverlink:startListening()

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