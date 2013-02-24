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
   local text = display.newText("RÉCOMPENSES", 0, 0, "Arial", 50)
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
		maskFile = "mask-recompensesmenu-320x480.png"
	}

	--Insert widgets/images into a group
	localGroup:insert( list )

	-- Insertion du texte dans chaque ligne au moment de leur génération
	local function onRowRender( event )
		local row = event.target
		local rowGroup = event.view
		
		
		-- Affichage du nom des niveaux et de leur numéro
		if(row.isCategory)
		then
			local text = display.newRetinaText( "Description", 0, 0, "arial", 14 )
			text:setReferencePoint( display.CenterLeftReferencePoint )
			text.y = row.height * 0.5
			text.x = 30
			text:setTextColor( 255, 255, 255 )
			rowGroup:insert( text )
			
			text = display.newRetinaText( "Points rescousse", 0, 0, "arial", 14 )
			text:setReferencePoint( display.CenterRightReferencePoint )
			text.y = row.height * 0.5
			text.x = display.contentWidth - 30
			text:setTextColor( 255, 255, 255 )
			rowGroup:insert( text )
		else
			local text = display.newRetinaText( "Récompense n°"..event.index-1, 0, 0, "arial", 12 )
			text:setReferencePoint( display.CenterLeftReferencePoint )
			text.y = row.height * 0.5
			text.x = 30
			text:setTextColor( 0,56,112 )
			rowGroup:insert( text )
			
			text = display.newRetinaText( "0", 0, 0, "arial", 12 )
			text:setReferencePoint( display.CenterRightReferencePoint )
			text.y = row.height * 0.5
			text.x = display.contentWidth - 30
			text:setTextColor( 0,56,112 )
			rowGroup:insert( text )
		end
		
	end

	-- Creation de 11 lignes d'exemple
	for i=0,10 do
	
		isCategory = false
		rowHeight = 30
		rowColor = {255,255,255,100}
		lineColor = {0, 56, 112, 255,255}
		
		if(i == 0) then 
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