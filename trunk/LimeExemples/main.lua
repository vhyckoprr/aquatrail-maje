--
-- Project: LimeExemples
-- Description: 
--
-- Version: 1.0
-- Managed with http://CoronaProjectManager.com
--
-- Copyright 2012 . All Rights Reserved.
-- 

local lime = require("lime")

local map = lime.loadMap("test4.tmx")-- to do before visual-- Create our listener function
local onObject = function(object)
    -- Create an image using the properties of the object
    display.newImage(object.playerImage, object.x, object.y)
end
-- Add our listener to our map linking it with the object type
map:addObjectListener("PlayerSpawn", onObject)

local visual = lime.createVisual(map)--[[local layer = map:getTileLayer("Calque 2")local tiles = layer.tiles-- Loop through our tiles
for i=1, #tiles, 1 do
    -- Get a list of all properties on the current tile
    local tileProperties = tiles[i]:getProperties()
    -- Loop through the properties, if any
    for key, value in pairs(tileProperties) do
        -- Get the current property
        local property = tileProperties[key]
        -- Print out its Name and Value
        print(property:getName(), property:getValue())
    end
end]]-- We first need to get access to the layer our tile is on, the name is specified in Tiled
local layer = map:getTileLayer("Calque 1")
-- Make sure we actually have a layer
if(layer) then
    -- Get all the tiles on this layer
    local tiles = layer.tiles
    -- Loop through our tiles
    for i=1, #tiles, 1 do
        -- Check if the tile is animated (note the capitilisation)
        if(tiles[i].IsAnimated) then
            -- Store off a copy of the tile
            local tile = tiles[i]
            -- Check if the tile has a property named "animation1"
            if(tile.animation1) then
                -- Prepare it through the sprite
                tile.sprite:prepare("animation1")
                -- Now finally play it
                tile.sprite:play()
            end
        end
    end
endlocal physical = lime.buildPhysical(map)