module(..., package.seeall)

--====================================================================--a
-- GET Height Visible
--====================================================================--

local getScreenHeightPhysPix = function( )
	local maxVisibleY = display.viewableContentHeight + -1* display.screenOriginY
	local screenHeightAppPix = maxVisibleY - display.screenOriginY
	local screenHeightPhysPix  = math.floor(screenHeightAppPix / display.contentScaleY + 0.51)
	--print("Y"..maxVisibleY.." "..screenHeightAppPix.." "..screenHeightPhysPix)
	return screenHeightPhysPix
end

--====================================================================--
-- GET Width Visible
--====================================================================--

local getScreenWidthPhysPix = function( )
	local maxVisibleX = display.viewableContentWidth + -1* display.screenOriginX
	local screenWidthAppPix  = maxVisibleX - display.screenOriginX
	local screenWidthPhysPix   = math.floor(screenWidthAppPix / display.contentScaleX + 0.51)
	--print("X"..maxVisibleX.." "..screenWidthAppPix.." "..screenWidthPhysPix)
	return screenWidthPhysPix
end

--====================================================================--
-- Create Center Rectangle fitted
--====================================================================--

local createCenterRectangleFitted = function( )
	
	local maxVisibleX = display.viewableContentWidth + -1* display.screenOriginX
	local screenWidthAppPix  = maxVisibleX - display.screenOriginX
	local screenWidthPhysPix   = math.floor(screenWidthAppPix / display.contentScaleX + 0.51)
	
	local maxVisibleY = display.viewableContentHeight + -1* display.screenOriginY
	local screenHeightAppPix = maxVisibleY - display.screenOriginY
	local screenHeightPhysPix  = math.floor(screenHeightAppPix / display.contentScaleY + 0.51)
	
	local back = display.newRect(math.floor(maxVisibleX-screenWidthAppPix),math.floor(maxVisibleY-screenHeightAppPix) , screenWidthPhysPix, screenHeightPhysPix)
	return back
end




local DynResManager = { getScreenHeightPhysPix = getScreenHeightPhysPix,  getScreenWidthPhysPix = getScreenWidthPhysPix, createCenterRectangleFitted = createCenterRectangleFitted}

return DynResManager