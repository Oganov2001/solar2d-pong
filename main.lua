-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Engine

local math = require("math")
local physics = require("physics")

-- Data

local paddle_size = {}
paddle_size.x = 24
paddle_size.y = 128

local score = {}
score.player = 0
score.enemy = 0

local ball_speed = 256
local ball_velocity = {}
ball_velocity.x = ball_speed
ball_velocity.y = 0

-- Setup

local backgroundLine = display.newLine( 240, 0, 240, 480 )
backgroundLine:setStrokeColor(0.30)

local playerScore = display.newText( score.player, 160, 48 )
playerScore.size = 64
local enemyScore = display.newText( score.enemy, 320, 48 )
enemyScore.size = 64

local player = display.newRect( 0, 160, paddle_size.x, paddle_size.y )
local enemy = display.newRect( 480, 160, paddle_size.x, paddle_size.y )
local ball = display.newCircle( 240, 160, 16 )

physics.start()
physics.setGravity( 0, 0 )

physics.addBody( player, "static" )
physics.addBody( enemy, "static" )
physics.addBody( ball, "dynamic", {bounce = 0.8})

-- Functions

local function playerMove(event)
    if (event.phase == "moved") then
        player.y = event.y

        if (player.y < 80) then player.y = 80
        elseif (player.y > 240) then player.y = 240 end
    end
end

local function onBallCollide(event)
    if (event.phase == "began") then
        ball_velocity.x = -ball_velocity.x
    end
end

local function ballMove()
    ball:setLinearVelocity( ball_velocity.x, ball_velocity.y )
end

-- Main

Runtime:addEventListener("touch", playerMove)
ball:addEventListener("collision", onBallCollide)
Runtime:addEventListener("lateUpdate", ballMove)
