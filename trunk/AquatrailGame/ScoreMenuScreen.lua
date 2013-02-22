module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )

	local DynResManager = require("DynResManager")
	local widget = require ("widget")
	local worldinfo = profile.getInfos()
	local localGroup = display.newGroup()
	
	-- Create a background colour just to make the screen look a little nicer
	local backcolor = DynResManager.createCenterRectangleFitted()
	backcolor:setFillColor(169, 214, 255)
	localGroup:insert(backcolor)
	
	--Background
   local back = display.newImage("fond_accueil.png")
   back.isVisible = true
   back.x = display.contentWidth*0.5 
   back.y = display.contentHeight*0.5 
   localGroup:insert(back)

   --Textes
   local text = display.newText("SCORES", 0, 0, "Arial", 50)
   text:setTextColor(0, 56, 112)
   text.x = display.contentWidth*0.5
   text.y = display.contentHeight*0.1 + text.height*0.5
   
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
			local text = display.newRetinaText( "Niveau " .. nomMonde .. " - " .. idNiveau, 0, 0, "Arial", 12 )
			text:setReferencePoint( display.CenterLeftReferencePoint )
			text.y = row.height * 0.5
			text.x = 30
			text:setTextColor( 0 )
			rowGroup:insert( text )
		else
			local text = display.newRetinaText( "Niveau " .. nomMonde, 0, 0, "Arial", 14 )
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
			text = display.newRetinaText( score, 0, 0, "Arial", 12 )
			text:setReferencePoint( display.CenterLeftReferencePoint )
			text.y = row.height * 0.5
			text.x = 415
			text:setTextColor( 0 )
			rowGroup:insert( text )
		else
			text = display.newRetinaText( "Score", 0, 0, "Arial", 14 )
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

   	-- Bouton retour
	local reBtn = display.newImage("bouton_retour_defaut.png")
   reBtn.isVisible = true
   reBtn:setReferencePoint(display.TopLeftReferencePoint)
   reBtn.x = 15
   reBtn.y = display.contentHeight - reBtn.height - 15
   localGroup:insert(reBtn)
	
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