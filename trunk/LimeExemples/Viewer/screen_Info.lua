module(..., package.seeall)

local ui = require( "ui" )

function new()

	local self = display.newGroup()

	self.back = display.newRect(self, 0, 0, display.contentWidth, display.contentHeight)
	self.back:setFillColor( 0, 0, 0 )
	
	self.header = display.newImage( self, "infoHeader.png" )
	
	local onBackButtonRelease = function( event )
		director:changeScene( "screen_Main", "moveFromRight" )
	end
	
	self.backButton = ui.newButton
	{
		default = "button_forward.png",
		over = "button_forward_over.png",
		onRelease = onBackButtonRelease
	}
	
	self.backButton.x = display.contentWidth - self.backButton.contentWidth / 2 - 5
	self.backButton.y = display.contentHeight - self.backButton.contentHeight / 2 - 10
	self:insert( self.backButton )
	
	self.websiteLink = display.newImage( self, "website.png" )
	self.websiteLink.x = display.contentCenterX
	self.websiteLink.y = display.contentHeight - self.websiteLink.contentHeight / 2
	self.websiteLink:addEventListener( "tap", function() system.openURL( "http://justaddli.me/" ) end )
	
	return self
	
end