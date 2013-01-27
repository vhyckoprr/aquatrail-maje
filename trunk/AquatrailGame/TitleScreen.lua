module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )		local DynResManager = require("DynResManager")	
	local localGroup = display.newGroup()
		-- Background
	-- Create a background colour just to make the screen look a little nicer
	local backcolor = DynResManager.createCenterRectangleFitted()
	backcolor:setFillColor(169, 214, 255)
	localGroup:insert(backcolor)
	
	--Background
	local back = display.newImage("fond_accueil.png")
   back.isVisible = true
   back.x = 	display.contentWidth*0.5 
   back.y =  display.contentHeight*0.5 
   localGroup:insert(back)
   
   --logo
	local logo = display.newImage("logo_aquatrail.png")
	local scale = 0.8
   logo:scale(scale, scale)
   logo.isVisible = true
   logo.x =  display.contentWidth*0.5
   logo.y =  display.contentWidth*0.02 + (logo.height*0.5) *scale
   localGroup:insert(logo)
	
	--PlayButton
  	local playBtn = display.newImage("bouton_jouer.png")
   	playBtn.x =  display.contentWidth*0.5
   	playBtn.y =  display.contentHeight*0.55
   	playBtn.isVisible = true
   	localGroup:insert(playBtn)
   	
   	--OptionsButton
  	local optBtn = display.newImage("bouton_options.png")
   	optBtn.x = 	display.contentWidth*0.75
   	optBtn.y =  display.contentHeight*0.70
   	optBtn.isVisible = true
   	localGroup:insert(optBtn)
   	
   	--RecompensesButton
  	local recBtn = display.newImage("bouton_recompenses.png")
   	recBtn.x = 	display.contentWidth*0.25
   	recBtn.y =  display.contentHeight*0.70 
   	recBtn.isVisible = true
   	localGroup:insert(recBtn)
   	
   	--ScoreButton
  	local scoreBtn = display.newImage("bouton_scores.png")
   	scoreBtn.x = display.contentWidth*0.33
   	scoreBtn.y = display.contentHeight*0.85 
   	scoreBtn.isVisible = true
   	localGroup:insert(scoreBtn)
   	
   	--CreditButton
  	local creditBtn = display.newImage("bouton_credits.png")
   	creditBtn.x = display.contentWidth*0.66
  	creditBtn.y = display.contentHeight*0.85
   	creditBtn.isVisible = true
   	localGroup:insert(creditBtn)
   
	--Exit Button
	local exitBtn = display.newImage("bouton_quitter.png")
  	exitBtn.x = display.contentWidth*0.98 - exitBtn.width*0.5
  	exitBtn.y = display.contentHeight*0.02 + exitBtn.height
   	exitBtn.isVisible = true
  	localGroup:insert(exitBtn)

	
	--PLAY function
	local function pressPlay (event)
		if event.phase == "ended" then
			director:changeScene ("WorldSelection")
		end
	end
	playBtn:addEventListener ("touch", pressPlay)
	
	--Options function
	local function pressOptions (event)
		if event.phase == "ended" then
			director:changeScene ("OptionsScreen")
		end
	end
	optBtn:addEventListener ("touch", pressOptions)
	
	--EXIT function
	local exitScene = 0
	local function exitBtnt ( event )
		if event.phase == "ended" then
			if(exitScene == 0) then
			exitScene = 1
			os.exit()
			end
		end
	end
	exitBtn:addEventListener("touch",exitBtnt)

	-- MUST return a display.newGroup()
	return localGroup
end
