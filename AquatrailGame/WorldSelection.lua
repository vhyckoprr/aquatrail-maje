module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )
	
	local DynResManager = require("DynResManager")
	local worldInfos = profile.getInfos()
	local unlockWorld1 = worldInfos.world1.unlocked
	local unlockWorld2 =worldInfos.world2.unlocked
	local unlockWorld3 =worldInfos.world3.unlocked
	local unlockWorld4 =worldInfos.world4.unlocked

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
   reBtn:setReferencePoint(display.TopLeftReferencePoint)
   reBtn.x = 15
   reBtn.y = display.contentHeight - reBtn.height - 15
   localGroup:insert(reBtn)


	--textWorlds
	local textWorlds = display.newImage("texte_mondes.png")
   textWorlds.isVisible = true
   textWorlds.x = 	display.contentWidth/2 
   textWorlds.y =  display.contentHeight/7
   localGroup:insert(textWorlds)
   
   --glaBtn (MONDE 1)
	local glaBtn = display.newImage("bouton_glace.png")
   glaBtn.isVisible = true
   glaBtn.x = display.contentWidth/2 -glaBtn.width/1.8
   glaBtn.y =  display.contentHeight/1.75-glaBtn.height/1.8
   localGroup:insert(glaBtn)
   --cadenas
   local glaCad = display.newImage("cadenas_monde_bloque.png")
   glaCad.isVisible = not unlockWorld1
   glaCad.x = glaBtn.x
   glaCad.y =  glaBtn.y
   localGroup:insert(glaCad)
   --------------------------------------------------------------------------
   
   --foretBtn (MONDE 2 )
	local forBtn = display.newImage("bouton_foret_lock.png")
   forBtn.isVisible = true
   forBtn.x = display.contentWidth/2 +forBtn.width/1.8
   forBtn.y =  display.contentHeight/1.75 -forBtn.height/1.8
   localGroup:insert(forBtn)
   --cadenas
   local forCad = display.newImage("cadenas_monde_bloque.png")
   forCad.isVisible = not unlockWorld2
   forCad.x = forBtn.x
   forCad.y =  forBtn.y
   localGroup:insert(forCad)
   -----------------------------------------------------------------------------
   
   --desertBtn (MONDE 3 )
	local desBtn = display.newImage("bouton_desert_lock.png")
   desBtn.isVisible = true
   desBtn.x = display.contentWidth/2 -desBtn.width/1.8
   desBtn.y =  display.contentHeight/1.75 +desBtn.height/1.8
   localGroup:insert(desBtn)
   -- cadenas
   local desCad = display.newImage("cadenas_monde_bloque.png")
   desCad.isVisible = not unlockWorld3
   desCad.x = desBtn.x
   desCad.y =  desBtn.y
   localGroup:insert(desCad)
   --------------------------------------------------------------------------
   
   --islandBtn ( MONDE 4)
	local islBtn = display.newImage("bouton_ile_lock.png")
   islBtn.isVisible = true
   islBtn.x = display.contentWidth/2 +islBtn.width/1.8
   islBtn.y =  display.contentHeight/1.75 +islBtn.height/1.8
   localGroup:insert(islBtn)
	-- cadenas
   local islCad = display.newImage("cadenas_monde_bloque.png")
   islCad.isVisible = not unlockWorld4
   islCad.x = islBtn.x
   islCad.y =  islBtn.y
   localGroup:insert(islCad)
   
   

	--Ice Button
	 local function pressIce (event)
		if (event.phase == "ended"  and unlockWorld1 )  then
			director:changeScene ("IceWorld")
		end
	end
	glaBtn:addEventListener ("touch", pressIce)
	
	--Forest Button
	 local function pressForest (event)
		if (event.phase == "ended"  and unlockWorld2 )  then
			director:changeScene ("ForestWorld")
		end
	end
	forBtn:addEventListener ("touch", pressForest)
		
	--Desert Button
	 local function pressDesert (event)
		if (event.phase == "ended"  and unlockWorld3 )  then
			director:changeScene ("DesertWorld")
		end
	end
	desBtn:addEventListener ("touch", pressDesert)
	
	--Island Button
	 local function pressIsland (event)
		if (event.phase == "ended"  and unlockWorld4)  then
			director:changeScene ("DesertWorld")
		end
	end
	islBtn:addEventListener ("touch", pressDesert)
	
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
