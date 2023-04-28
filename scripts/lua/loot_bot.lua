local LAYER_EVENT_ON_KILL_CREATURE           =     7

function autoLoot(event, player, creature)
    print "Looting"
    player:LootCorpse(creature:GetDBTableGUIDLow())
end





RegisterPlayerEvent(LAYER_EVENT_ON_KILL_CREATURE, autoLoot)