display.setStatusBar( display.HiddenStatusBar )

local lime = require("lime")
local director = require("director")
local fps = require("fps")

performance = fps.PerformanceOutput.new()
performance.group.x, performance.group.y = display.contentWidth / 2 - (performance.group.width / 5),  0;
performance.group.alpha = 0.7; -- So it doesn't get in the way of the rest of the scene
performance.group.isVisible = false

isSimulator = "simulator" == system.getInfo("environment")
	
-- Import director class
local director = require("director")

-- Create a main group
local mainGroup = display.newGroup()

-- Add the group from director class
mainGroup:insert(director.directorView)

-- Change scene without effects
director:changeScene("screen_Main")
