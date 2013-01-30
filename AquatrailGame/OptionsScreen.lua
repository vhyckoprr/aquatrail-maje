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

   --Textes
   local text = display.newText("OPTIONS", 0, 0, native.systemFont, 50)
   text:setTextColor(0, 56, 112)
   text.x = display.contentWidth*0.5
   text.y = display.contentHeight*0.1 + text.height*0.5
   
   text = display.newText("Musique", 0, 0, native.systemFont, 16)
   text:setTextColor(0, 56, 112)
   text.x = display.contentWidth*0.30 - text.width*0.5
   text.y = display.contentHeight*0.45 + 5
   
   text = display.newText("Bruitages", 0, 0, native.systemFont, 16)
   text:setTextColor(0, 56, 112)
   text.x = display.contentWidth*0.30 - text.width*0.5
   text.y = display.contentHeight*0.6 + 5
   
   --Réglage musique
   
   -- Chargement des musiques de test
    local backgroundMusic = audio.loadStream("themeglace.mp3")
	local stalactiteSound = audio.loadSound("b_stalactite.mp3")
 
   --Fonction définissant le comportement des sliders
	local function sliderMusiqueListener( event )
		local slider = event.target
		local value = event.value
		
		local backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1 }  )
		
		audio.setVolume(value*0.01, { channel=1 })
	end
	
	local function sliderBruitagesListener( event )
		audio.stop( { channel =1 } )
		
		local slider = event.target
		local value = event.value
		
		local stalactiteChannel = audio.play( stalactiteSound, { channel=2 } )
		
		audio.setVolume(value*0.01, { channel=2 })
	end
	
	--Création des sliders
	local sliderMusique = widget.newSlider
	{
		top = display.contentHeight*0.45,
		left = display.contentWidth*0.38,
		height = 10,
		width = 200,
		listener = sliderMusiqueListener, -- A chaque fois que l'on bouge le curseur, cette fonction est appelée
	
		-- if using vector shapes
	    fillColor = { 0, 56, 112, 255 },
	    handleColor = { 0, 0, 0, 255 },
		handleStroke = { 0, 0, 0, 255 },
	    bgFill = { 255, 255, 255, 0 },
	    bgStroke = { 0, 0, 0, 255 },
		cornerRadius = 5
	}
	
	local sliderBruitages = widget.newSlider
	{
		top = display.contentHeight*0.6 ,
		left = display.contentWidth*0.38,
		height = 10,
		width = 200,
		listener = sliderBruitagesListener, -- A chaque fois que l'on bouge le curseur, cette fonction est appelée
	
		-- if using vector shapes
	    fillColor = { 0, 56, 112, 255 },
	    handleColor = { 0, 0, 0, 255 },
		handleStroke = { 0, 0, 0, 255 },
	    bgFill = { 255, 255, 255, 0 },
	    bgStroke = { 0, 0, 0, 255 },
		cornerRadius = 5
	}

	--Valeur par défaut des curseurs
	--RECUPERATION DES VALEURS DE VOLUME ENREGISTREES DANS LA BDD (au lieu de 75)
	sliderMusique:setValue( 75 )
	sliderBruitages:setValue( 75 )
	
    -- insert the slider widget into a group
    localGroup:insert( sliderMusique )
	localGroup:insert( sliderBruitages )
   
	-- Bouton supprimer les données
	local supprBtn = display.newText("Supprimez les donnees", 0, 0, native.systemFont, 16)
   supprBtn:setTextColor(0, 56, 112)
   supprBtn.isVisible = true
   supprBtn.x = display.contentWidth*0.33 + supprBtn.width*0.5
   supprBtn.y = display.contentHeight*0.8 - supprBtn.height*0.5
   localGroup:insert(supprBtn)
	
	-- Bouton retour
	local reBtn = display.newImage("bouton_retour_defaut.png")
   reBtn.isVisible = true
   reBtn:setReferencePoint(display.TopLeftReferencePoint)
   reBtn.x = 15
   reBtn.y = display.contentHeight - reBtn.height - 15
   localGroup:insert(reBtn)
	
	--Supprimer les données function
	local function pressReturn (event)
		audio.stop( { channel =1 } )
		if event.phase == "ended" then
			director:changeScene ("SuppressionDonneesScreen")
		end
	end
	supprBtn:addEventListener ("touch", pressReturn)
	
	--Retour function
	local function pressReturn (event)
		audio.stop( { channel =1 } )
		if event.phase == "ended" then
		
			local volumeMusique = audio.getVolume ( { channel = 1 } )
			local volumeBruitages = audio.getVolume ( { channel = 2 } )
			
			--ENREGISTREMENT DES VALEURS DE VOLUMES volumeMusique ET volumeBruitages DANS LA BDD
			
			director:changeScene ("TitleScreen")
		end
	end
	reBtn:addEventListener ("touch", pressReturn)
	
	-- MUST return a display.newGroup()
	return localGroup
end