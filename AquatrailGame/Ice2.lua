module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )
	
	local localGroup = display.newGroup()
	
	display.setStatusBar( display.HiddenStatusBar )

	system.activate( "multitouch" )
	
	
	local EtatHero = 0 --0 pour Etat liquide, 1 pour Etat Solide, 2 pour Etat Vapeur
-- CONSTANTS,VARIABLES, REQUIREMENTS
	--Etat Liquide

	local STATE_WALKING_LIQ = "WalkingLiq"
	local STATE_JUMPING_LIQ = "JumpingLiq"
	local doubleSaut = true;

	--Etat Solide
	local STATE_WALKING_SOL = "WalkingSol"
	local STATE_JUMPING_SOL = "JumpingSol"
	local BriseGlace = false;

	--Transition Etat
	local STATE_TRANSITION = "Transition"

	local DIRECTION_LEFT = -1
	local DIRECTION_RIGHT = 1
	local SCORE = 0
	local ui = require("ui")
	local Gesture = require("lib_gesture")
	require("physics")
	local DynResManager = require("DynResManager")
	physics.start()
	
	
	local pointsTable = {}
	local line
	local myText = display.newText("Test: ", 75, 50, native.systemFont, 32)
	myText:setTextColor(150, 0, 0)
	myText.isVisible = false

	-- Create a background colour just to make the map look a little nicer
	--local back = DynResManager.createCenterRectangleFitted()
	--back:setFillColor(165, 210, 255)
	
	--Background
	local back = display.newImage("background_ice.png")
   back.isVisible = true
   back.x = 	display.contentWidth/2 
   back.y =  display.contentHeight/2 
   --fit
   back.width=DynResManager.getScreenWidthPhysPix()
   back.height=DynResManager.getScreenHeightPhysPix()
   --localGroup:insert(back)

	
	-- Load Lime
	local lime = require("lime")
	
	-- Disable culling
	lime.disableScreenCulling()
	
	-- Load your map
	local map = lime.loadMap("Niveau_2_1.tmx")
	
	
	local onPlayerProperty = function(property, type, object)
		player = object.sprite
	end
	
	map:setFocus( player )
	map:addPropertyListener("IsPlayer", onPlayerProperty)
	
	-- Create the visual
	local visual = lime.createVisual(map)
	
	-- Build the physical
	local physical = lime.buildPhysical(map)
	
	local maintheme = audio.loadSound( "music_1.mp3" )
	local b_stalactite = audio.loadSound( "b_stalactite.mp3" )
	local b_saut = audio.loadSound( "b_saut.mp3" )
	local b_gouttelette = audio.loadSound( "b_gouttelette.mp3" )
	
	audio.play(maintheme,{loops=-1})
	--physics.setDrawMode("hybrid")
	--COLLISION --------------------------------------------------------------------------------------------------------
	local function onCollision(self, event )
	
	 	if ( event.phase == "began" ) then
			if event.other.IsGround then
				print("Ground");
				player.canJump = true
				if(EtatHero ==0 )then
					doubleSaut=true
					--print("doubleSaut = true")
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
				--player.canJump = true
				--if(EtatHero ==0 )then
				--	doubleSaut=true
				--	print("doubleSaut = true")
				--end
			elseif event.other.IsPickup then
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
				
				if item.pickupType == "score" then
					
					text = display.newText( item.scoreValue, 0, 0, "Helvetica", 20 )
					SCORE=SCORE+item.scoreValue
					updateScore()
					
				elseif item.pickupType == "health" then
					
					text = display.newText( item.healthValue .. " Extra Health!", 0, 0, "Helvetica", 50 )
					
				end
				
				if text then
					text:setTextColor(0, 0, 0, 255)
					text.x = display.contentCenterX
					text.y = display.contentCenterY
					transition.to(text, {time = 1000, alpha = 0, onComplete=onTransitionEnd})
				end
			elseif event.other.IsStalacti then
				print("brise stalactite")
				if EtatHero == 1 then
					
					local stalacti = event.other

					local onTransitionEnd = function(transitionEvent)
					if transitionEvent["removeSelf"] then
						transitionEvent:removeSelf()
					end
				end

				-- Fade out the stalacti
				transition.to(stalacti, {time = 500, alpha = 0, onComplete=onTransitionEnd})
				audio.play(b_stalactite)
				
				end
			end
			if event.other.IsDestroy then
				print("IsDestroy");
				if EtatHero == 1 and BriseGlace then
					event.other:removeSelf()
				end
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
	local onUpdate = function(event)
		
		--L'animation animTransition est enclencher?
		if player.sequence == "animTransition" then
			--Le sprite est il entrain d'executer une animation?
			if player.animating  then
				--Le sprite a il fini son animation?
				if player.currentFrame ==3 then
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
		--check si il y a eu collision (direction positive vitesse negative)
		if ((player.direction == 1 and vx <0)or(player.direction == -1 and vx >0)) then
			player:setLinearVelocity(150, vy)
		else
				if (vx>=0 and vx<1)then
					player:applyForce( player.direction*10, 0, player.x, player.y )
				elseif (vx<150 ) then
					player:setLinearVelocity(vx * 1.15, vy)

				else
					player:setLinearVelocity(150, vy)
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
	local onTouch = function(event)
		if ( event.phase == "began" ) then
			--print("ChangeEtat")
	      	if EtatHero == 0 then
		    	EtatHero = 1
				doubleSaut = false
		      	--print("Etat Solide")
	       	elseif EtatHero ==1 then
		      	EtatHero =0
				doubleSaut = true
		      	--print("Etat Liquide")
	      	end
		end
		ChangePlayerDynamic()
		player.state = STATE_TRANSITION 
		player.direction = DIRECTION_RIGHT
		--print("anim" .. player.state)
		player:prepare("anim" .. player.state)
		player:play()
	end
	player:addEventListener("touch", onTouch)
	
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
	
	--Fonction de saut !
	--
	local function Jump (event)
			local vx, vy = player:getLinearVelocity() -- on recup la velociter du hero
			if ( event.phase == "began" ) then
				
					--mettre screen width a la place de 480
					if(event.x < ((480/2)-50)) then
						--Check Doublesaut
						--
						if player.canJump == false and doubleSaut==true and EtatHero == 0 then
							player.canJump = true
							doubleSaut=false 
						end
							
						if player.canJump then
							print("Jump")
							player:setLinearVelocity(vx , 0)--on reset limpulse y pour pas que �a sembale !
							player:applyLinearImpulse(0, -10, player.x, player.y)
							audio.play(b_saut)
							if EtatHero == 0 then
								player.state = STATE_JUMPING_LIQ
							elseif EtatHero ==1 then
								player.state = STATE_JUMPING_SOL
							end
							player.canJump = false
							--print("anim" .. player.state)
							player:prepare("anim" .. player.state)
					
							player:play()
						end
					end
			end

	end
	Runtime:addEventListener("touch", Jump)
	
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
	
-- SCORING --------------------------------------------------------------------------
	
	local scoreText  = display.newText( "score: "..SCORE, 0, 0, "Helvetica", 30 )
	scoreText.x = display.contentWidth/2
	scoreText.y =  scoreText.height / 2
	
	function updateScore ()
	      scoreText.text = "score: "..SCORE
	 end
    
-- BACKBUTTON---------------------------------------------
		
	local backbutton = display.newImage ("backbutton.png")
	backbutton.x = backbutton.width / 2
	backbutton.y = backbutton.height / 2
	local function pressBack (event)
		if event.phase == "ended" then
				audio.stop()
				Runtime:removeEventListener("enterFrame", onUpdate)
				Runtime:removeEventListener( "touch", UpdateGesturelib )
				Runtime:removeEventListener("touch", Jump)
				director:changeScene ("IceWorld")
		end
	end
	backbutton:addEventListener ("touch", pressBack)  
	
	--drawLine gesturelib
	--
	local function drawLine ()

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
	local function UpdateGesturelib(event)		
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
				drawLine ()
			end
			
		elseif "ended" == event.phase or "cancelled" == event.phase then
				--drawLine ()
				if EtatHero == 1 and (event.x - (480/2)-50) >0
				then
					myText.text = "Test : "..Gesture.GestureResult()
					--Si on fait un "slash vers bas" alors on fait la capacit� sp�cial du gla�on
					if Gesture.GestureResult() == "SwipeD"
					then
						--print("impulse bas")
						player:applyLinearImpulse(0, 30, player.x, player.y)
						BriseGlace=true
						--print("BriseGlace=true")
						timer.performWithDelay( 1000, function() BriseGlace=false  print("BriseGlace=false") end, 1 )
					end
				end
		end
	end

Runtime:addEventListener( "touch", UpdateGesturelib )

-- ANIMATIONS---------------------------------------------

--lance les animations :
	
	local layer = map:getTileLayer("Plateform")
 
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

--------------------------------------------------------------
--Add the Director Class insert statements here
	localGroup:insert(back)
	localGroup:insert(visual)
	localGroup:insert(scoreText)
	localGroup:insert(backbutton)


	-- MUST return a display.newGroup()
	return localGroup
end

