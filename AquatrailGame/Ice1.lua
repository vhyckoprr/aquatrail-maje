module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )

	
	local localGroup = display.newGroup()
	display.setStatusBar( display.HiddenStatusBar )

	system.activate( "multitouch" )
	local DynResManager = require("DynResManager")
	 local GameLogic = require("GameLogic")
	 
	 -- L'OBJET LEVEL POSSEDE LA METHODE endLevel QUI PERMETRA A LA GAME LOGIC DE SORTIR DU JEU
	local LEVEL = { 
endLevel = function (self, score, time)

							profile.saveInfoLevel(1, 1,score, time)
							audio.stop()
							GameLogic.stopEvents()
							director:changeScene ("ScoreScreen")
                end
    }
	
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

	function endLevel ()
			
	end
	
	--STATECHANGE
	--local LIQSOL = "LiqSol"
	--local LIQGAZ = "LiqGaz"
	--local SOLGAZ = "SolGaz"
	STATECHANGE = "LiqSol"
	
	local visual = GameLogic.createMap("Niveau45.tmx", scoreText, LEVEL,STATECHANGE)

--------------------------------------------------------------
--Add the Director Class insert statements here
	localGroup:insert(back)
	localGroup:insert(visual)
	localGroup:insert(scoreText)
	localGroup:insert(backbutton)


	-- MUST return a display.newGroup()
	return localGroup
end

