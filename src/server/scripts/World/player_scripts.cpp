/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#include "Player.h"
#include "ScriptMgr.h"

enum ApprenticeAnglerQuestEnum
{
    QUEST_APPRENTICE_ANGLER = 8194
};

class QuestApprenticeAnglerPlayerScript : public PlayerScript
{
public:
    QuestApprenticeAnglerPlayerScript() : PlayerScript("QuestApprenticeAnglerPlayerScript")
    {
    }

    void OnPlayerCompleteQuest(Player* player, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_APPRENTICE_ANGLER)
        {
            uint32 level = player->getLevel();
            int32 moneyRew = 0;
            if (level <= 10)
                moneyRew = 85;
            else if (level <= 60)
                moneyRew = 2300;
            else if (level <= 69)
                moneyRew = 9000;
            else if (level <= 70)
                moneyRew = 11200;
            else if (level <= 79)
                moneyRew = 12000;
            else
                moneyRew = 19000;

            player->ModifyMoney(moneyRew);
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_MONEY_FROM_QUEST_REWARD, uint32(moneyRew));
            player->SaveToDB(false, false);

            // Send packet with money
            WorldPacket data(SMSG_QUESTGIVER_QUEST_COMPLETE, (4 + 4 + 4 + 4 + 4));
            data << uint32(quest->GetQuestId());
            data << uint32(0);
            data << uint32(moneyRew);
            data << uint32(0);
            data << uint32(0);
            data << uint32(0);
            player->SendDirectMessage(&data);
        }
    }
};

void AddSC_player_scripts()
{
    new QuestApprenticeAnglerPlayerScript();
}
