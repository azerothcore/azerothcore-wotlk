-- Script criado por: ValberDEV
local function OnChat(event, player, message, type, language)
    if player:GetGMRank() == 2 then
        local file = io.open("GM_LOGS/gm_2.log", "a")
        if file then
            local formatted_message = string.format("[%s] <ID: %s - Char: %s> (%s) %s\n", os.date("%Y-%m-%d %H:%M:%S"), player:GetAccountId(), player:GetName(), type, message)
            file:write(formatted_message)
            file:close()
        end
		elseif player:GetGMRank() == 1 then
        local file = io.open("GM_LOGS/gm_1.log", "a")
        if file then
            local formatted_message = string.format("[%s] <ID: %s - Char: %s> (%s) %s\n", os.date("%Y-%m-%d %H:%M:%S"), player:GetAccountId(), player:GetName(), type, message)
            file:write(formatted_message)
            file:close()
        end
	elseif player:GetGMRank() == 3 then
        local file = io.open("GM_LOGS/gm_3.log", "a")
        if file then
            local formatted_message = string.format("[%s] <ID: %s - Char: %s> (%s) %s\n", os.date("%Y-%m-%d %H:%M:%S"), player:GetAccountId(), player:GetName(), type, message)
            file:write(formatted_message)
            file:close()
        end
	elseif player:GetGMRank() == 4 then
		local file = io.open("GM_LOGS/gm_4.log", "a")
        if file then
            local formatted_message = string.format("[%s] <ID: %s - Char: %s> (%s) %s\n", os.date("%Y-%m-%d %H:%M:%S"), player:GetAccountId(), player:GetName(), type, message)
            file:write(formatted_message)
            file:close()
        end
   	elseif player:GetGMRank() == 0 then  -- Player
		local name_player = player:GetName()
        local file = io.open("PLAYER_LOGS/"..name_player..".log", "a")
        if file then
            local formatted_message = string.format("[%s] <ID: %s - Char: %s> (%s) %s\n", os.date("%Y-%m-%d %H:%M:%S"), player:GetAccountId(), player:GetName(), type, message)
            file:write(formatted_message)
            file:close()
        end 

    end
end
RegisterPlayerEvent(18, OnChat)
RegisterPlayerEvent(19, OnChat)
RegisterPlayerEvent(20, OnChat)