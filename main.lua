------------------------------------- Data -----------------------------------------

pad = {
  x = 0,
  y = 0,
  width = 20,
  height = 80
}

pad2 = {
  x = 780,
  y = 0,
  width = 20,
  height = 80
}

ball = {
  x = 400,
  y = 300,
  width = 20,
  height = 20,
  speed_x = 2,
  speed_y = -2
}

scorePlayer1 = 0
scorePlayer2 = 0
scorePlayer1Reset = 0
scorePlayer2Reset = 0

trailList = {}

screenHeight = love.graphics.getHeight()
screenWidth = love.graphics.getWidth()

-------------------------------------- Function --------------------------------------

function centerBall()
  ball.x = love.graphics.getWidth() / 2
  ball.x = ball.x - ball.width / 2

  ball.y = love.graphics.getHeight() / 2
  ball.y = ball.y - ball.height / 2

  ball.speed_x = 2
  ball.speed_y = 2
end

function startNewGame()
  centerBall()
  centerPad()
  scorePlayer1 = scorePlayer1Reset
  scorePlayer2 = scorePlayer2Reset
end

function centerPad()
  pad.y = screenHeight / 2 - pad.height / 2
  pad2.y = screenHeight / 2 - pad2.height / 2
end

---------------------------------------- Load ----------------------------------------

function love.load()
  centerBall()
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
  for n = #trailList, 1, -1 do
    local t = trailList[n]
    t.life = t.life - dt
    if t.life <= 0 then
      table.remove(trailList, n)
    end
  end

  local trail = {
    x = ball.x,
    y = ball.y,
    life = 0.5
  }

  table.insert(trailList, trail)

  if ball.x < 0 then
    ball.speed_x = ball.speed_x * -1
  end
  if ball.y < 0 then
    ball.speed_y = ball.speed_y * -1
  end
  if ball.x > screenWidth - ball.width then
    ball.speed_x = ball.speed_x * -1
  end
  if ball.y > screenHeight - ball.height then
    ball.speed_y = ball.speed_y * -1
  end

  -- Player 1 collision
  if ball.x <= pad.x + pad.width then
    if ball.y + ball.height > pad.y and ball.y < pad.y + pad.height then
      ball.speed_x = ball.speed_x * -1
      ball.x = pad.x + pad.width
    end
  end
  -- Player 2 collision
  if ball.x + ball.width >= pad2.x then
    if ball.y + ball.height > pad2.y and ball.y < pad2.y + pad2.height then
      ball.speed_x = ball.speed_x * -1
      ball.x = pad2.x - pad2.width
    end
  end

  -- Player 1 Lost
  if ball.x < 0 then
    centerBall()
    centerPad()
    scorePlayer2 = scorePlayer2 + 1
  end
  -- Player 2 Lost
  if ball.x + ball.width > screenWidth then
    centerBall()
    centerPad()
    scorePlayer1 = scorePlayer1 + 1
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
  -- Trail
  for n = 1, #trailList do
    local t = trailList[n]
    love.graphics.setColor(1, 1, 1, t.life / 2)
    love.graphics.rectangle("fill", t.x, t.y, ball.width, ball.height)
  end
  -- Ball
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
  -- Central Line
  love.graphics.rectangle("fill", screenWidth / 2 - 10, 0, 10, 600)
  -- Score
  local score = scorePlayer1 .. " - " .. scorePlayer2
  love.graphics.print(score, 400, 0)
end
