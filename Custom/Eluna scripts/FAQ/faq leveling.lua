local cmd = "faq leveling"

local function OnCommand(event, player, command)
    if command == cmd then
        player:SendNotification("Please use the (mobile) teleporters to navigate to the correct leveling zone location.")
        player:SendBroadcastMessage("Please use the (mobile) teleporters to navigate to the correct leveling zone location.")
        end
        return false
end
RegisterPlayerEvent(42, OnCommand)