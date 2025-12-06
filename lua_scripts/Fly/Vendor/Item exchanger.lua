local NPC_ID = 500032  -- Substitua pelo ID do seu NPC
local RACE_TOKEN = 37836  -- Substitua pelo ID do item de Race Token
local FACTION_TOKEN = 37836  -- Substitua pelo ID do item de Faction Token
local APPEARANCE_TOKEN = 37836  -- Substitua pelo ID do item de Appearance Token
local PVP_TOKEN = 37836  -- Substitua pelo ID do item de PvP Zone Token
local EVENT_TOKEN = 37836  -- Substitua pelo ID do item de Event Token
local DONATION_TOKEN = 34597-- Substitua pelo ID do item de Donation Token

local function OnGossipHello(event, player, creature)
    player:GossipMenuAddItem(4, "----------Customization----------", 1, 0)
    player:GossipMenuAddItem(4, "|TInterface\\icons\\inv_misc_coin_16:24|t 75 T-Vírus -> |TInterface\\icons\\inv_misc_grouplooking:24|t Customize", 1, 1)
    player:GossipMenuAddItem(4, "|TInterface\\icons\\inv_misc_coin_16:24|t 150 T-Vírus -> |TInterface\\icons\\achievement_character_human_male:24|t Change race", 1, 2)
    player:GossipMenuAddItem(4, "|TInterface\\icons\\inv_misc_coin_16:24|t 300 T-Vírus -> |TInterface\\icons\\achievement_character_orc_male:24|t Change faction", 1, 3)
    
    --player:GossipMenuAddItem(4, "-----------PvP-----------", 1, 0)
    --player:GossipMenuAddItem(4, "|TInterface\\icons\\inv_banner_02:24|t 60000 Honor -> |TInterface\\icons\\achievement_arena_2v2_6:24|t 2500 Arenas", 1, 4)
    --player:GossipMenuAddItem(4, "|TInterface\\icons\\achievement_arena_2v2_6:24|t 250 Arenas -> |TInterface\\icons\\inv_banner_02:24|t 25000 Honor", 1, 5)
    
    player:GossipMenuAddItem(4, "-----------Tokens-----------", 1, 0)
    player:GossipMenuAddItem(4, "|TInterface\\icons\\inv_misc_coin_16:24|t 100 T-Vírus -> |TInterface\\icons\\inv_misc_rune_07:24|t 10 Battlegrounds Token", 1, 6)
    --player:GossipMenuAddItem(4, "|TInterface\\icons\\achievement_noblegarden_chocolate_egg:24|t 1000 Event Token -> |TInterface\\icons\\inv_misc_shell_03:24|t 1 Donation Token", 1, 7)
    
    player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if intid == 1 then
        if player:GetItemCount(EVENT_TOKEN) >= 75 then
            player:RemoveItem(EVENT_TOKEN, 75)
            player:SetAtLoginFlag(8)
            player:SendAreaTriggerMessage("Por favor, relogue para mudar sua aparência.")
            player:SendBroadcastMessage("Você trocou 75 T-Vírus por Customização.")
        else
            player:SendBroadcastMessage("Você precisa de 75 T-Vírus para usar esta função.")
        end
    elseif intid == 2 then
        if player:GetItemCount(EVENT_TOKEN) >= 150 then
            player:RemoveItem(EVENT_TOKEN, 150)
            player:SetAtLoginFlag(128)
            player:SendAreaTriggerMessage("Por favor, relogue para mudar sua raça.")
            player:SendBroadcastMessage("Você trocou 150 T-Vírus por Mudança de Raça.")
        else
            player:SendBroadcastMessage("Você precisa de 150 T-Vírus para usar esta função.")
        end
    elseif intid == 3 then
        if player:GetItemCount(EVENT_TOKEN) >= 300 then
            player:RemoveItem(EVENT_TOKEN, 300)
            player:SetAtLoginFlag(64)
            player:SendAreaTriggerMessage("Por favor, relogue para mudar sua facção.")
            player:SendBroadcastMessage("Você trocou 300 T-Vírus por Mudança de Facção.")
        else
            player:SendBroadcastMessage("Você precisa de 300 T-Vírus para usar esta função.")
        end
    elseif intid == 4 then
        if player:GetHonorPoints() >= 60000 then
            player:ModifyHonorPoints(-60000)
            player:ModifyArenaPoints(2500)
            player:SendBroadcastMessage("Você trocou 60000 Honra por 2500 Arenas.")
        else
            player:SendBroadcastMessage("Você não tem pontos de honra suficientes.")
        end
    elseif intid == 5 then
        if player:GetArenaPoints() >= 250 then
            player:ModifyArenaPoints(-250)
            player:ModifyHonorPoints(25000)
            player:SendBroadcastMessage("Você trocou 250 Arenas por 25000 Honra.")
        else
            player:SendBroadcastMessage("Você não tem pontos de arena suficientes.")
        end
    elseif intid == 6 then
        if player:GetItemCount(EVENT_TOKEN) >= 100 then
            player:RemoveItem(EVENT_TOKEN, 100)
            player:AddItem(DONATION_TOKEN, 10)
            player:SendBroadcastMessage("Você trocou 100 T-Vírus por 10 Battlegrounds Token.")
        else
            player:SendBroadcastMessage("Você precisa de 100 T-Vírus para usar esta função.")
        end
    elseif intid == 7 then
        if player:GetItemCount(EVENT_TOKEN) >= 1000 then
            player:RemoveItem(EVENT_TOKEN, 1000)
            player:AddItem(DONATION_TOKEN, 1)
            player:SendBroadcastMessage("Você trocou 1000 Event Tokens por 1 Donation Token.")
        else
            player:SendBroadcastMessage("Você precisa de 1000 Event Tokens para usar esta função.")
        end
    end
    player:GossipComplete()
end

RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, OnGossipSelect)
