local cmd = "faq maxlevel"

local function OnCommand(event, player, command)
    if command == cmd then
        player:SendNotification("The current Max Level is set to 80!")
        player:SendBroadcastMessage("The current Max Level is set to 80!")
        end
        return false
end
RegisterPlayerEvent(42, OnCommand)