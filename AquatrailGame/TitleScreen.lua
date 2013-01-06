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
   back.x = 	display.contentWidth/2 
   back.y =  display.contentHeight/2 
   localGroup:insert(back)
   
   --logo
	local logo = display.newImage("logo_aquatrail.png")
   logo.isVisible = true
   logo.x =  display.contentWidth/2 + logo.width /4
   logo.y =  display.contentHeight/2 - logo.height /2.5
   localGroup:insert(logo)
	
	--PlayButton
  	local playBtn = display.newImage("bouton_jouer.png")
   	playBtn.x =  display.contentWidth/2 
   	playBtn.y =  display.contentHeight-display.contentHeight/4-display.contentHeight/8
   	playBtn.isVisible = true
   	localGroup:insert(playBtn)
   	
   	--OptionsButton
  	local OptBtn = display.newImage("bouton_options.png")
   	OptBtn.x = 	display.contentWidth/2 
   	OptBtn.y =  display.contentHeight-display.contentHeight/4 +display.contentHeight/8
   	OptBtn.isVisible = true
   	localGroup:insert(OptBtn)
   	
   	--RecompensesButton
  	local RecBtn = display.newImage("bouton_recompenses.png")
   	RecBtn.x = 	display.contentWidth/3
   	RecBtn.y =  display.contentHeight-display.contentHeight/4 
   	RecBtn.isVisible = true
   	localGroup:insert(RecBtn)
   	
   	--ScoreButton
  	local ScoreBtn = display.newImage("bouton_scores.png")
   	ScoreBtn.x = 	display.contentWidth-display.contentWidth/3
   	ScoreBtn.y =    display.contentHeight-display.contentHeight/4 
   	ScoreBtn.isVisible = true
   	localGroup:insert(ScoreBtn)
   	
   	--CreditButton
  	local CreditBtn = display.newImage("bouton_credits.png")
   	CreditBtn.x = display.contentWidth - CreditBtn.width/1.5
  	 CreditBtn.y = display.contentHeight-display.contentHeight/4 +display.contentHeight/8
   	CreditBtn.isVisible = true
   	localGroup:insert(CreditBtn)
   
	--Exit Button
	local exitBtn = display.newImage("bouton_quitter.png")
  	exitBtn.x = exitBtn.width
  	 exitBtn.y = display.contentHeight-display.contentHeight/4 +display.contentHeight/8
   	exitBtn.isVisible = true
  	localGroup:insert(exitBtn)

	
	--PLAY function
	local function pressPlay (event)
		if event.phase == "ended" then
			director:changeScene ("WorldSelection")
		end
	end
	playBtn:addEventListener ("touch", pressPlay)
	
	--EXIT Button
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
