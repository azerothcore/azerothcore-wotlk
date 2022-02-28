local charset = {}  do -- [0-9a-zA-Z]
    for c = 48, 57  do table.insert(charset, string.char(c)) end
    for c = 65, 90  do table.insert(charset, string.char(c)) end
    for c = 97, 122 do table.insert(charset, string.char(c)) end
end

local randomSeed = os.clock()^5

function randomString(length)
    if not length or length <= 0 then return '' end
    math.randomseed(randomSeed)
    return randomString(length - 1) .. charset[math.random(1, #charset)]
end

function checkSecret(player, client, server)
	local valid = (client == server)
	if not (valid) then
		player:SendNotification("ERRORMSG")
	end
	return valid
end