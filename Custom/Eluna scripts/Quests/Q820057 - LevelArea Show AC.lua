local NpcId = 800009
local QuestId = 820057

local function OnQuestAccept(event, player, creature, quest)
    if (quest:GetId() == QuestId) then
        creature:SendUnitSay("Let me show you the Start of the Level Area of Ashzara Crater.", 0)
        creature:MoveTo( 1, 141.98, 991.51, 295.1, 1)
        creature:MoveIdle()
        creature:SendUnitSay("We have lots of creatures living in the Crater, as it was never explored completely, its your turn now!", 0)
        creature:MoveTo( 2, 157.81, 977.75, 293.65, 1)
        creature:MoveIdle()
        creature:SendUnitSay("This area is huge and has lots of different zones!", 0)
        creature:MoveIdle()
    end
end

local function OnQuestReward(event, player, creature, quest)
    if (quest:GetId() == QuestId) then
        creature:SendUnitSay("Lots of fun with leveling to 80!", 0)
        creature:DespawnOrUnsummon(5000)
        -- optional if someone does not complete the quest, so no respawn is done
        -- creature:SpawnCreature(NpcId, 130.521, 999.735, 295.539, 1.46258)
    end
end

RegisterCreatureEvent(NpcId, 31, OnQuestAccept)
RegisterCreatureEvent(NpcId, 34, OnQuestReward)