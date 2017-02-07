---------------------------------------------------------------------------------
--
-- game.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )

-- Load scene with same root filename as this file
--local scene = composer.newScene( sceneName )
local scene = composer.newScene()
---------------------------------------------------------------------------------

local Physics = require("physics")
Physics.start()

local background 
local backButton
local grass1
local grass2
local grass3
local grass4
local grass5
local heroObject
local obstacle = {}

function nextScene (event)
    native.showAlert('Jumper', 'Are you sure you want to exit the game?', {'Yes', 'Cancel'}, function(event)
        if event.action == 'clicked' and event.index == 1 then
            composer.gotoScene('mainmenu', {time = 500, effect = 'slideRight'})
        end
    end)
end


function heroJump(event)
    heroObject:applyLinearImpulse(0, -0.12, heroObject.x, heroObject.y)
end


function rollObstacles(event)

--get badguy to spawn back at start after they cross a certain x value and
--game should restart upon contact  

    local aSpeed = 0
    for i = 1, #obstacle, 1 do

        if obstacle[i].x < 0 then
            score = score + 1
            scoreText.text = score
            obstacle[i].x = 850
        else
            if (score >= 5) then
                aSpeed = math.random(-310, -145)
            elseif (score >= 10) then
                aSpeed = math.random(-430, -145)
            elseif (score >= 20) then
                aSpeed = math.random(-540, -145)
            elseif (score >= 30) then
                aSpeed = math.random(-650, -145)
            elseif (score >= 40) then
                aSpeed = math.random(-670, -145)
            elseif (score >= 50) then
                aSpeed = math.random(-674, -145)
            elseif (score >= 60) then
                aSpeed = math.random(-680, -150)
            elseif (score >= 70) then
                aSpeed = math.random(-690, -155)
            elseif (score >= 80) then
                aSpeed = math.random(-700, -160)
            elseif (score >= 90) then
                aSpeed = math.random(-710, -170)
            elseif (score >= 100) then
                aSpeed = math.random(-720, -190)

            else 
                aSpeed = math.random(-290, -150)
            end
            obstacle[i]:setLinearVelocity( aSpeed, 0 )
        end

    end
    
end



function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc

    -- add static images
    background = display.newImage( "Background/City.png", 240, 150)
    background:scale( .35, .35 )

    backButton = display.newImage("Buttons/backButton.png")
    backButton.name = "mainmenu"
    backButton:scale(.75, .75)
    backButton.x = display.contentCenterX - 230
    backButton.y = display.contentCenterY - 100

    -- add images that will use Physics     
    grass1 = display.newImage( "Images/grass.png", 197, 300)
    grass1.name = "grass1"
    grass2 = display.newImage("Images/grass.png", 290, 300)
    grass2.name = "grass2"
    grass3 = display.newImage( "Images/grass.png", 197, -30)
    grass3.name = "grass3"
    grass4 = display.newImage( "Images/grass.png", 600, 300)
    grass4.name = "grass4"
    grass5 = display.newImage( "Images/grass.png", 800, 300)
    grass5.name = "grass5"

   
    obstacle[1] = display.newImage( "Images/roadSign.png")
    obstacle[1].x = 250
    obstacle[1].y = 275 
    obstacle[1]:scale(.7, .7)
    obstacle[1].collType = "Images/asteroid"
    obstacle[1].name = "Asteroid 1"

    obstacle[2] = display.newImage( "Images/roadSign.png")
    obstacle[2].x = 350
    obstacle[2].y = 275
    obstacle[2]:scale(.7, .7)
    obstacle[2].name = "Asteroid 2"

    obstacle[3] = display.newImage( "Images/roadSign.png")
    obstacle[3].x = 450
    obstacle[3].y = 275
    obstacle[3]:scale(.7, .7)
    obstacle[3].name = "Asteroid 2"
    
    local heroSheet = graphics.newImageSheet( "Images/Sprite.tif", { width=1080, height=1080, numFrames=8 } )
    -- play 8 frames every 250 ms
    heroObject = display.newSprite( heroSheet, {start=1, count=8, time=250 } )
    heroObject.name = "greenGuy"

    heroObject.x = 50
    heroObject.y = 260  
    heroObject:scale(.1, .1)
    heroObject.gravityScale = 2.75
        
    -- add display components to scene
    sceneGroup:insert(background)
    sceneGroup:insert(backButton)
    sceneGroup:insert(grass1)
    sceneGroup:insert(grass2)
    sceneGroup:insert(grass3)
    sceneGroup:insert(grass4)
    sceneGroup:insert(grass5)

    -- add Listeners
    backButton:addEventListener( "tap", nextScene )
    background:addEventListener("tap", heroJump)
    --Runtime:addEventListener("enterFrame", rollObstacles)

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

        Physics.addBody(grass1, "static", {bounce = 0})
        Physics.addBody(grass2, "static", {bounce = 0})
        Physics.addBody(grass3, "static", {bounce = 0})
        Physics.addBody(grass4, "static", {bounce = 0})
        Physics.addBody(grass5, "static", {bounce = 0})
        
        Physics.addBody(heroObject, "dynamic", {radius = 20, bounce = 0})
        heroObject:play()
    
        Physics.addBody(obstacle[1], "dynamic", {radius = 20, bounce = 0})
        Physics.addBody(obstacle[2], "dynamic", {radius = 20, bounce = 0})
        Physics.addBody(obstacle[3], "dynamic", {radius = 20, bounce = 0})

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
        Physics.stop()
    elseif phase == "did" then
        -- Called when the scene is now off screen
        -- if nextSceneButton then
        --  nextSceneButton:removeEventListener( "touch", nextSceneButton )
        -- end
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    print("DESTROYING THE GAME!")

    Physics.removeBody(grass1)
    Physics.removeBody(grass2)
    Physics.removeBody(grass3)
    Physics.removeBody(grass4)
    Physics.removeBody(grass5)
    Physics.removeBody(heroObject)
    Physics.removeBody(obstacle[1])
    Physics.removeBody(obstacle[2])
    Physics.removeBody(obstacle[3])

    Physics.stop()

    backButton:removeEventListener( "tap", nextScene )
    background:removeEventListener("tap", heroJump)

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
