local cmd = "faq t11"

local function OnCommand(event, player, command)
    if command == cmd then
        player:SendNotification("For T11 you need 2500 tokens for each Tier 11 item.")
        player:SendBroadcastMessage("For T11 you need 2500 tokens for each Tier 11 item.")
        end
        return false
end
RegisterPlayerEvent(42, OnCommand)