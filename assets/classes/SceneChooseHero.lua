SceneChooseHero = Core.class(Sprite)

function SceneChooseHero:init()

	local basicGui = BasicGui.new("Choose a Hero", 
					true, SCENE_LOBBY, 
					"text1", SCENE_CHOOSE_HERO, 
					"text2", SCENE_CHOOSE_HERO)
	self:addChild(basicGui)

end