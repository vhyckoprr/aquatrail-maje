module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )
	
	local DynResManager = require("DynResManager")	
	local localGroup = display.newGroup()
		-- Background
	-- Create a background colour just to make the screen look a little nicer
	local backcolor = DynResManager.createCenterRectangleFitted()
	backcolor:setFillColor(59, 215, 169)
	localGroup:insert(backcolor)
	
	--Background
	local back = display.newImage("fond_mondes.png")
   back.isVisible = true
   back.x = 	display.contentWidth/2 
   back.y =  display.contentHeight/2 
   localGroup:insert(back)
   
   --return
	local reBtn = display.newImage("bouton_retour_mondes.png")
   reBtn.isVisible = true
   reBtn.x = reBtn.width
   reBtn.y = display.contentHeight-display.contentHeight/4 +display.contentHeight/8
   localGroup:insert(reBtn)


	--textWorlds
	local textWorlds = display.newImage("texte_mondes.png")
   textWorlds.isVisible = true
   textWorlds.x = 	display.contentWidth/2 
   textWorlds.y =  display.contentHeight/7
   localGroup:insert(textWorlds)
   
   --desertBtn
	local desBtn = display.newImage("bouton_desert_lock.png")
   desBtn.isVisible = true
   desBtn.x = display.contentWidth/2 -desBtn.width/1.8
   desBtn.y =  display.contentHeight/1.75 +desBtn.height/1.8
   localGroup:insert(desBtn)
   
   --foretBtn
	local forBtn = display.newImage("bouton_foret_lock.png")
   forBtn.isVisible = true
   forBtn.x = display.contentWidth/2 +forBtn.width/1.8
   forBtn.y =  display.contentHeight/1.75 -forBtn.height/1.8
   localGroup:insert(forBtn)
   
   --desBtn
	local glaBtn = display.newImage("bouton_glace.png")
   glaBtn.isVisible = true
   glaBtn.x = display.contentWidth/2 -glaBtn.width/1.8
   glaBtn.y =  display.contentHeight/1.75-glaBtn.height/1.8
   localGroup:insert(glaBtn)
   
   --islandBtn
	local islBtn = display.newImage("bouton_ile_lock.png")
   islBtn.isVisible = true
   islBtn.x = display.contentWidth/2 +islBtn.width/1.8
   islBtn.y =  display.contentHeight/1.75 +islBtn.height/1.8
   localGroup:insert(islBtn)
   
   --cadenas
   local forCad = display.newImage("cadenas_monde_bloque.png")
   forCad.isVisible = true
   forCad.x = forBtn.x
   forCad.y =  forBtn.y
   localGroup:insert(forCad)
   --
   local islCad = display.newImage("cadenas_monde_bloque.png")
   islCad.isVisible = true
   islCad.x = islBtn.x
   islCad.y =  islBtn.y
   localGroup:insert(islCad)
   --
   local desCad = display.newImage("cadenas_monde_bloque.png")
   desCad.isVisible = true
   desCad.x = desBtn.x
   desCad.y =  desBtn.y
   localGroup:insert(desCad)
	
	--Ice Button
	   	local function pressIce (event)
		if event.phase == "ended" then
			director:changeScene ("IceWorld")
		end
	end
	glaBtn:addEventListener ("touch", pressIce)
	
	--Return Button
	   	local function pressReturn (event)
		if event.phase == "ended" then
			director:changeScene ("TitleScreen")
		end
	end
	reBtn:addEventListener ("touch", pressReturn)

	-- MUST return a display.newGroup()
	return localGroup
end
