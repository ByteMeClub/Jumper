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
canJump = false
aScore = 0

local gameStats = {
	highScore = aScore
}


local loadsave = require("loadsave")

loadsave.saveTable(gameStats, "settings.json")




local composer = require( "composer" )

composer.gotoScene( "mainmenu" )
