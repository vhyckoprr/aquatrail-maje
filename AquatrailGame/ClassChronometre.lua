--CHRONOMETRE--
--Creation d'une "classe" Chrono
	Chrono = {}
	Chrono.__index = Chrono
	
	--Constructeur
	function Chrono:new()
		local var = {}
		setmetatable(var,Chrono)
		var.initTime = system.getTimer()/1000
		var.secondePast = 0
		var.minutePast = false
		var.secondes = 0
		var.minutes = 0
		var.display = false
		var.timeDisplayed = ""
		var.secondesDelta = 0
		return var
	end
	
	--Systeme de chronometre
	function Chrono:enterFrame(event)
		self.secondes = math.floor((event.time/1000)-self.initTime)%60
		if(self.secondes == 59 and self.minutePast) then 
			self.minutes = self.minutes+1;
			self.minutePast = false
		end
		if(self.secondePast == self.secondes) then
			--print(self.minutes.." : "..self.secondes)
			self.secondePast = (self.secondePast+1)%60
			if(self.secondePast == 0) then self.minutePast = true end
			if(self.display) then self:Display(self.display) end
			self.secondesDelta = self.secondesDelta+1
		end
	end
	
	--Lancer le chronometre
	function Chrono:Start()
		self.initTime = system.getTimer()/1000
		Runtime:addEventListener("enterFrame", self)
	end
	
	--Stopper le chronometre
	function Chrono:Stop()
		Runtime:removeEventListener("enterFrame", self)
	end
	
	--Afficher le chronometre
	function Chrono:Display(isDisplay)
		self.display = isDisplay
		
		if(self.display) then 
			local zeroComposite = ""
			if(self.secondes < 10) then zeroComposite = "0" end
			
			display.remove(self.timeDisplayed)
			
			self.timeDisplayed = display.newText(self.minutes..":"..zeroComposite..self.secondes, 0, 0, "Toledo", 16)
			self.timeDisplayed:setTextColor(255, 255, 255)
			self.timeDisplayed:setReferencePoint(display.TopLeftReferencePoint)
			self.timeDisplayed.x = display.contentWidth*0.5 - self.timeDisplayed.width*0.5
			self.timeDisplayed.y = display.contentHeight - self.timeDisplayed.height
		end
	end
	
	--reinitialiser
	function Chrono:reInitialize()
		self.secondePast = 0
		self.minutePast = false
		self.secondes = 0
		self.minutes = 0
		self.display = false
		self.timeDisplayed = ""
		self:Stop()
	end
	
	--Getter et Setter
	function getSecondes() return self.secondes end
	function getMinutes() return self.minutes end
	function getTimeInSecond() return self.minutes*60+self.secondes end
	function resetSecondesDelta() self.secondesDelta = 0 end
	function getSecondesDelta() return self.secondesDelta end
--Fin de la "classe" Chrono