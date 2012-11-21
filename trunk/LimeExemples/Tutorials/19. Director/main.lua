display.setStatusBar( display.HiddenStatusBar )

---------------------------------------------------------------
-- Import director class
---------------------------------------------------------------

director = require("director")

---------------------------------------------------------------
-- Create a main group
---------------------------------------------------------------

local mainGroup = display.newGroup()

---------------------------------------------------------------
-- Main function
---------------------------------------------------------------

local function main()

	-----------------------------------
	-- Add the group from director class
	-----------------------------------
	
	mainGroup:insert(director.directorView)

	-----------------------------------
	-- Change scene without effects
	-----------------------------------
	
	director:changeScene("screen1")
	
	-----------------------------------
	-- Return
	-----------------------------------
	
	return true
end

---------------------------------------------------------------
-- Begin
---------------------------------------------------------------

main()

-- It's that easy! :-)