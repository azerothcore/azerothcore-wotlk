local cmd = "buff"

local auras = { 16609, 25898, 48469, 42995, 48169, 48073, 48161, 26035, 23735, 23736, 23737, 23738, 23766, 23767, 23768, 23769 }

local function OnCommand(event, player, command)
    if command == cmd then
        if not player:IsInCombat() then
            for i = 2, #auras, 1 do
                player:AddAura(auras[i], player)
            end
            player:CastSpell(player, auras[1], true)
        else
            player:SendNotification("You're on combat!")
        end
        return false
    end
end
RegisterPlayerEvent(42, OnCommand)
