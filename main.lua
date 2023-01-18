------------------------------------- Data -----------------------------------------

pad = {}
pad.x = 0
pad.y = 0
pad.width = 20
pad.height = 80

pad2 = {}
pad2.x = 780
pad2.y = 0
pad2.width = 20
pad2.height = 80

ball = {}
ball.x = 400
ball.y = 300
ball.width = 20
ball.height = 20
ball.speed_x = 2
ball.speed_y = -2

scorePlayer1 = 0
scorePlayer2= 0
scorePlayer1Reset = 0
scorePlayer2Reset= 0

screenHeight = love.graphics.getHeight()
screenWidth = love.graphics.getWidth()

-------------------------------------- Function --------------------------------------

function centreBall()
  ball.x =  love.graphics.getWidth() / 2
  ball.x = ball.x - ball.width / 2
  
  ball.y = love.graphics.getHeight() / 2
  ball.y = ball.y - ball.height / 2
  
  ball.speed_x = 2
  ball.speed_y = 2
end

function startNewGame()
  centreBall()
  scorePlayer1 = scorePlayer1Reset
  scorePlayer2 = scorePlayer2Reset
end

function centerPad()
  pad.y = screenHeight / 2 - pad.height / 2
  pad2.y = screenHeight / 2 - pad2.height / 2
end  

---------------------------------------- Load ----------------------------------------

function love.load()
  centreBall()
  centerPad()
end

function love.update(dt)
  -------------------------------------- Control --------------------------------------
  -- Control Player 1
  if love.keyboard.isDown("s") and pad.y < screenHeight - pad.height then
    pad.y = pad.y + 2
  end
  if love.keyboard.isDown("z") and pad.y > 0 then 
    pad.y = pad.y - 2
  end
  -- Control Player 2
  if love.keyboard.isDown("down") and pad2.y < screenHeight - pad.height then
    pad2.y = pad2.y + 2
  end
  if love.keyboard.isDown("up") and pad2.y > 0 then 
    pad2.y = pad2.y - 2
  end
  
  if love.keyboard.isDown("space") then
    startNewGame()
  end
  
  ------------------------------------- Ball -------------------------------------------
  
  if ball.x < 0 then
    ball.speed_x = ball.speed_x * -1
  end
  if ball.y < 0 then
  ball.speed_y = ball.speed_y * -1
  end
  if ball.x > love.graphics.getWidth() - ball.width then
    ball.speed_x = ball.speed_x * -1
  end
  if ball.y > love.graphics.getHeight() - ball.height then
    ball.speed_y = ball.speed_y * -1
  end
  
  -- La balle à t-elle ateint la raquette ? 
  if ball.x <= pad.x + pad.width then
  -- Tester maintenant si la balle est sur la raquette ou pas
    if ball.y + ball.height > pad.y and ball.y < pad.y + pad.height then
        ball.speed_x = ball.speed_x * -1
        -- Positionne la balle au bord de la raquette
        ball.x = pad.x + pad.width
    end
  end
  
  if ball.x + ball.width >= pad2.x then
    
    if ball.y + ball.height > pad2.y and ball.y < pad2.y + pad2.height then
        ball.speed_x = ball.speed_x * -1
        
        ball.x = pad2.x - pad2.width
    end
  end
  
  
  ----------------------- TODO -----------------------------
  if ball.x < 0 or ball.x + ball.width > screenWidth then
    -- Lost !
    centreBall()
    centerPad()
  end
    
  
  
  ball.x = ball.x + ball.speed_x
  ball.y = ball.y + ball.speed_y
  
end

---------------------------------------- Draw ----------------------------------------

function love.draw()
  -- Player 1 
  love.graphics.rectangle("fill", pad.x, pad.y, pad.width, pad.height)
  -- Player 2
  love.graphics.rectangle("fill", pad2.x, pad2.y, pad2.width, pad2.height)
  -- Ball
  love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
  -- Central Line
  love.graphics.rectangle("fill", screenWidth / 2 - 10, 0, 10, 600)
end