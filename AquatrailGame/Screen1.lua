module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )
	
	local localGroup = display.newGroup()
		-- Background
	-- Create a background colour just to make the screen look a little nicer
	local backcolor = display.newRect(0, 0, display.contentWidth, display.contentHeight)
	backcolor:setFillColor(169, 214, 255)
	localGroup:insert(backcolor)		--Background	local back = display.newImage("fondAccueil.png")
   back.isVisible = true   back.x = 	display.contentWidth/2 
   back.y =  display.contentHeight/2 
   localGroup:insert(back)      --logo	local logo = display.newImage("logo_aquatrail.png")
   logo.isVisible = true   logo.x =  display.contentWidth/2 + logo.width / 4
   logo.y =  display.contentHeight/2 - logo.height /1.5
   localGroup:insert(back)
	
	--PlayButton
  	local playBtn = display.newImage("bouton_jouer.png")
   	playBtn.x = 	display.contentWidth/2 
   	playBtn.y =  display.contentHeight/2 
   	playBtn.isVisible = true
   	localGroup:insert(playBtn)   	   	--OptionsButton
  	local OptBtn = display.newImage("bouton_options.png")
   	OptBtn.x = 	display.contentWidth/2 
   	OptBtn.y =  display.contentHeight-display.contentHeight/4 
   	OptBtn.isVisible = true
   	localGroup:insert(OptBtn)   	   	--RecompensesButton
  	local RecBtn = display.newImage("bouton_recompenses.png")
   	RecBtn.x = 	display.contentWidth/3
   	RecBtn.y =  display.contentHeight-display.contentHeight/4-display.contentHeight/8
   	RecBtn.isVisible = true
   	localGroup:insert(RecBtn)   	   	--ScoreButton
  	local ScoreBtn = display.newImage("bouton_scores.png")
   	ScoreBtn.x = 	display.contentWidth-display.contentWidth/3
   	ScoreBtn.y =    display.contentHeight-display.contentHeight/4-display.contentHeight/8
   	ScoreBtn.isVisible = true
   	localGroup:insert(ScoreBtn)   	   	--CreditButton
  	local CreditBtn = display.newImage("bouton_credits.png")
   	CreditBtn.x = display.contentWidth - CreditBtn.width*2
  	 CreditBtn.y = display.contentHeight - CreditBtn.height
   	CreditBtn.isVisible = true
   	localGroup:insert(CreditBtn)
   
	--Exit Button
	local exitBtn = display.newImage("Exit_Button.png")
  	exitBtn.x = display.contentWidth/2 
  	exitBtn.y = display.contentHeight - exitBtn.height
   	exitBtn.isVisible = true
  	localGroup:insert(exitBtn)
	
	--PLAY function
	local function pressPlay (event)
		if event.phase == "ended" then
			director:changeScene ("Screen2")
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
