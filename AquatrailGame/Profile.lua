module(..., package.seeall)

local loadsave = require("loadsave")

local MAXLEVELINWORLD=6

worldinfo = {}

worldinfo.version = 1
 
worldinfo.world1 = {}
worldinfo.world1.unlocked = true

worldinfo.world1.level1 = {}
worldinfo.world1.level1.score = 0
worldinfo.world1.level1.time = ""
worldinfo.world1.level1.unlocked = true

worldinfo.world1.level2 = {}
worldinfo.world1.level2.score = 0
worldinfo.world1.level2.time = ""
worldinfo.world1.level2.unlocked = false

worldinfo.world1.level3 = {}
worldinfo.world1.level3.score = 0
worldinfo.world1.level3.time = ""
worldinfo.world1.level3.unlocked = false

worldinfo.world1.level4 = {}
worldinfo.world1.level4.score = 0
worldinfo.world1.level4.time = ""
worldinfo.world1.level4.unlocked = false

worldinfo.world1.level5 = {}
worldinfo.world1.level5.score = 0
worldinfo.world1.level5.time = ""
worldinfo.world1.level5.unlocked = false

worldinfo.world1.level6 = {}
worldinfo.world1.level6.score = 0
worldinfo.world1.level6.time = ""
worldinfo.world1.level6.unlocked = false

worldinfo.world2 = {}
worldinfo.world2.unlocked = false

worldinfo.world3 = {}
worldinfo.world3.unlocked = false

worldinfo.world4 = {}
worldinfo.world4.unlocked = false

--ATTENTION IL MANQUE TOUS LES LEVELS DES MONDES 2 3 & 4


local initProfile = function( )
	local worldInfoFile = loadsave.loadTable("profile.json")
	if (worldInfoFile == nil ) then
		loadsave.saveTable(worldinfo, "profile.json")
		print("JASON FILE NOT FOUND, CREATING NEW FILE")
	elseif (worldInfoFile.version ~= worldinfo.version ) then		loadsave.saveTable(worldinfo, "profile.json")
		print("JASON FILE OUT DATED, CREATING NEW FILE")	else 
		worldinfo = worldInfoFile
		print("WORLDINFO LOADED FROM FILE")
	end
end

local saveInfoLevel = function(idWorld, idLevel,score, time)
	local nextIdLevel = idLevel+1 
	local nextIdWorld = idWorld+1 
	local oldScore = worldinfo["world"..idWorld]["level"..idLevel].score
	print("idWorld "..idWorld.." idLevel "..idLevel.." oldScore "..oldScore.." NewScore "..score)
	if (oldScore<score)then
		worldinfo["world"..idWorld]["level"..idLevel].score=tonumber(score)
	end
	--unlock next level
	if (MAXLEVELINWORLD<=idLevel) then
		worldinfo["world"..nextIdWorld].unlocked = true
	else
		worldinfo["world"..idWorld]["level"..nextIdLevel].unlocked=true
	end
	loadsave.saveTable(worldinfo, "profile.json")
end

local getInfos = function ()
	return worldinfo
end

local Profile = { initProfile=initProfile, saveInfoLevel=saveInfoLevel, getInfos=getInfos }

return Profile


