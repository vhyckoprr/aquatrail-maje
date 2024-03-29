module(..., package.seeall)

-- CONSTANTS,VARIABLES, REQUIREMENTS ---------------------------------------------------------

--Etat de jeu
--
local GAMESTATE

local STATE_STARTLEVEL = "startlevel"
local STATE_PLAY = "play"
local STATE_PAUSE = "pause"
local STATE_ENDLEVEL = "endlevel"


local EcranTutoG = require("EcranTutoG")

--Les scores
--


---Choisir les 2 etats dans lesquels on switch
--Liq-Sol ou Liq-Gaz ou Sol-Gaz
local STATECHANGE

local LIQSOL = "LiqSol"
local LIQGAZ = "LiqGaz"
local SOLGAZ = "SolGaz"
	
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
local STATE_PLUIE = "Pluie"
local gagnerAlt = false--gagner de l'altitude
local arroser = false

--Transition Etat
local STATE_TRANSITIONLIQSOL = "TransitionLiqSol"
local STATE_TRANSITIONSOLLIQ = "TransitionSolLiq"
local STATE_TRANSITIONLIQGAZ = "TransitionLiqGaz"
local STATE_TRANSITIONGAZLIQ = "TransitionGazLiq"
local STATE_TRANSITIONSOLGAZ = "TransitionSolGaz"
local STATE_TRANSITIONGAZSOL = "TransitionGazSol"

local STATE_ANIMATIONENCOURS = false

local DIRECTION_LEFT = -1
local DIRECTION_RIGHT = 1
local SCORE = 0local TIME = 0
local POUVOIRVENT = 5
local fpairs = ipairslocal LEVEL = {}

local BASESPEEDSOLIDE=30
local BASESPEEDLIQUIDE=30
local BASEJUMPSOLIDE= 5
local BASEJUMPLIQUIDE= 5
local BASESPEEDGAZ= 5
local BASEFLYGAZ= 0.02

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
local paused = false

local pointsTable = {}
local stalactiteTable = {}
local stalacmiteTable = {}
local line
local Arrosable  = {}

local scoreElement

local maintheme = audio.loadSound( "themeglace.mp3" )
local b_stalactite = audio.loadSound( "b_stalactite.mp3" )
local b_saut = audio.loadSound( "b_saut.mp3" )
local b_gouttelette = audio.loadSound( "b_gouttelette.mp3" )
local startlevel = audio.loadSound( "debut_niveau.mp3" )

local worldinfo = profile.getInfos()
audio.setVolume(worldinfo.bruitage*0.01)
audio.setVolume(worldinfo.sound*0.01, { channel=1 })


------------------------------------------------------------------------------------

local createMap = function( urlMap, scoreEl, level, statehero, typeMap)
	STATECHANGE = statehero
	GAMESTATE = STATE_STARTLEVEL
	STATE_ANIMATIONENCOURS = true
	local pauseBUTTON = display.newImage ("Bouton-Pause-HUD.png")
	pauseBUTTON.x = display.contentWidth - (pauseBUTTON.width / 2)
	pauseBUTTON.y = pauseBUTTON.height / 2
	
	--start FPS show
	--
	--local prevTime = system.getTimer()
	--local fps = display.newText( "30", 30, 47, nil, 24 )
	--fps:setTextColor( 255 )
	--fps.prevTime = prevTime
	--
	--
	map = lime.loadMap(urlMap)
	
	if STATECHANGE == LIQSOL then
		EtatHero = 0
	elseif STATECHANGE == LIQGAZ then
		EtatHero = 0
	elseif STATECHANGE == SOLGAZ then
		EtatHero = 1
	end
	
	
	local onPlayerProperty = function(property, type, object)
		player = object.sprite
	end
		--
	--animation walk en fonction de letat de depart, ex: Liqsol commence par walkliq
	--
		LEVEL = level
	
	SCORE=0
	scoreElement = scoreEl 
	scoreElement.text = "Score : "..SCORE

	map:setFocus( player )
	map:addPropertyListener("IsPlayer", onPlayerProperty)

	-- Create the visual
	visual = lime.createVisual(map)

	-- Build the physical
	physical = lime.buildPhysical(map)
	
	--physics.setDrawMode( "hybrid" )
	
    --lancer le theme principal
	audio.play(maintheme,{loops=-1, channel=1})
	
	local function changeStalactiteBodyType(body)
		body.isAwake = true
		body.isBodyActive = true
		body.sprite.bodyType = "dynamic"
		--print(body.sprite.bodyType)
	end
	
	local layerPlatforms = map:getTileLayer("Platforms")
	-- local layerCastle = map:getTileLayer("Castle")
	local alltilesPlatforms = layerPlatforms.tiles
	-- local alltilesCastle = layerCastle.tiles
	print("layerPlatforms "..#alltilesPlatforms)
	-- print("layerCastle "..#alltilesCastle)
	
	local function clear ()
		print("clear"..#alltilesPlatforms)
		for i=0,#alltilesPlatforms,1 do
			if alltilesPlatforms[i]:isOnScreen () then
				--alltilesPlatforms[i]:destroy ()
			end
		end
		timer.performWithDelay( 2000, clear, 1 )
	end
	
	--COLLISION --------------------------------------------------------------------------------------------------------
	function onCollision(self, event )
	--if GAMESTATE == STATE_PLAY then
	 	if ( event.phase == "began" ) then			if event.other.IsEnd then
				GAMESTATE = STATE_ENDLEVEL				--En envoi les infos la fonction endLevel qui va se charger de sauvegarder le score et le temps par la suite et debloquer le prochain niveau				print("FIN DU NIVEAU")
				player:setLinearVelocity(0,0)
				player:prepare("animEndLevel")
				player:play()
				audio.play(startlevel)
							end
			if event.other.IsGround and GAMESTATE ~= STATE_ENDLEVEL then
				--print("Ground");
				player.canJump = true
				if EtatHero == 0 then
					doubleSaut = true
				elseif EtatHero == 1 then
					chargesol = true
				elseif EtatHero == 2 then
					gagnerAlt = true
				end
				if player.state == STATE_JUMPING_LIQ or  player.state == STATE_JUMPING_SOL or  player.state == STATE_JUMPING_GAZ then
					print("animwalk")
					if EtatHero == 0 then
						player.state = STATE_WALKING_LIQ
					elseif EtatHero ==1 then
						player.state = STATE_WALKING_SOL
					elseif EtatHero ==2 then
						player.state = STATE_WALKING_GAZ
					end
					player:prepare("anim" .. player.state)
					player:play()
				end
				if event.other.IsChangeVitesse then
					if STATECHANGE == LIQSOL then
						BASESPEEDLIQUIDE=30*event.other.bonusSpeedLiq
						BASEJUMPLIQUIDE=30*event.other.bonusJumpLiq
						BASESPEEDSOLIDE=30*event.other.bonusSpeedSol
						BASEJUMPSOLIDE=30*event.other.bonusJumpSol
					elseif STATECHANGE == LIQGAZ then
						BASESPEEDLIQUIDE=30*event.other.bonusSpeedLiq
						BASEJUMPLIQUIDE=30*event.other.bonusJumpLiq
						BASESPEEDGAZ=20*event.other.bonusSpeedGaz
						BASEFLYGAZ=30*event.other.bonusFlyGaz
					elseif STATECHANGE == SOLGAZ then
						BASESPEEDSOLIDE=30*event.other.bonusSpeedSol
						BASEJUMPSOLIDE=30*event.other.bonusJumpSol
						BASESPEEDGAZ=20*event.other.bonusSpeedGaz
						BASEFLYGAZ=30*event.other.bonusFlyGaz
					end
				end
			elseif event.other.DeclencherStalactite then
				--print("COUCOUDeclencherStalactite")
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
					scoreElement.text = "Score : "..SCORE
				elseif item.pickupType == "health" then
					text = display.newText( item.healthValue .. " Extra Health!", 0, 0, "Fontastique", 50 )
				end
				if text then
					text:setTextColor(0, 0, 0, 255)
					text.x = display.contentCenterX
					text.y = display.contentCenterY
					transition.to(text, {time = 1000, alpha = 0, onComplete=onTransitionEnd})
				end
			end
		if event.other.IsNuage then
			if STATECHANGE == LIQGAZ then
				if EtatHero == 2 then
					EtatHero = 0
					doubleSaut = true
					--print("Etat Liquide")
					player.state = STATE_TRANSITIONGAZLIQ
				end
			end
		STATE_ANIMATIONENCOURS = true
		player.direction = DIRECTION_RIGHT
		player:prepare("anim" .. player.state)
		player:play()
		end
		if event.other.IsFrozen then
			print("isFrozen")
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
				BASESPEEDGAZ = 10
				BASEFLYGAZ = 0.02
		end
		if event.other.IsDestructible then
			--print("brise stalactite")
			if EtatHero == 1 then
				local stalacti = event.other
				local onTransitionEnd = function(transitionEvent)
					if transitionEvent["removeSelf"] then
						transitionEvent:removeSelf()
					end
				end
			-- Fade out the stalacti
			transition.to(stalacti, {time = 0, alpha = 0, onComplete=onTransitionEnd})
			--print(stalacti.index)
			audio.play(b_stalactite)
			end
		elseif event.other.IsSmashable then
			if EtatHero == 1 and BriseGlace then
				local stalacti = event.other
				event.other:removeSelf()
				transition.to(stalacti, {time = 500, alpha = 0, onComplete=onTransitionEnd})
				local onTransitionEnd = function(transitionEvent)
					if transitionEvent["removeSelf"] then
						transitionEvent:removeSelf()
					end
					transition.to(stalacti, {time = 500, alpha = 0, onComplete=onTransitionEnd})
				end
			end
		end
		if event.other.IsVent then
			print("Vent")
			if event.other.IsVent == "top" then
				local vx, vy = player:getLinearVelocity() -- on recup la velociter du hero
				player:applyLinearImpulse(0, -POUVOIRVENT, player.x, player.y)
			end
			if event.other.IsVent == "down" then
				local vx, vy = player:getLinearVelocity() -- on recup la velociter du hero
				player:applyLinearImpulse(0, POUVOIRVENT, player.x, player.y)
			end
			if event.other.IsVent == "left" then
				local vx, vy = player:getLinearVelocity() -- on recup la velociter du hero
				player:applyLinearImpulse(POUVOIRVENT, 0, player.x, player.y)
			end
			if event.other.IsVent == "right" then
				local vx, vy = player:getLinearVelocity() -- on recup la velociter du hero
				player:applyLinearImpulse(-POUVOIRVENT, 0, player.x, player.y)
			end
		end
		if event.other.IsArrosable and EtatHero == 2 then
			print("IsArrosable")
			arroser = true
		end
		elseif ( event.phase == "ended" ) then
			if event.other.IsGround then
				--print("isground ended")
				player.canJump = false
			end
			if event.other.IsArrosable and EtatHero == 2 then
				arroser = false
			end
	 	end
		
		
		--SUPER GOUTTELETTE
		local stopSuperGoutteEffect = function()
			BASESPEEDLIQUIDE=30
			BASEJUMPLIQUIDE=5
			BASESPEEDSOLIDE=30
			BASEJUMPSOLIDE=5
			--Augmente la vitesse de la musique et de l'animation
			local mysource = audio.getSourceFromChannel(1)
			al.Source(mysource, al.PITCH, 1.0)
			player.timeScale = 1.0
		end

		if (event.other.Name == "SuperGouttelette") 
		then
			--print ("Super Gouttelette recuperee")
			BASESPEEDLIQUIDE=36
			BASEJUMPLIQUIDE=6
			BASESPEEDSOLIDE=36
			BASEJUMPSOLIDE=6
			--Augmente la vitesse de la musique et de l'animation
			local mysource = audio.getSourceFromChannel(1)
			al.Source(mysource, al.PITCH, 1.5)
			player.timeScale = 1.5
			--Arrete le bonus dans 2 secondes
			timer.performWithDelay(2000, stopSuperGoutteEffect, 1)
		end
		
		--Boule de neige ou botte de foin disparaisse au bout de 10s
		if (event.other.Name == "boule_de_neige" or event.other.Name == "botte_de_foin") 
		then
			local bouleNeige = event.other
				local onTransitionEndBouleNeige = function(transitionEvent)
					if transitionEvent["removeSelf"] then
						transitionEvent:removeSelf()
					end
				end
			-- Fade out the bouleNeige
			transition.to(bouleNeige, {time = 500, delay= 10000, alpha = 0, onComplete=onTransitionEndBouleNeige})
		end
		
	--end	
	end
	
	player.collision = onCollision
	player:addEventListener( "collision", player )
	
	-- UPDATE----------------------------------------------------------------------
	onUpdate = function(event)
		--FPS Show
		--
		--local curTime = event.time
		--local dt = curTime - prevTime
		--prevTime = curTime
		--if ( (curTime - fps.prevTime ) > 100 ) then
			-- limit how often fps updates
		--	fps.text = string.format( '%.2f', 1000 / dt )
		--end
		--
		--
		if player.y < 80 then
			player.y = 80
			--player:setLinearVelocity(vx , 0)
		end
		--Jouer animation debut de level
		--
		if GAMESTATE == STATE_STARTLEVEL then		
			--L'animation animTransition est enclencher?
			if player.sequence == "animStartLevel" then
				--Le sprite est il entrain d'executer une animation?
				if player.animating  then
					--Le sprite a il fini son animation?
					if player.currentFrame ==6 then
						if EtatHero == 0 then
							player.state = STATE_WALKING_LIQ
						elseif EtatHero == 1 then
							player.state = STATE_WALKING_SOL
						elseif EtatHero == 2 then
							player.state = STATE_WALKING_GAZ
						end
						player.direction = DIRECTION_RIGHT
						player:prepare("anim" .. player.state)
						player:play()
						GAMESTATE = STATE_PLAY
						STATE_ANIMATIONENCOURS = false
					end
				end
			end
		end 
	 
		if GAMESTATE == STATE_ENDLEVEL then	
		STATE_ANIMATIONENCOURS = true
		--print("endlevel1")
			--L'animation animTransition est enclencher?
			if player.sequence == "animEndLevel" then
				--Le sprite est il entrain d'executer une animation?
				if player.animating  then
					print(player.currentFrame)
					--Le sprite a il fini son animation?
					if player.currentFrame ==6 then
						--print("endlevel2")
						LEVEL:endLevel(SCORE,TIME,typeMap)
					end
				end
			end
			--Evite le problème de fin de niveau (le niveau qui ne se termine pas après l'anim de fin)
			if(player.sequence ~= "animEndLevel")
			then
				LEVEL:endLevel(SCORE,TIME,typeMap)
			end
		end
		if GAMESTATE == STATE_PLAY then		
			--L'animation animTransition est enclencher?
			--Les transition liqsol et liq gaz ayant 1 frame de différence on est obliger de decomposer en 2 if différents.
			if player.sequence == "animTransitionLiqSol" 
			or player.sequence == "animTransitionSolLiq" 
			--or player.sequence == "animTransitionSolGaz" 
			--or player.sequence == "animTransitionGazSol" 
			then
				--Le sprite est il entrain d'executer une animation?
				if player.animating  then
					--Le sprite a il fini son animation?
					if player.currentFrame ==5 then
						if EtatHero == 0 then
							player.state = STATE_WALKING_LIQ
						elseif EtatHero ==1 then
							player.state = STATE_WALKING_SOL
						elseif EtatHero ==2 then
							player.state = STATE_WALKING_GAZ
						end
						STATE_ANIMATIONENCOURS = false
						player.direction = DIRECTION_RIGHT
						--print("anim" .. player.state)
						player:prepare("anim" .. player.state)
						player:play()
					end
				end
			end
			if player.sequence == "animTransitionGazLiq" 
			or player.sequence == "animTransitionLiqGaz" 
			then
				--Le sprite est il entrain d'executer une animation?
				if player.animating  then
					--Le sprite a il fini son animation?
					if player.currentFrame ==6 then
						if EtatHero == 0 then
							player.state = STATE_WALKING_LIQ
						elseif EtatHero ==1 then
							player.state = STATE_WALKING_SOL
						elseif EtatHero ==2 then
							player.state = STATE_WALKING_GAZ
						end
						STATE_ANIMATIONENCOURS = false
						player.direction = DIRECTION_RIGHT
						--print("anim" .. player.state)
						player:prepare("anim" .. player.state)
						player:play()
					end
				end
			end
			if player.sequence == "animPluie" 
			then
				--Le sprite est il entrain d'executer une animation?
				if player.animating  then
					--Le sprite a il fini son animation?
					if player.currentFrame ==4 then
						if EtatHero == 0 then
							player.state = STATE_WALKING_LIQ
						elseif EtatHero ==1 then
							player.state = STATE_WALKING_SOL
						elseif EtatHero ==2 then
							player.state = STATE_WALKING_GAZ
						end
						STATE_ANIMATIONENCOURS = false
						player.direction = DIRECTION_RIGHT
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
			elseif ( EtatHero==2)then
				speed = BASESPEEDGAZ
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
		end
		map:setFocus( player )	
		map:update( event )
		
	end
	Runtime:addEventListener("enterFrame", onUpdate)
	
	local function checkEndTransition( )
		--print("okay")
	end
	
	function ChangePlayerDynamic()
 		local vx, vy = player:getLinearVelocity()
		if EtatHero == 0 then
			physics.removeBody( player )
			physics.addBody( player, { density=player.densityLiq, friction=player.frictionLiq, bounce=player.bounceLiq} )  -- manuel ,shape={0,0,20,0,20,20,0,20}} ) 
			player.isFixedRotation = true
		    --print("Etat Solide")
		elseif EtatHero == 1 then
		    physics.removeBody( player )
		    physics.addBody( player, { density=player.densityGla, friction=player.frictionGla, bounce=player.bounceGla} )
		    player.isFixedRotation = true
		elseif EtatHero == 2 then
		    physics.removeBody( player )
		    physics.addBody( player, { density=player.densityGaz, friction=player.frictionGaz, bounce=player.bounceGaz} )
		    player.isFixedRotation = true
		end
		player:setLinearVelocity(vx, vy)
	end
	
	function changeraltGaz() 
		if gagnerAlt == true then
			--print(player.y)
			player:applyLinearImpulse(0, -3, player.x, player.y)
			timer.performWithDelay( 100, changeraltGaz, 1 )
			
		end
	end
	
	--Fonction de saut !
	function ToucheScreen (event)
		if GAMESTATE == STATE_PLAY then
			local vx, vy = player:getLinearVelocity() -- on recup la velociter du hero
			if ( event.phase == "began" ) then
					if event.x - display.contentWidth/2 >0 
					and STATE_ANIMATIONENCOURS == false
					then
						if event.x < display.contentWidth - pauseBUTTON.width or  event.y > pauseBUTTON.height then
							--Check Doublesaut
							--
							if EtatHero == 0 then
								if player.canJump == false and doubleSaut == true then
									player.canJump = true
									doubleSaut=false 
								end
							elseif EtatHero == 1 and chargesol == true then
							
							
							elseif EtatHero == 2 then
								if event.y - display.contentHeight/2 >0 then
									player.state = STATE_JUMPING_GAZ
									player:prepare("anim" .. player.state)
									player:play()
									gagnerAlt = true
									timer.performWithDelay( 0, changeraltGaz, 1 )
									print("monte alt")
								else
									player.state = STATE_PLUIE
									player:prepare("anim" .. player.state)
									player:play()
									STATE_ANIMATIONENCOURS = true
									if arroser then 
										print("fleur pousse")
										--Arrosable[Numarroser]:prepare("animation1")
										--Arrosable[Numarroser]:play()
									end
								end
							end
							
							local jump
							if EtatHero==0 then
								jump = BASEJUMPLIQUIDE
							elseif EtatHero==1 then
								jump = BASEJUMPSOLIDE
							elseif EtatHero==2 then
								jump = BASEFLYGAZ
							end
								
							if player.canJump 
							and STATE_ANIMATIONENCOURS == false 
							then
								player:setLinearVelocity(vx , 0)--on reset limpulse y pour pas qu'il sembale et saute n'importe comment!
								if EtatHero == 2 then
									if event.y - display.contentHeight/2 >0 then
										player:applyLinearImpulse(0, -3, player.x, player.y)
									end
								else
									player:applyLinearImpulse(0, -(jump*player.globalJump), player.x, player.y)
								end
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
								--print("Charge")
								timer.performWithDelay( 1000, function() BriseGlace=false end, 1 )
							end
						end
					elseif event.x - display.contentWidth/2 <=0 
					and STATE_ANIMATIONENCOURS == false
					then--Si c'est pas la partie droite, alors c'est la partie gauche du device je change d'Etat
						if ( event.phase == "began" ) then
							if STATECHANGE == LIQSOL then
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
							elseif STATECHANGE == LIQGAZ then
								if EtatHero == 0 then
									EtatHero = 2
									doubleSaut = false
									player.state = STATE_TRANSITIONLIQGAZ 
									--print("Etat Gaz")
								elseif EtatHero == 2 then
									EtatHero = 0
									doubleSaut = true
									--print("Etat Liquide")
									player.state = STATE_TRANSITIONGAZLIQ
								end
							elseif STATECHANGE == SOLGAZ then
								if EtatHero == 1 then
									EtatHero = 2
									doubleSaut = false
									player.state = STATE_TRANSITIONSOLGAZ 
									--print("Etat Gaz")
								elseif EtatHero == 2 then
									EtatHero = 1
									doubleSaut = false
									--print("Etat Solide")
									player.state = STATE_TRANSITIONGAZSOL
								end
							end
						end
						STATE_ANIMATIONENCOURS = true
						ChangePlayerDynamic()
						player.direction = DIRECTION_RIGHT
						--print("anim" .. player.state)
						player:prepare("anim" .. player.state)
						player:play()
					end
			end
			if ( event.phase == "ended" ) then
				gagnerAlt = false
				if EtatHero == 2 and STATE_ANIMATIONENCOURS == false and player.sequence ~= "animEndLevel" then --Faire animation quand on gagne en altitude et quand on perd
					player.state = STATE_WALKING_GAZ
					player:prepare("anim" .. player.state)
					player:play()
					if player.y < 85 then
						player:setLinearVelocity(vx , 0)
					end
				end
			end
		end
		
		--Les Stalagmites ne bloque pas le glaçon :
		local layer = map:getTileLayer("Platforms")
		
		if layer ~= nil then
			local Stalacmite = layer:getTilesWithProperty("IsStalacmite")
			if(EtatHero == 1) then
				for i=1, #Stalacmite, 1 do
					Stalacmite[i]:setProperty("isSensor", true)
					Stalacmite[i]:reBuild()
				end
			else
				for i=1, #Stalacmite, 1 do
					Stalacmite[i]:setProperty("isSensor", false)
					Stalacmite[i]:reBuild()
				end
			end
		end
	end
	
	
	
	Runtime:addEventListener("touch", ToucheScreen)

	--PLAYER INIT-----------------------------------------------------------------------
	if EtatHero == 0 then
		player.state = STATE_WALKING_LIQ 
	elseif EtatHero ==1 then
		player.state = STATE_WALKING_SOL
	elseif EtatHero ==2 then
		player.state = STATE_WALKING_GAZ
	end
	ChangePlayerDynamic()
	player.direction = DIRECTION_RIGHT
	player:prepare("animStartLevel")
	player:play()
	audio.play(startlevel)

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
	
	-- Make sure we actually have a layer
	if(layer) then
        -- Get all the tiles on this layer
        local tiles = layer.tiles
        
        -- Make sure tiles is not nil
        if(tiles) then
                
			-- Loop through all our tiles on this layer     
			for i=1, #tiles, 1 do
				-- Check if the tile is animated (note the capitilisation)
				if tiles[i].IsFler and tiles[i].IsAnimated then
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
	
	local layer = map:getTileLayer("SableMouvant")
 
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

local stopEvents = function()
	print("kay")
	Runtime:removeEventListener("enterFrame", onUpdate)
	Runtime:removeEventListener("touch", ToucheScreen)
end


local PauseGame = function()
	if paused == false then
		physics.pause()
		paused = true
		audio.pause()
		GAMESTATE = STATE_PAUSE
		player:pause()
	elseif paused == true then
		physics.start()
		paused = false
		audio.resume(maintheme)
		GAMESTATE = STATE_PLAY
		player:play()
	end
end

local GameLogic = { createMap = createMap, stopEvents = stopEvents,PauseGame=PauseGame, updateScore=updateScore}

return GameLogic


