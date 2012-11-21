module(..., package.seeall)

local lime = require("lime")
local ui = require("ui")

function new()

	local self = display.newGroup()

	self.drawModes = {}
	self.drawModes[1] = "normal"
	self.drawModes[2] = "hybrid"
	self.drawModes[3] = "debug"
	
	self.drawModeIndex = 1
	
	local onReturnToMainMenuButtonRelease = function(event)
		self.buttonJustPressed = true
		director:changeScene("screen_MapList", "moveFromLeft")
	end
	
	local onReloadButtonRelease = function(event)
		--director:changeScene("screen_InMapSettings", "moveFromRight")
		
		self.map = self.map:reload()
		self:insert(self.map.world)
		
		self.returnToMenuButton.parent:insert(self.returnToMenuButton)
		self.reloadButton.parent:insert(self.reloadButton)
		self.fpsButton.parent:insert(self.fpsButton)
		self.physicsDrawModeButton.parent:insert(self.physicsDrawModeButton)
		
		self.buttonJustPressed = true
		
	end
	
	local onFPSButtonRelease = function(event)
	
		if performance.group then
			performance.group.parent:insert(performance.group)
			performance.group.isVisible = not performance.group.isVisible
		end
		
		self.buttonJustPressed = true
		
	end
	
	local onPhysicsDrawModeButtonRelease = function(event)
		
		self.drawModeIndex = self.drawModeIndex + 1
		
		if self.drawModeIndex > #self.drawModes then
			self.drawModeIndex = 1
		end
		
		physics.setDrawMode(self.drawModes[ self.drawModeIndex ])
		
		self.buttonJustPressed = true	
	end
	
	local onFallingBlockProperty = function(property, type, object)
		self.map:setFocus(object.sprite)
	end
	
	-- Create a background colour just to make the map look a little nicer
	self.back = display.newRect(self, 0, 0, display.contentWidth, display.contentHeight)
	
	local backColour = _G["map"].backColour or { 165, 210, 255 }
	self.back:setFillColor( backColour[1], backColour[2], backColour[3] )

	if _G["map"].useCulling then
		lime.enableScreenCulling()
	else
		lime.disableScreenCulling()
	end
	
	-- Load the map
	self.map = lime.loadMap(_G["map"].file)
	
	if _G["map"].name == "Physics Slide" then
		self.map:addPropertyListener("FallingBlock", onFallingBlockProperty)
	end	
	
	if _G["map"].useClamping == false then
		self.map:disableScreenClamping()
	end
		
	
	-- Create the visual
	self.visual = lime.createVisual(self.map)
	
	-- Create the physical
	lime.buildPhysical(self.map)
	
	-- Add the map to the screen group
	self:insert(self.visual)
	
	
	self.buttonJustPressed = true
	
	self.returnToMenuButton = ui.newButton{
		default = "button_inMapReturnToMenu.png",
		over = "button_inMapReturnToMenu_over.png",
		onRelease = onReturnToMainMenuButtonRelease,
		emboss = true
	}
	
	self.returnToMenuButton.x = self.returnToMenuButton.width / 2
	self.returnToMenuButton.y = self.returnToMenuButton.height / 2
	self.returnToMenuButton.alpha = 0.7
	self:insert(self.returnToMenuButton)
		
	self.reloadButton = ui.newButton{
		default = "button_inMapReload.png",
		over = "button_inMapReload_over.png",
		onRelease = onReloadButtonRelease,
		emboss = true
	}
	
	self.reloadButton.x = display.contentWidth - self.reloadButton.width / 2
	self.reloadButton.y = self.reloadButton.height / 2
	self.reloadButton.alpha = 0.7
	self:insert(self.reloadButton)	
	
	self.fpsButton = ui.newButton{
		default = "button_inMapFPS.png",
		over = "button_inMapFPS_over.png",
		onRelease = onFPSButtonRelease,
		emboss = true
	}
	
	self.fpsButton.x = display.contentWidth - self.fpsButton.width / 2
	self.fpsButton.y = display.contentHeight - self.fpsButton.height / 2
	self.fpsButton.alpha = 0.7
	self:insert(self.fpsButton)
	
	self.physicsDrawModeButton = ui.newButton{
		default = "button_inMapPhysicsDrawMode.png",
		over = "button_inMapPhysicsDrawMode_over.png",
		onRelease = onPhysicsDrawModeButtonRelease,
		emboss = true
	}
	
	self.physicsDrawModeButton.x = self.physicsDrawModeButton.width / 2
	self.physicsDrawModeButton.y = display.contentHeight - self.physicsDrawModeButton.height / 2
	self.physicsDrawModeButton.alpha = 0.7
	self.physicsDrawModeButton.isVisible = _G["map"].usesPhysics
	self:insert(self.physicsDrawModeButton)
	
	local onUpdate = function(event)
		self.map:update(event)
	end
	
	local onTouch = function(event)
		self.map:drag(event)
	end
	
	local onTap = function(event)
		
		if self.buttonJustPressed then
			self.buttonJustPressed = false
			return
		end
		
		local screenPosition = { x = event.x, y = event.y }
		local worldPosition = lime.utils.screenToWorldPosition(self.map, screenPosition)

	--	self.map:setPosition(worldPosition.x, worldPosition.y)
	--	self.map:fadeToPosition(worldPosition.x, worldPosition.y)
		self.map:slideToPosition(worldPosition.x, worldPosition.y)
		
	end
	
	function clean()
		Runtime:removeEventListener("enterFrame", onUpdate)
		
		if performance.group then
			performance.group.isVisible = false
		end
		
		self.map:destroy()
	end
	
	Runtime:addEventListener("enterFrame", onUpdate)
	self:addEventListener("touch", onTouch)
	self:addEventListener("tap", onTap)
	
	self.mapJustRecreated = false
	
	physics.setDrawMode("normal")

	return self
	
end