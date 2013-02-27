

module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )
	
	local DynResManager = require("DynResManager")
	local widget = require ("widget")
	local json = require ("json")
	local worldinfo = profile.getInfos()
	local tempInfos = profile.getTempInfos()
	local localGroup = display.newGroup()
	local afficheScore = score.getAfficheScore()
	
	--update score
	afficheScore.ongletScore = true
	afficheScore.ongletTemps = false
	afficheScore.ongletProgression = false
	afficheScore.nivChoisi = tempInfos.Level
	afficheScore.mondeChoisi = tempInfos.World
	afficheScore.ongletActif = 1
	
	
	
	-- L'ecran change en fonction du monde choisi
	local bg = "fond_glace.png"
	local color = {158,233,235}
	local colorText = {87, 163, 166}
	local boutonRetour = "bouton_retour_defaut.png"
	if(tempInfos.World=="1") then bg = "fond_glace.png"; color = {158,233,235}; colorText = {87, 163, 166}; boutonRetour = "bouton_retour_glace.png";
	elseif(tempInfos.World=="2") then bg = "fond_foret.png"; color = {200,127,23}; colorText = {192,125,59}; boutonRetour = "bouton_retour_foret.png";
	elseif(tempInfos.World=="4") then bg = "fond_ile.png"; color = {84,186,255}; colorText = {115,205,217}; boutonRetour = "bouton_retour_ile.png";
	elseif(tempInfos.World=="3") then bg = "fond_desert.png"; color = {241,148,86}; colorText = {192,125,59}; boutonRetour = "bouton_retour_desert.png";
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
   titre:setTextColor(0, 56, 112)
   titre.x = display.contentWidth*0.5
   titre.y = display.contentHeight*0.075 + titre.height*0.5
   
   --Btn Score
	local btnScore = display.newRect(0, 0, 100, 30)
	btnScore.strokeWidth = 1
	btnScore:setStrokeColor(0, 0, 0)
	btnScore:setReferencePoint( display.TopLeftReferencePoint )
	btnScore.x = 20
	btnScore.y = 90
	localGroup:insert(btnScore)
	   
	local text = display.newText("Score", 0, 0, "Fontastique", 14)
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
	   
	text = display.newText("Temps", 0, 0, "Fontastique", 14)
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
	   
	text = display.newText("Progression", 0, 0, "Fontastique", 14)
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
	
	-- Insertion du texte dans chaque ligne au moment de leur génétion
local function onRowRender( event )
	local row = event.target
	local rowGroup = event.view
	
	
	-- Calcul de l'ID et du NOM du Monde et de l'ID du niveau
	local nomMonde = ""
	local idNiveau = afficheScore.nivChoisi
	local idMonde = afficheScore.mondeChoisi
	
	--On détermine les colonnes en fonction de l'onglet actif
		local colonne1Titre = ""
		local colonne2Titre = ""
		local colonne3Titre = ""
		
		if(afficheScore.ongletActif == 1)
		then
			colonne1Titre = "Classement"
			colonne2Titre = "Nom"
			colonne3Titre = "Score"

		elseif(afficheScore.ongletActif == 2)
		then
			colonne1Titre = "Classement"
			colonne2Titre = "Nom"
			colonne3Titre = "Temps"

		elseif(afficheScore.ongletActif == 3)
		then
			colonne1Titre = "Progression"
			colonne2Titre = ""
			colonne3Titre = "%"
			if(event.index == 2) then colonne1Contenu = "Score" end
			if(event.index == 3) then colonne1Contenu = "Temps" end
			colonne2Contenu = ""

		end
		
		-- Affichage des titres des colonnes et de leur valeur pour chaque ligne
		if(not row.isCategory)
		then
			--Contenu Colonne1
			local text = display.newRetinaText( colonne1Contenu, 0, 0, "Fontastique", 12 )
			text:setReferencePoint( display.CenterMiddleReferencePoint )
			text.y = row.height * 0.5
			text.x = display.contentWidth*0.16
			text:setTextColor( 0 )
			rowGroup:insert( text )
			
			--Contenu Colonne2
			text = display.newRetinaText( colonne2Contenu, 0, 0, "Fontastique", 12 )
			text:setReferencePoint( display.CenterMiddleReferencePoint )
			text.y = row.height * 0.5
			text.x = display.contentWidth*0.5
			text:setTextColor( 0 )
			rowGroup:insert( text )
			
			--Contenu Colonne3
			text = display.newRetinaText( colonne3Contenu, 0, 0, "Fontastique", 12 )
			text:setReferencePoint( display.CenterMiddleReferencePoint )
			text.y = row.height * 0.5
			text.x = display.contentWidth*0.82
			text:setTextColor( 0 )
			rowGroup:insert( text )
		else
			--Titre Colonne1
			local text = display.newRetinaText( colonne1Titre, 0, 0, "Fontastique", 14 )
			text:setReferencePoint( display.CenterMiddleReferencePoint )
			text.y = row.height * 0.5
			text.x = display.contentWidth*0.16
			text:setTextColor( 255, 255, 255 )
			rowGroup:insert( text )
			
			--Titre Colonne2
			text = display.newRetinaText( colonne2Titre, 0, 0, "Fontastique", 14 )
			text:setReferencePoint( display.CenterMiddleReferencePoint )
			text.y = row.height * 0.5
			text.x = display.contentWidth*0.5
			text:setTextColor( 255, 255, 255 )
			rowGroup:insert( text )
			
			--Titre Colonne3
			text = display.newRetinaText( colonne3Titre, 0, 0, "Fontastique", 14 )
			text:setReferencePoint( display.CenterMiddleReferencePoint )
			text.y = row.height * 0.5
			text.x = display.contentWidth*0.82
			text:setTextColor( 255, 255, 255 )
			rowGroup:insert( text )
		end
	end
	
	--Insert widgets/images into a group
	localGroup:insert( list )
	
	function networkListenerAjout( event )
		if ( event.isError ) then
			colonne1Contenu = "Network Error"
			colonne2Contenu = ""
			colonne3Contenu = ""
			displayError()
		else
			network.request( "http://12h52.fr/aquatrail/list.php?world="..tempInfos.World.."&stage="..tempInfos.Level.."", "GET", networkListener )
		end
	end
	network.request( "http://12h52.fr/aquatrail/ajout.php?login="..tempInfos.Login.."&score="..tempInfos.Score.."&adress="..tempInfos.Uid.."&world="..tempInfos.World.."&stage="..tempInfos.Level.."", "GET", networkListenerAjout )
	
	function networkListener( event )
        if ( event.isError ) then
                colonne1Contenu = "Network Error"
				colonne2Contenu = ""
				colonne3Contenu = ""
				displayError()
        else
                myNewData = event.response
                print ("From server: "..myNewData)
                decodedData = (json.decode( myNewData)) 
				if (decodedData.error == nil) then
					local index = decodedData.index - 1
					createCategory()
					print(worldinfo.Uid)
					for i=1, index, 1 do
						colonne1Contenu = i
						colonne2Contenu = decodedData["row"..i].login
						if(afficheScore.ongletActif == 1)
						then
							colonne3Contenu = decodedData["row"..i].score
						else
							colonne3Contenu = decodedData["row"..i].time
						end
						refreshData(decodedData["row"..i], i)
					end
				else
					colonne1Contenu = "Pas de données"
					colonne2Contenu = ""
					colonne3Contenu = ""
					displayWarning()
				end
        end
	end

	function displayError()
		
		isCategory = false; rowHeight = 34; rowColor={ 255, 0, 0, 255 }; lineColor={0, 56, 112, 255}
		list:insertRow
		{
			isCategory = isCategory,
			onRender = onRowRender,
			height = rowHeight,
			rowColor = rowColor,
			lineColor = lineColor
		}
		
	end
	
	function displayWarning()
		
		isCategory = false; rowHeight = 34; rowColor={ 255, 255, 0, 255 }; lineColor={0, 56, 112, 255}
		list:insertRow
		{
			isCategory = isCategory,
			onRender = onRowRender,
			height = rowHeight,
			rowColor = rowColor,
			lineColor = lineColor
		}
		
	end
	
	function createCategory()
		
		isCategory = true; rowHeight = 34; rowColor={ 0, 56, 112, 255 }; lineColor={0, 56, 112, 255}
		list:insertRow
		{
			isCategory = isCategory,
			onRender = onRowRender,
			height = rowHeight,
			rowColor = rowColor,
			lineColor = lineColor
		}
		
	end

	function refreshData(playerData, index)

		isCategory = false
		rowHeight = 30
		lineColor = {0, 56, 112, 255}
		
		print(playerData.adress)
		if ( playerData.adress == worldinfo.Uid )
		then
			color = 127
			rowColor = {0,0,0,155}
		else
			color = 0
			rowColor = {255,255,255,100}
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

	function refresh()
		apparenceOngletActif ()
		list:deleteAllRows()
		network.request( "http://12h52.fr/aquatrail/list.php?world="..afficheScore.mondeChoisi.."&stage="..afficheScore.nivChoisi.."", "GET", networkListener )
	end
	
btnScore:addEventListener ("tap", refresh)
btnTemps:addEventListener ("tap", refresh)
btnProgression:addEventListener ("tap", refresh)	

--Affichage initial
timer.performWithDelay( 0, apparenceOngletActif )
--timer.performWithDelay( 0, ongletActif )


	-- Bouton retour
	local reBtn = display.newImage(boutonRetour)
   reBtn.isVisible = true
   reBtn:setReferencePoint(display.BottomLeftReferencePoint)
   reBtn.x = 15
   reBtn.y = display.contentHeight - 15
   
   
	
	--Return Button
	local function pressReturn (event)
		if (event.phase == "ended") then
			if(tempInfos.World=="1") then 
				director:changeScene ("IceWorld")
			elseif(tempInfos.World=="2") then 
				director:changeScene ("DesertWorld")
			elseif(tempInfos.World=="4") then 
				director:changeScene ("IslandWorld") -- a verifier
			elseif(tempInfos.World=="3") then 
				director:changeScene ("ForestWorld")
			end
		end
	end
	reBtn:addEventListener ("touch", pressReturn)
	localGroup:insert(reBtn)
  
	-- MUST return a display.newGroup()
	return localGroup
end
	


