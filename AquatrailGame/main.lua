display.setStatusBar( display.HiddenStatusBar )

---------------------------------------------------------------
-- Import director class
---------------------------------------------------------------

director = require("director")
profile = require("Profile")
score = require("afficheScore")
chrono = require("chronometre")
chargement = require("chargement")


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
		Infos.pseudo = "Joueur"
		director:changeScene("TitleScreen")
	else
		--load profil creation
		director:changeScene("TitleScreen")
	end
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