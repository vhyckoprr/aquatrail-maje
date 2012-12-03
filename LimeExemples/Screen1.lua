module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )
	
	local localGroup = display.newGroup()
		-- Background
	-- Create a background colour just to make the screen look a little nicer
	local back = display.newRect(0, 0, display.contentWidth, display.contentHeight)
	back:setFillColor(165, 210, 255)
	localGroup:insert(back)
	
	--PlayButton
  	local playBtn = display.newImage("Play_Button.png")
   	playBtn.x = 	playBtn.width / 2
   	playBtn.y =  display.contentHeight - playBtn.height / 2
   	playBtn.isVisible = true
   	localGroup:insert(playBtn)
   
	--Exit Button
	local exitBtn = display.newImage("Exit_Button.png")
  	exitBtn.x = display.contentWidth - exitBtn.width / 2
  	exitBtn.y = display.contentHeight - exitBtn.height / 2
   	exitBtn.isVisible = true
  	localGroup:insert(exitBtn)
  	
  	--Text Aquatrail
  	local aquaText  = display.newText( "Aquatrail DEMO 0.2", 0, 0, "Arial", 50 )
		aquaText.x = display.contentWidth/2
		aquaText.y =  display.contentHeight/2
		localGroup:insert(aquaText)
	
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
