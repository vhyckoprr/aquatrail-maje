module(..., package.seeall)

local ui = require( "ui" )

function new()

	local self = display.newGroup()

	--self.back = display.newRect(self, 0, 0, display.contentWidth, display.contentHeight)
	self.back = display.newImage(self, "back.jpg")
	
	local onInfoButtonRelease = function( event )
		director:changeScene( "screen_Info", "moveFromLeft" )
	end
	
	self.infoButton = ui.newButton
	{
		default = "button_info.png",
		over = "button_info_over.png",
		onRelease = onInfoButtonRelease
	}
	
	self.infoButton.x = self.infoButton.contentWidth / 2
	self.infoButton.y = display.contentHeight - self.infoButton.contentHeight / 2 - 10
	self:insert( self.infoButton )
	
	local onHelpButtonRelease = function( event )
		--director:changeScene( "screen_MapList", "moveFromRight" )
	end
	
	self.helpButton = ui.newButton
	{
		default = "button_help.png",
		over = "button_help_over.png",
		onRelease = onInfoButtonRelease
	}
	
	self.helpButton.x = self.infoButton.x + self.helpButton.contentWidth
	self.helpButton.y = self.infoButton.y - 1
	self:insert( self.helpButton )	
	self.helpButton.isVisible = false
	
	local onForwardButtonRelease = function( event )
		director:changeScene( "screen_MapList", "moveFromRight" )
	end
	
	self.forwardButton = ui.newButton
	{
		default = "button_forward.png",
		over = "button_forward_over.png",
		onRelease = onForwardButtonRelease
	}
	
	self.forwardButton.x = display.contentWidth - self.forwardButton.contentWidth / 2
	self.forwardButton.y = display.contentHeight - self.forwardButton.contentHeight
	self:insert( self.forwardButton )
	
	return self
	
end