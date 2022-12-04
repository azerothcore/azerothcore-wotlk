local NpcId = 800009
local QuestId = 820056

local function OnQuestAccept(event, player, creature, quest)
    if (quest:GetId() == QuestId) then
        creature:SendUnitSay("A warm Welcome to DC-WoW! We wish you all the fun! HÖHÖHÖ", 0)
    end
end

local function OnQuestReward(event, player, creature, quest)
    if (quest:GetId() == QuestId) then
        creature:SendUnitSay("For more questions please use the .faq commands or check on discord! There is also a world chat for everyone.", 0)
    end
end

RegisterCreatureEvent(NpcId, 31, OnQuestAccept)
RegisterCreatureEvent(NpcId, 34, OnQuestReward)