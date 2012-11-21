display.setStatusBar( display.HiddenStatusBar )

local ui = require("ui")

-- Create a background colour just to make the map look a little nicer
local back = display.newRect(0, 0, display.contentWidth, display.contentHeight)
back:setFillColor(165, 210, 255)

-- Load Lime
local lime = require("lime")

-- Load your map
local map = lime.loadMap("isometric.tmx")

-- Disable screen clamping
map:disableScreenClamping()

-- Create the visual
local visual = lime.createVisual(map)

-- Player object
local player = nil

-- Get the postition of the first tile
local gridPosition = { column = 0, row = 0 }
local offset = { x = 0, y = map.tilewidth / 2 + map.tileheight / 2 }
local position = lime.utils.gridToWorldPosition( map, gridPosition, offset )

-- Get the two layers
local grassLayer = map:getTileLayer("Grass")
local treeLayer = map:getTileLayer("Trees")

-- Create and position the player
if position then
	player = display.newImage( grassLayer.group, "player.png" )
	player.x = position.x
	player.y = position.y
	map:setFocus( player )
end

-- Main update function
local onUpdate = function( event )
	map:update( event )
end
Runtime:addEventListener( "enterFrame", onUpdate )

-- Move player function
local movePlayer = function( direction )

	-- Only allow movement if the player isn't currently moving
	if not player.transition then 
	
		local newGridPosition = { column = gridPosition.column, row = gridPosition.row }
		local newRotation = 0
		
		-- Get the grid position for the next tile
		if direction == "NE" then
			newRotation = -90
			newGridPosition.row = newGridPosition.row - 1
		elseif direction == "SE" then
			newRotation = 0
			newGridPosition.column = newGridPosition.column + 1
		elseif direction == "SW" then
			newRotation = 90
			newGridPosition.row = newGridPosition.row + 1
		elseif direction == "NW" then
			newRotation = 180
			newGridPosition.column = newGridPosition.column - 1
		end
		
		-- Get the next tile on both layers
		local grassTile = grassLayer:getTileAt( newGridPosition )
		local treeTile = treeLayer:getTileAt( newGridPosition )
		
		-- Rotate the player
		player.rotation = newRotation
		
		-- Check if there is actually a tile on the grass layer, if not then we have hit the edge of the map
		if grassTile  then
		
			-- If there is a tree tile or the grass tile is an obstacle then we shall not pass
			if treeTile or grassTile.isObstacle then
				return
			end
			
			-- Get the position of the new tile
			position = lime.utils.gridToWorldPosition( map, newGridPosition, offset )
			
			local onTransitionComplete = function( event )
				player.transition = nil
			end
			
			-- Move the player
			player.transition = transition.to( player, { time = 500, x = position.x, y = position.y, onComplete = onTransitionComplete } )
			
			-- Update the main grid position
			gridPosition = { column = newGridPosition.column, row = newGridPosition.row }
		
		end
	end
	
end

local onMoveButtonRelease = function( event )

	local button = event.target
	
	if button and button.direction then
		movePlayer( button.direction )
	end
	
end

local onTreeButtonRelease = function( event )
	treeLayer.group.alpha = treeLayer.group.alpha == 1 and 0.3 or 1
end

-- Create the HUD
local buttonNorthEast = ui.newButton{
        default = "arrow-northeast.png",
        over = "arrow-northeast-over.png",
        onRelease = onMoveButtonRelease
}

buttonNorthEast.x = buttonNorthEast.width * 2
buttonNorthEast.y = display.contentHeight - buttonNorthEast.height * 2 + 10
buttonNorthEast.direction = "NE"

local buttonSouthEast = ui.newButton{
        default = "arrow-southeast.png",
        over = "arrow-southeast-over.png",
        onRelease = onMoveButtonRelease
}

buttonSouthEast.x = buttonSouthEast.width * 2
buttonSouthEast.y = display.contentHeight - buttonSouthEast.height / 2 - 10
buttonSouthEast.direction = "SE"

local buttonNorthWest = ui.newButton{
        default = "arrow-northwest.png",
        over = "arrow-northwest-over.png",
        onRelease = onMoveButtonRelease
}

buttonNorthWest.x = buttonNorthWest.width
buttonNorthWest.y = display.contentHeight - buttonNorthEast.height * 2 + 10
buttonNorthWest.direction = "NW"

local buttonSouthWest = ui.newButton{
        default = "arrow-southwest.png",
        over = "arrow-southwest-over.png",
        onRelease = onMoveButtonRelease
}

buttonSouthWest.x = buttonSouthEast.width
buttonSouthWest.y = display.contentHeight - buttonSouthEast.height / 2 - 10
buttonSouthWest.direction = "SW"

local buttonTrees = ui.newButton{
        default = "tree.png",
        over = "tree-over.png",
        onRelease = onTreeButtonRelease
}

buttonTrees.x = display.contentWidth - buttonTrees.width / 2 - 10
buttonTrees.y = display.contentHeight - buttonTrees.height / 2 - 10