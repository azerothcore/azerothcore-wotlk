print "---------- GM Login/Logout ---"

local function GMLogin (event, player)
    if player:GetGMRank() > 1 then
        SendWorldMessage("Lord |CFFFF0303"..player:GetName().."|r is among us.")
	end
end

local function GMLogout (event, player)
    if player:GetGMRank() > 1 then
        SendWorldMessage("Lord |CFFFF0303"..player:GetName().."|r gone.")
    end
end


RegisterPlayerEvent(3, GMLogin)
RegisterPlayerEvent(4, GMLogout)