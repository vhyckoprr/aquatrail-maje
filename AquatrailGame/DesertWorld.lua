module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )
	
	local DynResManager = require("DynResManager")
	local EcranTutoD = require("EcranTutoD")
	local worldInfos = profile.getInfos()
	local unlockLevel1 = worldInfos.world3.level1.unlocked
	local unlockLevel2 = worldInfos.world3.level2.unlocked
	local unlockLevel3 = worldInfos.world3.level3.unlocked
	local unlockLevel4 = worldInfos.world3.level4.unlocked
	local unlockLevel5 = worldInfos.world3.level5.unlocked
	local unlockLevel6 = worldInfos.world3.level6.unlocked
	
	--POUR LE MOMENT CES NIVEAUX SONT INEXISTANT DONC ON LES BLOQUE
	unlockLevel6 = false
	
	local localGroup = display.newGroup()
		-- Background
	-- Create a background colour just to make the screen look a little nicer
	local backcolor = DynResManager.createCenterRectangleFitted()
	backcolor:setFillColor(241, 148, 86)
	localGroup:insert(backcolor)
	
	--Background
	local back = display.newImage("background_desert.png")
   back.isVisible = true
   back.x = 	display.contentWidth/2 
   back.y =  display.contentHeight/2 
   localGroup:insert(back)
   
   --return
	local reBtn = display.newImage("bouton_retour_desert.png")
   reBtn.isVisible = true
   reBtn:setReferencePoint(display.TopLeftReferencePoint)
   reBtn.x = 15
   reBtn.y = display.contentHeight - reBtn.height - 15
   localGroup:insert(reBtn)

	--textWorlds
	local textWorlds = display.newImage("texte_desert.png")
   textWorlds.isVisible = true
   textWorlds.x = 	display.contentWidth/2 
   textWorlds.y =  display.contentHeight/7
   localGroup:insert(textWorlds)
   
   --case1Btn
	local case1Btn = display.newImage("bouton_niveau-desert_V2.0.png")
   case1Btn.isVisible = true
   case1Btn.x = display.contentWidth/2 -case1Btn.width*1.5
   case1Btn.y =  display.contentHeight/1.75 -case1Btn.height/1.5
   localGroup:insert(case1Btn)
    local case1Text = display.newText("1", 0, 0, "Fontastique", 32)
	case1Text:setTextColor(105, 26, 186)
	case1Text.isVisible = true
	case1Text.x = case1Btn.x
	case1Text.y = case1Btn.y
   
   --case2Btn
	local case2Btn = display.newImage("bouton_niveau-desert_V2.0.png")
   case2Btn.isVisible = true
   case2Btn.x = display.contentWidth/2 
   case2Btn.y =  display.contentHeight/1.75 -case2Btn.height/1.5
   localGroup:insert(case2Btn)
   local case2Text = display.newText("2", 0, 0, "Fontastique", 32)
	case2Text:setTextColor(105, 26, 186)
	case2Text.isVisible = true
	case2Text.x = case2Btn.x
	case2Text.y = case2Btn.y
   
   --case3Btn
	local case3Btn = display.newImage("bouton_niveau-desert_V2.0.png")
   case3Btn.isVisible = true
   case3Btn.x = display.contentWidth/2 +case3Btn.width*1.5
   case3Btn.y =  display.contentHeight/1.75 -case3Btn.height/1.5
   localGroup:insert(case3Btn)
   local case3Text = display.newText("3", 0, 0, "Fontastique", 32)
	case3Text:setTextColor(105, 26, 186)
	case3Text.isVisible = true
	case3Text.x = case3Btn.x
	case3Text.y = case3Btn.y
   
   --case4Btn
	local case4Btn = display.newImage("bouton_niveau-desert_V2.0.png")
   case4Btn.isVisible = true
   case4Btn.x = display.contentWidth/2 -case4Btn.width*1.5
   case4Btn.y =  display.contentHeight/1.75 +case4Btn.height/1.5
   localGroup:insert(case4Btn)
   local case4Text = display.newText("4", 0, 0, "Fontastique", 32)
	case4Text:setTextColor(105, 26, 186)
	case4Text.isVisible = true
	case4Text.x = case4Btn.x
	case4Text.y = case4Btn.y
   
   --case5Btn
	local case5Btn = display.newImage("bouton_niveau-desert_V2.0.png")
   case5Btn.isVisible = true
   case5Btn.x = display.contentWidth/2
   case5Btn.y =  display.contentHeight/1.75 +case5Btn.height/1.5
   localGroup:insert(case5Btn)
   local case5Text = display.newText("5", 0, 0, "Fontastique", 32)
	case5Text:setTextColor(105, 26, 186)
	case5Text.isVisible = true
	case5Text.x = case5Btn.x
	case5Text.y = case5Btn.y
   
   --case6Btn
	local case6Btn = display.newImage("bouton_niveau-desert_V2.0.png")
   case6Btn.isVisible = true
   case6Btn.x = display.contentWidth/2 +case6Btn.width*1.5
   case6Btn.y =  display.contentHeight/1.75 +case6Btn.height/1.5
   localGroup:insert(case6Btn)
   local case6Text = display.newText("6", 0, 0, "Fontastique", 32)
	case6Text:setTextColor(105, 26, 186)
	case6Text.isVisible = true
	case6Text.x = case6Btn.x
	case6Text.y = case6Btn.y
	
	--cadenas
   local case1Cad = display.newImage("cadenas_niveau_bloque.png")
   case1Cad.isVisible = false
   case1Cad.x = case1Btn.x
   case1Cad.y =  case1Btn.y
   localGroup:insert(case1Cad)
   --
   local case2Cad = display.newImage("cadenas_niveau_bloque.png")
   case2Cad.isVisible = false
   case2Cad.x = case2Btn.x
   case2Cad.y =  case2Btn.y
   localGroup:insert(case2Cad)
   --
   local case3Cad = display.newImage("cadenas_niveau_bloque.png")
   case3Cad.isVisible = false
   case3Cad.x = case3Btn.x
   case3Cad.y =  case3Btn.y
   localGroup:insert(case3Cad)
   --
   local case4Cad = display.newImage("cadenas_niveau_bloque.png")
   case4Cad.isVisible = false
   case4Cad.x = case4Btn.x
   case4Cad.y =  case4Btn.y
   localGroup:insert(case4Cad)
   --
   local case5Cad = display.newImage("cadenas_niveau_bloque.png")
   case5Cad.isVisible = false
   case5Cad.x = case5Btn.x
   case5Cad.y =  case5Btn.y
   localGroup:insert(case5Cad)
   --
   local case6Cad = display.newImage("cadenas_niveau_bloque.png")
   case6Cad.isVisible = false
   case6Cad.x = case6Btn.x
   case6Cad.y =  case6Btn.y
   localGroup:insert(case6Cad)
   
   chargement.preLoadAnim()
   
   --Level 1 Clic
	local function pressCase1(event)
		if (event.phase == "ended" ) then
			EcranTutoD.level=1
			director:changeScene ("EcranTutoD")
		end
	end
	case1Btn:addEventListener ("touch", pressCase1)
	
	--Level 2 Clic
	local function pressCase2(event)
		if (event.phase == "ended" )  then
			EcranTutoD.level=2
			director:changeScene ("Des2")
		end
	end
	case2Btn:addEventListener ("touch", pressCase2)
	
	--Level 3 Clic
	local function pressCase3(event)
		if (event.phase == "ended" )  then
			EcranTutoD.level=3
			director:changeScene ("Des3")
		end
	end
	case3Btn:addEventListener ("touch", pressCase3)
	
	--Level 4 Clic
	local function pressCase4(event)
		if (event.phase == "ended" )  then
			EcranTutoD.level=4
			director:changeScene ("Des4")
		end
	end
	case4Btn:addEventListener ("touch", pressCase4)
	
	--Level 5 Clic
	local function pressCase5(event)
		if (event.phase == "ended")  then
			EcranTutoD.level=5
			director:changeScene ("Des5")
		end
	end
	case5Btn:addEventListener ("touch", pressCase5)
	
	--Level 6 Clic
	local function pressCase6(event)
		if (event.phase == "ended" and unlockLevel6 )  then
			EcranTutoD.level=6
			director:changeScene ("Des6")
		end
	end
	case6Btn:addEventListener ("touch", pressCase6)
   
	--Return Button
	   	local function pressReturn (event)
		if event.phase == "ended" then
			director:changeScene ("WorldSelection")
		end
	end
	reBtn:addEventListener ("touch", pressReturn)

	-- MUST return a display.newGroup()
	return localGroup
end
