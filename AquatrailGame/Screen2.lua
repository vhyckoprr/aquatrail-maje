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

	--Transition Etat
	local STATE_TRANSITION = "Transition"

	local DIRECTION_LEFT = -1
	local DIRECTION_RIGHT = 1
	local SCORE = 0
	local ui = require("ui")
	require("physics")
	physics.start()
	
	-- Create a background colour just to make the map look a little nicer
	local back = display.newRect(0, 0, display.contentWidth, display.contentHeight)
	back:setFillColor(165, 210, 255)

	
	-- Load Lime
	local lime = require("lime")
	
	-- Disable culling
	lime.disableScreenCulling()
	
	-- Load your map
	local map = lime.loadMap("mytestlevel.tmx")
	
	local onPlayerProperty = function(property, type, object)
		player = object.sprite
	end
	
	map:setFocus( player )
	map:addPropertyListener("IsPlayer", onPlayerProperty)
	
	-- Create the visual
	local visual = lime.createVisual(map)
	
	-- Build the physical
	local physical = lime.buildPhysical(map)
	
	local maintheme = audio.loadSound( "maintheme.mp3" )
	--local channelmaintheme = audio.play(maintheme,{loops = 100})
	
	-- HUD Event Listeners
	--[[
	local onButtonLeftEvent = function(event)
		
		if event.phase == "press" then
			if (player.direction ==DIRECTION_RIGHT)then
				player.direction = DIRECTION_LEFT
				player.xScale = player.direction
				-- on change de direction donc vx vy = 0
				local vx, vy = player:getLinearVelocity()
				player:setLinearVelocity(0, vy)
			end
			player.state = STATE_WALKING	

		end
	
		player:prepare("anim" .. player.state)
		
		player:play()
	end
	
	local onButtonRightEvent = function(event)
	
		if event.phase == "press" then
			if (player.direction ==DIRECTION_LEFT)then
				player.direction = DIRECTION_RIGHT
				player.xScale = player.direction
				-- on change de direction donc vx vy = 0
				local vx, vy = player:getLinearVelocity()
				player:setLinearVelocity(0, vy)
			end
			player.state = STATE_WALKING	

		end
	
		player:prepare("anim" .. player.state)
		
		player:play()
	end
	]]
	local onButtonAPress = function(event)
		--if player.canJump then
			--player:applyLinearImpulse(0, -7.5, player.x, player.y)
			
			--if EtatHero == 0 then
				--player.state = STATE_JUMPING_LIQ
			--elseif EtatHero ==1 then
				--player.state = STATE_JUMPING_SOL
			--end
			
			--player:prepare("anim" .. player.state)
	
			--player:play()
		--end
	end

	
	-- HUD A BUTTON--------------------------------------------------------------------------------------------------
	--local buttonA = ui.newButton{
	--        default = "buttonA.png",
	--        over = "buttonA_over.png",
	--        onPress = onButtonAPress
	--}
	
	--buttonA.x = display.contentWidth - buttonA.width / 2 - 10
	--buttonA.y = display.contentHeight - buttonA.height / 2 - 10
	
	--COLLISION --------------------------------------------------------------------------------------------------------
	local function onCollision(self, event )
	
	 	if ( event.phase == "began" ) then
			if event.other.IsGround then
				player.canJump = true
				if(EtatHero ==0 )then
					doubleSaut=true
					print("doubleSaut = true")
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
			end
		elseif ( event.phase == "ended" ) then
			if event.other.IsGround then
			print("isground ended")
				player.canJump = false
				
				--Check saut
				--
				--if doubleSaut==false and (EtatHero == 1 or EtatHero == 2 ) then
				--	player.canJump = false
				--	print("canJump = false1")
				--end
				
	 		elseif event.other.IsObstacle then
	 			--local vx, vy = player:getLinearVelocity()
				--player:setLinearVelocity(0 , vy)
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
					player:prepare("anim" .. player.state)
					player:play()
				end
			end
		end
		
		local vx, vy = player:getLinearVelocity()
		--check si il y a eu collision (direction positive vitesse negative)
		if ((player.direction == 1 and vx <0)or(player.direction == -1 and vx >0)) then
			player:setLinearVelocity(0 , vy)
		else
				if (vx == 0)then
					player:applyForce( player.direction*10, 0, player.x, player.y )
				elseif (vx<150  and vx>-150) then
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
		print("okay")
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

		player.state = STATE_TRANSITION 
		player.direction = DIRECTION_RIGHT
		player:prepare("anim" .. player.state)
		player:play()
	end
	player:addEventListener("touch", onTouch)
	
	local function Jump (event)
	--TODO : Faire en sorte de reset l'impulse car défois, le saut s'emballe sinon
	--
	
		if ( event.phase == "began" ) then
			player:applyLinearImpulse(0, 0, player.x, player.y)
				--mettre screen width a la place de 480
				if((event.x - 480/2)-50 >0) then
					--Check Doublesaut
					--
					if player.canJump == false and doubleSaut==true and EtatHero == 0 then
						player.canJump = true
						doubleSaut=false 
					end
						
					if player.canJump then
						print("Jump")
						player:applyLinearImpulse(0, -4, player.x, player.y)
						
						if EtatHero == 0 then
							player.state = STATE_JUMPING_LIQ
						elseif EtatHero ==1 then
							player.state = STATE_JUMPING_SOL
						end
						player.canJump = false
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
	player.direction = DIRECTION_RIGHT
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
				audio.stop(channelmaintheme)
				Runtime:removeEventListener("enterFrame", onUpdate)
				director:changeScene ("Screen1")
		end
	end
	backbutton:addEventListener ("touch", pressBack)  
	
	
	
--------------------------------------------------------------
--Add the Director Class insert statements here
	localGroup:insert(back)
	localGroup:insert(visual)
	--localGroup:insert(buttonA)
	localGroup:insert(scoreText)
	localGroup:insert(backbutton)


	-- MUST return a display.newGroup()
	return localGroup
end

