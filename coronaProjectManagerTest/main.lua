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
local Gesture = require("lib_gesture")


local pointsTable = {}
local line
local EtatHero = 0 --0 pour Etat liquide, 1 pour Etat Solide, 2 pour Etat Vapeur

--Utilisation de font en fonction du device
labelFont = gameUI.newFontXP{ ios="Zapfino", android=native.systemFont }

system.activate( "multitouch" )
----Structure pour spritelocal sheetHeroData = {
  width = 128,  height = 128,  numFrames = 8
}local sequenceHeroData = {
  {name = "EtatLiquide",  frames={ 1,2,3},  time = 400},    {name = "EtatSolide",  frames={ 5,6,7},  time = 400},    {name = "EtatVapeur",  frames={ 5,6,7},  time = 400}
}----

-- 
--  DECOR
--
--
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

-- 
--  FIN DECOR
--
--


--
--
--Creation du sprite personnage
--
--
local sheet2 = graphics.newImageSheet( "HeroTest.png", sheetHeroData )
-- play 3 frames every 500 ms
local instance2 = display.newSprite( sheet2, sequenceHeroData )
instance2.x = 50
instance2.y = baseline -40instance2:setSequence("EtatLiquide");
instance2:play()
instance2:addEventListener( "touch", instance2 )
--
--
--Fin Creation du sprite personnage
--
--

-- 
--	Event Touch Perso
--
function instance2:touch( event )
	if EtatHero==0 then
		instance2:setSequence("EtatSolide");
		EtatHero=1
	elseif EtatHero==1 then
		instance2:setSequence("EtatLiquide");
		EtatHero=0
	end
	instance2:play()
    -- 'self' parameter exists via the ':' in function definition
end

--
--Fin Event Touch Perso
--

--
--Faire avancer le decor
--

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

--
--Fin faire avancer le decor
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

local myText = display.newText("Result: ", 0, 0, native.systemFont, 32)
myText:setTextColor(255, 0, 0)
myText.size = 25

local function Update(event)		
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
	
	elseif "ended" == event.phase or "cancelled" == event.phase then
			--drawLine ()
			myText.text = Gesture.GestureResult()
	end
	instance2:addEventListener( "touch", instance2 )
end

-- Start everything moving


Runtime:addEventListener( "enterFrame", move );
Runtime:addEventListener( "touch"		, Update )