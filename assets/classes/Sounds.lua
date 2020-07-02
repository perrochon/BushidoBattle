Sounds = Core.class(EventDispatcher)

function Sounds:init(scene)
	self.sounds = {}
	if scene == SCENE_PLAY then
		self:add("melee-hit", "sounds/melee_hit.wav")
		self:add("melee-hit", "sounds/melee_hit2.wav")
		self:add("melee-miss", "sounds/melee_miss.mp3")
		self:add("hero-steps", "sounds/footsteps-light.wav")
		self:add("hero-steps", "sounds/footsteps-03.wav")
		self:add("monster-steps", "sounds/footsteps-02.wav")
		self:add("monster-steps", "sounds/footsteps-one.wav")
		self:add("monster-steps", "sounds/footsteps-fast.wav")
	elseif scene == SCENE_VICTORY then
		self:add("music-victory", "sounds/music-victory.mp3")
	elseif scene == SCENE_DEATH then
		self:add("music-death", "sounds/music-death.mp3")
	elseif scene == SCENE_START then
		self:add("music-title", "sounds/music-title.mp3")
	elseif scene == SCENE_LOBBY then
		self:add("music-lobby", "sounds/Ninja-Game-Intro.mp3")
	else
		DEUBG("No scene called", scene)
	end
end

function Sounds:add(name, sound)
--ties a name to a sound or a table of sounds.
	if self.sounds[name] == nil then
		self.sounds[name] = {}
	end
	self.sounds[name][#self.sounds[name]+1] = Sound.new(sound)
end

function Sounds:play(name, volume)
--plays a named sound at a particular volume
	if self.sounds[name] then
		local repeats = 1
		if string.sub(name, 1, 5) == "music" then 
			repeats = math.huge
			volume = volume and volume or MUSIC_VOLUME
		else
			volume = volume and volume or EFFECTS_VOLUME
		end
		--play repeats of however many sounds there are for that named sound
		sound = self.sounds[name][math.random(1, #self.sounds[name])]:play(0, repeats)
		if sounds then 
			sound:setVolume(volume)
		end
		if string.sub(name, 1, 5) == "music" then
			return sound -- TODO Why not return it all the time. If it's not used, it drops off the stack
		end
	end
end
