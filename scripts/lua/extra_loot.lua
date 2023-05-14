



print "LOAD FREE LOOT"
local PLAYER_EVENT_ON_LOOT_ITEM               =     32       -- (event, player, item, count)

local roll_chance = 1

local function item_roll_bonus(event, player, item, count)
    -- if (math.random() < roll_chance) then
    --     player:AddItem(item);
    -- end
	print (item)
    print("triggerred")
	
end


RegisterPlayerEvent(PLAYER_EVENT_ON_LOOT_ITEM, item_roll_bonus)