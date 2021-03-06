---------------------------------------------------------------------------------
--
-- credits.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )

-- Load scene with same root filename as this file
--local scene = composer.newScene( sceneName )
local scene = composer.newScene()
---------------------------------------------------------------------------------

--local nextSceneButton

function nextScene (event)
    composer.gotoScene( event.target.name , { effect = "slideDown", time = 300 } )
end

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
    local background = display.newImage("Background/creditsBackground.png")
    background:scale(.4,.4)
    background.x = display.contentCenterX 
    background.y = display.contentCenterY + 15
    sceneGroup:insert(background)

    local backButton = display.newImage("Buttons/backButton.png")
    backButton.name = "mainmenu"
    backButton:scale(.75, .75)
    backButton.x = display.contentCenterX - 230
    backButton.y = display.contentCenterY -125
    sceneGroup:insert(backButton)

   


    backButton:addEventListener( "tap", nextScene )
       
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
         

    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
        --creditsTheme = audio.loadStream("Music/creditsTheme.OGG")
        --playCreditsTheme = audio.play( creditsTheme, { channel=4, loops=0, fadein=0 } )
        
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
        --audio.stop( 4 )
    elseif phase == "did" then
        -- Called when the scene is now off screen
        -- if nextSceneButton then
        --  nextSceneButton:removeEventListener( "touch", nextSceneButton )
        -- end
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
