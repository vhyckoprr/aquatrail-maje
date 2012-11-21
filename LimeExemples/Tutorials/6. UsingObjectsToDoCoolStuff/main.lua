display.setStatusBar( display.HiddenStatusBar )

-- Create a background colour just to make the map look a little nicer
local back = display.newRect(0, 0, display.contentWidth, display.contentHeight)
back:setFillColor(165, 210, 255)

-- Load Lime
local lime = require("lime")

-- Load your map
local map = lime.loadMap("tutorial6.tmx")

-- Create our listener function
local onObject = function(object)
	-- Create an image using the properties of the object
	display.newImage(object.playerImage, object.x, object.y)
end

-- Add our listener to our map linking it with the object type
map:addObjectListener("PlayerSpawn", onObject)

-- Create the visual
local visual = lime.createVisual(map)