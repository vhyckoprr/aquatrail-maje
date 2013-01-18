display.setStatusBar( display.HiddenStatusBar )

---------------------------------------------------------------
-- Import des library
---------------------------------------------------------------

director = require("director")
DynResManager = require("DynResManager")
ui = require("ui")
Gesture = require("lib_gesture")
lime = require("lime")
json = require("json")
require("physics")

--Nos includes
--
GameLogic = require("GameLogic")
loadsave = require("loadsave")
profile = require("Profile")


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
	
	mainGroup:insert(director.directorView)		-----------------------------------	-- load profile
	profile.initProfile()	-----------------------------------	
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