module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )

	local DynResManager = require("DynResManager")
	local localGroup = display.newGroup()
	
	-- Create a background colour just to make the screen look a little nicer
	local backcolor = DynResManager.createCenterRectangleFitted()
	backcolor:setFillColor(10, 10, 20)
	localGroup:insert(backcolor)
	
	--Background
	local back = display.newImage("fond_accueil.png")
   back.isVisible = false
   back.x = display.contentWidth*0.5 
   back.y = display.contentHeight*0.5 
   localGroup:insert(back)

   --Textes
   local titre = display.newText("SUPPRIMEZ LES DONNEES", 0, 0, "Fontastique", 30)
   titre:setTextColor(112, 168, 224)
   titre.x = display.contentWidth*0.5
   titre.y = display.contentHeight*0.1 + titre.height*0.5
   
   local text = display.newText("Vous perdrez l'intégralité de vos données : \n- Score \n- Récompenses \n- Niveaux", 0, 0, "Fontastique", 18)
   text:setTextColor(112, 168, 224)
   text.x = display.contentWidth*0.5 
   text.y = display.contentHeight*0.5
   
   --Bouton Valider
   local validerBtn = display.newText("Valider", 0, 0, "Fontastique", 20)
   validerBtn:setTextColor(112, 168, 224)
   validerBtn.x = display.contentWidth*0.33
   validerBtn.y = display.contentHeight*0.8
   
   --Bouton Retour
   local reBtn = display.newText("Retour", 0, 0, "Fontastique", 20)
   reBtn:setTextColor(112, 168, 224)
   reBtn.x = display.contentWidth*0.66
   reBtn.y = display.contentHeight*0.8
   
   
   --Valider function
    function Valider1 ()
		validerBtn:addEventListener ("touch", Confirmation)
    end
	
    function Valider2 ()
		--validerBtn:addEventListener ("touch", RetourMenu)
		--rentrer votre pseudo
			director:changeScene ("PseudoScreen")
    end
	
	function Confirmation (event)
		if event.phase == "ended" then
			validerBtn:removeEventListener ("touch", Confirmation)
			
			--SUPPRIMER LES DONNEES DE LA BDD
			profile.eraseProfile()
			
			titre.text = "CONFIRMATION"
			text.text = "Vos données ont bien été suprimées"
			validerBtn.isVisible = false
			reBtn.isVisible = false
			
			timer.performWithDelay( 2000, Valider2 )
			
			return true
		end
	end
	
	function RetourMenu (event)
		if event.phase == "ended" then
			validerBtn:removeEventListener ("touch", RetourMenu)
			
			timer.performWithDelay( 1, Valider1 )
			
			director:changeScene ("TitleScreen")
			return true
		end
	end

	Valider1()

	
   --Retour function
	local function pressReturn (event)
		if event.phase == "ended" then
			director:changeScene ("OptionsScreen")
		end
	end
	reBtn:addEventListener ("touch", pressReturn)
   
   
   	-- MUST return a display.newGroup()
	return localGroup
end