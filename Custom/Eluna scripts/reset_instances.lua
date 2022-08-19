local cmd = "resetid"

local function OnCommand(event, player, command)
    if command == cmd then
        if not player:IsInCombat() then
        player:UnbindAllInstances()
	    player:SendBroadcastMessage("Your instance ID's has been reset.")
        end
        return false
    end
end
RegisterPlayerEvent(42, OnCommand)