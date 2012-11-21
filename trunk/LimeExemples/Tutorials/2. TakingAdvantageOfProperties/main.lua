display.setStatusBar( display.HiddenStatusBar )

-- Create a background colour just to make the map look a little nicer
local back = display.newRect(0, 0, display.contentWidth, display.contentHeight)
back:setFillColor(165, 210, 255)

-- Load Lime
local lime = require("lime")

-- Load your map
local map = lime.loadMap("tutorial2.tmx")

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
						
			-- Check this tile has atleast one property
			if(tiles[i]:getPropertyCount() > 0) then
				
				-- Get the properties of the current tile
				local tileProperties = tiles[i]:getProperties()
				
				-- Print out tile position
				print("Tile at row " .. tiles[i].row .. " and column " .. tiles[i].column .. ".")
				
				-- Loop through all the properties
				for key, value in pairs(tileProperties) do
					-- Get the property
					local property = tileProperties[key]
					
					-- Print out the name and value
					print(property:getName(), property:getValue())
				end
			end
		end
	end	
end