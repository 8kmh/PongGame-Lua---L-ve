------------------------------------- Data -----------------------------------------

pad = {}
pad.x = 0
pad.y = 0
pad.largeur = 20
pad.hauteur = 80

pad2 = {}
pad2.x = 780
pad2.y = 0
pad2.largeur = 20
pad2.hauteur = 80

balle = {}
balle.x = 400
balle.y = 300
balle.largeur = 20
balle.hauteur = 20
balle.vitesse_x = 2
balle.vitesse_y = -2

screenHeight = love.graphics.getHeight()
screenWidth = love.graphics.getWidth()

-------------------------------------- Function --------------------------------------

function centreBalle()
  balle.x =  love.graphics.getWidth() / 2
  balle.x = balle.x - balle.largeur / 2
  
  balle.y = love.graphics.getHeight() / 2
  balle.y = balle.y - balle.hauteur / 2
  
  balle.vitesse_x = 2
  balle.vitesse_y = 2
end

function startNewGame()
  centreBalle()
  
end

---------------------------------------- Load ----------------------------------------

function love.load()
  centreBalle()
end

function love.update(dt)
  -------------------------------------- Control --------------------------------------
  -- Control Joueur 1
  if love.keyboard.isDown("down") and pad.y < screenHeight - pad.hauteur then
    pad.y = pad.y + 2
  end
  if love.keyboard.isDown("up") and pad.y > 0 then 
    pad.y = pad.y - 2
  end
  -- Control Joueur 2
  if love.keyboard.isDown("s") and pad2.y < screenHeight - pad.hauteur then
    pad2.y = pad2.y + 2
  end
  if love.keyboard.isDown("z") and pad2.y > 0 then 
    pad2.y = pad2.y - 2
  end
  
  if love.keyboard.isDown("space") then
    startNewGame()
  end
  
  ------------------------------------- Ball -------------------------------------------
  
  if balle.x < 0 then
    balle.vitesse_x = balle.vitesse_x * -1
  end
  if balle.y < 0 then
  balle.vitesse_y = balle.vitesse_y * -1
  end
  if balle.x > love.graphics.getWidth() - balle.largeur then
    balle.vitesse_x = balle.vitesse_x * -1
  end
  if balle.y > love.graphics.getHeight() - balle.hauteur then
    balle.vitesse_y = balle.vitesse_y * -1
  end
  
  -- La balle à t-elle ateint la raquette ? 
  if balle.x <= pad.x + pad.largeur then
  -- Tester maintenant si la balle est sur la raquette ou pas
    if balle.y + balle.hauteur > pad.y and balle.y < pad.y + pad.hauteur then
        balle.vitesse_x = balle.vitesse_x * -1
        -- Positionne la balle au bord de la raquette
        balle.x = pad.x + pad.largeur
    end
  end
  ----------------------- TODO -----------------------------
  if balle.x < 0 or balle.x > screenHeight then
    -- Perdu !
    centreBalle()
  end
    
  
  
  balle.x = balle.x + balle.vitesse_x
  balle.y = balle.y + balle.vitesse_y
  
end

---------------------------------------- Draw ----------------------------------------

function love.draw()
  -- Player 1 
  love.graphics.rectangle("fill", pad.x, pad.y, pad.largeur, pad.hauteur)
  -- Player 2
  love.graphics.rectangle("fill", pad2.x, pad2.y, pad2.largeur, pad2.hauteur)
  -- Ball
  love.graphics.rectangle("fill", balle.x, balle.y, balle.largeur, balle.hauteur)
  -- Central Line
  love.graphics.rectangle("fill", screenWidth / 2 - 10, 0, 10, 600)
end