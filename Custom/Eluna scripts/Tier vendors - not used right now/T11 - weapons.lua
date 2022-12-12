local NpcId = 800007

local function OnGossipHello(event, player, object)
    creature:SendChatMessageToPlayer( 1, 0, "Pay 7500x Level 100 tokens for Tier 12 Weapons.", target )
end

RegisterCreatureGossipEvent(NpcId, 1, OnGossipHello)