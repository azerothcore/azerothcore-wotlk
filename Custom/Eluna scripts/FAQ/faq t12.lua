local cmd = "faq t12"

local function OnCommand(event, player, command)
    if command == cmd then
        player:SendNotification("For T12 you need 7500 tokens for each Tier 12 item.")
        player:SendBroadcastMessage("For T12 you need 7500 tokens for each Tier 12 item.")
        end
        return false
end
RegisterPlayerEvent(42, OnCommand)