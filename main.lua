-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Engine

local math = require("math")

-- Data

local paddle_size = {}
paddle_size.x = 24
paddle_size.y = 128

local score = {}
score.player = 0
score.enemy = 0

local ball_speed = 4
local ball_velocity = {}
ball_velocity.x = ball_speed
ball_velocity.y = ball_speed

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

-- Functions

local function playerMove(event)
    if (event.phase == "moved") then
        player.y = event.y

        if (player.y < 80) then player.y = 80
        elseif (player.y > 240) then player.y = 240 end
    end
end

local function ballMove()
    ball.x = ball.x + ball_velocity.x
    ball.y = ball.y + ball_velocity.y
end

-- Main

Runtime:addEventListener("touch", playerMove)
Runtime:addEventListener("lateUpdate", ballMove)
