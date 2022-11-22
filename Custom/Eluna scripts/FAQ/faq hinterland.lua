local cmd = "faq hinterland"

local function OnCommand(event, player, command)
    if command == cmd then
        player:SendNotification("The Hinterland Battleground is an open battlefield for the current set maxlevel, with some special scripts, quests, events and more! Can be accessed by our teleporters!")
        player:SendBroadcastMessage("The Hinterland Battleground is an open battlefield for the current set maxlevel, with some special scripts, quests, events and more! Can be accessed by our teleporters!")
        end
        return false
end
RegisterPlayerEvent(42, OnCommand)