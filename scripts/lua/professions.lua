print "---------- Load starting spells ---"

local PLAYER_EVENT_ON_FIRST_LOGIN = 30
local function LearnProfessions(event, player)
    -- player:LearnSpell(201070); -- strike
    -- player:LearnSpell(201008); -- expertise

    -- player:LearnSpell(9785); -- Blacksmithing Artisan
    -- player:LearnSpell(10662); -- Leatherworking Artisan
    -- player:LearnSpell(12180); -- Tailoring Artisan

    -- player:LearnSpell(674); -- dual wield

    -- player:LearnSpell(750); -- Plate
    -- player:LearnSpell(8737); -- Mail
    -- player:LearnSpell(9077); -- Leather

    -- player:LearnSpell(11993) -- Herbalism Artisan 
    -- player:LearnSpell(10248) -- Mining Artisan 
    -- player:LearnSpell(18248) -- Fishing Artisan 
    -- player:LearnSpell(200000) -- Find resources
    
    -- player:LearnSpell(201000) -- weapon crafting
    -- player:LearnSpell(11611) -- Alchemy
    -- player:LearnSpell(12656) -- Engineering
    -- player:LearnSpell(18260) -- Cooking
    -- player:LearnSpell(13920) -- Enchanting
    -- player:LearnSpell(28895) -- Jewelcrafting
    -- --player:LearnSpell(6460) -- Lockpicking
    -- player:LearnSpell(31252) -- prospecting
    
end

RegisterPlayerEvent(PLAYER_EVENT_ON_FIRST_LOGIN, LearnProfessions)