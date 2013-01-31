xml = require( "xml" ).newParser()
require ("xml_parser")
module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )
	
require ("request")	
local localGroup = display.newGroup()
---------------------------------LIST---------------------------------------------------------------------
--import the widget library
local widget = require("widget")

--Create a group to hold our widgets & images
local widgetGroup = display.newGroup()

-- create a gradient for the top-half of the toolbar
local toolbarGradient = graphics.newGradient( {168, 181, 198, 255 }, {139, 157, 180, 255}, "down" )

-- create toolbar to go at the top of the screen
local titleBar = widget.newTabBar{
	gradient = toolbarGradient,
	bottomFill = { 117, 139, 168, 255 },
	height = 44
}
titleBar.y = display.screenOriginY + titleBar.contentHeight * 0.5

-- create embossed text to go on toolbar
local titleText = display.newEmbossedText( "Scores", 0, 0, native.systemFontBold, 20 )
titleText:setReferencePoint( display.CenterReferencePoint )
titleText:setTextColor( 255 )
titleText.x = display.viewableContentWidth/2
titleText.y = titleBar.y

-- create a shadow underneath the titlebar (for a nice touch)
local shadow = display.newImage( "shadow.png" )
shadow:setReferencePoint( display.TopLeftReferencePoint )
shadow.x, shadow.y = 0, titleBar.y + titleBar.contentHeight * 0.5
shadow.xScale = 480 / shadow.contentWidth
shadow.alpha = 0.45

--Text to show which item we selected
local itemSelected = display.newText( "You selected item ", 0, 0, native.systemFontBold, 28 )
itemSelected:setTextColor( 0 )
itemSelected.x = display.contentWidth + itemSelected.contentWidth * 0.5
itemSelected.y = display.contentCenterY
widgetGroup:insert( itemSelected )

--Forward reference for our back button
local backButton

--Create Table view
list = widget.newTableView{
	width = 480, 
	height = 288,
	bottomPadding = 8,
	maskFile = "mask-320x448.png"
}
list.y = titleBar.y + titleBar.contentHeight * 0.5


--Insert widgets/images into a group
widgetGroup:insert( list )
widgetGroup:insert( titleBar )
widgetGroup:insert( titleText )
widgetGroup:insert( shadow )


--Handle row rendering
local function onRowRender( event )
	local row = event.row
	local rowGroup = event.view
	local label = "List item "
	local color = 0
	
	--Create the row's text
	row.textObj = display.newRetinaText( rowGroup, label .. row.index, 0, 0, native.systemFontBold, 12 )
	row.textObj:setTextColor( color )
	row.textObj:setReferencePoint( display.CenterLeftReferencePoint )
	row.textObj.x, row.textObj.y = 20, rowGroup.contentHeight * 0.5
	rowGroup:insert( row.textObj )
	
	--Create the row's arrow
	--row.arrow = display.newImage( "rowArrow.png", false )
	--row.arrow.x = rowGroup.contentWidth - row.arrow.contentWidth * 2
	--row.arrow.y = rowGroup.contentHeight * 0.5
	--rowGroup:insert( row.arrow )
end

--Handle the back button release event
local function onBackRelease()
	--Transition in the list, transition out the item selected text and the back button
	transition.to( list, { x = 0, time = 400, transition = easing.outExpo } )
	transition.to( itemSelected, { x = display.contentWidth + itemSelected.contentWidth * 0.5, time = 400, transition = easing.outExpo } )
	transition.to( backButton, { x = 60, alpha = 0, time = 400, transition = easing.outQuad } )
end

--Create the back button
backButton = widget.newButton{
	style = "backSmall",
	label = "Back", 
	yOffset = - 3,
	onRelease = onBackRelease
}
backButton.alpha = 0
backButton.x = 60
backButton.y = titleBar.y
widgetGroup:insert( backButton )


--Hande row touch events
local function onRowTouch( event )
	local row = event.row
	local background = event.background
	
	if event.phase == "press" then
		--print( "Pressed row: " .. row.index )
		--background:setFillColor( 0, 110, 233, 255 )

	elseif event.phase == "release" or event.phase == "tap" then
		--Update the item selected text
		--[[
		itemSelected.text = "You selected item " .. row.index
		
		--Transition out the list, transition in the item selected text and the back button
		transition.to( list, { x = - list.contentWidth, time = 400, transition = easing.outExpo } )
		transition.to( itemSelected, { x = display.contentCenterX, time = 400, transition = easing.outExpo } )
		transition.to( backButton, { x = 40, alpha = 1, time = 400, transition = easing.outQuad } )
		
		print( "Tapped and/or Released row: " .. row.index )
		background:setFillColor( 0, 110, 233, 255 )
		row.reRender = true
		]]
	end
end
------------------------------------------------------------------------------------------------------------------------------ EXPLICATION SUR RECUPERATION de l''XML sur le serveur-- DEUX METHODES-- Recuperation de l'xml sous forme de requete (utilisation de xml.lua))
network.request ( "http://12h52.fr/aquatrail/list.php?world=1&stage=3", "GET", networkListenerData)
-- FAIRE VARIER LE "1" ET LE "3" en fonction du niveau
--SOIT-- Sauvegarde de l'xml puis lecture (utilisation de xml_parse.lua)
--network.download ("http://12h52.fr/aquatrail/list.php?world=1&stage=3", "GET", networkListenerData, "score.xml")
-- FAIRE VARIER LE "1" ET LE "3" en fonction du niveau

	-- insert rows on list FOR TEST ONLY 
for i = 1, 20 do
	list:insertRow{
		height = 30,
		onRender = onRowRender,
		listener = onRowTouch
	}
end
	----------------------------

localGroup:insert(widgetGroup)
--------------------------------------------------------------------------------------------END LIST------------------------------------------------------------------------------------------
   
	
	--return
	local backbutton = display.newImage ("backbutton.png")
	backbutton.x = backbutton.width / 2
	backbutton.y = backbutton.height / 2
	localGroup:insert(backbutton)
   
  --Return Button
	   	local function pressReturn (event)
		if event.phase == "ended" then
			director:changeScene ("IceWorld")
		end
	end
	backbutton:addEventListener ("touch", pressReturn)

	-- MUST return a display.newGroup()
	return localGroup
end
-- FOUNCTION EN DEHORS POUR POUVOIR LES APPELLER DEPUIS request.lua
function list:displayData(xmlTree)			--[[ METHOD 1
	local message = {}
	--for j=1, #xmlTree.length do
		message[0] = xmlTree.child[1]
	--end
	for i=1,#message do
	local player = {}
	-- extract data from table and store in local variables
	-- for easier readability/access:
	player.id = message[i].child[1].value
	player.type = message[i].child[2].value
	player.score = message[i].child[3].value
	player.login = message[i].child[4].value
	player.time = message[i].child[5].value
	list:refreshData(player, i)

end
	]]--
	--[[ METHOD 2
	for i,xmlNode in pairs(xmlTree) do
			local player = {}
			print("ICI : "..xmlNode.Name)
			player.id = xmlValue(xmlNode, "id")
			player.type = xmlValue(xmlNode, "type")
			player.score = xmlValue(xmlNode, "score")
			player.login = xmlValue(xmlNode, "login")
			player.time = xmlValue(xmlNode, "time")
			player.world = xmlValue(xmlNode, "world")
			player.stage = xmlValue(xmlNode, "stage")
			print ( player.login)
			list:refreshData(player, index)
			index=index+1
	end
	]]--
end

function list:refreshData(playerData, index)
		-- permet de creer la liste a partir des données xml	
	-- insert rows into list (tableView widget)
	print ("INDEX"..index)
		list:insertRow{
			height = 30,
			onRender = onRowRender,
			listener = onRowTouch
			--onRender.classement = index,
			--onRender.login = playerData.login,
			--onRender.score = playerData.score,
			--onRender.time = playerData.time
		}

end

function xmlValue(xmlTree, nodeName)
	for i,xmlNode in pairs(xmlTree.ChildNodes) do
		if(xmlNode.Name==nodeName) then
			return xmlNode.Value
		end
	end
end