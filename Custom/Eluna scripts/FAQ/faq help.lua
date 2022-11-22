local cmd = "faq help"

local function OnCommand(event, player, command)
    if command == cmd then
        player:SendNotification("This is a list of all commands for related to FAQ. - use .faq + see below")
        player:SendBroadcastMessage("buff")
        player:SendBroadcastMessage("leveling")
        player:SendBroadcastMessage("teleporter")
        player:SendBroadcastMessage("source")
        player:SendBroadcastMessage("progression")
        player:SendBroadcastMessage("discord")
        player:SendBroadcastMessage("maxlevel")
        player:SendBroadcastMessage("hinterland")
        player:SendBroadcastMessage("dungeons")
        player:SendBroadcastMessage("buff")
        player:SendBroadcastMessage("buff")
        end
        return false
end
RegisterPlayerEvent(42, OnCommand)