---------------------------------------------------------------------------------
--
-- main.lua
--
---------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )


-- global variables to track scores


gameStats = {
	highScore = 0
}


score = 0
highScore = 0
tempScore = 0
canJump = false
aScore = 0

loadsave = require("loadsave")
gameStatsFromFile = loadsave.loadTable("stats.json")


if(gameStatsFromFile == nil) then
	highScore = 0
	loadsave.saveTable(gameStats, "stats.json")
	gameStats.highScore = 0
else 
	gameStats = gameStatsFromFile
	highScore = gameStats.highScore
end



local composer = require( "composer" )
composer.gotoScene( "mainmenu" )
