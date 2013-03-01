--CHARGEMENT--
--Creation d'une "classe" Load

local sprite = require "sprite"

	Load = {}
	Load.spriteSheet = sprite.newSpriteSheet("chargement-30px.png", 30, 30)
	Load.spriteSet = sprite.newSpriteSet(Load.spriteSheet, 1, 6)
	

	--Preload de l'animation de chargement
local preLoadAnim = function ()
	sprite.add( Load.spriteSet, "chargement", 1, 6, 900, 0)
	
	Load.chargement = sprite.newSprite( Load.spriteSet )
	Load.chargement.isVisible = false
	Load.chargement:setReferencePoint( display.CenterLeftReferencePoint )
	
	Load.textChargement = display.newText( "Chargement...", 0, 0, "Fontastique", 16 )
	Load.textChargement.isVisible = false
	Load.textChargement:setTextColor(255, 255, 255)
	Load.textChargement:setReferencePoint(display.CenterLeftReferencePoint)
	
	Load.chargement.x = 10
	Load.chargement.y = Load.chargement.height*0.5 + 10
	Load.chargement:prepare("chargement")
	
	Load.textChargement.x = Load.chargement.width + 20
	Load.textChargement.y = Load.chargement.height*0.5 + 10
end

local play = function ()
	Load.textChargement.isVisible = true
	Load.chargement.isVisible = true
	Load.chargement:play()
end

 local Loading = { play=play, preLoadAnim=preLoadAnim }
 
 return Loading
	
--Fin de la "classe" Load