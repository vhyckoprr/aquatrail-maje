module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )
	
	local DynResManager = require("DynResManager")
	
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
   localGroup:insert(back)
   
   --return
	local reBtn = display.newImage("bouton_retour_glace.png")
   reBtn.isVisible = true
   reBtn.x = reBtn.width
   reBtn.y = display.contentHeight-display.contentHeight/4 +display.contentHeight/8
   localGroup:insert(reBtn)


	--textWorlds
	local textWorlds = display.newImage("texte_glace.png")
   textWorlds.isVisible = true
   textWorlds.x = 	display.contentWidth/2 
   textWorlds.y =  display.contentHeight/7
   localGroup:insert(textWorlds)
   
   --case1Btn
	local case1Btn = display.newImage("bouton_niveau_glace.png")
   case1Btn.isVisible = true
   case1Btn.x = display.contentWidth/2 -case1Btn.width*1.5
   case1Btn.y =  display.contentHeight/1.75 -case1Btn.height/1.5
   localGroup:insert(case1Btn)
    local case1Text = display.newText("1", 0, 0, native.systemFont, 32)
	case1Text:setTextColor(87, 163, 166)
	case1Text.isVisible = true
	case1Text.x = case1Btn.x
	case1Text.y = case1Btn.y
   
   --case2Btn
	local case2Btn = display.newImage("bouton_niveau_glace.png")
   case2Btn.isVisible = true
   case2Btn.x = display.contentWidth/2 
   case2Btn.y =  display.contentHeight/1.75 -case2Btn.height/1.5
   localGroup:insert(case2Btn)
   local case2Text = display.newText("2", 0, 0, native.systemFont, 32)
	case2Text:setTextColor(87, 163, 166)
	case2Text.isVisible = true
	case2Text.x = case2Btn.x
	case2Text.y = case2Btn.y
   
   --case3Btn
	local case3Btn = display.newImage("bouton_niveau_glace.png")
   case3Btn.isVisible = true
   case3Btn.x = display.contentWidth/2 +case3Btn.width*1.5
   case3Btn.y =  display.contentHeight/1.75 -case3Btn.height/1.5
   localGroup:insert(case3Btn)
   local case3Text = display.newText("3", 0, 0, native.systemFont, 32)
	case3Text:setTextColor(87, 163, 166)
	case3Text.isVisible = false
	case3Text.x = case3Btn.x
	case3Text.y = case3Btn.y
   
   --case4Btn
	local case4Btn = display.newImage("bouton_niveau_glace.png")
   case4Btn.isVisible = true
   case4Btn.x = display.contentWidth/2 -case4Btn.width*1.5
   case4Btn.y =  display.contentHeight/1.75 +case4Btn.height/1.5
   localGroup:insert(case4Btn)
   local case4Text = display.newText("4", 0, 0, native.systemFont, 32)
	case4Text:setTextColor(87, 163, 166)
	case4Text.isVisible = false
	case4Text.x = case4Btn.x
	case4Text.y = case4Btn.y
   
   --case5Btn
	local case5Btn = display.newImage("bouton_niveau_glace.png")
   case5Btn.isVisible = true
   case5Btn.x = display.contentWidth/2
   case5Btn.y =  display.contentHeight/1.75 +case5Btn.height/1.5
   localGroup:insert(case5Btn)
   local case5Text = display.newText("5", 0, 0, native.systemFont, 32)
	case5Text:setTextColor(87, 163, 166)
	case5Text.isVisible = false
	case5Text.x = case5Btn.x
	case5Text.y = case5Btn.y
   
   --case6Btn
	local case6Btn = display.newImage("bouton_niveau_glace.png")
   case6Btn.isVisible = true
   case6Btn.x = display.contentWidth/2 +case6Btn.width*1.5
   case6Btn.y =  display.contentHeight/1.75 +case6Btn.height/1.5
   localGroup:insert(case6Btn)
   local case6Text = display.newText("6", 0, 0, native.systemFont, 32)
	case6Text:setTextColor(87, 163, 166)
	case6Text.isVisible = false
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
   case3Cad.isVisible = true
   case3Cad.x = case3Btn.x
   case3Cad.y =  case3Btn.y
   localGroup:insert(case3Cad)
   --
   local case4Cad = display.newImage("cadenas_niveau_bloque.png")
   case4Cad.isVisible = true
   case4Cad.x = case4Btn.x
   case4Cad.y =  case4Btn.y
   localGroup:insert(case4Cad)
   --
   local case5Cad = display.newImage("cadenas_niveau_bloque.png")
   case5Cad.isVisible = true
   case5Cad.x = case5Btn.x
   case5Cad.y =  case5Btn.y
   localGroup:insert(case5Cad)
   --
   local case6Cad = display.newImage("cadenas_niveau_bloque.png")
   case6Cad.isVisible = true
   case6Cad.x = case6Btn.x
   case6Cad.y =  case6Btn.y
   localGroup:insert(case6Cad)
   
   --Level 1 Clic
	   	local function pressCase1(event)
		if event.phase == "ended" then
			director:changeScene ("Ice1")
		end
	end
	case1Btn:addEventListener ("touch", pressCase1)		--Level 2 Clic
	   	local function pressCase2(event)
		if event.phase == "ended" then
			director:changeScene ("Ice2")
		end
	end
	case2Btn:addEventListener ("touch", pressCase2)
   
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
