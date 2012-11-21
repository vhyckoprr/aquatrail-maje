display.setStatusBar( display.HiddenStatusBar )

require("physics")

physics.start()

-- Create a background colour just to make the map look a little nicer
local back = display.newRect(0, 0, display.contentWidth, display.contentHeight)
back:setFillColor(165, 210, 255)

-- Load Lime
local lime = require("lime")

-- Load your map
local map = lime.loadMap("tutorial9.tmx")

local onPlayerSpawnObject = function(object)
	local layer = map:getTileLayer("Player")
	
	player = display.newImage(layer.group, "guy.png")
	player.x = object.x
	player.y = object.y
	
	physics.addBody(player, { density = 1.0, friction = 0.3, bounce = 0.2 })
	player.isFixedRotation = true
end

map:addObjectListener("PlayerSpawn", onPlayerSpawnObject)

-- Create the visual
local visual = lime.createVisual(map)

-- Build the physical
local physical = lime.buildPhysical(map)
	
local onTouch = function(event)
	if player.canJump then
		player:applyLinearImpulse(0, -5, player.x, player.y)
	end
end

Runtime:addEventListener("touch", onTouch)


local function onCollision(self, event )

 	if ( event.phase == "began" ) then
		if event.other.IsGround then
			player.canJump = true
		end
	elseif ( event.phase == "ended" ) then
		if event.other.IsGround then
			player.canJump = false
		end
	end
end


player.collision = onCollision
player:addEventListener( "collision", player )
