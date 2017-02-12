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
tempScore = 0

--[[
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

-- Define reference points locations anchor ponts
local TOP_REF = 0
local BOTTOM_REF = 1
local LEFT_REF = 0
local RIGHT_REF = 1
local CENTER_REF = 0.5
local baseline = 280
]]



local composer = require( "composer" )

function onCollision( event )
	-- event.phase is a Corona-provided global varible that provides information on what phase the event (in this case collision) is in
	if (event.phase == "began") then

		obj1 = event.object1.name
		obj2 = event.object2.name
		
		if (obj1 == "greenGuy") then
			if (obj2 == "Asteroid 1" or obj2 == "Asteroid 2" or obj2 == "Asteroid 3") then
				event.phase = "ended"
				tempScore = score
				composer.gotoScene('restart', {time = 500, effect = 'zoomOutIn'})
			elseif (obj2 == "grass1" or obj2 == "grass2" or obj2 == "grass3" or obj2 == "grass4" or obj2 == "grass5") then
				print("filler")
			else
				print("Object 2 hitting hero is:" .. obj2 .. "<<")
			end
		elseif  (obj2 == "greenGuy") then
			if (obj1 == "Asteroid 1" or obj1 == "Asteroid 2" or obj1 == "Asteroid 3") then
				event.phase = "ended"
				tempScore = score
				composer.gotoScene('restart', {time = 500, effect = 'zoomOutIn'})
			elseif (obj1 == "grass1" or obj1 == "grass2" or obj1 == "grass3" or obj1 == "grass4" or obj1 == "grass5") then
				print("filler")
			else
				print("Object 1 hitting hero is:" .. obj1 .. "<<")
			end
		end	
	end

end

--[[
local grass = display.newImage( "Images/grass.png" )
grass.anchorX = LEFT_REF
grass.x = 0
grass.y = 300
local grass2 = display.newImage( "Images/grass.png" )
grass2.anchorX = LEFT_REF
grass2.x = 480
grass2.y = 300 

-- solid ground, doesn't need to 

local tPrevious = system.getTimer()
local function move(event)
	local tDelta = event.time - tPrevious
	tPrevious = event.time

	local xOffset = ( .3 * tDelta )

	grass.x = grass.x - xOffset
	grass2.x = grass2.x - xOffset
	
	if (grass.x + grass.contentWidth) < 0 then
		grass:translate( 480 * 2, 0)
	end
	if (grass2.x + grass2.contentWidth) < 0 then
		grass2:translate( 480 * 2, 0)
	end
	
end

]]



-- require the composer library


-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc)


-- Add any system wide event handlers, location, key events, system resume/suspend, memory, etc.

Runtime:addEventListener( "collision", onCollision )
--Runtime:addEventListener( "enterFrame", move )

-- load scene1
composer.gotoScene( "mainmenu" )
