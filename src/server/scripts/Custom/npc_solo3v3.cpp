#include "ScriptMgr.h"
#include "ArenaTeamMgr.h"
#include "Common.h"
#include "DisableMgr.h"
#include "BattlegroundMgr.h"
#include "Battleground.h"
#include "ArenaTeam.h"
#include "Language.h"
#include "npc_solo3v3.h"
#include "BattlegroundQueue.h"
#include "Group.h"

  
class npc_solo3v3 : public CreatureScript
{
public:
    npc_solo3v3() : CreatureScript("npc_solo3v3") 
    {
        for (int i = 0; i < MAX_TALENT_CAT; i++)
            cache3v3Queue[i] = 0;

        lastFetchQueueList = 0;
    }

    bool OnGossipHello(Player* player, Creature* me)
    {
        if(!player || !me)
            return true;

        if (sWorld->getBoolConfig(CONFIG_SOLO_3V3_ENABLE) == false)
        {
            ChatHandler(player->GetSession()).SendSysMessage("Arena disabled!");
            return true;
        }

        fetchQueueList();
        std::stringstream infoQueue;
        infoQueue << "Встать в очередь на Solo 3vs3 арену\n";
		infoQueue << "Игроков в очереди: " << (cache3v3Queue[MELEE] + cache3v3Queue[RANGE] + cache3v3Queue[HEALER]);
        infoQueue << "\n\n";
		infoQueue << "Мили в очереди: " << cache3v3Queue[MELEE] << "\n";
        infoQueue << "Кастеров в очереди: " << cache3v3Queue[RANGE] << "\n";
		infoQueue << "Хилов в очереди: " << cache3v3Queue[HEALER];

		std::stringstream infoQueue2;
        infoQueue2 << "Выйти из очереди\n\n";
		infoQueue2 << "Игроков в очереди: " << (cache3v3Queue[MELEE] + cache3v3Queue[RANGE] + cache3v3Queue[HEALER]);
        infoQueue2 << "\n\n";
		infoQueue2 << "Мили в очереди: " << cache3v3Queue[MELEE] << "\n";
        infoQueue2 << "Кастеров в очереди: " << cache3v3Queue[RANGE] << "\n";
		infoQueue2 << "Хилов в очереди: " << cache3v3Queue[HEALER];
		
        if (player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_5v5) 
            || player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_3v3_SOLO))
            player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_CHAT, infoQueue2.str().c_str(), GOSSIP_SENDER_MAIN, 3, "Вы действительно хотите выйти из очереди Solo 3vs3 арены?", 0, false);

        if(player->GetArenaTeamId(ArenaTeam::GetSlotByType(ARENA_TEAM_5v5)) == NULL)
            player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_CHAT, "Создать команду Solo 3vs3 арены", GOSSIP_SENDER_MAIN, 1, "", 0, false);
        else
        {
            if (player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_5v5) == false && 
                player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_3v3_SOLO) == false) {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, infoQueue.str().c_str(), GOSSIP_SENDER_MAIN, 2);
            }
        }

        player->SEND_GOSSIP_MENU(10110, me->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* me, uint32 /*uiSender*/, uint32 uiAction)
    {
        if(!player || !me)
            return true;

        player->PlayerTalkClass->ClearMenus();

        switch (uiAction)
        {
            case 1: // Create new Arenateam
				{
					CreateArenateam(player, me);
				}
				break;
            case 2: // 3v3 Join Queue Arena (rated)
                {
                    // check Deserter debuff
                    if (player->HasAura(26013)
						&& (sWorld->getBoolConfig(CONFIG_SOLO_3V3_CAST_DESERTER_ON_AFK)
						|| sWorld->getBoolConfig(CONFIG_SOLO_3V3_CAST_DESERTER_ON_LEAVE))) {
                        WorldPacket data;
						sBattlegroundMgr->BuildGroupJoinedBattlegroundPacket(&data, ERR_GROUP_JOIN_BATTLEGROUND_DESERTERS);
                        player->GetSession()->SendPacket(&data);
                    }
                    else if (ArenaCheckFullEquipAndTalents(player) && JoinQueueArena(player, me, true, ARENA_TYPE_3v3_SOLO) == false)
						ChatHandler(player->GetSession()).SendSysMessage("Что-то пошло не так, когда вы пытались встать в очередь. Вы уже стоите в другой очереди на арену/бг?");

					player->CLOSE_GOSSIP_MENU();
					return true;
                }
            case 3: // Leave Queue
                {
					uint8 arenaType = ARENA_TYPE_5v5;
					if (player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_3v3_SOLO))
						arenaType = ARENA_TYPE_3v3_SOLO;

					WorldPacket Data;
					Data << arenaType << (uint8)0x0 << (uint32)BATTLEGROUND_AA << (uint16)0x0 << (uint8)0x0;
					player->GetSession()->HandleBattleFieldPortOpcode(Data);
					player->CLOSE_GOSSIP_MENU();
                    return true;
                }
		}

        OnGossipHello(player, me);
        return true;
    }

private:
    int cache3v3Queue[MAX_TALENT_CAT];
    uint32 lastFetchQueueList;

    bool ArenaCheckFullEquipAndTalents(Player* player)
    {
        if (!player)
            return false;

        if (sWorld->getBoolConfig(CONFIG_ARENA_CHECK_EQUIP_AND_TALENTS) == false)
            return true;

        std::stringstream err;

        if (player->GetFreeTalentPoints() > 0)
            err << "You have currently " << player->GetFreeTalentPoints() << " free talent points. Please spend all your talent points before queueing arena.\n";

        Item* newItem = NULL;
        for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
        {
            if (slot == EQUIPMENT_SLOT_OFFHAND || slot == EQUIPMENT_SLOT_RANGED || slot == EQUIPMENT_SLOT_TABARD || slot == EQUIPMENT_SLOT_BODY)
                continue;

            newItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
            if (newItem == NULL)
            {
                err << "Your character is not fully equipped.\n";
                break;
            }
        }

        if (err.str().length() > 0)
        {
            ChatHandler(player->GetSession()).SendSysMessage(err.str().c_str());
            return false;
        }
        return true;
    }

    bool JoinQueueArena(Player* player, Creature* me, bool isRated, uint8 arenatype)
    {
        if (!player || !me)
            return false;

        if (sWorld->getIntConfig(CONFIG_SOLO_3V3_MIN_LEVEL) > player->getLevel())
            return false;

        uint8 arenaslot = ArenaTeam::GetSlotByType(ARENA_TEAM_5v5);
        uint32 arenaRating = 0;
        uint32 matchmakerRating = 0;

        // ignore if we already in BG or BG queue
        if (player->InBattleground() || player->InBattlegroundQueue())
            return false;

        //check existance
        Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(BATTLEGROUND_AA);
        if (!bg)
            return false;

        if (DisableMgr::IsDisabledFor(DISABLE_TYPE_BATTLEGROUND, BATTLEGROUND_AA, NULL))
        {
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_ARENA_DISABLED);
            return false;
        }

        BattlegroundTypeId bgTypeId = bg->GetBgTypeID();
        BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, arenatype);
        PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bg->GetMapId(), player->getLevel());
        if (!bracketEntry)
            return false;
		
        // check if already in queue
        if (player->GetBattlegroundQueueIndex(bgQueueTypeId) < PLAYER_MAX_BATTLEGROUND_QUEUES)
            //player is already in this queue
            return false;
		
        // check if has free queue slots
        if (!player->HasFreeBattlegroundQueueId())
            return false;
		
		// queue result (default ok)
		GroupJoinBattlegroundResult err = GroupJoinBattlegroundResult(bg->GetBgTypeID());

        uint32 ateamId = 0;

        if (isRated)
        {
            ateamId = player->GetArenaTeamId(arenaslot);
            ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(ateamId);
			
            if (!at)
            {
                player->GetSession()->SendNotInArenaTeamPacket(arenatype);
                return false;
            }

            // get the team rating for queueing
            arenaRating = at->GetRating();
            matchmakerRating = at->GetAverageMMR();
            // the arenateam id must match for everyone in the group

            if (arenaRating <= 0)
                arenaRating = 1;
        }

		BattlegroundQueue &bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
		bg->SetRated(isRated);

		GroupQueueInfo* ginfo = bgQueue.AddGroup(player, NULL, bracketEntry, isRated, false, arenaRating, matchmakerRating, ateamId);
		uint32 avgTime = bgQueue.GetAverageQueueWaitTime(ginfo);
		uint32 queueSlot = player->AddBattlegroundQueueId(bgQueueTypeId);

		WorldPacket data;
		// send status packet (in queue)
		sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_QUEUE, avgTime, ginfo->JoinTime, arenatype, player->GetTeamId());
		player->GetSession()->SendPacket(&data);
		sBattlegroundMgr->ScheduleArenaQueueUpdate(ateamId, bgQueueTypeId, bracketEntry->GetBracketId());
        return true;
    }

    bool CreateArenateam(Player* player, Creature* me)
    {
        if (!player || !me)
            return false;

        uint8 slot = ArenaTeam::GetSlotByType(ARENA_TEAM_5v5);
        if (slot >= MAX_ARENA_SLOT)
            return false;

        // Check if player is already in an arena team
        if (player->GetArenaTeamId(slot))
        {
            player->GetSession()->SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, player->GetName(), "", ERR_ALREADY_IN_ARENA_TEAM);
            return false;
        }

        // Teamname = playername
        // if team name exist, we have to choose another name (playername + number)
        int i = 1;
        std::stringstream teamName;
		teamName << "3vs3 Solo - " << player->GetName();
		// teamName << player->GetName();
        do
        {
            if (sArenaTeamMgr->GetArenaTeamByName(teamName.str()) != NULL) // teamname exist, so choose another name
            {
                teamName.str(std::string());
                teamName << player->GetName() << i++;
            }
            else
                break;
        } while (i < 100); // should never happen

        // Create arena team
        ArenaTeam* arenaTeam = new ArenaTeam();

        if (!arenaTeam->Create(player->GetGUID(), ARENA_TEAM_5v5, teamName.str(), 4278190080, 45, 4278190080, 5, 4278190080))
        {
            delete arenaTeam;
            return false;
        }

        // Register arena team
        sArenaTeamMgr->AddArenaTeam(arenaTeam);
        arenaTeam->AddMember(player->GetGUID());
		
        //ChatHandler(player->GetSession()).SendSysMessage("Arena team successful created!");
        return true;
    }

    void fetchQueueList()
    {
        if (GetMSTimeDiffToNow(lastFetchQueueList) < 1000)
            return; // prevent spamming
        lastFetchQueueList = getMSTime();

        BattlegroundQueue* queue = &sBattlegroundMgr->GetBattlegroundQueue(BATTLEGROUND_QUEUE_3v3_SOLO);

        for (int i = 0; i < MAX_TALENT_CAT; i++)
            cache3v3Queue[i] = 0;

        for (int i = BG_BRACKET_ID_FIRST; i <= BG_BRACKET_ID_LAST; i++)
		{
			for (int j = 0; j < 2; j++)
			{
				for (BattlegroundQueue::GroupsQueueType::iterator itr = queue->m_QueuedGroups[i][j].begin(); itr != queue->m_QueuedGroups[i][j].end(); itr++)
				{
					if ((*itr)->IsInvitedToBGInstanceGUID) // Skip when invited
						continue;

					std::map<uint64, PlayerQueueInfo*> *grpPlr = &(*itr)->Players;
					for (std::map<uint64, PlayerQueueInfo*>::iterator grpPlrItr = grpPlr->begin(); grpPlrItr != grpPlr->end(); grpPlrItr++)
					{
						Player* plr = sObjectAccessor->FindPlayer(grpPlrItr->first);
						if (!plr)
							continue;

						Solo3v3TalentCat plrCat = GetTalentCatForSolo3v3(plr); // get talent cat
						cache3v3Queue[plrCat]++;
					}
				}
			}
		}
    }
};


void AddSC_npc_solo3v3()
{
    new npc_solo3v3();
}