module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )
	
	local localGroup = display.newGroup()
	display.setStatusBar( display.HiddenStatusBar )

	system.activate( "multitouch" )
	local DynResManager = require("DynResManager")	 local GameLogic = require("GameLogic")
	
	--Background
	local back = display.newImage("background_ice.png")
   back.isVisible = true
   back.x = 	display.contentWidth/2 
   back.y =  display.contentHeight/2 
   --fit
   back.width=DynResManager.getScreenWidthPhysPix()
   back.height=DynResManager.getScreenHeightPhysPix()
   --localGroup:insert(back)
   
   local scoreText  = display.newText( "score: ", 0, 0, "Helvetica", 30 )
	scoreText.x = display.contentWidth/2
	scoreText.y =  scoreText.height / 2
	
	-- BACKBUTTON---------------------------------------------
		
	local backbutton = display.newImage ("backbutton.png")
	backbutton.x = backbutton.width / 2
	backbutton.y = backbutton.height / 2
	local function pressBack (event)
		if event.phase == "ended" then
				audio.stop()
				GameLogic.stopEvents()
				director:changeScene ("IceWorld")
		end
	end
	backbutton:addEventListener ("touch", pressBack)  
   local visual = GameLogic.createMap("Niveau_2_1.tmx", scoreText)

	

--------------------------------------------------------------
--Add the Director Class insert statements here
	localGroup:insert(back)
	localGroup:insert(visual)
	localGroup:insert(scoreText)
	localGroup:insert(backbutton)


	-- MUST return a display.newGroup()
	return localGroup
end

