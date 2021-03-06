---------------------------------------------------------------------------------
--
-- restart.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )

-- Load scene with same root filename as this file
--local scene = composer.newScene( sceneName )
local scene = composer.newScene()
---------------------------------------------------------------------------------

--local nextSceneButton

function nextScene (event)
    

    composer.gotoScene( event.target.name , { effect = "fade", time = 300 } )   
    audio.resume(1)
    
    
end


function showScore(event)

    newScoreText = display.newText(Count, display.contentCenterX + 110 , 120, native.systemFont, 80)

    --tempText = display.newText(Count, display.contentCenterX, 120, native.systemFont, 100)
    Count = 0
   
    newScoreText:setTextColor(0,0,0)

    
    sceneGroup:insert(newScoreText)

end

function scene:create( event )
     sceneGroup = self.view

     audio.pause(1)

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc

    newScoreLabel = display.newText("Score: ", display.contentCenterX -30 , 270, native.systemFont, 80)
    newScoreLabel:setTextColor(50,100,100,35)


    newScoreText = display.newText(score, display.contentCenterX + 110 , 270, native.systemFont, 80)

    --tempText = display.newText(Count, display.contentCenterX, 120, native.systemFont, 100)
    Count = 0
   
    

    background = display.newImage("youLose.png")
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    background:scale(.4, .4)
    sceneGroup:insert(background)

--[[
    print("update score")
    newScoreLabel = display.newText("Score: ", display.contentCenterX -30 , 120, native.systemFont, 80)
    newScoreText = display.newText(Count, display.contentCenterX + 110 , 120, native.systemFont, 80)
    --tempText = display.newText(Count, display.contentCenterX, 120, native.systemFont, 100)
    Count = 0
    newScoreLabel:setTextColor(0,0,0)
    newScoreText:setTextColor(0,0,0)
]]
    local backButton = display.newImage("Buttons/backButton.png")
    backButton.name = "game"
    backButton:scale(.75, .75)
    backButton.x = display.contentCenterX - 230
    backButton.y = display.contentCenterY - 100
    sceneGroup:insert(backButton)

    sceneGroup:insert(newScoreText)
    sceneGroup:insert(newScoreLabel)

--[[
    sceneGroup:insert(newScoreLabel)
    sceneGroup:insert(newScoreText)
    ]]
    --sceneGroup:insert(tempText)

    backButton:addEventListener( "tap", nextScene )

       
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
        -- local title = self:getObjectByName( "Title" )
        -- title.x = display.contentWidth / 2
        -- title.y = display.contentHeight / 2
        -- title.size = display.contentWidth / 20
        -- local goToScene2Btn = self:getObjectByName( "GoToScene2Btn" )
        -- goToScene2Btn.x = display.contentWidth - 95
        -- goToScene2Btn.y = display.contentHeight - 35
        -- local goToScene2Text = self:getObjectByName( "GoToScene2Text" )
        -- goToScene2Text.x = display.contentWidth - 92
        -- goToScene2Text.y = display.contentHeight - 35

        -- add event listener to 'playButton' and 'instructionsButton' global variables that were created in drawMainMenu()
        --playButton:addEventListener( "tap", myMenu.play )
        --instructionsButton:addEventListener( "tap", myMenu.showInstructions )
        --creditsButton:addEventListener( "tap", myMenu.showCredits )


    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
                
		--loseTheme = audio.loadStream("Music/gameOver.ogg")
        --playLoseTheme = audio.play( loseTheme, { channel=3, loops=0, fadein=0 } )

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
        --audio.stop( 3 )
    elseif phase == "did" then
        -- Called when the scene is now off screen
		-- if nextSceneButton then
		-- 	nextSceneButton:removeEventListener( "touch", nextSceneButton )
		-- end
        composer.removeScene("restart")
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
