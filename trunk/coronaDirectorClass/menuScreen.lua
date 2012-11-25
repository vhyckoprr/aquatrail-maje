module(..., package.seeall)

--====================================================================--
-- SCENE: [menuScreen]
--====================================================================--

--[[

 - Version: [1.0]
 - Made by: [Pierre]

******************
 - INFORMATION
******************

  - [Your info here]

--]]

new = function (params)		------------------
	-- Imports
	------------------
	
	local ui = require ( "ui" )
	
	------------------
	-- Groups
	------------------
	
	local localGroup = display.newGroup()
	
	------------------
	-- Your code here
	------------------
	
	local background = display.newImage( "backgroundMenuTest.png" )	local title      = display.newText( "Aquatrail Main Menu", 0, 0, native.systemFontBold,32 )			--====================================================================--
	-- INITIALIZE
	--====================================================================--
	
	local initVars = function ()		------------------
		-- Inserts
		------------------
		
		localGroup:insert( background )
		localGroup:insert( title )				------------------
		-- Positions
		------------------
		
		title.x = 160
		title.y = 20				------------------
		-- Colors
		------------------
		
		title:setTextColor( 255,255,255 )			end
		------------------
	-- Initiate variables
	------------------
	
	initVars()	
	------------------
	-- MUST return a display.newGroup()
	------------------
	
	return localGroup
	
end