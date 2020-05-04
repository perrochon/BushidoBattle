SceneConnect = Core.class(Sprite)

function SceneConnect:init()

	local help
	
	if SOCKETS then
		help = "To play with a friend, first player clicks on [Server], second player clicks on [Client]."

		local basicGui = BasicGui.new("Play with a friend", 
							"Lobby", SCENE_LOBBY, 
							"Server", SCENE_START_SERVER, 
							"Client", SCENE_JOIN_SERVER)
		self:addChild(basicGui)
	else
		help = "This platform does not support playing with a friend. Please install the Android app."

		local basicGui = BasicGui.new("Play with a friend", 
							"Lobby", SCENE_LOBBY, 
							nil, nil, 
							nil, nil)
		self:addChild(basicGui)
	end

		local text = TextField.new(FONT_MEDIUM, help)
		text:setTextColor(COLOR_YELLOW)	
		text:setLayout({flags = FontBase.TLF_REF_MEDIAN |FontBase.TLF_LEFT, 
						w=APP_WIDTH-2*MENU_MARGIN})
		text:setPosition(BUTTON_MARGIN, MENU_MARGIN * 2)
		self:addChild(text)
	
end