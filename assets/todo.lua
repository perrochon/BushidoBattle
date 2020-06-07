--[[

TODO
	- auto connect all the way to Battle...Dependency: new connection protocol
	- Camera Follow Update
	- Bugs
		- Menagerie shows some weird shooting by the sentries, range attack in the wrong direction
		- Change Hero Name in HTML not working anymore
		- Why are green and blue samurai hopping at end of walk?
		- Barracks level very slow due to lots of berserkers pathfinding
		- ResetAllHeroes with a mode that keeps important parameters (xp, kills)
		- Hero reset button not greyed out if hero is dead...
		- Replace Hero animation in ChooseHero with dead hero if hero is dead
		- BFS to monster/env tile searches whole board. Why? Find closest spot? Even when right next to hero. Cut off?
	- (1.0) Multiple Heroes / Remote
		- Mark heroes that still have a turn
	- Game Logic
		- map00 in cheats
		- Need another tactics, for soldiers with single melee weapon(barbarians, trolls)
		- Render shortest path, if walk, and line if can shoot
		- if BFS fails on less than 1000 iterations (because no path), then move anyway
		- shortest path optimization? distance 1.4 can be done in 1 step... so need to multiply with sqrt 2.
		- (low) Diagonal moves only possible when one side open? Not if both sides are blocked (requires maze map fix)
		- (low) limit ranged attacks in number (no unlimited javelins)
		- (low) ranged attack friendly fire (for monsters). Hit a monster if it's in the way...
		- Don't have monsters shoot into walls. If path is fully blocked, then better move, or don't shoot
	- Fog of war
		- Hero shouldn't know shortest route through dark areas, i.e. darkness blocks heroes, not monsters
		- Block line of sight at walls?
	- Graphics
		- Trolls, bears are small - per monster scale factor, and use that everywhere...
		- Use range attack for sprites that have it (heroes...)
		- Make Ninjas throw Shurikens... (or whatever they have). Graphics and words
		- Load monster graphics into cyclopedia
		- New graphics for monsters, environment, terrain, projectiles
		- Jump in gladiator?
	- (1.0) Remote Play
		- fix basic mechanism. Let anyone move any hero. Once all heroes are moved once (or pass), monsters move.
		- Monster AI with multiple heroes
		- Ensure same map on client
		- >2 devices
		- remote attack update
	- Settings Screen with 
		- AutoConnect, sounds, music, (fog of war?)
	- TODO (w/o FIX) in the code base
	- Refactor
		- (low) move keyboard zoom to Camera itself, so it can zoom other stuff, too.
		- (medium) TODO FIX in the code base
		- (medium) factor out remaining data and constants from init.lua to separate files
		- (low) use --!NEED:test.lua and --!NOEXEC http://forum.giderosmobile.com/discussion/comment/63010/#Comment_63010
	- (low) HTML (Web) Sockets
		- http://forum.giderosmobile.com/discussion/6880/gideros-2017-3-1-is-out-now/p1 (search for "sockets")
	- Shaders (for on the fly color changes)
		- https://www.khronos.org/opengl/wiki/GLSL_:_common_mistakes
		- http://forum.giderosmobile.com/discussion/6154/get-pixel-information-from-bitmap-or-texture#latest

Dev Stuff
	- Automated Tests
	- Style Guide: http://lua-users.org/wiki/LuaStyleGuide
	
Deployment
	build.gradle (app)
		Update compileSDK and build tools version
	upgrade version code!
	need to re-enter key information each time	
	
Assets
	https://craftpix.net/product/2d-fantasy-samurai-sprite-sheets/
	https://craftpix.net/product/ninja-and-assassin-chibi-2d-game-sprites/
	https://craftpix.net/product/2d-fantasy-ninja-sprite-sheets/
	https://craftpix.net/product/2d-fantasy-asassin-sprite-sheets/
	https://craftpix.net/product/2d-fantasy-archer-sprite-sheets/
	https://craftpix.net/product/2d-fantasy-ghosts-sprite-sheets/


NOTES
-----

	- Coordinates: 
		(c,r) indicate column, row. 
		(x,y) indicate pixels (either app-coordinate or screen (transformed by Camera)
		Typically, x = c * TILE_WIDTH and y = r * TILEWIDTH (often rounded to ccenter of the tile)



--]]