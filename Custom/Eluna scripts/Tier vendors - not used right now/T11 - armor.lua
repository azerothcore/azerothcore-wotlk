local NpcId = 800005

local function OnGossipHello(event, player, object)
    creature:SendChatMessageToPlayer( 1, 0, "Pay 2500x Level 100 tokens for Tier 11 Armor parts.", target )
end

RegisterCreatureGossipEvent(NpcId, 1, OnGossipHello)