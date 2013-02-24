module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )
	
	local DynResManager = require("DynResManager")
	local worldInfos = profile.getInfos()
	local afficheScore = score.getAfficheScore()
	
	local localGroup = display.newGroup()
	
	-- L'ecran change en fonction du monde choisi
	local bg = "fond_glace.png"
	local color = {158,233,235}
	local colorText = {87, 163, 166}
	local bouton = "bouton_niveau_glace.png"
	local boutonRetour = "bouton_retour_defaut.png"
	if(afficheScore.scoreGlace) then bg = "fond_glace.png"; color = {158,233,235}; colorText = {87, 163, 166}; bouton = "bouton_niveau_glace.png"; boutonRetour = "bouton_retour_glace.png";
	elseif(afficheScore.scoreForet) then bg = "fond_foret.png"; color = {200,127,23}; colorText = {192,125,59}; bouton = "bouton_niveau_desert_foret.png"; boutonRetour = "bouton_retour_foret.png";
	elseif(afficheScore.scoreIle) then bg = "fond_ile.png"; color = {84,186,255}; colorText = {115,205,217}; bouton = "bouton_niveau_glace.png"; boutonRetour = "bouton_retour_ile.png";
	elseif(afficheScore.scoreDesert) then bg = "fond_desert.png"; color = {241,148,86}; colorText = {192,125,59}; bouton = "bouton_niveau_desert_foret.png"; boutonRetour = "bouton_retour_desert.png";
	else end
		
	-- Create a background colour just to make the screen look a little nicer
	local backcolor = DynResManager.createCenterRectangleFitted()
	backcolor:setFillColor(color[1],color[2],color[3])
	localGroup:insert(backcolor)

	--Background
	local back = display.newImage(bg)
   back.isVisible = true
   back.x = 	display.contentWidth/2 
   back.y =  display.contentHeight/2 
   localGroup:insert(back)
   
   --Textes
   local text = display.newText("SCORES", 0, 0, "Arial", 50)
   text:setTextColor(0, 56, 112)
   text.x = display.contentWidth*0.5
   text.y = display.contentHeight*0.075 + text.height*0.5
   
   --return
	local reBtn = display.newImage(boutonRetour)
   reBtn.isVisible = true
   reBtn:setReferencePoint(display.TopLeftReferencePoint)
   reBtn.x = 15
   reBtn.y = display.contentHeight - reBtn.height - 15
   localGroup:insert(reBtn)

   --case1Btn
	local case1Btn = display.newImage(bouton)
   case1Btn.isVisible = true
   case1Btn.x = display.contentWidth/2 -case1Btn.width*1.5
   case1Btn.y =  display.contentHeight/1.75 -case1Btn.height/1.5
   localGroup:insert(case1Btn)
    local case1Text = display.newText("1", 0, 0, native.systemFont, 32)
	case1Text:setTextColor(colorText[1], colorText[2], colorText[3])
	case1Text.x = case1Btn.x
	case1Text.y = case1Btn.y
   
   --case2Btn
	local case2Btn = display.newImage(bouton)
   case2Btn.isVisible = true
   case2Btn.x = display.contentWidth/2 
   case2Btn.y =  display.contentHeight/1.75 -case2Btn.height/1.5
   localGroup:insert(case2Btn)
   local case2Text = display.newText("2", 0, 0, native.systemFont, 32)
	case2Text:setTextColor(colorText[1], colorText[2], colorText[3])
	case2Text.x = case2Btn.x
	case2Text.y = case2Btn.y
   
   --case3Btn
	local case3Btn = display.newImage(bouton)
   case3Btn.isVisible = true
   case3Btn.x = display.contentWidth/2 +case3Btn.width*1.5
   case3Btn.y =  display.contentHeight/1.75 -case3Btn.height/1.5
   localGroup:insert(case3Btn)
   local case3Text = display.newText("3", 0, 0, native.systemFont, 32)
	case3Text:setTextColor(colorText[1], colorText[2], colorText[3])
	case3Text.x = case3Btn.x
	case3Text.y = case3Btn.y
   
   --case4Btn
	local case4Btn = display.newImage(bouton)
   case4Btn.isVisible = true
   case4Btn.x = display.contentWidth/2 -case4Btn.width*1.5
   case4Btn.y =  display.contentHeight/1.75 +case4Btn.height/1.5
   localGroup:insert(case4Btn)
   local case4Text = display.newText("4", 0, 0, native.systemFont, 32)
	case4Text:setTextColor(colorText[1], colorText[2], colorText[3])
	case4Text.x = case4Btn.x
	case4Text.y = case4Btn.y
   
   --case5Btn
	local case5Btn = display.newImage(bouton)
   case5Btn.isVisible = true
   case5Btn.x = display.contentWidth/2
   case5Btn.y =  display.contentHeight/1.75 +case5Btn.height/1.5
   localGroup:insert(case5Btn)
   local case5Text = display.newText("5", 0, 0, native.systemFont, 32)
	case5Text:setTextColor(colorText[1], colorText[2], colorText[3])
	case5Text.x = case5Btn.x
	case5Text.y = case5Btn.y
   
   --case6Btn
	local case6Btn = display.newImage(bouton)
   case6Btn.isVisible = true
   case6Btn.x = display.contentWidth/2 +case6Btn.width*1.5
   case6Btn.y =  display.contentHeight/1.75 +case6Btn.height/1.5
   localGroup:insert(case6Btn)
   local case6Text = display.newText("6", 0, 0, native.systemFont, 32)
	case6Text:setTextColor(colorText[1], colorText[2], colorText[3])
	case6Text.x = case6Btn.x
	case6Text.y = case6Btn.y
   
   --Level 1 Clic
	   	local function pressCase1(event)
		if (event.phase == "ended" ) then
			score.setNivChoisi(1)
			director:changeScene ("scoreClassementScreen")
		end
	end
	case1Btn:addEventListener ("touch", pressCase1)
	
	--Level 2 Clic
	   	local function pressCase2(event)
		if (event.phase == "ended" )  then
			score.setNivChoisi(2)
			director:changeScene ("scoreClassementScreen")
		end
	end
	case2Btn:addEventListener ("touch", pressCase2)
	
	--Level 3 Clic
	   	local function pressCase3(event)
		if (event.phase == "ended" )  then
			score.setNivChoisi(3)
			director:changeScene ("scoreClassementScreen")
		end
	end
	case3Btn:addEventListener ("touch", pressCase3)
	
	--Level 4 Clic
	   	local function pressCase4(event)
		if (event.phase == "ended" )  then
			score.setNivChoisi(4)
			director:changeScene ("scoreClassementScreen")
		end
	end
	case4Btn:addEventListener ("touch", pressCase4)
	
	--Level 5 Clic
	   	local function pressCase5(event)
		if (event.phase == "ended")  then
			score.setNivChoisi(5)
			director:changeScene ("scoreClassementScreen")
		end
	end
	case5Btn:addEventListener ("touch", pressCase5)
	
	--Level 6 Clic
	   	local function pressCase6(event)
		if (event.phase == "ended")  then
			score.setNivChoisi(6)
			director:changeScene ("scoreClassementScreen")
		end
	end
	case6Btn:addEventListener ("touch", pressCase6)
   
	--Return Button
	   	local function pressReturn (event)
		if event.phase == "ended" then
			director:changeScene ("scoreMenuScreen")
		end
	end
	reBtn:addEventListener ("touch", pressReturn)

	-- MUST return a display.newGroup()
	return localGroup
end
