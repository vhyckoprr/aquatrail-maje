--CHRONOMETRE--
--Creation d'une "classe" Chrono
	Chrono = {}

	Chrono.timerId = 0
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
			
			Chrono.timeDisplayed = display.newText(Chrono.minutes..":"..zeroComposite..Chrono.secondes, 0, 0, "Arial", 30)
			Chrono.timeDisplayed:setTextColor(255, 255, 255)
			Chrono.timeDisplayed:setReferencePoint(display.TopCenterReferencePoint)
			Chrono.timeDisplayed.x = display.contentWidth*0.5
			Chrono.timeDisplayed.y = display.contentHeight*0.01
		end
	end
	
	--Systeme de chronometre
	function update(event)
		if(not Chrono.pause)
		then
			Chrono.secondes = Chrono.secondes+1
			Chrono.secondePast = true
			if(Chrono.display) then Display() end
			Chrono.secondesDelta = Chrono.secondesDelta+1
			
			if(Chrono.secondes%59 == 0 and not(Chrono.secondes <= 0))
			then
				Chrono.secondes = -1
				Chrono.minutes = Chrono.minutes+1
			end
		end
	end
	
	--Lancer le chronometre
	local Start = function ()
		timer.performWithDelay(0, update)
		Chrono.timerId = timer.performWithDelay(1000, update, 0)
	end
	
	--Pause du chrono
	local Pause = function()
		if(Chrono.pause) then Chrono.pause = false
		else Chrono.pause = true end
	end
	
	--reinitialiser
	function reInitialize()
		Chrono.timerId = 0
		Chrono.secondes = -1
		Chrono.minutes = 0
		Chrono.display = false
		Chrono.timeDisplayed = ""
		Chrono.secondesDelta = 0
		Chrono.pause = false
	end
	
	--Stopper le chronometre
	local Stop = function ()
		timer.cancel(Chrono.timerId)
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