display.setStatusBar( display.HiddenStatusBar )

---------------------------------------------------------------
-- Import director class
---------------------------------------------------------------

director = require("director")
profile = require("Profile")
score = require("afficheScore")

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
	-- load profile
	profile.initProfile()
	-----------------------------------		--------------------------------------	-- global variable test	list = {}	----------------------------------------
	
	-----------------------------------
	-- Change scene without effects
	-----------------------------------
	
	director:changeScene("TitleScreen")
	
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