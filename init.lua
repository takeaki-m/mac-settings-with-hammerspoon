-- [[
cf
https://mac-ra.com/hammerspoon-command-eikana02://mac-ra.com/hammerspoon-command-eikana02/
https://qiita.com/mishiwata1015/items/fb7527e5b45f84a90eec
]]

-- [[
check current input source name
ctrl + cmd + ↓
]]
hs.hotkey.bind({"ctrl", "cmd"}, "down", function()
    -- local method = hs.keycodes.currentMethod()
    local method = hs.keycodes.currentLayout()
    hs.alert.show(method)
end)



-- [[
change input source with command key
right-command -> Japanese
left-command -> ABC
]]
local simpleCmd = false
local map = hs.keycodes.map

local function kanaSwitchEvent(event)
    local c = event:getKeyCode()
    local f = event:getFlags()
    if event:getType() == hs.eventtap.event.types.keyDown then
        if f['cmd'] then
            simpleCmd = true
        end
    elseif event:getType() == hs.eventtap.event.types.flagsChanged then
        if not f['cmd'] then
            if simpleCmd == false then
                if c == map['cmd'] then
                    hs.keycodes.setLayout("ABC")
                elseif c == map['rightcmd'] then
                    hs.keycodes.setMethod('Hiragana')
                end
            end
            simpleCmd = false
        end
    end
end

kanaSwitcher = hs.eventtap.new(
    {hs.eventtap.event.types.keyDown, hs.eventtap.event.types.flagsChanged},
    kanaSwitchEvent
    )
kanaSwitcher:start()


