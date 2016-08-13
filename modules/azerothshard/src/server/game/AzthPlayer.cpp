#include "Player.h"
#include "Group.h"
#include "AzthPlayer.h"
#include "Define.h"
#include "ObjectAccessor.h"
#include "World.h"

AzthPlayer::AzthPlayer(Player *origin) {
    playerQuestRate = sWorld->getRate(RATE_XP_QUEST);
    player = origin;
}

void AzthPlayer::SetPlayerQuestRate(float rate) {
    playerQuestRate = rate;
}

uint32 AzthPlayer::getArena1v1Info(uint8 type) {
    return arena1v1Info[type];
}

void AzthPlayer::setArena1v1Info(uint8 type, uint32 value) {
    arena1v1Info[type] = value;
}

float AzthPlayer::GetPlayerQuestRate() {
    return playerQuestRate;
}

uint8 AzthPlayer::getGroupLevel()  {
    uint8 groupLevel = 0;

    Group *group = player->GetGroup();
    Map* map = player->FindMap();
    if (group) {
        if (map->IsDungeon()) {
            // caso party instance
            InstanceSave* is = sInstanceSaveMgr->PlayerGetInstanceSave(GUID_LOPART(player->GetGUID()), map->GetId(), player->GetDifficulty((map->IsRaid())));
            groupLevel = is->azthInstMgr->levelMax;
        } else {
            // caso party esterno
            groupLevel = group->azthGroupMgr->levelMaxGroup;
        }
    }

    return groupLevel;
}

// Send a kill credit, skipping the normal checks on raid/battleground and pvp quests.
void AzthPlayer::ForceKilledMonsterCredit(uint32 entry, uint64 guid)
{
    uint16 addkillcount = 1;
    uint32 real_entry = entry;
    if (guid)
    {
        Creature* killed = player->GetMap()->GetCreature(guid);
        if (killed && killed->GetEntry())
            real_entry = killed->GetEntry();
    }

    player->StartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_CREATURE, real_entry);   // MUST BE CALLED FIRST
    player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, real_entry, addkillcount, guid ? player->GetMap()->GetCreature(guid) : NULL);

    for (uint8 i = 0; i < MAX_QUEST_LOG_SIZE; ++i)
    {
        uint32 questid = player->GetQuestSlotQuestId(i);
        if (!questid)
            continue;

        Quest const* qInfo = sObjectMgr->GetQuestTemplate(questid);
        if (!qInfo)
            continue;

        QuestStatusData& q_status = player->m_QuestStatus[questid];
        if (q_status.Status == QUEST_STATUS_INCOMPLETE)
        {
            if (qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_KILL) /*&& !qInfo->HasSpecialFlag(QUEST_SPECIAL_FLAGS_CAST)*/)
            {
                for (uint8 j = 0; j < QUEST_OBJECTIVES_COUNT; ++j)
                {
                    // skip GO activate objective or none
                    if (qInfo->RequiredNpcOrGo[j] <= 0)
                        continue;

                    uint32 reqkill = qInfo->RequiredNpcOrGo[j];

                    if (reqkill == real_entry)
                    {
                        uint32 reqkillcount = qInfo->RequiredNpcOrGoCount[j];
                        uint16 curkillcount = q_status.CreatureOrGOCount[j];
                        if (curkillcount < reqkillcount)
                        {
                            q_status.CreatureOrGOCount[j] = curkillcount + addkillcount;

                            player->m_QuestStatusSave[questid] = true;

                            player->SendQuestUpdateAddCreatureOrGo(qInfo, guid, j, curkillcount, addkillcount);
                        }
                        if (player->CanCompleteQuest(questid))
                            player->CompleteQuest(questid);
                        else
                            player->AdditionalSavingAddMask(ADDITIONAL_SAVING_QUEST_STATUS);

                        // same objective target can be in many active quests, but not in 2 objectives for single quest (code optimization).
                        break;
                    }
                }
            }
        }
    }
}


AzthPlayer::~AzthPlayer() {}
