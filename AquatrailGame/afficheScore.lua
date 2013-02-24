module(..., package.seeall)
--AFFICHESCORE--
afficheScore = {}

afficheScore.scoreGlace = false
afficheScore.scoreForet = false
afficheScore.scoreIle = false
afficheScore.scoreDesert = false

afficheScore.ongletScore = true
afficheScore.ongletTemps = false
afficheScore.ongletProgression = false
afficheScore.ongletActif = 1

afficheScore.scoreGlaceNiv = {false,false,false,false,false,false}
afficheScore.scoreForetNiv = {false,false,false,false,false,false}
afficheScore.scoreIleNiv = {false,false,false,false,false,false}
afficheScore.scoreDesertNiv = {false,false,false,false,false,false}
afficheScore.nivChoisi = 1

afficheScore.monScore = true

local setMondeChoisi = function (monde)
	afficheScore.scoreGlace = false
	afficheScore.scoreForet = false
	afficheScore.scoreIle = false
	afficheScore.scoreDesert = false
	
	if(monde == "glace") then afficheScore.scoreGlace = true
	elseif(monde == "foret") then afficheScore.scoreForet = true
	elseif(monde == "ile") then afficheScore.scoreIle = true
	elseif(monde == "desert") then afficheScore.scoreDesert = true
	else print("Monde non reconnu") end
end

local setNivChoisi = function(niveau)
	afficheScore.nivChoisi = niveau
	
	for i=0, 6
	do
		afficheScore.scoreGlaceNiv[i] = false
		afficheScore.scoreForetNiv[i] = false
		afficheScore.scoreIleNiv[i] = false
		afficheScore.scoreDesertNiv[i] = false
	end
	
	if(afficheScore.scoreGlace) then afficheScore.scoreGlaceNiv[niveau] = true end
	if(afficheScore.scoreForet) then afficheScore.scoreForetNiv[niveau] = true end
	if(afficheScore.scoreIle) then afficheScore.scoreIleNiv[niveau] = true end
	if(afficheScore.scoreDesert) then afficheScore.scoreDesertNiv[niveau] = true end
 end
 
 local setOngletChoisi = function(onglet)
	afficheScore.ongletScore = false
	afficheScore.ongletTemps = false
	afficheScore.ongletProgression = false
	afficheScore.ongletActif = onglet
	
	if(onglet == 1) then afficheScore.ongletScore = true end
	if(onglet == 2) then afficheScore.ongletTemps = true end
	if(onglet == 3) then afficheScore.ongletProgression = true end
 end
 
 local setToMonScore = function (monScore)
	if(monScore) then afficheScore.monScore = true 
	else afficheScore.monScore = false end
 end
 
 local getAfficheScore = function()
	return afficheScore
 end
 
 local AfficheScore = { setMondeChoisi=setMondeChoisi, setNivChoisi=setNivChoisi, setOngletChoisi=setOngletChoisi, getAfficheScore=getAfficheScore, setToMonScore=setToMonScore}
 
 return AfficheScore
 