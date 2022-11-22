local cmd = "faq teleporter"

local function OnCommand(event, player, command)
    if command == cmd then
        player:SendNotification("You can use a mobile teleporter with your pet or use the ones standing around everywhere.")
        player:SendBroadcastMessage("You can use a mobile teleporter with your pet or use the ones standing around everywhere.")
        end
        return false
end
RegisterPlayerEvent(42, OnCommand)