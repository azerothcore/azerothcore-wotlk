local function pvp(event, killer, killed, player)
    if (killer:GetGUIDLow() == killed:GetGUIDLow()) then return false end
    SendWorldMessage("|TInterface\\icons\\achievement_bg_killxenemies_generalsroom:15|t [Chat PVP]: |cff00ffff"..killer:GetName().."|cffffff00 Matou |cffff0000"..killed:GetName().." |TInterface\\icons\\achievement_bg_ab_defendflags:15|t")
end

RegisterPlayerEvent(6, pvp)

-- Para que este mensaje solo salga en campos de batalla, añadimos el condicional adecuado:
local function pvp_bg(event, killer, killed, player)
    if(player:InBattleground()) then
        if (killer:GetGUIDLow() == killed:GetGUIDLow()) then return false end
        SendWorldMessage("|TInterface\\icons\\achievement_bg_killxenemies_generalsroom:15|t [Chat PVP]: |cff00ffff"..killer:GetName().."|cffffff00 Matou |cffff0000"..killed:GetName().." |TInterface\\icons\\achievement_bg_ab_defendflags:15|t")
    end
end

RegisterPlayerEvent(6, pvp_bg)

-- Para que este mensaje solo salga en arenas, añadimos el condicional adecuado:
local function pvp_arena(event, killer, killed, player)
    if(player:InArena()) then
        if (killer:GetGUIDLow() == killed:GetGUIDLow()) then return false end
        SendWorldMessage("|TInterface\\icons\\achievement_bg_killxenemies_generalsroom:15|t [Chat PVP]: |cff00ffff"..killer:GetName().."|cffffff00 Matou |cffff0000"..killed:GetName().." |TInterface\\icons\\achievement_bg_ab_defendflags:15|t")
    end
end

RegisterPlayerEvent(6, pvp_arena)
