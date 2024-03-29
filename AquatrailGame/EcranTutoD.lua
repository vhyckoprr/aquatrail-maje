module(..., package.seeall)
-- Main function - MUST return a display.newGroup()a
new = function ( params )

	--system.activate( "multitouch" )
	local DynResManager = require("DynResManager")
	local GameLogic = require("GameLogic")
	local level = 1
	local localGroup = display.newGroup()
	local tuto = false
	chargement.preLoadAnim()
	--Background
   local ecranTuto = display.newImage("ecran-tuto-desert.png")
   ecranTuto.isVisible = true
   ecranTuto.x = 	display.contentWidth/2 
   ecranTuto.y =  display.contentHeight/2 
   --fit
   --localGroup:insert(ecranTuto)
   
   localGroup:insert(ecranTuto)
   function ToucheScreenTuto (event)
		if event.phase == "began" then
			chargement.play()
		end
		if event.phase == "ended" then
			if tuto then
					if level == 1 then
						director:changeScene ("Des1")
					elseif level == 2 then
						director:changeScene ("Des2")
					elseif level == 3 then
						director:changeScene ("Des3")
					elseif level == 4 then
						director:changeScene ("Des4")
					elseif level == 5 then
						director:changeScene ("Des5")
					elseif level == 6 then
						director:changeScene ("Des6")
					end
				Runtime:removeEventListener("touch", ToucheScreenTuto)
				else
					tuto = true
			end
		end
   end
   Runtime:addEventListener("touch", ToucheScreenTuto)
   
   return localGroup
end

