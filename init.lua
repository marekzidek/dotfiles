-- https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip
hs.loadSpoon("SpoonInstall")

------- ClipboardTool -------
spoon.SpoonInstall:andUse("ClipboardTool",
    {
        fn = function(lawl)
            lawl:start()
            lawl.show_copied_alert = false
            lawl.hist_size = 10000
        end
    })

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")

----------- Seal -------------
--spoon.SpoonInstall:andUse("Seal",
--               {
--                 hotkeys = { show = { {"cmd", "shift"}, "space" } },
--                 fn = function(s)
--                   s:loadPlugins({"apps", "calc", "safari_bookmarks",
--                                  "screencapture", "useractions"})
--                   s.plugins.safari_bookmarks.always_open_with_safari = false
--                   s.plugins.useractions.actions =
--                     {
--
--                     }
--                   s:refreshAllCommands()
--                 end,
--                 start = true,
--               }
--)



------ iTerm2 key bind ------
hs.hotkey.bind({"alt"}, '1', function()hs.application.launchOrFocus('iTerm')end)
hs.hotkey.bind({"alt"}, '2', function()hs.application.launchOrFocus('Google Chrome')end)
hs.hotkey.bind({"alt"}, '3', function()hs.application.get('Slack'):activate()end)
hs.hotkey.bind({"alt"}, '4', function()hs.application.launchOrFocus('Microsoft Outlook')end)
hs.hotkey.bind({"alt"}, '7', function()hs.application.launchOrFocus('zoom.us')end)


------ Window tiling --------

hs.hotkey.bind({"cmd", "shift"}, "l", function()
  local win = hs.window.focusedWindow();
  if not win then return end
win:moveToScreen(win:screen():next())
end)

hs.hotkey.bind({"cmd", "shift"}, "h", function()
  local win = hs.window.focusedWindow();
  if not win then return end
win:moveToScreen(win:screen():previous())
end)

hs.hotkey.bind({"cmd", "shift"}, "j", function()
	local win = hs.window.focusedWindow();
	if not win then return end
win:minimize()
end)




spoon.SpoonInstall:andUse("MiroWindowsManager",
    {
	fn = function(lol)
	    hs.window.animationDuration = 0.0
	    lol:bindHotkeys({
	      up = {"cmd", "k"},
	      right = {"cmd", "l"},
	      down = {"cmd", "j"},
	      left = {"cmd", "h"},
	      fullscreen = {{"cmd", "shift"}, "k"}
	    })
	end
    }
)


-- MOVEMENT OF A FOCUSED WINDOW TO A DIFFERENT DESKTOP --
local hotkey = require "hs.hotkey"
local window = require "hs.window"
local spaces = require "hs.spaces"

function getGoodFocusedWindow(nofull)
   local win = window.focusedWindow()
   if not win or not win:isStandard() then return end
   if nofull and win:isFullScreen() then return end
   return win
end

function flashScreen(screen)
   local flash=hs.canvas.new(screen:fullFrame()):appendElements({
	 action = "fill",
	 fillColor = { alpha = 0.25, red=1},
	 type = "rectangle"})
   flash:show()
   hs.timer.doAfter(.15,function () flash:delete() end)
end

function switchSpace(skip,dir)
   for i=1,skip do
      hs.eventtap.keyStroke({"ctrl","fn"},dir,0) -- "fn" is a bugfix!
   end
end

function moveWindowOneSpace(dir,switch)
   local win = getGoodFocusedWindow(true)
   if not win then return end
   local screen=win:screen()
   local uuid=screen:getUUID()
   local userSpaces=nil
   for k,v in pairs(spaces.allSpaces()) do
      userSpaces=v
      if k==uuid then break end
   end
   if not userSpaces then return end
   local thisSpace=spaces.windowSpaces(win) -- first space win appears on
   if not thisSpace then return else thisSpace=thisSpace[1] end
   local last=nil
   local skipSpaces=0
   for _, spc in ipairs(userSpaces) do
      if spaces.spaceType(spc)~="user" then -- skippable space
	 skipSpaces=skipSpaces+1
      else
	 if last and
	    ((dir=="left" and spc==thisSpace) or
	     (dir=="right" and last==thisSpace)) then
	       local newSpace=(dir=="left" and last or spc)
	       if switch then
		  -- spaces.gotoSpace(newSpace)  -- also possible, invokes MC
		  switchSpace(skipSpaces+1,dir)
	       end
	       spaces.moveWindowToSpace(win,newSpace)
	       return
	 end
	 last=spc	 -- Haven't found it yet...
	 skipSpaces=0
      end
   end
   flashScreen(screen)   -- Shouldn't get here, so no space found
end

hotkey.bind({"shift", "cmd", "ctrl"}, "p",
	    function() moveWindowOneSpace("right",true) end)
hotkey.bind({"shift", "cmd", "ctrl"}, "n",
	    function() moveWindowOneSpace("left",true) end)

-- DISPLAY FOCUS SWITCHING --
local application = require "hs.application"
--One hotkey should just suffice for dual-display setups as it will naturally
--cycle through both.
--A second hotkey to reverse the direction of the focus-shift would be handy
--for setups with 3 or more displays.

--Bring focus to next display/screen
hs.hotkey.bind({"alt"}, "l", function ()
  focusScreen(hs.window.focusedWindow():screen():next())
end)

--Bring focus to previous display/screen
hs.hotkey.bind({"alt"}, "h", function()
  focusScreen(hs.window.focusedWindow():screen():previous())
end)

--Predicate that checks if a window belongs to a screen
function isInScreen(screen, win)
  return win:screen() == screen
end

-- Brings focus to the scren by setting focus on the front-most application in it.
-- Also move the mouse cursor to the center of the screen. This is because
-- Mission Control gestures & keyboard shortcuts are anchored, oddly, on where the
-- mouse is focused.
function focusScreen(screen)
  --Get windows within screen, ordered from front to back.
  --If no windows exist, bring focus to desktop. Otherwise, set focus on
  --front-most application window.
  local windows = hs.fnutils.filter(
      hs.window.orderedWindows(),
      hs.fnutils.partial(isInScreen, screen))
  local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
  windowToFocus:focus()

  -- Move mouse to center of screen
  local pt = geometry.rectMidPoint(screen:fullFrame())
  mouse.setAbsolutePosition(pt)
end


-- END DISPLAY FOCUS SWITCHING --

------ Slight focus window highlight -----
--- hs.window.highlight.ui.overlay=true
--- hs.window.highlight.ui.overlayColor = {0,0,0,0.04}
--- hs.window.highlight.start()



local application = require "hs.application"

---- Directional Focus ------
hs.hotkey.bind({"shift", "cmd", "ctrl"},'l',function()hs.window.focusedWindow():focusWindowEast(nil, true, true)end)

hs.hotkey.bind({"shift", "cmd", "ctrl"},'h',function()hs.window.focusedWindow():focusWindowWest(nil, true, true)end)

hs.hotkey.bind({"shift", "cmd", "ctrl"},'k',function()hs.window.focusedWindow():focusWindowNorth(nil, true, true)end)

hs.hotkey.bind({"shift", "cmd", "ctrl"},'j',function()hs.window.focusedWindow():focusWindowSouth(nil, true, true)end)

--------- Switcher -----------

--switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{})
--print(switcher_space)
--switcher_space.ui.fontName = 'Monaco'
--switcher_space.ui.textSize = 15
--switcher_space.ui.showTitles = false

--hs.window.switcher.ui.ThumbnailSize = 256
--hs.window.switcher.ui.showSelectedThumbnail = false
--hs.window.switcher.ui.showSelectedTitle = false
---- alternatively, call .nextWindow() or .previousWindow() directly (same as hs.window.switcher.new():next())
--hs.hotkey.bind('alt','tab',function()switcher_space:next()end, nil, function()switcher_space:next()end)
----hs.hotkey.bind('alt','tab',switcher_space.nextWindow,nil,switcher_space.nextWindow)
---- you can also bind to `repeatFn` for faster traversing
--hs.hotkey.bind('alt-shift','tab',function()switcher_space:previous()end, nil, function()switcher_space:previous()end)
-----hs.hotkey.bind('alt-shift','tab',switcher_space.previousWindow,nil,switcher_space.previousWindow)


--------- Wifi Show --------------
wifiMenu = hs.menubar.newWithPriority(2147483645)
wifiMenu:setTitle(hs.wifi.currentNetwork())

wifiWatcher = nil

function ssidChanged()
    local wifiName = hs.wifi.currentNetwork()
    if wifiName then
        wifiMenu:setTitle(wifiName)
    else
        wifiMenu:setTitle("Wifi OFF")
    end
end

wifiWatcher = hs.wifi.watcher.new(ssidChanged):start()


------ Disable CMD - tab ----- UNDER CONSTRUCTION
--hs.hotkey.bind({"cmd"},"tab",function()
--end)


------ HeadphoneAutoPause --------
spoon.SpoonInstall:andUse("HeadphoneAutoPause",
    {
        fn = function(hap)
            hap.autoResume = false
            hap:start()
        end
    }
)


----------------- GRID STUFF ---------
hs.grid.setMargins({w=15, h=13})
