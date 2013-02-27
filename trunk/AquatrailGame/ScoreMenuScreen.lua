module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )

	local DynResManager = require("DynResManager")
	local widget = require ("widget")
	local worldinfo = profile.getInfos()
	local localGroup = display.newGroup()
	
	-- Create a background colour just to make the screen look a little nicer
	local backcolor = DynResManager.createCenterRectangleFitted()
	backcolor:setFillColor(59, 215, 169)
	localGroup:insert(backcolor)
	
	--Background
   local back = display.newImage("fond_mondes.png")
   back.isVisible = true
   back.x = display.contentWidth*0.5 
   back.y = display.contentHeight*0.5 
   localGroup:insert(back)

   --Textes
   local text = display.newText("SCORES", 0, 0, "Fontastique", 50)
   text:setTextColor(255,255,255)
   text.x = display.contentWidth*0.5
   text.y = display.contentHeight*0.05 + text.height*0.5
  
--[[
   --Creer la liste de score
	local list = widget.newTableView
	{
		top = 95,
		width = 480, 
		height = 185,
		bottomPadding = 8,
		bgColor = { 255, 255, 255, 100 },
		maskFile = "mask-scoremenu-320x480.png"
	}

	--Insert widgets/images into a group
	localGroup:insert( list )

	-- Insertion du texte dans chaque ligne au moment de leur génération
	local function onRowRender( event )
		local row = event.target
		local rowGroup = event.view
		
		-- Calcul de l'ID et du NOM du Monde et de l'ID du niveau
		local nomMonde = ""
		local idMonde = 1
		local idNiveau = (event.index % 7)-1
		if(idNiveau == -1) then idNiveau = 6 end
		if(event.index >= 1 and event.index <=7) then nomMonde = "Glace"; idMonde = 1 end
		if(event.index >= 8 and event.index <=14) then nomMonde = "Foret"; idMonde = 2 end
		if(event.index >= 15 and event.index <=21) then nomMonde = "Desert"; idMonde = 3 end
		if(event.index >= 22 and event.index <=28) then nomMonde = "Ile"; idMonde = 4 end
		
		-- Affichage du nom des niveaux et de leur numéro
		if(not row.isCategory)
		then
			local text = display.newRetinaText( "Niveau " .. nomMonde .. " - " .. idNiveau, 0, 0, "Fontastique", 12 )
			text:setReferencePoint( display.CenterLeftReferencePoint )
			text.y = row.height * 0.5
			text.x = 30
			text:setTextColor( 0 )
			rowGroup:insert( text )
		else
			local text = display.newRetinaText( "Niveau " .. nomMonde, 0, 0, "Fontastique", 14 )
			text:setReferencePoint( display.CenterLeftReferencePoint )
			text.y = row.height * 0.5
			text.x = 30
			text:setTextColor( 112, 168, 224 )
			rowGroup:insert( text )
		end

			
		
		

		-- recuperation du score de chaque niveau  dans la bdd
		score = 0;
		if (idMonde == 1) then -- A SUPPRIMER lorsque la bdd des mondes sera complète 
		if(not(idNiveau == 0)) then score = worldinfo["world"..idMonde]["level"..idNiveau].score end
		end -- A SUPPRIMER lorsque la bdd des mondes sera complète 

		
		
		
		
		
		-- Affichage du score sur les ligne des niveaux mais pas sur les lignes d'en-tête
		if(not row.isCategory)
		then
			text = display.newRetinaText( score, 0, 0, "Fontastique", 12 )
			text:setReferencePoint( display.CenterLeftReferencePoint )
			text.y = row.height * 0.5
			text.x = 415
			text:setTextColor( 0 )
			rowGroup:insert( text )
		else
			text = display.newRetinaText( "Score", 0, 0, "Fontastique", 14 )
			text:setReferencePoint( display.CenterLeftReferencePoint )
			text.y = row.height * 0.5
			text.x = 415
			text:setTextColor( 112, 168, 224 )
			rowGroup:insert( text )
		end
		
	end

	-- Creation des 24 lignes correspondant au 24 niveaux:
	for i=0,27 do
	
		isCategory = false
		rowHeight = 30
		rowColor = {255,255,255,100}
		lineColor = {0, 56, 112, 255,255}
		
		if(i%7 == 0) then 
			isCategory = true; rowHeight = 34; rowColor={ 0, 56, 112, 255 }; lineColor={112, 168, 224, 255}
		end
	
		list:insertRow{
			isCategory = isCategory,
			onRender=onRowRender,
			height = rowHeight,
			rowColor = rowColor,
			lineColor = lineColor
		}
	end
]]--

   --glaBtn (MONDE 1)
	local glaBtn = display.newImage("bouton_glace.png")
   glaBtn.isVisible = true
   glaBtn.x = display.contentWidth/2 -glaBtn.width/1.8
   glaBtn.y =  display.contentHeight/1.75-glaBtn.height/1.8
   localGroup:insert(glaBtn)

   --foretBtn (MONDE 2 )
	local forBtn = display.newImage("bouton_foret.png")
   forBtn.isVisible = true
   forBtn.x = display.contentWidth/2 +forBtn.width/1.8
   forBtn.y =  display.contentHeight/1.75 -forBtn.height/1.8
   localGroup:insert(forBtn)

   --desertBtn (MONDE 3 )
	local desBtn = display.newImage("bouton_desert.png")
   desBtn.isVisible = true
   desBtn.x = display.contentWidth/2 -desBtn.width/1.8
   desBtn.y =  display.contentHeight/1.75 +desBtn.height/1.8
   localGroup:insert(desBtn)

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
   
   	-- Bouton retour
	local reBtn = display.newImage("bouton_retour_mondes.png")
   reBtn.isVisible = true
   reBtn:setReferencePoint(display.TopLeftReferencePoint)
   reBtn.x = 15
   reBtn.y = display.contentHeight - reBtn.height - 15
   localGroup:insert(reBtn)
	
	--Ice Button
	 local function pressIce (event)
		if (event.phase == "ended")  then
			score.setMondeChoisi("glace")
			director:changeScene ("scoreNivScreen")
		end
	end
	glaBtn:addEventListener ("touch", pressIce)
	
	--Forest Button
	 local function pressForest (event)
		if (event.phase == "ended")  then
			score.setMondeChoisi("foret")
			director:changeScene ("scoreNivScreen")
		end
	end
	forBtn:addEventListener ("touch", pressForest)
		
	--Desert Button
	 local function pressDesert (event)
		if (event.phase == "ended")  then
			score.setMondeChoisi("desert")
			director:changeScene ("scoreNivScreen")
		end
	end
	desBtn:addEventListener ("touch", pressDesert)
	
	--Island Button
	 local function pressIsland (event)
		if (event.phase == "ended")  then
			score.setMondeChoisi("ile")
			director:changeScene ("scoreNivScreen")
		end
	end
	--islBtn:addEventListener ("touch", pressIsland)
	
	--Retour function
	local function pressReturn (event)
		audio.stop( { channel =1 } )
		if event.phase == "ended" then
			director:changeScene ("TitleScreen")
		end
	end
	reBtn:addEventListener ("touch", pressReturn)
	
	-- MUST return a display.newGroup()
	return localGroup
end