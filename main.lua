---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )


-- global variables to track scores
score = 0
highScore = 0

local composer = require( "composer" )

function onCollision( event )
	-- event.phase is a Corona-provided global varible that provides information on what phase the event (in this case collision) is in
	if (event.phase == "began") then

		obj1 = event.object1.name
		obj2 = event.object2.name
		
		if (obj1 == "greenGuy") then
			if (obj2 == "Asteroid 1" or obj2 == "Asteroid 2" or obj2 == "Asteroid 3") then
				event.phase = "ended"
				composer.gotoScene('restart', {time = 500, effect = 'fromTop'})
			elseif (obj2 == "grass1" or obj2 == "grass2" or obj2 == "grass3" or obj2 == "grass4" or obj2 == "grass5") then
				print("filler")
			else
				print("Object 2 hitting hero is:" .. obj2 .. "<<")
			end
		elseif  (obj2 == "greenGuy") then
			if (obj1 == "Asteroid 1" or obj1 == "Asteroid 2" or obj1 == "Asteroid 3") then
				event.phase = "ended"
				composer.gotoScene('restart', {time = 500, effect = 'fromTop'})
			elseif (obj1 == "grass1" or obj1 == "grass2" or obj1 == "grass3" or obj1 == "grass4" or obj1 == "grass5") then
				print("filler")
			else
				print("Object 1 hitting hero is:" .. obj1 .. "<<")
			end
		end	
	end

end

-- require the composer library


-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)


-- Add any system wide event handlers, location, key events, system resume/suspend, memory, etc.

Runtime:addEventListener( "collision", onCollision )

-- load scene1
composer.gotoScene( "mainmenu" )
