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
Count = 0
canJump = false



local composer = require( "composer" )

composer.gotoScene( "mainmenu" )
