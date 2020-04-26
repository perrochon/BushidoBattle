SceneConnect = Core.class(Sprite)

function SceneConnect:init()

	local basicGui = BasicGui.new("Connect with Friends", 
						"Lobby", SCENE_LOBBY, 
						"Server", SCENE_START_SERVER, 
						"Client", SCENE_JOIN_SERVER)
	self:addChild(basicGui)

end