--CHRONOMETRE--
--Creation d'une "classe" Chrono
	Chrono = {}

	Chrono.secondePast = true
	Chrono.minutePast = false
	Chrono.secondes = -1
	Chrono.minutes = 0
	Chrono.display = false
	Chrono.timeDisplayed = ""
	Chrono.secondesDelta = 0
	Chrono.pause = false
	
	--Afficher le chronometre
	function Display()
		if(Chrono.display) then 
			local zeroComposite = ""
			if(Chrono.secondes < 10) then zeroComposite = "0" end
			
			display.remove(Chrono.timeDisplayed)
			
			Chrono.timeDisplayed = display.newText(Chrono.minutes..":"..zeroComposite..Chrono.secondes, 0, 0, "Arial", 16)
			Chrono.timeDisplayed:setTextColor(255, 255, 255)
			Chrono.timeDisplayed:setReferencePoint(display.TopLeftReferencePoint)
			Chrono.timeDisplayed.x = display.contentWidth*0.5 - Chrono.timeDisplayed.width*0.5
			Chrono.timeDisplayed.y = display.contentHeight - Chrono.timeDisplayed.height
		end
	end
	
	--Systeme de chronometre
	function enterFrame(event)
		if(not Chrono.pause)
		then
			if((event.time%1000) >=0 and (event.time%1000) <= 500 and not Chrono.secondePast)
			then
				Chrono.secondes = Chrono.secondes+1
				Chrono.secondePast = true
				if(Chrono.display) then Display() end
				Chrono.secondesDelta = Chrono.secondesDelta+1
			end
			if((event.time%1000) >500 and (event.time%1000) <= 999 and Chrono.secondePast)
			then
				Chrono.secondePast = false
			end
			
			if(Chrono.secondes%59 == 0 and not(Chrono.secondes <= 0) and not Chrono.minutePast and (event.time%1000) >500 and (event.time%1000) <= 999)
			then
				Chrono.secondes = -1
				Chrono.minutes = Chrono.minutes+1
				Chrono.minutePast = true
			end
			if(Chrono.minutePast and (event.time%1000) >=0 and (event.time%1000) <= 500)
			then
				Chrono.minutePast = false
			end
		end
	end
	
	--Lancer le chronometre
	local Start = function ()
		Runtime:addEventListener("enterFrame", enterFrame)
	end
	
	--Pause du chrono
	local Pause = function()
		if(Chrono.pause)
		then
			Chrono.pause = false
		else
			Chrono.pause = true
		end
	end
	
	--reinitialiser
	function reInitialize()
		Chrono.secondePast = true
		Chrono.minutePast = false
		Chrono.secondes = -1
		Chrono.minutes = 0
		Chrono.display = false
		Chrono.timeDisplayed = ""
		Chrono.secondesDelta = 0
		Chrono.pause = false
	end
	
	--Stopper le chronometre
	local Stop = function ()
		Runtime:removeEventListener("enterFrame", enterFrame)
		reInitialize()
	end

	--Getter et Setter
	local getSecondes = function () return Chrono.secondes end
	local getMinutes = function () return Chrono.minutes end
	local getTotalTimeInSecond = function () return Chrono.minutes*60+Chrono.secondes end
	local resetSecondesDelta = function () Chrono.secondesDelta = 0 end
	local getSecondesDelta = function () return Chrono.secondesDelta end
	local setDisplay = function(isDisplay) Chrono.display = isDisplay end
	
 local Chronometre = { Start=Start, Pause=Pause, Stop=Stop, getSecondes=getSecondes, getMinutes=getMinutes, getTotalTimeInSecond=getTotalTimeInSecond, resetSecondesDelta=resetSecondesDelta, getSecondesDelta=getSecondesDelta, setDisplay=setDisplay }
 
 return Chronometre
	
--Fin de la "classe" Chrono