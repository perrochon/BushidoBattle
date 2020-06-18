--[[
RELEASE NOTES

next 
	- Loot! Woot!
	- Map Navigation upgrades (pahts, attack when in range)
	- Hero name input works in HTML again (using non-native input now)

TODO
	- Bugs
		- Lobby buttons sometimes no longer works in map
		- Hero Name Input: http://forum.giderosmobile.com/discussion/comment/29504/
		- Change Hero Name in HTML not working anymore
		- Navigation funky. Also, need to be able to look at Loot.
		- Barracks level very slow due to lots of berserkers pathfinding
		- ResetAllHeroes with a mode that keeps important parameters (xp, kills)
		- Hero reset button not greyed out if hero is dead...
		- BFS 
			-cut of BFS based on time spent (i.e. 1s/number of monsters)
			-to monster/env tile searches whole board. Why? 
				Find closest spot? Even when right next to hero. Cut off?
			- if BFS times out / fails on less than 1000 iterations (because no path), then move anyway
			- Rewrite BFS with an array of map size? 
				Only worth it if re-used, still updating 1000+ objects on each search...
				10 monsters, 100 fields searched is still 1000
				Instead of boolean found use int, and increment on every search, then no need to clean out
	- FIX in the code base
	- TODO (w/o FIX) in the code base
	- Graphics
		- Fix naming of file names for attack. Barbarians are wrong, for example
		- Use range attack animation for sprites that have it (heroes...)
		- Make Ninjas throw Shurikens... (or whatever they have). Graphics and words
		- Load monster graphics into cyclopedia
		- New graphics for monsters, environment, terrain, projectiles
		- Jump in gladiator?
		- Swizzle full res Samurai_02
		- Make full res animations of heroes for hero selection screen
	- Game Logic
		- Need another tactics, for soldiers with single melee weapon(barbarians, trolls)
		- Navigation: Fat-finger offset for touch would be set in OnTouch event, just read in click
		- shortest path optimization? distance 1.4 can be done in 1 step... so need to multiply with sqrt 2.
		- Music / Sounds refresh. Find a set of new sounds and revise all of it
		- (low) Diagonal moves only possible when one side open? Not if both sides are blocked (requires maze map fix)
		- (low) limit ranged attacks in number (no unlimited javelins)
		- (low) ranged attack friendly fire (for monsters). Hit a monster if it's in the way...
		- Don't have monsters shoot into walls. If path is fully blocked, then better move, or don't shoot
	- Loot
	- Fog of war
		- Hero shouldn't know shortest route through dark areas, i.e. darkness blocks heroes, not monsters
		- Block line of sight at walls?
		- Better way of doing fog of war, that works with smooth animation, and multiple players
	- (1.0) Multiple Heroes / Remote
		- Better placement of multiple heroes. For now, they all go on top of each other...
		-- options: define in map, pile up, find empty spot close, either here, or in character:setPosition
		-- Problems is we haven't loaded maps when we place heroes, and WorldMap.new wants the heroes array
		- Mark heroes that still have a turn
		- Scale difficulty. More monsters? Less HP?
		- Monster AI with multiple heroes
	- (1.0) Remote Play
		- fix basic mechanism. Let anyone move any hero. Once all heroes are moved once (or pass), monsters move.
		- auto connect all the way to Battle...Dependency: new connection protocol. May be tricky with >2 players
		- Ensure same map on client
		- >2 devices
		- remote attack update
	- Settings Screen with 
		- AutoConnect, sounds, music, (fog of war?)
	- Achievements Screen with 
		- Scores, per level? XP?
	- Refactor
		- libpng warning: iCCP: known incorrect sRGB profile
		- Factor out common code in ScenePlay BasicAttack and RangedAttack
		- Macro Functions https://wiki.giderosmobile.com/index.php/Macro_Functions
		- Remove monster tilemap logic
		- access .info, instead of copying it all over.... Maybe call it .i or .p
		- Make Character a sprite, instead of having a sprite (will still have a sprite, of course)
		- (low) move keyboard zoom to Camera itself, so it can zoom other stuff, too.
		-- Look in directory and see how many maps we have instead of hard coding number
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