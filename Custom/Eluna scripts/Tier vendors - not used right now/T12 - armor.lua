local NpcId = 800006

local function OnGossipHello(event, player, object)
    creature.SendChatMessageToPlayer( 0, 0, "Pay 7500x Level 100 tokens for Tier 12 Armor parts.", player )
end

RegisterCreatureGossipEvent(NpcId, 1, OnGossipHello)