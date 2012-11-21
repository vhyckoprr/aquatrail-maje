display.setStatusBar( display.HiddenStatusBar )

system.activate( "multitouch" )

local lime = require("lime")
local joystickClass = require( "joystick" )

local map = lime.loadMap("tutorial16.tmx")

local player = nil

local onPlayerCreate = function(property, type, object)
	player = object
end

map:addPropertyListener("IsPlayer", onPlayerCreate)

lime.createVisual(map)
lime.buildPhysical(map)

--map:setFocus(player.sprite)

local mapSpeed = 5
local playerSpeed = 2

local onUpdate = function(event)
	map:update(event)
end

Runtime:addEventListener("enterFrame", onUpdate)

local function moveMap( event )
	
	local xAmount, yAmount = event.joyX, event.joyY
	
	if type(xAmount) == "number" then
		xAmount = xAmount * mapSpeed
	end
	
	if type(yAmount) == "number" then
		yAmount = -yAmount * mapSpeed 
	end
	
	map:move(xAmount, yAmount)
end

-- Add A New Joystick
local mapJoystick = joystickClass.newJoystick
{
	outerImage = "joystickOuter.png",		
	outerAlpha = 0.8,						
	innerImage = "joystickInner.png",		
	innerAlpha = 0.8,						
	position_x = 20,						
	position_y = 220,						
	onMove = moveMap						
}

mapJoystick.xScale = 0.7
mapJoystick.yScale = 0.7

local function movePlayer( event )
	
	local xAmount, yAmount = event.joyX, event.joyY
	
	if type(xAmount) == "number" then
		xAmount = -xAmount * playerSpeed
		
	end
	
	if type(yAmount) == "number" then
		yAmount = yAmount * playerSpeed 
	end
	
	player:move(xAmount, yAmount)
end


-- Add A New Joystick
local playerJoystick = joystickClass.newJoystick
{
	outerImage = "joystickOuter.png",		
	outerAlpha = 0.8,						
	innerImage = "joystickInner.png",		
	innerAlpha = 0.8,						
	position_x = 375,						
	position_y = 220,						
	onMove = movePlayer						
}

playerJoystick.xScale = 0.7
playerJoystick.yScale = 0.7

local function movePlayerAndMap( event )
	
	local xAmount, yAmount = event.joyX, event.joyY
	
	if type(xAmount) == "number" then
		xAmount = -xAmount * playerSpeed
		map:setFocus(player.sprite)
	else
		map:setFocus(nil)
	end
	
	if type(yAmount) == "number" then
		yAmount = yAmount * playerSpeed 
	end

	player:move(xAmount, yAmount)
end


-- Add A New Joystick
local playerAndMapJoystick = joystickClass.newJoystick
{
	outerImage = "joystickOuter.png",		
	outerAlpha = 0.8,						
	innerImage = "joystickInner.png",		
	innerAlpha = 0.8,						
	position_x = 200,						
	position_y = 220,						
	onMove = movePlayerAndMap						
}

playerAndMapJoystick.xScale = 0.7
playerAndMapJoystick.yScale = 0.7


-- Position the map over the central tree
map:setPosition(900, 850)