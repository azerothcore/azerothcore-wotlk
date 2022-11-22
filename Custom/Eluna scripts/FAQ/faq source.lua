local cmd = "faq source"

local function OnCommand(event, player, command)
    if command == cmd then
        player:SendNotification("The sourcecode and full changelog can be found under https://github.com/darkmord1991/DarkChaos-255.")
        player:SendBroadcastMessage("The sourcecode and full changelog can be found under https://github.com/darkmord1991/DarkChaos-255.")
        end
        return false
end
RegisterPlayerEvent(42, OnCommand)