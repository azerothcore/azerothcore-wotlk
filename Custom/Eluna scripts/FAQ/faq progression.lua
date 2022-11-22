local cmd = "faq progression"

local function OnCommand(event, player, command)
    if command == cmd then
        player:SendNotification("Right now Max Level is set to 80! It will be extended to the next progression step soon.")
        player:SendBroadcastMessage("Right now Max Level is set to 80! It will be extended to the next progression step soon.")
        end
        return false
end
RegisterPlayerEvent(42, OnCommand)