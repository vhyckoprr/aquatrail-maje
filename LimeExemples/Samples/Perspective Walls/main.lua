display.setStatusBar( display.HiddenStatusBar )

-- Load Lime
local lime = require("lime")

lime.disableScreenCulling()

-- Load your map
local map = lime.loadMap("perspective_walls.tmx")

-- Create the visual
local visual = lime.createVisual(map)

local onTouch = function(event)
	map:drag(event)
end

Runtime:addEventListener("touch", onTouch)

map:showDebugImages()