------- ClipboardTool -------
lawl = hs.loadSpoon("ClipboardTool")
lawl:start()


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


lol = hs.loadSpoon("MiroWindowsManager")	
hs.window.animationDuration = 0.0
spoon.MiroWindowsManager:bindHotkeys({
  up = {"cmd", "k"},
  right = {"cmd", "l"},
  down = {"cmd", "j"},
  left = {"cmd", "h"},
  fullscreen = {{"cmd", "shift"}, "k"}								
})


--------- Switcher -----------

switcher_space = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter{})
print(switcher_space)
switcher_space.ui.fontName = 'Monaco'
switcher_space.ui.textSize = 15		
switcher_space.ui.showTitles = false

hs.window.switcher.ui.ThumbnailSize = 256 
hs.window.switcher.ui.showSelectedThumbnail = false
hs.window.switcher.ui.showSelectedTitle = false
-- alternatively, call .nextWindow() or .previousWindow() directly (same as hs.window.switcher.new():next())
hs.hotkey.bind('alt','tab',function()switcher_space:next()end, nil, function()switcher_space:next()end)
--hs.hotkey.bind('alt','tab',switcher_space.nextWindow,nil,switcher_space.nextWindow)
-- you can also bind to `repeatFn` for faster traversing
hs.hotkey.bind('alt-shift','tab',function()switcher_space:previous()end, nil, function()switcher_space:previous()end)
---hs.hotkey.bind('alt-shift','tab',switcher_space.previousWindow,nil,switcher_space.previousWindow)


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
hs.hotkey.bind({"cmd"},"tab",function()
end)


------ HeadphoneAutoPause --------
hap = hs.loadSpoon("HeadphoneAutoPause")
hap.autoResume = false
hap:start()




