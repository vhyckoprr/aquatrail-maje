display.setStatusBar( display.HiddenStatusBar )

-- Create a background colour just to make the map look a little nicer
local back = display.newRect(0, 0, display.contentWidth, display.contentHeight)
back:setFillColor(165, 210, 255)

-- Load Lime
local lime = require("lime")

-- Load your map
local map = lime.loadMap("tutorial5.tmx")

-- Create the visual
local visual = lime.createVisual(map)

-- We first need to get access to the layer our tile is on, the name is specified in Tiled
local layer = map:getTileLayer("Tile Layer 1")

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