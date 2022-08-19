
local command = "bank"

function OnEvents(event, player, message, type, language)

    if (message == command) then
		
       player:SendBroadcastMessage("|cff00cc00Bienvenido a tu Banco|cff00ffff ["..player:GetName().."]|r")
	   player:SendShowBank(player)
	   return false;
    end
end

RegisterPlayerEvent(42, OnEvents)