display.setStatusBar( display.HiddenStatusBar )

system.activate( "multitouch" )

local STATE_IDLE = "Idle"
local STATE_WALKING = "Walking"
local STATE_JUMPING = "Jumping"
local DIRECTION_LEFT = -1
local DIRECTION_RIGHT = 1

local ui = require("ui")
require("physics")

physics.start()

-- Create a background colour just to make the map look a little nicer
local back = display.newRect(0, 0, display.contentWidth, display.contentHeight)
back:setFillColor(165, 210, 255)

-- Load Lime
local lime = require("lime")-- Disable culling
lime.disableScreenCulling()

-- Load your map
local map = lime.loadMap("tutorial20.tmx")

local onPlayerProperty = function(property, type, object)
	player = object.sprite
end

map:setFocus( player )
map:addPropertyListener("IsPlayer", onPlayerProperty)

-- Create the visual
local visual = lime.createVisual(map)

-- Build the physical
local physical = lime.buildPhysical(map)

-- HUD Event Listeners
local onButtonLeftEvent = function(event)

	if event.phase == "press" then
		if (player.direction ==DIRECTION_RIGHT)then
			player.direction = DIRECTION_LEFT
			player.xScale = player.direction
			-- on change de direction donc vx vy = 0
			local vx, vy = player:getLinearVelocity()
			player:setLinearVelocity(0, vy)
		end
		player.state = STATE_WALKING	
	else
		player.state = STATE_IDLE
	end

	player:prepare("anim" .. player.state)
	
	player:play()
end

local onButtonRightEvent = function(event)

	if event.phase == "press" then
		if (player.direction ==DIRECTION_LEFT)then
			player.direction = DIRECTION_RIGHT
			player.xScale = player.direction
			-- on change de direction donc vx vy = 0
			local vx, vy = player:getLinearVelocity()
			player:setLinearVelocity(0, vy)
		end
		player.state = STATE_WALKING	
	else
		player.state = STATE_IDLE
	end

	player:prepare("anim" .. player.state)
	
	player:play()
end

local onButtonAPress = function(event)
	if player.canJump then
		player:applyLinearImpulse(0, -7.5, player.x, player.y)
		
		player.state = STATE_JUMPING
		
		player:prepare("anim" .. player.state)

		player:play()
	end
end

local onButtonBPress = function(event)

end

-- Create the HUD
local buttonLeft = ui.newButton{
        default = "buttonLeft.png",
        over = "buttonLeft_over.png",
        onEvent = onButtonLeftEvent
}

buttonLeft.x = buttonLeft.width / 2 + 10
buttonLeft.y = display.contentHeight - buttonLeft.height / 2 - 10	

local buttonRight = ui.newButton{
        default = "buttonRight.png",
        over = "buttonRight_over.png",
        onEvent = onButtonRightEvent
}

buttonRight.x = buttonLeft.x + buttonRight.width
buttonRight.y = buttonLeft.y

local buttonA = ui.newButton{
        default = "buttonA.png",
        over = "buttonA_over.png",
        onPress = onButtonAPress
}

buttonA.x = display.contentWidth - buttonA.width / 2 - 10
buttonA.y = display.contentHeight - buttonA.height / 2 - 10


local function onCollision(self, event )

 	if ( event.phase == "began" ) then
		if event.other.IsGround then
			player.canJump = true
			if player.state == STATE_JUMPING then
				player.state = STATE_IDLE
			
				player:prepare("anim" .. player.state)
				player:play()
			end
		elseif event.other.IsObstacle then
			player.canJump = true		elseif event.other.IsPickup then
			
			local item = event.other
			
			local onTransitionEnd = function(transitionEvent)
				if transitionEvent["removeSelf"] then
					transitionEvent:removeSelf()
				end
			end
					
			-- Fade out the item
			transition.to(item, {time = 500, alpha = 0, onComplete=onTransitionEnd})
			
			local text = nil
			
			if item.pickupType == "score" then
				
				text = display.newText( item.scoreValue .. " Points!", 0, 0, "Helvetica", 50 )
				
			elseif item.pickupType == "health" then
				
				text = display.newText( item.healthValue .. " Extra Health!", 0, 0, "Helvetica", 50 )
				
			end
			
			if text then
				text:setTextColor(0, 0, 0, 255)
				text.x = display.contentCenterX
				text.y = text.height / 2
				
				transition.to(text, {time = 1000, alpha = 0, onComplete=onTransitionEnd})
			end
		end
	elseif ( event.phase == "ended" ) then
		if event.other.IsGround then
			player.canJump = false
 		elseif event.other.IsObstacle then 			local vx, vy = player:getLinearVelocity()
			 player:setLinearVelocity(0 , vy)		end 	end
end

player.collision = onCollision
player:addEventListener( "collision", player )

local onUpdate = function(event)
		local vx, vy = player:getLinearVelocity()	--check si il y a eu collision (direction positive vitesse negative)	if ((player.direction == 1 and vx <0)or(player.direction == -1 and vx >0)) then		player:setLinearVelocity(0 , vy)	else
		if player.state == STATE_WALKING then
			if (vx == 0)then
				player:applyForce( player.direction*10, 0, player.x, player.y )
			elseif (vx<200  and vx>-200) then
				player:setLinearVelocity(vx * 1.2, vy)
			end
			
		elseif player.state == STATE_IDLE then			if (vx<25  and vx>-25) then
					player:setLinearVelocity(0 , vy)			else				player:setLinearVelocity(vx *0.9 , vy)			end
		end	end
	-- Update the map. Needed for using map:setFocus()
	map:setFocus( player )	
	map:update( event )
end

Runtime:addEventListener("enterFrame", onUpdate)

player.state = STATE_IDLE
player.direction = DIRECTION_RIGHT
player:prepare("anim" .. player.state)
player:play()