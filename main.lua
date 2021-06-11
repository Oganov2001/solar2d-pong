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

local ball_speed = 256
local ball_velocity = {}
ball_velocity.x = ball_speed
ball_velocity.y = 0

local score = {}
score.player = 0
score.enemy = 0


-- Setup

local backgroundLine = display.newLine( 240, 0, 240, 320 )
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
        -- Paddle bounce
        if (event.other == player or event.other == enemy) then
            -- Direction randomizer
            local direction = math.random(-1, 1)
            if (direction == 0) then dir = 1 end

            ball_velocity.x = -ball_velocity.x
            ball_velocity.y = ball_speed * direction
        end
    end
end

local function resetBall()
    ball.x = 240
    ball.y = 160
end

local function boundaryCheck()
      local boundaryCollided
      local ballGoneLeft
      local ballGoneRight

      if (ball.y <= 16 or ball.y >= 304) then
          boundaryCollided = true
      else
          boundaryCollided = false
      end

      if (ball.x < 0) then ballGoneLeft = true
      elseif (ball.x > 480) then ballGoneRight = true
      else
          ballGoneLeft = false
          ballGoneRight = false
      end

      if (boundaryCollided) then
          ball_velocity.y = -ball_velocity.y
      end

      if (ballGoneLeft) then
          resetBall()
          score.player = score.player + 1
          playerScore.text = score.player
      end

      if (ballGoneRight) then
          resetBall()
          score.enemy = score.enemy + 1
          enemyScore.text = score.enemy
      end
end

local function ballMove()
    ball:setLinearVelocity( ball_velocity.x, ball_velocity.y )
end

-- Main

Runtime:addEventListener("touch", playerMove)
ball:addEventListener("collision", onBallCollide)
Runtime:addEventListener("enterFrame", boundaryCheck)
Runtime:addEventListener("lateUpdate", ballMove)
