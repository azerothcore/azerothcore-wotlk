print "---------- Load starting spells ---"

local PLAYER_EVENT_ON_FIRST_LOGIN = 30
local function LearnProfessions(event, player)
    player:LearnSpell(9785); -- Blacksmithing Artisan
    player:LearnSpell(10662); -- Leatherworking Artisan
    player:LearnSpell(12180); -- Tailoring Artisan

    player:LearnSpell(674); -- dual wield
    -- -- not working
    player:LearnSpell(750); -- Plate
    player:LearnSpell(8737); -- Mail
    player:LearnSpell(9077); -- Leather

end

local function LearnArmors(event, player)
    -- not work either ??
    if not player:HasSkill(414) then player:SetSkill(414, 0, 1, 1) end 
    if not player:HasSkill(413) then player:SetSkill(413, 0, 1, 1) end 
    if not player:HasSkill(293) then player:SetSkill(293, 0, 1, 1) end 
end

--RegisterPlayerEvent(PLAYER_EVENT_ON_FIRST_LOGIN, LearnArmors)

RegisterPlayerEvent(PLAYER_EVENT_ON_FIRST_LOGIN, LearnProfessions)