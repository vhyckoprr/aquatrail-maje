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
local lime = require("lime")

-- Load your map
local map = lime.loadMap("tutorial11.tmx")

local onPlayerProperty = function(property, type, object)
	player = object.sprite
end

map:addPropertyListener("IsPlayer", onPlayerProperty)

-- Create the visual
local visual = lime.createVisual(map)

-- Build the physical
local physical = lime.buildPhysical(map)

-- HUD Event Listeners
local onButtonLeftEvent = function(event)

	if event.phase == "press" then
		player.direction = DIRECTION_LEFT
		player.xScale = player.direction
		player.state = STATE_WALKING	
	else
		player.state = STATE_IDLE
	end

	player:prepare("anim" .. player.state)
	
	player:play()
end

local onButtonRightEvent = function(event)

	if event.phase == "press" then
		player.direction = DIRECTION_RIGHT
		player.xScale = player.direction
		player.state = STATE_WALKING	
	else
		player.state = STATE_IDLE
	end

	player:prepare("anim" .. player.state)
	
	player:play()
end

local onButtonAPress = function(event)
	if player.canJump then
		player:applyLinearImpulse(0, -5, player.x, player.y)
		
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

local buttonB = ui.newButton{
        default = "buttonB.png",
        over = "buttonB_over.png",
        onPress = onButtonBPress
}

buttonB.x = buttonA.x - buttonB.width
buttonB.y = buttonA.y

local function onCollision(self, event )

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
end

player.collision = onCollision
player:addEventListener( "collision", player )

local onUpdate = function(event)
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