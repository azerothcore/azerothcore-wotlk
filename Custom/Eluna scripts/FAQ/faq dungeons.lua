local cmd = "faq dungeons"

local function OnCommand(event, player, command)
    if command == cmd then
        player:SendNotification("We have some custom dungeons in place - more to come!")
        player:SendBroadcastMessage("We have some custom dungeons in place - more to come!")
        player:SendBroadcastMessage("The Nexus - Level 100")
        player:SendBroadcastMessage("The Oculus - Level 100")
        player:SendBroadcastMessage("Gundrak - Level 130")
        player:SendBroadcastMessage("AhnCahet - Level 130")
        player:SendBroadcastMessage("Auchenai Crypts - Level 160")
        player:SendBroadcastMessage("Mana Tombs - Level 160")
        player:SendBroadcastMessage("Sethekk Halls - Level 160")
        player:SendBroadcastMessage("Shadow Labyrinth - Level 160")
        end
        return false
end
RegisterPlayerEvent(42, OnCommand)