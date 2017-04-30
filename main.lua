---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )


-- global variables to track scores


appPreferences =
{
	score = 0,
	highScore = 0,
	tempScore = 0,
	Count = 0,
	canJump = false
}

system.setPreferences("app", appPreferences)

score = system.getPreference( "app", "score", "number")
highScore = system.getPreference("app", "highScore", "number")
tempScore = system.getPreference("app", "tempScore", "number")
Count = system.getPreference("app", "Count", "number")
canJump = system.getPreference("app", "canJump", "boolean")


local composer = require( "composer" )

composer.gotoScene( "mainmenu" )
