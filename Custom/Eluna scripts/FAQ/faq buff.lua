local cmd = "faq buff"

local function OnCommand(event, player, command)
    if command == cmd then
        player:SendNotification("Use .buff to get some buffs anywhere you are!")
        player:SendBroadcastMessage("Use .buff to get some buffs anywhere you are!")
        end
        return false
end
RegisterPlayerEvent(42, OnCommand)