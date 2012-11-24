display.setStatusBar( display.HiddenStatusBar )system.activate( "multitouch" )

local STATE_IDLE = "Idle"
local STATE_WALKING = "Walking"
local STATE_JUMPING = "Jumping"
local DIRECTION_LEFT = -1
local DIRECTION_RIGHT = 1

require("physics")physics.start()
-- Load Lime
local lime = require("lime")

-- Load your map
local map = lime.loadMap("tutorial20.tmx")-- Create Player (IsPlayer Property)local onPlayerProperty = function(property, type, object)
	player = object.sprite
end

map:addPropertyListener("IsPlayer", onPlayerProperty)

-- Create the visual
local visual = lime.createVisual(map)-- Build the physical
local physical = lime.buildPhysical(map)
-- background
local back = display.newRect( map:getVisual(), 0, 0, map:getVisual().contentWidth, map:getVisual().contentHeight )
back:setFillColor(165, 210, 255)local onTouch = function( event )
	if(event.x > player.x) then		player.direction = DIRECTION_RIGHT
		player.xScale = player.direction
		player.state = STATE_WALKING	elseif ( event.x<player.x) then		player.direction = DIRECTION_LEFT
		player.xScale = player.direction
		player.state = STATE_WALKING	end			player:prepare("anim" .. player.state)
	player:play()
endRuntime:addEventListener( "touch", onTouch )-- scrolling--[[
local onTouch = function( event )
	-- Drag the map
	map:drag( event )
end

Runtime:addEventListener( "touch", onTouch )

local onComplete = function()
	print( "Move Complete" )
end

-- Create a circle
local circle = display.newCircle( 0, display.contentCenterY, 20 )

-- Paint it red
circle:setFillColor( 255, 0, 0 )

-- Add it to a tile layer. 
map:getTileLayer( "Platforms" ):addObject( circle )

-- Set the maps focus to the circle.
map:setFocus( circle )

local onTap = function( event )
	
	-- Convert the touch position to a world position
	local worldPosition = lime.utils.screenToWorldPosition( map, event )
	
	-- Jump to the new position instantly
	--map:setPosition( worldPosition.x, worldPosition.y )
	
	-- Move the map a set amount
	--map:move( 50, 0 )
	
	-- Slide to the new position at the default speed (time)
	--map:slideToPosition( worldPosition.x, worldPosition.y )
	
	-- Slide to the new position at a custom speed (time)
	--map:slideToPosition( worldPosition.x, worldPosition.y, 200 )
	
	-- Slide to the new position at a custom speed (time) with a completion handler
	--map:slideToPosition( worldPosition.x, worldPosition.y, 200, onComplete )

	-- Fade to the new position at the default speed (time)
	--map:fadeToPosition( worldPosition.x, worldPosition.y )
	
	-- Fade to the new position at a custom speed (time)
	--map:fadeToPosition( worldPosition.x, worldPosition.y, 200 )
	
	-- Fade to the new position at a custom speed (time) with a delay between the two fades
	--map:fadeToPosition( worldPosition.x, worldPosition.y, 200, 1000 )
	
	-- Fade to the new position at a custom speed (time) with a delay between the two fades and a completion handler
	--map:fadeToPosition( worldPosition.x, worldPosition.y, 200, 1000, onComplete )

	-- Slide the circle to the new position
	lime.utils.slideObjectToPosition( circle, circle, worldPosition.x, worldPosition.y, 1000 )
	
	
end

Runtime:addEventListener( "tap", onTap )

local onUpdate = function( event )
	-- Update the map. Needed for using map:setFocus()
	map:update( event )
end]]local function onCollision(self, event )

 	if ( event.phase == "began" ) then
		if event.other.IsGround then
			player.canJump = true
			
			if player.state == STATE_JUMPING then
				player.state = STATE_IDLE
			
				player:prepare("anim" .. player.state)
				player:play()
			end
		end
	elseif ( event.phase == "ended" ) then
		if event.other.IsGround then
			player.canJump = false
		end
	end
endplayer.collision = onCollision
player:addEventListener( "collision", player )local onUpdate = function(event)
	if player.state == STATE_WALKING then
		
		player:applyForce(player.direction * 10, 0, player.x, player.y)	
		
	elseif player.state == STATE_IDLE then
		
		local vx, vy = player:getLinearVelocity()
		
		if vx ~= 0 then
			player:setLinearVelocity(vx * 0.9, vy)
		end
	end
end

Runtime:addEventListener("enterFrame", onUpdate)

player.state = STATE_IDLE
player:prepare("anim" .. player.state)
player:play()
