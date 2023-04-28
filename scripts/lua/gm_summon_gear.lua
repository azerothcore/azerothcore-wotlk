command = "gimme"

items = {12106,2401, 6187,  18610, 4560, 4560, 5235, 4111, 20522}

local function summon_stuff(event, player)
    for i,v in pairs(items) do player:AddItem(v) end
end

local function PlrMenu(event, player, message)

	
	if (message:lower() == command) then
		if player:GetGMRank() > 2 then
            summon_stuff(event, player)
		return false
	end
	end
end

RegisterPlayerEvent(42, PlrMenu)