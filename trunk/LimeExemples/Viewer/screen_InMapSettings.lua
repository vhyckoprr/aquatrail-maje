module(..., package.seeall)

local ui = require("ui")

function new()

	local self = display.newGroup()

	local onReturnToMapButtonRelease = function(event)
		director:changeScene("screen_Map", "moveFromLeft")
	end
	
	self.back = display.newRect(self, 0, 0, display.contentWidth, display.contentHeight)
	self.back:setFillColor(255, 0, 0)
	
	self.returnToMapButton = ui.newButton{
		default = "images/ui/buttons/inMapReturnToMenu.png",
		over = "images/ui/buttons/inMapReturnToMenu.png",
		onRelease = onReturnToMapButtonRelease,
		emboss = true
	}
	
	self.returnToMapButton.x = self.returnToMapButton.width / 2
	self.returnToMapButton.y = self.returnToMapButton.height / 2
	self:insert(self.returnToMapButton)

	return self
	
end