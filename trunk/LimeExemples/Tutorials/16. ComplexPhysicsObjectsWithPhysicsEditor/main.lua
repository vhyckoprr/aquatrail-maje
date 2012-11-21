function loadPhysicsJson(filename, baseDirectory)
	local _physicsData = lime.utils.readInTable(filename, baseDirectory)	
	
	_physicsData.get = function(self, name)
		return unpack(self[name])
	end
	
	return _physicsData
end

display.setStatusBar( display.HiddenStatusBar )

-- Create a background colour just to make the map look a little nicer
local back = display.newRect(0, 0, display.contentWidth, display.contentHeight)
back:setFillColor(165, 210, 255)

-- Load Lime
local lime = require("lime")

-- Load your map
local map = lime.loadMap("tutorial16.tmx")

-- Create the visual
local visual = lime.createVisual(map)

-- Build the physical
local physical = lime.buildPhysical(map)

-- Add physics objects created in PhysicsEditor
--local physicsData = (require "tutorial16").physicsData()
local physicsData = loadPhysicsJson("tutorial16.json", system.ResourceDirectory)
physics.addBody(map.world, "static", physicsData:get("tutorial16"))

-- See physics objects, for debugging purposes
physics.setDrawMode("hybrid")
