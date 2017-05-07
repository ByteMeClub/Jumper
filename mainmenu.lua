---------------------------------------------------------------------------------
--
-- mainmenu.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )

-- Load scene with same root filename as this file
--local scene = composer.newScene( sceneName )
local scene = composer.newScene()
---------------------------------------------------------------------------------

--local nextSceneButton


local playList = {"track1.mp3", "track2.mp3"}



local function shuffle(t)
    local random = math.random
    local iterations = #t
    local j
    
    j = random(iterations)

    return j
end



function nextScene (event)
    composer.gotoScene( event.target.name , { effect = "fade", time = 300 } )
    --audio.pause(1)
end



function scene:create( event )
    
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc

    local background = display.newImage("menuBackground.png")
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    background:scale(1.2, 1.2)

    -- create Global button variable - 'playButton'
    local playButton = display.newImage("Buttons/playButton.png")
    playButton.x = display.contentCenterX
    playButton.y = display.contentCenterY - 75
    playButton.name = "game"
    --playButton:scale( .3, .3 )

    local instructionsButton = display.newImage("Buttons/instructionsButton.png")
    instructionsButton.x = display.contentCenterX
    instructionsButton.y = display.contentCenterY + 5
    instructionsButton.name = "instructions"
    --instructionsButton:scale(.3 , .3)

    local creditsButton = display.newImage("Buttons/creditsButton.png")
    creditsButton.x = display.contentCenterX
    creditsButton.y = display.contentCenterY + 85
    creditsButton.name = "credits"
    --creditsButton:scale(.1, .1)

    

    sceneGroup:insert(background)
    sceneGroup:insert(playButton)
    sceneGroup:insert(instructionsButton)
    sceneGroup:insert(creditsButton)



    --add event listener to 'playButton' and 'instructionsButton' global variables that were created in drawMainMenu()
    playButton:addEventListener( "tap", nextScene )
    instructionsButton:addEventListener( "tap", nextScene )
    creditsButton:addEventListener( "tap", nextScene )

end


function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
        

       

    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc


        song = shuffle(playList)
        menuTheme = audio.loadStream("Music/track2.mp3")
        playMenuTheme = audio.play( menuTheme, { channel=1, loops=-1, fadein=0 } )
      
        --playMenuTheme = audio.play( menuTheme, { channel=1, loops=-1, fadein=0 } )

        
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
        --audio.stop( 1 )
    elseif phase == "did" then
        -- Called when the scene is now off screen
		-- if nextSceneButton then
		-- 	nextSceneButton:removeEventListener( "touch", nextSceneButton )
		-- end
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view
    
    --audio.dispose( menuTheme )

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
