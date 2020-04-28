SceneConnect = Core.class(Sprite)

function SceneConnect:init()

	local basicGui = BasicGui.new("Play with a friend", 
						"Lobby", SCENE_LOBBY, 
						"Server", SCENE_START_SERVER, 
						"Client", SCENE_JOIN_SERVER)
	self:addChild(basicGui)


	local help = "To play with a friend, first player clicks on Server, second on Client."

	local text = TextField.new(FONT_MEDIUM, help)
	text:setTextColor(COLOR_YELLOW)	
	text:setLayout({flags = FontBase.TLF_REF_MEDIAN |FontBase.TLF_LEFT, 
					w=APP_WIDTH-2*MENU_MARGIN})
	text:setPosition(BUTTON_MARGIN, MENU_MARGIN * 2)
	self:addChild(text)
	
end