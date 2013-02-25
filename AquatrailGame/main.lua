display.setStatusBar( display.HiddenStatusBar )

---------------------------------------------------------------
-- Import director class
---------------------------------------------------------------

director = require("director")
profile = require("Profile")
score = require("afficheScore")
chrono = require("chronometre")


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
	local Infos = profile.getInfos()
	if ( Infos.pseudo=="unnamed" ) then
		--load profil creation
		director:changeScene("PseudoScreen")
	else
		--load profil creation
		director:changeScene("TitleScreen")
	end
	
	--load profil creation
	--director:changeScene("PseudoScreen")
	
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