local enabled_skill = false
local enabled_spell = true
local enabled = true

local skills = {44, 45, 226, 173, 118, 473, 46, 54, 229, 136, 43, 176, 172, 160, 55, 228}
local spells = {264, 5011, 1180, 674, 15590, 266, 196, 198, 201, 3127, 200, 5019, 227, 2764, 2567, 197, 199, 202, 5009, 3018}

local firstlogin = false

local function OnFirstLogin(event, player)
    if enabled_spell then
        for k,v in pairs(spells) do
            if not player:HasSpell( v ) then
                player:LearnSpell( v )
            end
	    end
    end
	
    if enabled_skill then
        for k,v in pairs(skills) do
            if not player:HasSkill( v ) then
                player:SetSkill( v, 1, 5, 5 )
            end
	    end
    end
	-- firstlogin = true
end

local function OnLogin(event, player)
    if not firstlogin then
        for k,v in pairs(spells) do
            if not player:HasSpell( v ) then
                player:LearnSpell( v )
            end
        end
        
        for k,v in pairs(skills) do
            if not player:HasSkill( v ) then
                player:SetSkill( v, 1, 5, 5 )
            end
        end
    end
end


if enabled then
-- RegisterPlayerEvent( 3, OnLogin )
RegisterPlayerEvent( 30, OnFirstLogin )
end