module(..., package.seeall)

-- CONSTANTS,VARIABLES, REQUIREMENTS ---------------------------------------------------------


--Les scores
--Debut fin de niveau avec timer
--
---Choisir les 2 etats dans lesquels on switch
	--Liq-Sol ou Liq-Gaz ou Sol-Nuage

	
	
	
	
	
local EtatHero = 0 --0 pour Etat liquide, 1 pour Etat Solide, 2 pour Etat Vapeur

--Etat Liquide

local STATE_WALKING_LIQ = "WalkingLiq"
local STATE_JUMPING_LIQ = "JumpingLiq"
local doubleSaut = true


--Etat Solide
local STATE_WALKING_SOL = "WalkingSol"
local STATE_JUMPING_SOL = "JumpingSol"
local BriseGlace = false
local chargesol = true

--Etat Gazeu
local STATE_WALKING_GAZ = "WalkingGaz"
local STATE_JUMPING_GAZ = "JumpingGaz"
local gagnerAlt = false--gagner de l'altitude

--Transition Etat
local STATE_TRANSITIONLIQSOL = "TransitionLiqSol"
local STATE_TRANSITIONSOLLIQ = "TransitionSolLiq"

local DIRECTION_LEFT = -1
local DIRECTION_RIGHT = 1
local SCORE = 0local TIME = 0local LEVEL = {}

local BASESPEEDSOLIDE=30
local BASESPEEDLIQUIDE=30
local BASEJUMPSOLIDE= 5
local BASEJUMPLIQUIDE= 5

--local player.globalJump
--local player.globalSpeed


local ui = require("ui")
local Gesture = require("lib_gesture")
require("physics")

physics.start()


-- Load Lime
local lime = require("lime")
-- Disable culling
lime.enableScreenCulling()

local map
local player
local visual 
local physical

local pointsTable = {}
local stalactiteTable = {}
local stalacmiteTable = {}
local line

local scoreElement

local maintheme = audio.loadSound( "themeglace.mp3" )
local b_stalactite = audio.loadSound( "b_stalactite.mp3" )
local b_saut = audio.loadSound( "b_saut.mp3" )
local b_gouttelette = audio.loadSound( "b_gouttelette.mp3" )

------------------------------------------------------------------------------------

local createMap = function( urlMap, scoreEl, level )


	map = lime.loadMap(urlMap)
	local onPlayerProperty = function(property, type, object)
		player = object.sprite
	end		LEVEL = level
	
	SCORE=0
	scoreElement = scoreEl 
	scoreElement.text = "score: "..SCORE

	map:setFocus( player )
	map:addPropertyListener("IsPlayer", onPlayerProperty)

	-- Create the visual
	visual = lime.createVisual(map)

	-- Build the physical
	physical = lime.buildPhysical(map)
	
	--physics.setDrawMode( "hybrid" )
	
    --lancer le theme principal
	audio.play(maintheme,{loops=-1})
	
	local function changeStalactiteBodyType(body)
		body.isAwake = true
		body.isBodyActive = true
		body.sprite.bodyType = "dynamic"
		--print(body.sprite.bodyType)
	end
	
	--COLLISION --------------------------------------------------------------------------------------------------------
	 function onCollision(self, event )
	
	 	if ( event.phase == "began" ) then	 	   if event.other.IsEnd then	 	   	--En envoi les infos la fonction endLevel qui va se charger de sauvegarder le score et le temps par la suite et debloquer le prochain niveau	 	   	print("FIN DU NIVEAU")	 	   	LEVEL:endLevel(SCORE,TIME)	 	end	 	
		if event.other.IsGround then
			--print("Ground");
			player.canJump = true
			if EtatHero == 0 then
				doubleSaut = true
			elseif EtatHero == 1 then
				chargesol = true
			elseif EtatHero == 2 then
				gagnerAlt = true
			end
			if player.state == STATE_JUMPING_LIQ or  player.state == STATE_JUMPING_SOL then
				if EtatHero == 0 then
					player.state = STATE_WALKING_LIQ
				elseif EtatHero ==1 then
					player.state = STATE_WALKING_SOL
				end

				player:prepare("anim" .. player.state)
				player:play()
			end
		elseif event.other.IsObstacle then
		
		elseif event.other.DeclencherStalactite then
			print("COUCOUDeclencherStalactite")
			for i=0, #stalactiteTable, 1 do
				timer.performWithDelay(500, changeStalactiteBodyType(stalactiteTable[i]))
			end
			event.other:removeSelf()
		elseif event.other.IsCollectable then
			local item = event.other
			local onTransitionEnd = function(transitionEvent)
				if transitionEvent["removeSelf"] then
					transitionEvent:removeSelf()
				end
			end	
			-- Fade out the item
			transition.to(item, {time = 500, alpha = 0, onComplete=onTransitionEnd})
			local text = nil
			audio.play(b_gouttelette)
			if (item.Score) then
				SCORE=SCORE+item.Score
				--print(item.Score)
				scoreElement.text = "score: "..SCORE
			elseif item.pickupType == "health" then
				text = display.newText( item.healthValue .. " Extra Health!", 0, 0, "Helvetica", 50 )
			end
			if text then
				text:setTextColor(0, 0, 0, 255)
				text.x = display.contentCenterX
				text.y = display.contentCenterY
				transition.to(text, {time = 1000, alpha = 0, onComplete=onTransitionEnd})
			end
		elseif event.other.IsDestructible then
			print("brise stalactite")
			if EtatHero == 1 then
				local stalacti = event.other

				local onTransitionEnd = function(transitionEvent)
				if transitionEvent["removeSelf"] then
					transitionEvent:removeSelf()
				end
			end
			-- Fade out the stalacti
			transition.to(stalacti, {time = 0, alpha = 0, onComplete=onTransitionEnd})
			audio.play(b_stalactite)
		end
		end
		if event.other.IsSmashable then
			--print("IsSmashable");
			if EtatHero == 1 and BriseGlace then
				local stalacti = event.other

				local onTransitionEnd = function(transitionEvent)
				if transitionEvent["removeSelf"] then
					transitionEvent:removeSelf()
				end
				transition.to(stalacti, {time = 500, alpha = 0, onComplete=onTransitionEnd})
				end
			end
		end
		if event.other.IsChangeVitesse then
			BASESPEEDLIQUIDE=30*event.other.bonusSpeedLiq
			BASEJUMPLIQUIDE=30*event.other.bonusJumpLiq
			BASESPEEDSOLIDE=30*event.other.bonusSpeedSol
			BASEJUMPSOLIDE=30*event.other.bonusJumpSol
		end
		if event.other.IsFrozen then
			--Jouer l'animation de gele lac
			if EtatHero == 1 then
				local lac = event.other

				local onGeleLacEnd = function(onGeleLacEndEvent)
				if onGeleLacEndEvent["removeSelf"] then
					onGeleLacEndEvent:removeSelf()
				end
			end
			-- Fade out the stalacti
			transition.to(lac, {time = 500, alpha = 0, onComplete=onGeleLacEnd})
		end
		elseif event.other.IsNotFrozen then
			BASESPEEDSOLIDE=30
			BASESPEEDLIQUIDE=30
			BASEJUMPSOLIDE= 5
			BASEJUMPLIQUIDE= 5
		end
		elseif ( event.phase == "ended" ) then
			if event.other.IsGround then
				--print("isground ended")
				player.canJump = false
			end
	 	end
	end
	
	player.collision = onCollision
	player:addEventListener( "collision", player )
	
	-- UPDATE----------------------------------------------------------------------
	 onUpdate = function(event)
		
		--L'animation animTransition est enclencher?
		if player.sequence == "animTransitionLiqSol" or player.sequence == "animTransitionSolLiq" then
			--Le sprite est il entrain d'executer une animation?
			if player.animating  then
				--Le sprite a il fini son animation?
				if player.currentFrame ==4 then
					if EtatHero == 0 then
						player.state = STATE_WALKING_LIQ
					elseif EtatHero ==1 then
						player.state = STATE_WALKING_SOL
					end
					player.direction = DIRECTION_RIGHT
					--print("anim" .. player.state)
					player:prepare("anim" .. player.state)
					player:play()
				end
			end
		end
		
		local vx, vy = player:getLinearVelocity()
		--print("vx "..vx)
		local speed=30
		local jump=30
		if (EtatHero==0)then
			speed = BASESPEEDLIQUIDE
			--print (BASESPEEDLIQUIDE)
		elseif ( EtatHero==1)then
			speed = BASESPEEDSOLIDE
			--print (BASESPEEDSOLIDE)
		end
		--scrolling
		--check si il y a eu collision (direction positive vitesse negative)
		if ((player.direction == 1 and vx <0)or(player.direction == -1 and vx >0)) then
			player:setLinearVelocity(speed*player.globalSpeed, vy)
		else
				if (vx>=0 and vx<1)then
					player:applyForce( player.direction*10, 0, player.x, player.y )
				elseif (vx<speed*player.globalSpeed ) then
					player:setLinearVelocity(vx * 1.15, vy)

				else
					player:setLinearVelocity(speed*player.globalSpeed, vy)
				end
		end
		-- Update the map. Needed for using map:setFocus()
		map:setFocus( player )	
		map:update( event )
	end
	Runtime:addEventListener("enterFrame", onUpdate)
	local function checkEndTransition( )
		--print("okay")
	end
	-- TOUCH--------------------------------------------------------------------------
	 onTouch = function(event)
		if ( event.phase == "began" ) then
			--print("ChangeEtat")
	      	if EtatHero == 0 then
		    	EtatHero = 1
				doubleSaut = false
				player.state = STATE_TRANSITIONLIQSOL
		      	--print("Etat Solide")
	       	elseif EtatHero ==1 then
		      	EtatHero =0
				doubleSaut = true
				player.state = STATE_TRANSITIONSOLLIQ
		      	--print("Etat Liquide")
	      	end
		end
		ChangePlayerDynamic()
		player.direction = DIRECTION_RIGHT
		--print("anim" .. player.state)
		player:prepare("anim" .. player.state)
		player:play()
	end
	--player:addEventListener("touch", onTouch)
	
	function ChangePlayerDynamic()
 		local vx, vy = player:getLinearVelocity()
		if EtatHero == 0 then
		    	physics.removeBody( player )
		    	physics.addBody( player, { density=player.densityLiq, friction=player. frictionLiq, bounce=player. bounceLiq} )  -- manuel ,shape={0,0,20,0,20,20,0,20}} ) 
		    	player.isFixedRotation = true
		    --print("Etat Solide")
		elseif EtatHero ==1 then

      	physics.removeBody( player )
		   physics.addBody( player, { density=player.densityGla, friction=player. frictionGla, bounce=player. bounceGla} )
		   player.isFixedRotation = true
		end
		player:setLinearVelocity(vx, vy)
	end
	function changeraltGaz() 
		if gagnerAlt == true then
			player:applyLinearImpulse(0, -4, player.x, player.y)
			timer.performWithDelay( 100, changeraltGaz, 1 )
		end
	end
	--Fonction de saut !
	--
	function ToucheScreen (event)
			local vx, vy = player:getLinearVelocity() -- on recup la velociter du hero
			if ( event.phase == "began" ) then
					if event.x - display.contentWidth/2 >0 then
						--Check Doublesaut
						--
						if EtatHero == 0 then
							if player.canJump == false and doubleSaut == true then
								player.canJump = true
								doubleSaut=false 
							end
						elseif EtatHero == 1 and chargesol == true then
						
						
						elseif EtatHero == 2 then
							gagnerAlt = true
							timer.performWithDelay( 1000, changeraltGaz, 1 )
						end
						
						local jump
						if (EtatHero==0)then
							jump = BASEJUMPLIQUIDE
						elseif ( EtatHero==1)then
							jump = BASEJUMPSOLIDE
						end
							
						if player.canJump then
							player:setLinearVelocity(vx , 0)--on reset limpulse y pour pas qu'il sembale et saute n'importe comment!
							player:applyLinearImpulse(0, -(jump*player.globalJump), player.x, player.y)
							audio.play(b_saut)
							if EtatHero == 0 then
								player.state = STATE_JUMPING_LIQ
							elseif EtatHero ==1 then
								player.state = STATE_JUMPING_SOL
							elseif EtatHero ==2 then
								player.state = STATE_JUMPING_GAZ
							end
							player.canJump = false
							player:prepare("anim" .. player.state)
							player:play()
						--si je suis en glaçon et que je peu charger
						elseif EtatHero == 1 and chargesol == true then 
							chargesol = false
							player:applyLinearImpulse(0, 30, player.x, player.y)
							BriseGlace=true
							print("Charge")
							timer.performWithDelay( 1000, function() BriseGlace=false end, 1 )
						end
					else--Si c'est pas la partie droite, alors c'est la partie gauche du device je change d'Etat
						if ( event.phase == "began" ) then
							--print("ChangeEtat")
							if EtatHero == 0 then
								EtatHero = 1
								doubleSaut = false
								player.state = STATE_TRANSITIONLIQSOL 
								--print("Etat Solide")
							elseif EtatHero ==1 then
								EtatHero =0
								doubleSaut = true
								--print("Etat Liquide")
								player.state = STATE_TRANSITIONSOLLIQ
							end
						end
						ChangePlayerDynamic()
						player.direction = DIRECTION_RIGHT
						--print("anim" .. player.state)
						player:prepare("anim" .. player.state)
						player:play()
					end
			end
			if ( event.phase == "ended" ) then
				gagnerAlt = false
			end

	end
	Runtime:addEventListener("touch", ToucheScreen)

	--PLAYER INIT-----------------------------------------------------------------------
	if EtatHero == 0 then
		player.state = STATE_WALKING_LIQ 
	elseif EtatHero ==1 then
		player.state = STATE_WALKING_SOL
	end
	ChangePlayerDynamic()
	player.direction = DIRECTION_RIGHT
	--print("anim" .. player.state)
	player:prepare("anim" .. player.state)
	player:play()

	
	--drawLine gesturelib
	--
	 function drawLine ()

		if (line and #pointsTable > 2) then
			line:removeSelf()
		end
		
		local numPoints = #pointsTable
		local nl = {}
		local  j, p
			 
		nl[1] = pointsTable[1]
			 
		j = 2
		p = 1
			 
		for  i = 2, numPoints, 1  do
			nl[j] = pointsTable[i]
			j = j+1
			p = i 
		end
		
		if ( p  < numPoints -1 ) then
			nl[j] = pointsTable[numPoints-1]
		end
		
		if #nl > 2 then
				line = display.newLine(nl[1].x,nl[1].y,nl[2].x,nl[2].y)
				for i = 3, #nl, 1 do 
					line:append( nl[i].x,nl[i].y);
				end
				line:setColor(255,255,0)
				line.width=5
		end
	end	
	 function UpdateGesturelib(event)		
		if "began" == event.phase then
			pointsTable = nil
			pointsTable = {}
			local pt = {}
			pt.x = event.x
			pt.y = event.y
			table.insert(pointsTable,pt)
		
		elseif "moved" == event.phase then
		
			local pt = {}
			pt.x = event.x
			pt.y = event.y
			table.insert(pointsTable,pt)
			if EtatHero == 1 and (event.x - (480/2)-50) >0
			then
				--drawLine ()
			end
			
		elseif "ended" == event.phase or "cancelled" == event.phase then
				--drawLine ()
				if EtatHero == 1 and (event.x - (480/2)-50) >0
				then
					--myText.text = "Test : "..Gesture.GestureResult()
					--Si on fait un "slash vers bas" alors on fait la capacit� sp�cial du gla�on
					if Gesture.GestureResult() == "SwipeD"
					then
						--print("impulse bas")
						player:applyLinearImpulse(0, 30, player.x, player.y)
						BriseGlace=true
						--print("BriseGlace=true")
						timer.performWithDelay( 1000, function() BriseGlace=false end, 1 )
					end
				end
		end
	end
--Pas d'utilisation de gesturelib donc on comment
--Runtime:addEventListener( "touch", UpdateGesturelib )

-- STALACTITES

local layer = map:getTileLayer("Platforms")
stalactiteTable = {}
stalacmiteTable = {}
-- Make sure we actually have a layer
	if(layer) then
        -- Get all the tiles on this layer
        local tiles = layer.tiles
        -- Make sure tiles is not nil
        if(tiles) then

                -- Loop through all our tiles on this layer     
                local j=0
                for i=1, #tiles, 1 do
                        -- Check if the tile is a stalactite
                        if(tiles[i].IsStalactite) then
							-- Store off a copy of the tile
							--print(tiles[i].." "..tiles[i].sprite)
							stalactiteTable[j]=tiles[i]
							physics.addBody( tiles[i].sprite, { density=2, friction=0.1, bounce=0.1} ) 
							tiles[i].sprite.isFixedRotation = true
							tiles[i].sprite.bodyType = "static"
							j=j+1
                        end
						if(tiles[i].IsStalacmite) then
							-- Store off a copy of the tile
							--print(tiles[i].." "..tiles[i].sprite)
							print("IsStalacmite"..i)
							tiles[i].isSensor = true
							stalacmiteTable[j]=tiles[i]
							j=j+1
                        end
                end
        end   
	end
 function stalacmiteisSensor (bool)
 
 end
-- ANIMATIONS---------------------------------------------

--lance les animations :
	
	local layer = map:getTileLayer("Platforms")
 
-- Make sure we actually have a layer
	if(layer) then
 
        -- Get all the tiles on this layer
        local tiles = layer.tiles
        
        -- Make sure tiles is not nil
        if(tiles) then
                
                -- Loop through all our tiles on this layer     
                for i=1, #tiles, 1 do
                        -- Check if the tile is animated (note the capitilisation)
                        if(tiles[i].IsAnimated) then
                                -- Store off a copy of the tile
                                local tile = tiles[i]
                                
                                -- Check if the tile has a property named "animation1", our sequence
                                if(tile.animation1) then
                                        
                                        -- Prepare it through the sprite
                                        tile.sprite:prepare("animation1")
                                        
                                        -- Now finally play it
                                        tile.sprite:play()
                                end
                        end
                end
        end     
end

	return visual
	
end

local stopEvents = function(   )
	Runtime:removeEventListener("enterFrame", onUpdate)
	--Runtime:removeEventListener( "touch", UpdateGesturelib)
	Runtime:removeEventListener("touch", ToucheScreen)
end

local GameLogic = { createMap = createMap, stopEvents = stopEvents, updateScore=updateScore}

return GameLogic


