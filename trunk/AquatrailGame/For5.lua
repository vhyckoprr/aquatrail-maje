module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )

	
	local localGroup = display.newGroup()
	local paused = false
	display.setStatusBar( display.HiddenStatusBar )

	--system.activate( "multitouch" )
	local DynResManager = require("DynResManager")
	local GameLogic = require("GameLogic")
	 
	 -- L'OBJET LEVEL POSSEDE LA METHODE endLevel QUI PERMETRA A LA GAME LOGIC DE SORTIR DU JEU
	local LEVEL = { 
endLevel = function (self, score, time)
		profile.saveInfoLevel(2, 5,score, chrono.getTotalTimeInSecond())
		chrono.Stop()
		audio.stop()
		GameLogic.stopEvents()
		director:changeScene ("ScoreScreen")
	end
    }
	
	--Background
	local back = display.newImage("background_foret.png")
   back.isVisible = true
   back.x = 	display.contentWidth/2 
   back.y =  display.contentHeight/2 
   --fit
   back.width=DynResManager.getScreenWidthPhysPix()
   back.height=DynResManager.getScreenHeightPhysPix()
   --localGroup:insert(back)
   
	local scoreText  = display.newText( "Score : ", 0, 0, "Fontastique", 20 )
	scoreText:setReferencePoint(display.BottomCenterReferencePoint)
	scoreText.x = display.contentWidth/2
	scoreText.y = display.contentHeight

	
	function endLevel ()
			
	end

	--STATECHANGE
	--local LIQSOL = "LiqSol"
	--local LIQGAZ = "LiqGaz"
	--local SOLGAZ = "SolGaz"
	local STATECHANGE = "LiqGaz"
	

    local visual = GameLogic.createMap("Niveau_F_5.tmx", scoreText, LEVEL,STATECHANGE)

	--CHRONOMETRE
	chrono.Start()
	chrono.setDisplay(true)
	
	-- BACKBUTTON--
	local backbutton = display.newImage ("Bouton-Reload-HUD.png")
	backbutton.x = backbutton.width / 2
	backbutton.y = backbutton.height / 2
	local function pressBack (event)
		if event.phase == "ended" then
				chrono.Stop()
				audio.stop()
				GameLogic.stopEvents()
				director:changeScene ("ForestWorld")
		end
	end
	backbutton:addEventListener ("touch", pressBack) 
	
	-- PauseBUTTON--
	local pauseBUTTON = display.newImage ("Bouton-Pause-HUD.png")
	pauseBUTTON.x = display.contentWidth - (pauseBUTTON.width / 2)
	pauseBUTTON.y = pauseBUTTON.height / 2
	local function PauseFonction (event)
		print("pause")
		if event.phase == "ended" then
			if paused == false then
				chrono.Pause()
				GameLogic.PauseGame()
			elseif paused == true then
				chrono.Pause()
				GameLogic.PauseGame()
			end
		end
	end
	pauseBUTTON:addEventListener ("touch", PauseFonction) 

--------------------------------------------------------------
--Add the Director Class insert statements here
	localGroup:insert(back)
	localGroup:insert(visual)
	localGroup:insert(scoreText)
	localGroup:insert(backbutton)
	localGroup:insert(pauseBUTTON)

	-- MUST return a display.newGroup()
	return localGroup
end

