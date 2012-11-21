module(..., package.seeall)

local ui = require("ui")
local tableView = require("tableView")

function new()

	local self = display.newGroup()

	self.back = display.newRect(self, 0, 0, display.contentWidth, display.contentHeight)
	--self.back:setFillColor( 133, 249, 80 )
	self.back:setFillColor( 0, 0, 0 )
	
	local onListItemRelease = function(event)
		_G["map"] = event.target.data
		--_G.mapListYPosition = event.target.y - 40 -- - ( display.contentHeight / 2 ) + 41
		director:changeScene("screen_Map", "moveFromRight")
	end
	
	local allMaps = lime.utils.readInTable("maps.json", system.ResourceDirectory)
	local maps = {}
	
	for i = 1, #allMaps, 1 do
		if allMaps[i].isIncluded then
			maps[ #maps + 1 ] = allMaps[i]
		end
	end
	
	local topBoundary = display.screenOriginY + 40
	local bottomBoundary = display.screenOriginY
	
	-- create the list of items
	self.list = tableView.newList{
		data=maps, 
		default="listItemBg.png",
		over="listItemBg_over.png",
		onRelease=onListItemRelease,
		top=topBoundary,
		bottom=bottomBoundary,
		backgroundColor={ 0, 0, 0 },
		callback=function(row) 
		
			local group = display.newGroup()
			
			group.nameText = display.newText(group, row.name, 0, 0, native.systemFontBold, 20)
			group.nameText:setTextColor( 133, 249, 80 )
			group.nameText.x = math.floor( group.nameText.width / 2) + 10
			group.nameText.y = 46
			
			group.descriptionText = display.newText(group, row.description, 0, 0, native.systemFontBold, 12)
			group.descriptionText:setTextColor( 255, 255, 255 )
			group.descriptionText.x = math.floor( group.descriptionText.width / 2) + 10
			group.descriptionText.y = group.nameText.y +  group.descriptionText.height * 1.5
		
		--	group.linkText = display.newText(group, row.link, 0, 0, native.systemFontBold, 10)
		--	group.linkText:setTextColor(0, 0, 128)
		--	group.linkText.x = math.floor( group.linkText.width / 2) + 10
		--	group.linkText.y = 70 --group.height --  group.linkText.height 
				
			return group
		end
	}

	self:insert(self.list)
	
	self.header = display.newImage( self, "listHeader.png" )
	if _G.mapListYPosition then
		--self.list.y = -_G.mapListYPosition
	end	
	
	local onBackButtonRelease = function( event )
		director:changeScene( "screen_Main", "moveFromLeft" )
	end
	
	self.backButton = ui.newButton
	{
		default = "button_back.png",
		over = "button_back_over.png",
		onRelease = onBackButtonRelease
	}
	
	self.backButton.x = self.backButton.contentWidth / 2 + 5
	self.backButton.y = self.header.y
	self:insert( self.backButton )
	
	function clean()
		self.list:cleanUp()
	end
	
	return self
	
end