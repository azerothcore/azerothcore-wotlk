
function MountSpeed(event, player)
	if player:GetLevel() == 80 then
	player:LearnSpell(34091)
	player:LearnSpell(54197)
	end
end


RegisterPlayerEvent(30, MountSpeed)