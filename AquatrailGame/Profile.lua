module(..., package.seeall)

local loadsave = require("loadsave")

local MAXLEVELINWORLD=6

worldinfo = {}

worldinfo.version = 8
worldinfo.sound = 50
worldinfo.bruitage = 50
 

--ATTENTION IL MANQUE TOUS LES LEVELS DES MONDES 2 3 & 4
 --[[
for i=1, 4
do
	worldinfo["world"..i] = { unlocked = false }
	for j=1, MAXLEVELINWORLD
	do
	print(" 'else' i = "..i.." j= "..j)
		worldinfo["world"..i]["level"..j] = { score = 0, time = "", unlocked = false }
	end
end

worldinfo.world1.unlocked = true
--]]

 -- Le code ci-dessus remplace le code ci-dessous normalement
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

--WORLDINFO 2
--
worldinfo.world2 = {}
worldinfo.world2.unlocked = true

worldinfo.world2.level1 = {}
worldinfo.world2.level1.score = 0
worldinfo.world2.level1.time = ""
worldinfo.world2.level1.unlocked = true

worldinfo.world2.level2 = {}
worldinfo.world2.level2.score = 0
worldinfo.world2.level2.time = ""
worldinfo.world2.level2.unlocked = false

worldinfo.world2.level3 = {}
worldinfo.world2.level3.score = 0
worldinfo.world2.level3.time = ""
worldinfo.world2.level3.unlocked = false

worldinfo.world2.level4 = {}
worldinfo.world2.level4.score = 0
worldinfo.world2.level4.time = ""
worldinfo.world2.level4.unlocked = false

worldinfo.world2.level5 = {}
worldinfo.world2.level5.score = 0
worldinfo.world2.level5.time = ""
worldinfo.world2.level5.unlocked = false

worldinfo.world2.level6 = {}
worldinfo.world2.level6.score = 0
worldinfo.world2.level6.time = ""
worldinfo.world2.level6.unlocked = false

--WORLDINFO 3
--
worldinfo.world3 = {}
worldinfo.world3.unlocked = true

worldinfo.world3.level1 = {}
worldinfo.world3.level1.score = 0
worldinfo.world3.level1.time = ""
worldinfo.world3.level1.unlocked = true

worldinfo.world3.level2 = {}
worldinfo.world3.level2.score = 0
worldinfo.world3.level2.time = ""
worldinfo.world3.level2.unlocked = false

worldinfo.world3.level3 = {}
worldinfo.world3.level3.score = 0
worldinfo.world3.level3.time = ""
worldinfo.world3.level3.unlocked = false

worldinfo.world3.level4 = {}
worldinfo.world3.level4.score = 0
worldinfo.world3.level4.time = ""
worldinfo.world3.level4.unlocked = false

worldinfo.world3.level5 = {}
worldinfo.world3.level5.score = 0
worldinfo.world3.level5.time = ""
worldinfo.world3.level5.unlocked = false

worldinfo.world3.level6 = {}
worldinfo.world3.level6.score = 0
worldinfo.world3.level6.time = ""
worldinfo.world3.level6.unlocked = false

worldinfo.world4 = {}
worldinfo.world4.unlocked = false


local initProfile = function( )
	local worldInfoFile = loadsave.loadTable("profile.json")
	if (worldInfoFile == nil ) then
		loadsave.saveTable(worldinfo, "profile.json")
		loadsave.saveTable(worldinfo, "profileOrigin.json")
		print("JASON FILE NOT FOUND, CREATING NEW FILE")
	elseif (worldInfoFile.version ~= worldinfo.version ) then		loadsave.saveTable(worldinfo, "profile.json")
		loadsave.saveTable(worldinfo, "profileOrigin.json")
		print("JASON FILE OUT DATED, CREATING NEW FILE")	else 
		worldinfo = worldInfoFile
		print("WORLDINFO LOADED FROM FILE")
	end
end

local saveInfoLevel = function(idWorld, idLevel,score, time)
	local nextIdLevel = idLevel+1 
	local nextIdWorld = idWorld+1 
	local oldScore = worldinfo["world"..idWorld]["level"..idLevel].score
	--local oldTime = worldinfo["world"..idWorld]["level"..idLevel].time
	print("idWorld "..idWorld.." idLevel "..idLevel.."\noldScore "..oldScore.." NewScore "..score)
	if (oldScore<score)then
		worldinfo["world"..idWorld]["level"..idLevel].score=tonumber(score)
	end
	--[[
	if (oldTime>time)then
		worldinfo["world"..idWorld]["level"..idLevel].time=tonumber(time)
	end
	]]--
	--unlock next level
	if (MAXLEVELINWORLD<=idLevel) then
		worldinfo["world"..nextIdWorld].unlocked = true
	else
		worldinfo["world"..idWorld]["level"..nextIdLevel].unlocked=true
	end
	loadsave.saveTable(worldinfo, "profile.json")
end

local eraseProfile = function()
	local worldInfoOriginFile = loadsave.loadTable("profileOrigin.json")
	worldinfo = worldInfoOriginFile
	loadsave.saveTable(worldinfo, "profile.json")
end

local saveOption = function(musi,brui)
	worldinfo.sound = musi
	worldinfo.bruitage = brui
	print(musi)
	loadsave.saveTable(worldinfo, "profile.json")
end
local getInfos = function ()
	return worldinfo
end

local Profile = { initProfile=initProfile, saveInfoLevel=saveInfoLevel, getInfos=getInfos, saveOption=saveOption, eraseProfile=eraseProfile}

return Profile


