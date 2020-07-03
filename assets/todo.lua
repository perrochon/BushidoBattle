--[[
RELEASE NOTES

- Release on Android
	- Export to Android
	- Update in Notepad
		- compileSdkVersion to 28
		- buildToolsVersion in app/build.gradle to "28.0.3"
		- versionCode to YYMMDDHH (makes it bigger than the last)
		- Not sure why Gideros doesn't do that despite setting
	- Rename old folder in Android, move new exported folder in it's place
	- Open in Android Studio
	- Deploy to phone and test
	- Generate Signed Bundle
		- Keystore: E:\KeyStore, key name: key0
	- Open Play Console
		- Create release
		- Update Version number

next 
	- Loot! Woot!
	- Map Navigation upgrades (paths, attack when in range)
	- Hero name input works in HTML again (using non-native input now)

known issues 
	- 2-player mode broken ("connect")

major next features
	- Parties (more than one hero)
	- Support remote play (again)
	- Spending Loot

Priority

TODO
	- Bugs
		- Update maps to allow for 4 heroes starting placement (need 4 spots horizontally)
		- ResetAllHeroes with a mode that keeps important parameters (xp, kills)
	- FIX in the code base
	- TODO (w/o FIX) in the code base
	- Graphics
		- Hero reset button not greyed out if hero is dead...
		- Fix naming of file names for attack. Barbarians are wrong, for example
		- Use range attack animation for sprites that have it (heroes...)
		- Make Ninjas throw Shurikens... (or whatever they have). Graphics and words
		- New graphics for projectiles
		- (low) Projectile direction/angle to move direction defender, not direction obstacle
		- Swizzle full res Samurai_02
		- Make full res animations of heroes for hero selection screen
	- Navigation
		- Fat-finger offset for touch would be set in OnTouch event, just read in click
	- Game Logic
		- Need another tactics, for soldiers with single melee weapon(barbarians, trolls)
		- Music / Sounds refresh. Find a set of new sounds and revise all of it
		- (low) Diagonal moves only possible when one side open? Not if both sides are blocked (requires maze map fix)
		- (low) limit ranged attacks in number (no unlimited javelins)
		- (low) ranged attack friendly fire (for monsters). Hit a monster if it's in the way...
		- (low) Don't have monsters shoot into walls. If path is fully blocked, then better move, or don't shoot
	- Loot
		- Ways to spend it
		- Scenario end based on loot (dropped or found)
	- Fog of war
		- (low) block line of sight at walls?
		- (low) Better way of doing fog of war, that works with smooth animation, and multiple players
	- (1.0) Multiple Heroes / Remote / HEROFIX
		- Better placement of multiple heroes. For now, they all go on top of each other...
		-- options: define in map, pile up, find empty spot close, either here, or in character:setPosition
		-- Problems is we haven't loaded maps when we place heroes, and WorldMap.new wants the heroes array
		- Mark heroes that still have a turn
		- Scale difficulty. More monsters? Less HP?
		- Monster AI with multiple heroes
	- (1.0) Remote Play / HEROFIX
		- Fix basic mechanism. Let anyone move any hero. Once all heroes are moved once (or pass), monsters move.
		- auto connect all the way to Battle...Dependency: new connection protocol. May be tricky with >2 players
		- Ensure same map on client
		- >2 devices
		- remote attack update
		- Let 2nd player play monsters
	- Settings Screen with 
		- AutoConnect, sounds, music, (fog of war?)
	- Achievements Screen with 
		- Scores, per level? XP?
	- Refactor
		- access .info, instead of copying it all over.... Maybe call it .i or .p
		- libpng warning: iCCP: known incorrect sRGB profile
		- Factor out common code in ScenePlay BasicAttack and RangedAttack
		- Make Character a sprite, instead of having a sprite (will still have a sprite, of course)
		- (low) move keyboard zoom to Camera itself, so it can zoom other stuff, too.
		-- Look in directory and see how many maps we have instead of hard coding number
		- (medium) factor out remaining data and constants from init.lua to separate files
		- (low) use --!NEED:test.lua and --!NOEXEC http://forum.giderosmobile.com/discussion/comment/63010/#Comment_63010
		- (low) Hero Name Input: http://forum.giderosmobile.com/discussion/comment/29504/
	- (low) BFS 
			- (low) Rewrite BFS with an array of map size? 
				Only worth it if re-used, still updating 1000+ objects on each search...
				10 monsters, 100 fields searched is still 1000
				Instead of boolean found use int, and increment on every search, then no need to clean out
		- (low) Change Hero Name in Player portrait keyboard
	- (low) HTML (Web) Sockets
		- http://forum.giderosmobile.com/discussion/6880/gideros-2017-3-1-is-out-now/p1 (search for "sockets")
	- Music
		- https://soundimage.org/wp-content/uploads/2020/03/Ancient-Game-Open.mp3
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