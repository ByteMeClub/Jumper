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

Physics.setGravity( 0, 18)

local background 
local backButton
local pauseButton
local grass1
local grass2
local grass3
local grass4
local grass5
local heroObject
local obstacle = {}
local scoreText
local scoreLabel
local highScoreText
local highScoreLabel

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

--[[
local Grass = display.newImage( "Images/grass.png" )
Grass.anchorX = LEFT_REF
Grass.x = 0
Grass.y = 300
local Grass2 = display.newImage( "Images/grass.png" )
Grass2.anchorX = LEFT_REF
Grass2.x = 480
Grass2.y = 300 
]]
local tPrevious = system.getTimer()



function nextScene (event)    
    Physics.pause()
    heroObject:pause()
    audio.pause(2)
    native.showAlert('Jumper', 'Are you sure you want to exit the game?', {'Yes', 'Cancel'}, function(event)
        if event.action == 'clicked' and event.index == 1 then
            composer.gotoScene('mainmenu', {time = 500, effect = 'slideRight'})
        else
            heroObject:play()
            Physics.start()
            audio.resume(2)
        end
    end)

end


function pauseScene (event)
    Physics.pause()
    heroObject:pause()
    audio.pause(2)
    native.showAlert('Jumper', 'Game Paused', {'Return to Menu', 'Resume'}, function(event)
        if event.action == 'clicked' and event.index == 1 then
            composer.gotoScene('mainmenu', {time = 500, effect = 'slideRight'})
        else
            heroObject:play()
            Physics.start()
            audio.resume( 2 )
        end
    end)
end

function heroJump(event)
    if (canJump == true ) then
        heroObject:applyLinearImpulse(0, -0.12, heroObject.x, heroObject.y)
        canJump = false
    end
end



local function move(event)
    local tDelta = event.time - tPrevious
    tPrevious = event.time

    local xOffset = ( .3 * tDelta )

    Grass.x = Grass.x - xOffset
    Grass2.x = Grass2.x - xOffset
    
    if (Grass.x + Grass.contentWidth) < 0 then
        Grass:translate( 480 * 2, 0)
    end
    if (Grass2.x + Grass2.contentWidth) < 0 then
        Grass2:translate( 480 * 2, 0)
    end
    
end




function rollObstacles(event)

--get badguy to spawn back at start after they cross a certain x value and
--game should restart upon contact  
    
    local aSpeed = 0
    for i = 1, #obstacle, 1 do

        if obstacle[i].x < (heroObject.x - 50) then
            score = score + 1
            scoreText.text = score
            if (score > highScore) then
                highScore = score
                highScoreText.text = highScore
            end
            Count = Count + 1
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


local function onLocalCollision(self, event)

    if (event.phase == "began") then

        local obj1 = self.name
        local obj2 = event.other.name
        
        if (obj1 == "greenGuy") then
            if (obj2 == "Asteroid 1" or obj2 == "Asteroid 2" or obj2 == "Asteroid 3") then
                event.phase = "ended"
--                tempScore = score
                composer.gotoScene('restart', {time = 500, effect = 'zoomOutIn'})
            elseif (obj2 == "grass1" or obj2 == "grass2" or obj2 == "grass3" or obj2 == "grass4" or obj2 == "grass5") then
                canJump = true
                print("filler")
            else
                
                print("Object 2 hitting hero is:" .. obj2 .. "<<")
            end
        elseif  (obj2 == "greenGuy") then
            if (obj1 == "Asteroid 1" or obj1 == "Asteroid 2" or obj1 == "Asteroid 3") then
                event.phase = "ended"
--                tempScore = score
                composer.gotoScene('restart', {time = 500, effect = 'zoomOutIn'})
            elseif (obj1 == "grass1" or obj1 == "grass2" or obj1 == "grass3" or obj1 == "grass4" or obj1 == "grass5") then
                print("filler")
                canJump = true
            else
                
                print("Object 1 hitting hero is:" .. obj1 .. "<<")
            end
        end 
    end


end



function scene:create( event )
    local sceneGroup = self.view

    Physics.pause()

    composer.removeScene("mainmenu")

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene

    score = 0

    print("SCORE = ", score)

    --audio.play(2)

    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc

    -- add static images

    background = display.newImage( "Background/City.png", 240, 150)
    background:scale( .35, .35 )

    backButton = display.newImage("Buttons/backButton.png")
    backButton.name = "mainmenu"
    backButton:scale(.75, .75)
    backButton.x = display.contentCenterX - 230
    backButton.y = display.contentCenterY - 100

    pauseButton = display.newImage("Buttons/backButton.png")
    pauseButton.name = "pause"
    pauseButton:scale(.5, .5)
    pauseButton.x = display.contentCenterX 
    pauseButton.y = display.contentCenterY - 125

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
   

   
    obstacle[1] = display.newImage( "Images/asteroid.png")
    obstacle[1].x = 400
    obstacle[1].y = 275 
    obstacle[1]:scale(.5, .5)
    --obstacle[1].collType = "Images/asteroid"
    obstacle[1].name = "Asteroid 1"

    obstacle[2] = display.newImage( "Images/asteroid.png")
    obstacle[2].x = 700
    obstacle[2].y = 275
    obstacle[2]:scale(.5, .5)
    obstacle[2].name = "Asteroid 2"

    obstacle[3] = display.newImage( "Images/asteroid.png")
    obstacle[3].x = 1000
    obstacle[3].y = 275
    obstacle[3]:scale(.5, .5)
    obstacle[3].name = "Asteroid 2"
    
    local heroSheet = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=15 } )
    -- play 8 frames every 250 ms
    heroObject = display.newSprite( heroSheet, {start=1, count=15, time=500 } )
    heroObject.name = "greenGuy"

    heroObject.x = 50
    heroObject.y = 260  
    --heroObject:scale(.1, .1)


--[[
    local roadSheet = graphics.newImageSheet( "Images/Road.png", { width=1920, height=810, numFrames=12 } )

    roadObject = display.newSprite( roadSheet, {start=1, count=12, time=250 } )
    roadObject.name = "road"

    roadObject.x = 50
    roadObject.y = 260  
]]

        
    scoreText = display.newText(score, display.contentCenterX + 50, 90, native.systemFont, 30)
    scoreLabel = display.newText("Score: ", display.contentCenterX -10 , 90, native.systemFont, 30)
    highScoreText = display.newText(highScore, display.contentCenterX + 250, 30, native.systemFont, 30)
    highScoreLabel = display.newText("Highscore: ", display.contentCenterX + 160, 30, native.systemFont, 30)

    -- add display components to scene
    -- IMPORTANT! If you add display components diectly to Physics and do not add them to sceneGroup, then they will not get removed automatically when scence is hidden/destroyed
    sceneGroup:insert(background)
    sceneGroup:insert(backButton)
    sceneGroup:insert(pauseButton)
    sceneGroup:insert(grass1)
    sceneGroup:insert(grass2)
    sceneGroup:insert(grass3)
    sceneGroup:insert(grass4)
    sceneGroup:insert(grass5)

    --sceneGroup:insert(Grass)
    --sceneGroup:insert(Grass2)

    sceneGroup:insert(heroObject)
    sceneGroup:insert(obstacle[1])
    sceneGroup:insert(obstacle[2])
    sceneGroup:insert(obstacle[3])

    sceneGroup:insert(scoreText)
    sceneGroup:insert(highScoreText)
    sceneGroup:insert(scoreLabel)
    sceneGroup:insert(highScoreLabel)

    -- add Listeners
    backButton:addEventListener( "tap", nextScene )
    background:addEventListener("tap", heroJump)
    pauseButton:addEventListener( "tap", pauseScene )
    --Runtime:addEventListener( "enterFrame", move )

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

        playTheme = audio.loadStream("Music/playTheme2.ogg")
        playMenuTheme = audio.play( playTheme, { channel=2, loops=-1, fadein=0 } )

        print("STARTING SHOW.did !")

        Physics.start()

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

        heroObject.collision = onLocalCollision
        heroObject:addEventListener( "collision")

        Runtime:addEventListener("enterFrame", rollObstacles)
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
        -- heroObject:pause()

        audio.stop( 2 )
    elseif phase == "did" then
        -- Called when the scene is now off screen
        -- if nextSceneButton then
        --  nextSceneButton:removeEventListener( "touch", nextSceneButton )
        -- end
        print("HIDING & DESTROYING THE GAME!")

        composer.removeScene("game")
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view
    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
    Physics.removeBody(grass1)
    Physics.removeBody(grass2)
    Physics.removeBody(grass3)
    Physics.removeBody(grass4)
    Physics.removeBody(grass5)
    Physics.removeBody(heroObject)
    Physics.removeBody(obstacle[1])
    Physics.removeBody(obstacle[2])
    Physics.removeBody(obstacle[3])

    Runtime:removeEventListener("enterFrame", rollObstacles)
    Physics.stop()
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
