module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )
	
	local DynResManager = require("DynResManager")
	local worldInfos = profile.getInfos()
	local unlockLevel1 = worldInfos.world1.level1.unlocked
	local unlockLevel2 = worldInfos.world1.level2.unlocked
	local unlockLevel3 = worldInfos.world1.level3.unlocked
	local unlockLevel4 = worldInfos.world1.level4.unlocked
	local unlockLevel5 = worldInfos.world1.level5.unlocked
	local unlockLevel6 = worldInfos.world1.level6.unlocked
	
	local localGroup = display.newGroup()
		-- Background
	-- Create a background colour just to make the screen look a little nicer
	local backcolor = DynResManager.createCenterRectangleFitted()
	backcolor:setFillColor(158, 233, 235)
	localGroup:insert(backcolor)
	
	--Background
	local back = display.newImage("fond_glace.png")
   back.isVisible = true
   back.x = 	display.contentWidth/2 
   back.y =  display.contentHeight/2 
   localGroup:insert(back)      local textScore = display.newText("Score", 0, 0, native.systemFont, 64)
	textScore:setTextColor(0, 0, 0)
	textScore.isVisible = true	textScore.x = display.contentWidth/2 
	textScore.y = display.contentHeight/2 		--return
	local reBtn = display.newImage("bouton_retour_glace.png")
   reBtn.isVisible = true
   reBtn.x = reBtn.width
   reBtn.y = display.contentHeight-display.contentHeight/4 +display.contentHeight/8
   localGroup:insert(reBtn)
   
  --Return Button
	   	local function pressReturn (event)
		if event.phase == "ended" then
			director:changeScene ("IceWorld")
		end
	end
	reBtn:addEventListener ("touch", pressReturn)

	-- MUST return a display.newGroup()
	return localGroup
end
