--CHARGEMENT--
--Creation d'une "classe" Load

local sprite = require "sprite"

	Load = {}
	Load.spriteSheet = sprite.newSpriteSheet("chargement.png", 77, 77)
	Load.spriteSet = sprite.newSpriteSet(Load.spriteSheet, 1, 6)
	Load.chargement = sprite.newSprite( Load.spriteSet )

	--Preload de l'animation de chargement
local preLoadAnim = function ()
	sprite.add( Load.spriteSet, "chargement", 1, 6, 900, 0)
	Load.chargement = sprite.newSprite( Load.spriteSet )
	Load.chargement.isVisible = false
	Load.chargement:setReferencePoint( display.BottomRightReferencePoint )
	Load.chargement.x = display.contentWidth - 10
	Load.chargement.y = display.contentHeight - 10
	Load.chargement:prepare("chargement")
end

local play = function ()
	Load.chargement.isVisible = true
	Load.chargement:play()
end

 local Loading = { play=play, preLoadAnim=preLoadAnim }
 
 return Loading
	
--Fin de la "classe" Load