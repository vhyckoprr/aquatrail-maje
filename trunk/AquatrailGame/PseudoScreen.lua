module(..., package.seeall)
-- Main function - MUST return a display.newGroup()
new = function ( params )

local localGroup = display.newGroup()

local widget = require( "widget" )

local tHeight		-- forward reference
local function fieldHandler( textField )
	return function( event )
		if ( "began" == event.phase ) then
			-- This is the "keyboard has appeared" event
			-- In some cases you may want to adjust the interface when the keyboard appears.
		
		elseif ( "ended" == event.phase ) then
			-- This event is called when the user stops editing a field: for example, when they touch a different field
			
		elseif ( "editing" == event.phase ) then
		
		elseif ( "submitted" == event.phase ) then
			-- This event occurs when the user presses the "return" key (if available) on the onscreen keyboard
			print( textField().text )
			-- Hide keyboard
			native.setKeyboardFocus( nil )
		end
	end
end

-- Predefine local objects for use later
local defaultField
local fields = display.newGroup()

-- Determine if running on Corona Simulator
--
local isSimulator = "simulator" == system.getInfo("environment")
if system.getInfo( "platformName" ) == "Mac OS X" then isSimulator = false; end

-- Default Button Pressed
local defaultButtonPress = function( event )
	-- si simulateur on passe un nom a la con
	if isSimulator then
		director:changeScene("TitleScreen")
	else -- sinon on s'assure que le nom comporte entre 3 et 12 caractères
		if ( string.len( defaultField.text)>2 and string.len(defaultField.text)<13) then
			profile.saveProfile(defaultField.text)
			director:changeScene("TitleScreen")
		else
			msg = display.newText( "Votre pseudo doit comporter entre 3 et 12 caractères", 0, 280, "Arial", 12 )
			msg.x = display.contentWidth/2		-- center title
			msg:setTextColor( 255,255,0 )
		end
	end
	native.setKeyboardFocus( nil )
end


-------------------------------------------
-- *** Create native input textfields ***
-------------------------------------------

-- Note: currently this feature works in device builds or Xcode simulator builds only (also works on Corona Mac Simulator)
local isAndroid = "Android" == system.getInfo("platformName")
local inputFontSize = 18
local inputFontHeight = 30
tHeight = 30

if isAndroid then
	-- Android text fields have more chrome. It's either make them bigger, or make the font smaller.
	-- We'll do both
	inputFontSize = 14
	inputFontHeight = 42
	tHeight = 40
end

defaultField = native.newTextField( 10, 30, 180, tHeight )
defaultField.font = native.newFont( native.systemFontBold, inputFontSize )
defaultField:addEventListener( "userInput", fieldHandler( function() return defaultField end ) ) 

-- Add fields to our new group
fields:insert(defaultField)
localGroup:insert(fields)
-------------------------------------------
-- *** Add field labels ***
-------------------------------------------

local defaultLabel = display.newText( "Rentrez votre Pseudo", display.contentWidth/2, 35, native.systemFont, 18 )
defaultLabel:setTextColor( 170, 170, 255, 255 )
localGroup:insert(defaultLabel)

-------------------------------------------
-- *** Create Buttons ***
-------------------------------------------

-- "Remove Default" Button
defaultButton = widget.newButton{
	default = "bouton_niveau_desert_foret.png",
	over = "bouton_niveau_glace.png",
	onPress = defaultButtonPress,
	label = "Go",
	labelColor = { default = { 255, 255, 255 } },
	fontSize = 18,
	emboss = true
}


-- Position the buttons on screen
local s = display.getCurrentStage()
defaultButton.x = s.contentWidth/4;	
defaultButton.y = s.contentHeight/2;	
localGroup:insert(defaultButton)

-------------------------------------------
-- Create a Background touch event
-------------------------------------------

local bkgd = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
bkgd:setFillColor( 0, 0, 0, 0 )		-- set Alpha = 0 so it doesn't cover up our buttons/fields
localGroup:insert(bkgd)

-- Tapping screen dismisses the keyboard
--
-- Needed for the Number and Phone textFields since there is
-- no return key to clear focus.

local listener = function( event )
	-- Hide keyboard
	print("tap pressed")
	native.setKeyboardFocus( nil )
	return true
end

-- Native Text Fields not supported on Simulator
--
if isSimulator then
	msg = display.newText( "Don't work on simulator", 0, 280, "Arial", 12 )
	msg.x = display.contentWidth/2		-- center title
	msg:setTextColor( 255,255,0 )
end

-- Add listener to background for user "tap"
bkgd:addEventListener( "tap", listener )



	-- MUST return a display.newGroup()
	return localGroup
end
