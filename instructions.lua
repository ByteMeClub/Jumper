---------------------------------------------------------------------------------
--
-- instructions.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )

-- Load scene with same root filename as this file
--local scene = composer.newScene( sceneName )
local scene = composer.newScene()
---------------------------------------------------------------------------------

--local nextSceneButton

function nextScene (event)
    composer.gotoScene( event.target.name , { effect = "slideUp", time = 300 } )
end


function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
    local background = display.newImage("Background/Instructions.png")
    background:scale(.32,.32)
    background.x = display.contentCenterX 
    background.y = display.contentCenterY 
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
        
        -- we obtain the object by id from the scene's object hierarchy
        -- nextSceneButton = self:getObjectByName( "GoToScene2Btn" )
        -- if nextSceneButton then
        -- 	-- touch listener for the button
        -- 	function nextSceneButton:touch ( event )
        -- 		local phase = event.phase
        -- 		if "ended" == phase then
        -- 			composer.gotoScene( "scene2", { effect = "fade", time = 300 } )
        -- 		end
        -- 	end
        -- 	-- add the touch event listener to the button
        -- 	nextSceneButton:addEventListener( "touch", nextSceneButton )
        -- end
        
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
    elseif phase == "did" then
        -- Called when the scene is now off screen
		-- if nextSceneButton then
		-- 	nextSceneButton:removeEventListener( "touch", nextSceneButton )
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
