-- 
-- Abstract: JungleScene sample project
-- Demonstrates sprite sheet animations, with different frame rates
-- 
-- Version: 1.0
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2010 Corona Labs Inc. All Rights Reserved.

-- Plants are from http://blender-archi.tuxfamily.org/Greenhouse
-- and are subject to creative commons license, http://creativecommons.org/licenses/by/3.0/

display.setStatusBar( display.HiddenStatusBar )

--inclure les autres fichiers LUA
local gameUI = require("gameUI")

--Utilisation de font en fonction du device
labelFont = gameUI.newFontXP{ ios="Zapfino", android=native.systemFont }

system.activate( "multitouch" )


-- The sky as background
local sky = display.newImage( "sky.jpg" )

local baseline = 280

-- a bunch of foliage
local tree = {}
tree[1] = display.newImage( "Palm-arecaceae.png" )
tree[1].xScale = 0.7; tree[1].yScale = 0.7
tree[1]:setReferencePoint( display.BottomCenterReferencePoint )
tree[1].x = 20; tree[1].y = baseline
tree[1].dx = 0.1
tree[2] = display.newImage( "Greenhouse-Palm-jubaea01.png" )
tree[2].xScale = 0.6; tree[2].yScale = 0.6
tree[2]:setReferencePoint( display.BottomCenterReferencePoint )
tree[2].x = 120; tree[2].y = baseline
tree[2].dx = 0.2
tree[3] = display.newImage( "Greenhouse-Palm-cycas01.png" )
tree[3].xScale = 0.8; tree[3].yScale = 0.8
tree[3]:setReferencePoint( display.BottomCenterReferencePoint )
tree[3].x = 200; tree[3].y = baseline
tree[3].dx = 0.3
tree[4] = display.newImage( "Ginger.png" )
tree[4].xScale = 0.7; tree[4].yScale = 0.7
tree[4]:setReferencePoint( display.BottomCenterReferencePoint )
tree[4].x = baseline; tree[4].y = baseline
tree[4].dx = 0.4
tree[5] = display.newImage( "Greenhouse-Palm-acai01.png" )
tree[5].xScale = 0.8; tree[5].yScale = 0.8
tree[5]:setReferencePoint( display.BottomCenterReferencePoint )
tree[5].x = 300; tree[5].y = baseline
tree[5].dx = 0.5
tree[6] = display.newImage( "Dracena.png" )
tree[6].xScale = 0.4; tree[5].yScale = 0.4
tree[6]:setReferencePoint( display.BottomCenterReferencePoint )
tree[6].x = 320; tree[6].y = baseline
tree[6].dx = 0.6
tree[7] = display.newImage( "Banana.png" )
tree[7].xScale = 0.4; tree[7].yScale = 0.4
tree[7]:setReferencePoint( display.BottomCenterReferencePoint )
tree[7].x = 380; tree[7].y = baseline
tree[7].dx = 0.7
tree[8] = display.newImage( "Bamboo-rgba.png" )
tree[8].xScale = 0.8; tree[8].yScale = 0.8
tree[8]:setReferencePoint( display.BottomCenterReferencePoint )
tree[8].x = 420; tree[8].y = baseline
tree[8].dx = 0.8


-- A sprite sheet with a green dude
local sheet2 = graphics.newImageSheet( "mario2.png", { width=128, height=128, numFrames=3 } )

-- play 3 frames every 500 ms
local instance2 = display.newSprite( sheet2, { name="man", start=1, count=3, time=400 } )
instance2.x = 50
instance2.y = baseline -40
instance2:play()


-- touch listener
function instance2:touch( event )
	instance2.x = event.x; instance2.y = event.y;
    -- 'self' parameter exists via the ':' in function definition
end

-- begin detecting touches
instance2:addEventListener( "touch", instance2 )



local function spawnDisk( event )
	
	local phase = event.phase
	if "ended" == phase then
		local spriteMarioDrag = instance2
		spriteMarioDrag.x = event.x; spriteMarioDrag.y = event.y;

	end
	return true

end


-- Grass
-- This is doubled so we can slide it
-- When one of the grass images slides offscreen, we move it all the way to the right of the next one.
local grass = display.newImage( "grass.png" )
grass:setReferencePoint( display.CenterLeftReferencePoint )
grass.x = 0
grass.y = baseline - 20
local grass2 = display.newImage( "grass.png" )
grass2:setReferencePoint( display.CenterLeftReferencePoint )
grass2.x = 480
grass2.y = baseline - 20

-- solid ground, doesn't need to move
local ground = display.newRect( 0, baseline, 480, 90 )
ground:setFillColor( 0x31, 0x5a, 0x18 )

-- A per-frame event to move the elements
local tPrevious = system.getTimer()
local function move(event)
	local tDelta = event.time - tPrevious
	tPrevious = event.time

	local xOffset = ( 0.2 * tDelta )

	grass.x = grass.x - xOffset
	grass2.x = grass2.x - xOffset
	
	if (grass.x + grass.contentWidth) < 0 then
		grass:translate( 480 * 2, 0)
	end
	if (grass2.x + grass2.contentWidth) < 0 then
		grass2:translate( 480 * 2, 0)
	end
	
	local i
	for i = 1, #tree, 1 do
		tree[i].x = tree[i].x - tree[i].dx * tDelta * 0.2
		if (tree[i].x + tree[i].contentWidth) < 0 then
			tree[i]:translate( 480 + tree[i].contentWidth * 2, 0 )
		end
	end
end

local function dragBody( event )
	print("that good")
	return gameUI.dragBody( event )
	
	-- Substitute one of these lines for the line above to see what happens!
	--gameUI.dragBody( event, { maxForce=400, frequency=5, dampingRatio=0.2 } ) -- slow, elastic dragging
	--gameUI.dragBody( event, { maxForce=20000, frequency=1000, dampingRatio=1.0, center=true } ) -- very tight dragging, snaps to object center
end

-- Start everything moving
--sky

Runtime:addEventListener( "touch", spawnDisk ) -- touch the screen to create disks
Runtime:addEventListener( "enterFrame", move );