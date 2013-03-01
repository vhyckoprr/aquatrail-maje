module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )

	local DynResManager = require("DynResManager")
	local widget = require ("widget")
	local json = require ("json")
	local worldinfo = profile.getInfos()
	local localGroup = display.newGroup()
	local afficheScore = score.getAfficheScore()
	
	-- L'ecran change en fonction du monde choisi
	local bg = "fond_glace.png"
	local color = {158,233,235}
	local colorText = {87, 163, 166}
	local boutonRetour = "bouton_retour_defaut.png"
	if(afficheScore.scoreGlace) then bg = "background_ice.png"; color = {158,233,235}; colorText = {87, 163, 166}; boutonRetour = "bouton_retour_glace.png";
	elseif(afficheScore.scoreForet) then bg = "background_foret.png"; color = {200,127,23}; colorText = {120,65,0}; boutonRetour = "bouton_retour_foret.png";
	elseif(afficheScore.scoreIle) then bg = "fond_ile.png"; color = {84,186,255}; colorText = {128,226,205}; boutonRetour = "bouton_retour_ile.png";
	elseif(afficheScore.scoreDesert) then bg = "background_desert.png"; color = {241,148,86}; colorText = {105,26,186}; boutonRetour = "bouton_retour_desert.png";
	else end
	
	local colonne1Contenu = "number"
	local colonne2Contenu = "player"
	local colonne3Contenu = "score"	

	-- Create a background colour just to make the screen look a little nicer
	local backcolor = DynResManager.createCenterRectangleFitted()
	backcolor:setFillColor(color[1],color[2],color[3])
	localGroup:insert(backcolor)

	--Background
	local back = display.newImage(bg)
   back.isVisible = true
   back.x = display.contentWidth/2 
   back.y = display.contentHeight/2 
   localGroup:insert(back)
   
   --Textes
	local titre = display.newText("SCORES", 0, 0, "Fontastique", 50)
	titre:setTextColor(colorText[1], colorText[2], colorText[3])
	if(afficheScore.scoreForet) then titre:setTextColor(0,210,30) end
	titre.x = display.contentWidth*0.5
	titre.y = display.contentHeight*0.05 + titre.height*0.5
   
   --Btn Score
	local btnScore = display.newRect(0, 0, 100, 30)
	btnScore.strokeWidth = 1
	btnScore:setStrokeColor(0, 0, 0)
	btnScore:setReferencePoint( display.TopLeftReferencePoint )
	btnScore.x = 20
	btnScore.y = 90
	localGroup:insert(btnScore)
	   
	local text = display.newText("Score", 0, 0, "Fontastique", 18)
	text:setReferencePoint( display.CenterLeftReferencePoint )
	text:setTextColor(255, 255, 255)
	text.x = 30
	text.y = 105
	
	local function pressScore (event)
		if event.phase == "ended" then
			score.setOngletChoisi(1)
		end
	end
	btnScore:addEventListener ("touch", pressScore)
	
	--Btn Temps
	local btnTemps = display.newRect(0, 0, 100, 30)
	btnTemps.strokeWidth = 1
	btnTemps:setStrokeColor(0, 0, 0)
	btnTemps:setReferencePoint( display.TopLeftReferencePoint )
	btnTemps.x = 123
	btnTemps.y = 90
	localGroup:insert(btnTemps)
	   
	text = display.newText("Temps", 0, 0, "Fontastique", 18)
	text:setReferencePoint( display.CenterLeftReferencePoint )
	text:setTextColor(255, 255, 255)
	text.x = 133
	text.y = 105
	
	local function pressTemps (event)
		if event.phase == "ended" then
			score.setOngletChoisi(2)
		end
	end
	btnTemps:addEventListener ("touch", pressTemps)
	
	--Btn Progression
	local btnProgression = display.newRect(0, 0, 100, 30)
	btnProgression.strokeWidth = 1
	
	btnProgression:setStrokeColor(0, 0, 0)
	btnProgression:setReferencePoint( display.TopLeftReferencePoint )
	btnProgression.x = 226
	btnProgression.y = 90
	localGroup:insert(btnProgression)
	   
	text = display.newText("Progression", 0, 0, "Fontastique", 18)
	text:setReferencePoint( display.CenterLeftReferencePoint )
	text:setTextColor(255, 255, 255)
	text.x = 236
	text.y = 105
   
    local function pressProgression (event)
		if event.phase == "ended" then
			score.setOngletChoisi(3)
		end
	end
	btnProgression:addEventListener ("touch", pressProgression)
   
	
   
   --Gestion de l'apparence de l'onglet actif
	local function apparenceOngletActif ()
		btnScore:setFillColor(0, 56, 112, 100)
		btnTemps:setFillColor(0, 56, 112, 100)
		btnProgression:setFillColor(0, 56, 112, 100)
		if(afficheScore.ongletScore) then btnScore:setFillColor(0, 56, 112) end
		if(afficheScore.ongletTemps) then btnTemps:setFillColor(0, 56, 112) end
		if(afficheScore.ongletProgression) then btnProgression:setFillColor(0, 56, 112) end
	end
   
	--Creer la liste de score
	local list = widget.newTableView
	{
		top = 120,
		width = 480, 
		height = 125,
		bgColor = { 255, 255, 255, 100 },
		topPadding = 0,
		maskFile = "mask-scoremenu-320x480.png"
	}

	--Insert widgets/images into a group
	localGroup:insert( list )
	
local function ongletActif(event)

	
	apparenceOngletActif ()
	list:deleteAllRows()

	-- Insertion du texte dans chaque ligne au moment de leur génétion
	local function onRowRender( event )
		local row = event.target
		local rowGroup = event.view
		
		-- Calcul de l'ID et du NOM du Monde et de l'ID du niveau
		local nomMonde = ""
		local idNiveau = afficheScore.nivChoisi
		local idMonde = 1
		if(afficheScore.scoreGlace) then nomMonde = "Glace"; idMonde = 1
		elseif(afficheScore.scoreForet) then nomMonde = "Forêt"; idMonde = 2
		elseif(afficheScore.scoreDesert) then nomMonde = "Désert"; idMonde = 3
		elseif(afficheScore.scoreIle) then nomMonde = "Île"; idMonde = 4
		else end
		
		--On détermine les colonnes en fonction de l'onglet actif
			local colonne1Titre = ""
			local colonne2Titre = ""
			local colonne3Titre = ""
			local colonne1Contenu = ""
			local colonne2Contenu = ""
			local colonne3Contenu = 0
			if(afficheScore.ongletActif == 1)
			then
				colonne1Titre = "Nom"
				colonne2Titre = "Pays"
				colonne3Titre = "Score"
				colonne1Contenu = "Joueur"
				colonne2Contenu = "France"
				if (idMonde ~= 4) then -- A SUPPRIMER lorsque la bdd des mondes sera complète 
					colonne3Contenu = worldinfo["world"..idMonde]["level"..idNiveau].score
				end -- A SUPPRIMER lorsque la bdd des mondes sera complète 
			elseif(afficheScore.ongletActif == 2)
			then
				colonne1Titre = "Nom"
				colonne2Titre = "Pays"
				colonne3Titre = "Temps"
				colonne1Contenu = "Joueur"
				colonne2Contenu = "France"
				if (idMonde ~= 4) then -- A SUPPRIMER lorsque la bdd des mondes sera complète 
					local temps = tonumber(worldinfo["world"..idMonde]["level"..idNiveau].time)
					if(temps ~= nil)
					then
						local zeroComposite = ""
						if((temps%60) >= 0 and (temps%60) < 10) then zeroComposite = "0" end
						colonne3Contenu = math.floor(temps/60)..":"..zeroComposite..(temps%60)
					else
						colonne3Contenu = "∞"
					end
				end -- A SUPPRIMER lorsque la bdd des mondes sera complète 
			elseif(afficheScore.ongletActif == 3)
			then
				colonne1Titre = "Progression"
				colonne2Titre = ""
				colonne3Titre = "%"
				if(event.index == 2) then colonne1Contenu = "Score" end
				if(event.index == 3) then colonne1Contenu = "Temps" end
				colonne2Contenu = ""
				if (idMonde ~= 4) then -- A SUPPRIMER lorsque la bdd des mondes sera complète 
					--A DECOMENTER quand chaque niveau aura son scoreMax.
					-- if(event.index == 2) then colonne3Contenu = math.min(math.ceil(worldinfo["world"..idMonde]["level"..idNiveau].score*100 / worldinfo["world"..idMonde]["level"..idNiveau].scoreMax), 100) end
					-- if(event.index == 3) then 
						--local temps = tonumber(worldinfo["world"..idMonde]["level"..idNiveau].time)
						--if(temps ~= nil and temps <= 120000) then colonne3Contenu = 100
						--elseif(temps ~= nil and temps >= 300000) then colonne3Contenu = 0
						--elseif(temps ~= nil and ) then colonne3Contenu = math.ceil(temps*100 / worldinfo["world"..idMonde]["level"..idNiveau].timeMin)
						--else end
					--end
					
					--Pour depanner on dit que le score max est 5000 pour tous les niveaux 
					--et que si le temps est inférieur à 1mn on a 100% et que s'il est supérieur à 3mn on a 0% (entre les deux, on applique une règle de proportionnalité)
					if(event.index == 2) then colonne3Contenu = math.min(math.ceil(worldinfo["world"..idMonde]["level"..idNiveau].score*100 /5000), 100) end
					if(event.index == 3) 
					then
						local temps = tonumber(worldinfo["world"..idMonde]["level"..idNiveau].time)
						if(temps ~= nil and temps <= 60) then colonne3Contenu = 100
						elseif(temps ~= nil and temps >= 180) then colonne3Contenu = 0
						elseif (temps ~= nil) then colonne3Contenu = math.min(200-math.ceil(temps*100 / 60), 100)
						else colonne3Contenu = 0 end
					end
				end -- A SUPPRIMER lorsque la bdd des mondes sera complète
			end
			
			-- Affichage des titres des colonnes et de leur valeur pour chaque ligne
			if(not row.isCategory)
			then
				--Contenu Colonne1
				local text = display.newRetinaText( colonne1Contenu, 0, 0, "Arial", 12 )
				text:setReferencePoint( display.CenterMiddleReferencePoint )
				text.y = row.height * 0.5
				text.x = display.contentWidth*0.16
				text:setTextColor( 0 )
				rowGroup:insert( text )
				
				--Contenu Colonne2
				text = display.newRetinaText( colonne2Contenu, 0, 0, "Arial", 12 )
				text:setReferencePoint( display.CenterMiddleReferencePoint )
				text.y = row.height * 0.5
				text.x = display.contentWidth*0.5
				text:setTextColor( 0 )
				rowGroup:insert( text )
				
				--Contenu Colonne3
				text = display.newRetinaText( colonne3Contenu, 0, 0, "Arial", 12 )
				text:setReferencePoint( display.CenterMiddleReferencePoint )
				text.y = row.height * 0.5
				text.x = display.contentWidth*0.82
				text:setTextColor( 0 )
				rowGroup:insert( text )
			else
				--Titre Colonne1
				local text = display.newRetinaText( colonne1Titre, 0, 0, "Arial", 14 )
				text:setReferencePoint( display.CenterMiddleReferencePoint )
				text.y = row.height * 0.5
				text.x = display.contentWidth*0.16
				text:setTextColor( 255, 255, 255 )
				rowGroup:insert( text )
				
				--Titre Colonne2
				text = display.newRetinaText( colonne2Titre, 0, 0, "Arial", 14 )
				text:setReferencePoint( display.CenterMiddleReferencePoint )
				text.y = row.height * 0.5
				text.x = display.contentWidth*0.5
				text:setTextColor( 255, 255, 255 )
				rowGroup:insert( text )
				
				--Titre Colonne3
				text = display.newRetinaText( colonne3Titre, 0, 0, "Arial", 14 )
				text:setReferencePoint( display.CenterMiddleReferencePoint )
				text.y = row.height * 0.5
				text.x = display.contentWidth*0.82
				text:setTextColor( 255, 255, 255 )
				rowGroup:insert( text )
			end
	end
	
	-- Creation des lignes
		--Nombre de ligne necessaire (par défaut = 2) (normalement, il faut compter le nombre de ligne dans la bdd
	local nbLigne = 2
	if(afficheScore.ongletActif  == 3) then nbLigne = 3 end
		
	for i=1,nbLigne do
	
		isCategory = false
		rowHeight = 30
		rowColor = {255,255,255,100}
		lineColor = {0, 56, 112, 255}
		
		if(i == 1) then 
			isCategory = true; rowHeight = 34; rowColor={ 0, 56, 112, 255 }; lineColor={0, 56, 112, 255}
		end
	
		list:insertRow
		{
			isCategory = isCategory,
			onRender = onRowRender,
			height = rowHeight,
			rowColor = rowColor,
			lineColor = lineColor
		}
	end
end
btnScore:addEventListener ("tap", ongletActif)
btnTemps:addEventListener ("tap", ongletActif)
btnProgression:addEventListener ("tap", ongletActif)	

--Affichage initial
timer.performWithDelay( 0, apparenceOngletActif )
timer.performWithDelay( 0, ongletActif )

	-- Bouton retour
	local reBtn = display.newImage(boutonRetour)
   reBtn.isVisible = true
   reBtn:setReferencePoint(display.BottomLeftReferencePoint)
   reBtn.x = 15
   reBtn.y = display.contentHeight - 15
   localGroup:insert(reBtn)
   
	--Retour function
	local function pressReturn (event)
		if event.phase == "ended" then
			director:changeScene ("scoreNivScreen")
		end
	end
	reBtn:addEventListener ("touch", pressReturn)
	
	-- MUST return a display.newGroup()
	return localGroup
end