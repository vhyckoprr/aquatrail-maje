module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )

	local DynResManager = require("DynResManager")
	local widget = require ("widget")
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
   
   --Textes Gauche
   local titre = display.newText("Graphisme", 0, 0, "Toledo", 16)
   titre:setTextColor(0, 56, 112)
   titre.x = display.contentWidth*0.15 + titre.width*0.5
   titre.y = display.contentHeight*0.1 + titre.height*0.5
   
   local text = display.newText("Blandine Bayoud\nMatthieu Rougier\nFiiz Kurosaki", 0, 0, "Toledo", 12)
   text:setTextColor(0, 56, 112)
   text.x = display.contentWidth*0.15 + text.width*0.5
   text.y = titre.y + titre.height*0.5 + text.height*0.5 + 10
    
   titre = display.newText("Game Design", 0, 0, "Toledo", 16)
   titre:setTextColor(0, 56, 112)
   titre.x = display.contentWidth*0.15 + titre.width*0.5
   titre.y = text.y + text.height*0.5 + titre.height*0.5 + 20
   
   text = display.newText("Florian Olivari\nArmelle Majouga", 0, 0, "Toledo", 12)
   text:setTextColor(0, 56, 112)
   text.x = display.contentWidth*0.15 + text.width*0.5
   text.y = titre.y + titre.height*0.5 + text.height*0.5 + 10
    
   titre = display.newText("Sound Design", 0, 0, "Toledo", 16)
   titre:setTextColor(0, 56, 112)
   titre.x = display.contentWidth*0.15 + titre.width*0.5
   titre.y = text.y + text.height*0.5 + titre.height*0.5 + 20
   
   text = display.newText("Romain Verdun", 0, 0, "Toledo", 12)
   text:setTextColor(0, 56, 112)
   text.x = display.contentWidth*0.15 + text.width*0.5
   text.y = titre.y + titre.height*0.5 + text.height*0.5 + 10
   
   
   --Textes droite
   titre = display.newText("Programmation", 0, 0, "Toledo", 16)
   titre:setTextColor(0, 56, 112)
   titre.x = display.contentWidth*0.55 + titre.width*0.5
   titre.y = display.contentHeight*0.1 + titre.height*0.5
   
   text = display.newText("Stéphane Bautista\nPierre Maccini\nYoan Cutillas", 0, 0, "Toledo", 12)
   text:setTextColor(0, 56, 112)
   text.x = display.contentWidth*0.55 + text.width*0.5
   text.y = titre.y + titre.height*0.5 + text.height*0.5 + 10
   
   titre = display.newText("Gestion de projet", 0, 0, "Toledo", 16)
   titre:setTextColor(0, 56, 112)
   titre.x = display.contentWidth*0.55 + titre.width*0.5
   titre.y = text.y + text.height*0.5 + titre.height*0.5 + 20
   
   text = display.newText("Théo Andreoletti\nDavid Valles", 0, 0, "Toledo", 12)
   text:setTextColor(0, 56, 112)
   text.x = display.contentWidth*0.55 + text.width*0.5
   text.y = titre.y + titre.height*0.5 + text.height*0.5 + 10
   
   titre = display.newText("Communication", 0, 0, "Toledo", 16)
   titre:setTextColor(0, 56, 112)
   titre.x = display.contentWidth*0.55 + titre.width*0.5
   titre.y = text.y + text.height*0.5 + titre.height*0.5 + 20
   
   text = display.newText("Peter Iafare", 0, 0, "Toledo", 12)
   text:setTextColor(0, 56, 112)
   text.x = display.contentWidth*0.55 + text.width*0.5
   text.y = titre.y + titre.height*0.5 + text.height*0.5 + 10
   
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