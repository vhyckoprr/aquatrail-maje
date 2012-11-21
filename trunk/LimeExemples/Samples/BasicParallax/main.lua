--------------------------------------------------------------
--			Basic Parallax Sample							--
--															--
--	This is a simple demo just to show off					--
--  basic parallax scrolling. A current limitation			--
--  is the use of ObjectLayers.								--
--															--
--  To set a map up to use Parallax you must first			--
--  add a "ParallaxEnabled" property to the map and			--
--  then on each layer a "parallaxFactorX" and/or			--
--  "parallaxFactorY" property. The higher the number		--
--  the faster it will scroll so you will want higher		--
--  values for layers that are closer to the camera.		--
--  This demo uses values ranging from around 0.1 to 2		--
--  but just play with them to see what feels right for		--
--	your game.												--
--															--
--------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

-- Create a background colour just to make the map look a little nicer
local back = display.newRect(0, 0, display.contentWidth, display.contentHeight)
back:setFillColor(165, 210, 255)

-- Load Lime
local lime = require("lime")

-- Disable culling
lime.disableScreenCulling()

-- Load your map
local map = lime.loadMap("BasicParallax.tmx")

-- Create the visual
local visual = lime.createVisual(map)

-- Build the physical
lime.buildPhysical(map)

local onTap = function( event )

	local pos = lime.utils.screenToWorldPosition( map, event )
	map:slideToPosition( pos.x, pos.y )
	--map:fadeToPosition( pos.x, pos.y )

end

local onTouch = function( event )
	map:drag( event )
end
map:showDebugImages()
Runtime:addEventListener( "tap", onTap )
Runtime:addEventListener( "touch", onTouch )