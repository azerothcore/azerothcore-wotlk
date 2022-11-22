local cmd = "faq discord"

local function OnCommand(event, player, command)
    if command == cmd then
        player:SendNotification("PLACEHOLDER")
        player:SendBroadcastMessage("PLACEHOLDER")
        end
        return false
end
RegisterPlayerEvent(42, OnCommand)