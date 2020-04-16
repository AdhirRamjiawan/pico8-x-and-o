pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

local playerPosition = { x = 30, y =30, stateIndex = 1 }
local currentPlayer = "x"
local hasWon = false
local state = {
	{0,0,0},
	{0,0,0},
	{0,0,0}
}

function checkWin()
   
  -- row checks
  for y = 1,3 do
    if state[1][y] == 0 or state[2][y] == 0 or state[3][y] == 0 then
	  goto continue
	end
  
    if (state[1][y] == state[2][y]) and (state[2][y] == state[3][y]) then
	  hasWon = true
	  sfx(2)
	  return
	end
	
	::continue::
  end
  
  -- column checks
  for x = 1,3 do
    if state[x][1] == 0 or state[x][2] == 0 or state[x][3] == 0 then
	  goto continue
	end
  
    if (state[x][1] == state[x][2]) and (state[x][2] == state[x][3]) then
	  hasWon = true
	  sfx(2)
	  return
	end
	
	::continue::
  end

  -- diagonal checks
  
  if (state[1][1] ~= 0 and state[1][1] == state[2][2] and state[2][2] == state[3][3]) then
    hasWon = true
	sfx(2)
	return
  end  
  
  if (state[1][3] ~= 0 and state[1][3] == state[2][2] and state[2][2] == state[3][1]) then
    hasWon = true
	sfx(2)
	return
  end  
  
end

function displayState(s, x, y)
  local sym = ""
  
  if (s == 0) then
    sym = ""
  else
	sym = s
  end
  
  print(sym, x + 7, y + 7, 1)
end

function drawBoard()
  rect(25, 25, 115, 115, 1)
end

function drawPlayerPosition()
  print("x: " .. playerPosition.x / 30, 10, 120, 1)
  print("y: " .. playerPosition.y / 30, 40, 120, 1)
  print("cur: " .. currentPlayer, 100, 120, 1)

  rect(
	playerPosition.x, 
	playerPosition.y, 
	playerPosition.x + 20, 
	playerPosition.y + 20, 
	1)
end

function _init()
end

function _update()
  local movement = 30
  if btnp(0) then
	playerPosition.x -= movement
  elseif btnp(1) then
	playerPosition.x += movement
  elseif btnp(2) then
	playerPosition.y -= movement
  elseif btnp(3) then
	playerPosition.y += movement
  end
  
  
  if btnp(4) then
    if (currentPlayer == "x") then
	  currentPlayer = "o"
	  sfx(0)
	else
	  currentPlayer = "x"
	  sfx(1)
	end
	
	local sx = playerPosition.x / 30
    local sy = playerPosition.y / 30
	state[sx][sy] = currentPlayer
	checkWin()
  end
  
  
end

function _draw()
  cls()
  print("Let's play x and o", 10, 10)
  drawBoard()
  
  for x= 1, 3 do
    for y = 1,3 do
	  displayState(state[x][y], 30 * x, 30 * y);
	end
  end
  
  drawPlayerPosition()
  
  if hasWon then
    print("Win!!!", 50, 50, 6)
  end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000040500505006050090500c0500e0501205019050220502205022050220502205000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000210502105021050210501c0501805016050100500f0500b0500b050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200001b0501b0501b0501b0501b0501b0501b0501a0501a050190501705016050140501205011050100500e0500e0500e0500f0501105013050170501a0501e0502205025050280502c0502f0503005030050
