/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "Chat.h"
#include "Config.h"
#include "Player.h"
#include "ScriptMgr.h"

enum QuestIds
{
    QUEST_AB_A = 11335,
    QUEST_AB_H = 11339,

    QUEST_AV_A = 11336,
    QUEST_AV_H = 11340,

    QUEST_EOS_A = 11337,
    QUEST_EOS_H = 11341,

    QUEST_WSG_A = 11338,
    QUEST_WSG_H = 11342,

    QUEST_MARKER_WIN = 50010,
    QUEST_MARKER_DEFEAT = 50011
};

class BgQuestRewardScript : public BGScript
{
public:
    BgQuestRewardScript() : BGScript("mod_bg_quest_reward_script", {
        ALLBATTLEGROUNDHOOK_ON_BATTLEGROUND_END_REWARD
    }) { }

    void OnBattlegroundEndReward(Battleground* /*bg*/, Player* player, TeamId winnerTeamId) override
    {
        if (!sConfigMgr->GetOption<bool>("ModPvPQuests.Enable", true))
            return;

        if (player->GetMap()->IsBattleArena())
            return;

        if (winnerTeamId == player->GetBgTeamId())
        {
            if (Quest const* quest = sObjectMgr->GetQuestTemplate(QUEST_MARKER_WIN))
            {
                if (player->CanTakeQuest(quest, false))
                {
                    player->AddQuest(quest, nullptr);
                    player->CompleteQuest(QUEST_MARKER_WIN);
                    player->RewardQuest(quest, 0, nullptr, true, true);

                    if (int32 ap = sConfigMgr->GetOption<int>("ModPvPQuests.WinAP", 10))
                        player->ModifyArenaPoints(ap);
                }
            }
        }
        else
        {
            if (Quest const* quest = sObjectMgr->GetQuestTemplate(QUEST_MARKER_DEFEAT))
            {
                if (int32 ap = sConfigMgr->GetOption<int>("ModPvPQuests.LossAP", 0))
                {
                    if (player->CanTakeQuest(quest, false))
                    {
                        player->AddQuest(quest, nullptr);
                        player->CompleteQuest(QUEST_MARKER_DEFEAT);
                        player->RewardQuest(quest, 0, nullptr, true, true);
                        player->ModifyArenaPoints(ap);
                    }
                }
            }
        }

    }
};

// Add all scripts in one
void ModPvPQuestsScripts()
{
    new BgQuestRewardScript();
}
