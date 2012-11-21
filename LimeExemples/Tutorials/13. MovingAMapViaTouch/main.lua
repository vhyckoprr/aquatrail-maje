io.output():setvbuf('no')
display.setStatusBar( display.HiddenStatusBar )

-- Load Lime
local lime = require("lime")

-- Disable screen culling
lime.disableScreenCulling()

-- Load the map
local map = lime.loadMap("tutorial13.tmx")

-- Create the visual
local visual = lime.createVisual(map)

-- Build the physical
local physical = lime.buildPhysical(map)

-- With the new screen culling you will need to update the map if it is bigger than a screen.
-- Alternatively if the map is stilll fairly small but across multiple screens it would
-- probably be worth disabling the culling before you load a map via lime.disableScreenCulling()
-- removing the need to update anything.
local onUpdate = function(event)
	map:update(event)
end

local onTap = function(event)
	local screenPosition = { x = event.x, y = event.y }
	local worldPosition = lime.utils.screenToWorldPosition(map, screenPosition)

--	map:setPosition(worldPosition.x, worldPosition.y)
--	map:fadeToPosition(worldPosition.x, worldPosition.y)
	map:slideToPosition(worldPosition.x, worldPosition.y)
	
end

Runtime:addEventListener("tap", onTap)

local onTouch = function(event)
	--local screenPosition = { x = event.x, y = event.y }
	--local worldPosition = lime.utils.screenToWorldPosition(map, screenPosition)
	
	map:drag(event)

--	map:setPosition(worldPosition.x, worldPosition.y)
end

Runtime:addEventListener("touch", onTouch)
Runtime:addEventListener("enterFrame", onUpdate)