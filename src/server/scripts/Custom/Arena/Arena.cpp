#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "BattlegroundMgr.h"
#include "Battleground.h"
#include "BattlegroundQueue.h"
#include "Chat.h"
#include "Config.h"
#include "DisableMgr.h"
#include "Language.h"
#include "Log.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Translate.h"

//Const for 1v1 arena
constexpr BattlegroundQueueTypeId bgQueueTypeId = (BattlegroundQueueTypeId)((int)BATTLEGROUND_QUEUE_5v5);

#define GetText(a, b, c)    a->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU ? b : c

//Config
std::vector<uint32> forbiddenTalents;

class npc_1v1arena : public CreatureScript
{
public:
    npc_1v1arena() : CreatureScript("npc_1v1arena") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if (!player || !creature)
            return true;

        ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(player->GetArenaTeamId(ArenaTeam::GetSlotByType(ARENA_TEAM_5v5)));
        std::stringstream s;
        if (at)
        {
            s << "\n            Статистика вашей команды 1v1:";
            s << "\n\n             Рейтинг: " << at->GetStats().Rating;
            s << "\n            Ранг: " << at->GetStats().Rank;
            s << "\n            Игр за сезон: " << at->GetStats().SeasonGames;
            s << "\n            Побед за сезон: " << at->GetStats().SeasonWins;
            s << "\n            Игр за неделю: " << at->GetStats().WeekGames;
            s << "\n            Побед за неделю: " << at->GetStats().WeekWins;
        } else {
            s << "Команда арены не создана и статистика не доступна";
        }   

        if (player->InBattlegroundQueueForBattlegroundQueueType(bgQueueTypeId))
        {
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GetText(player, RU_arena_leave_queue, EN_arena_leave_queue), GOSSIP_SENDER_MAIN, 3, GetText(player, RU_arena_leave_queue_confirm, EN_arena_leave_queue_confirm), 0, false);
        }

        if (!player->GetArenaTeamId(ArenaTeam::GetSlotByType(ARENA_TEAM_5v5)))
        {
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GetText(player, RU_arena_create_team, EN_arena_create_team), GOSSIP_SENDER_MAIN, 1, GetText(player, RU_arena_leave_queue_confirm, EN_arena_leave_queue_confirm), 0, false);
        }
        else
        {
            if (!player->InBattlegroundQueueForBattlegroundQueueType(bgQueueTypeId))
            {
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, GetText(player, RU_arena_join_queue_1vs1, EN_arena_join_queue_1vs1), GOSSIP_SENDER_MAIN, 2);
            }
        }

        player->PlayerTalkClass->SendGossipMenu(s.str().c_str(), creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        if (!player || !creature)
            return true;

        ClearGossipMenuFor(player);

        switch (action)
        {
            case 1: // Create new Arenateam
            {
                if (80 <= player->getLevel())
                {
                    if (player->GetMoney() >= 0 && CreateArenateam(player, creature))
                        player->ModifyMoney(0);
                }
                else
                {
                    ChatHandler(player->GetSession()).SendSysMessage("You have to be level 80 to create a 1v1 arena team.");
                    CloseGossipMenuFor(player);
                    return true;
                }
            } break;

            case 2: // Join Queue Arena (rated)
            {  
                if ((Arena1v1CheckTalents(player) && ArenaCheckFullEquipAndTalents(player) && !JoinQueueArena(player, creature, true)))
                    ChatHandler(player->GetSession()).SendSysMessage(GetText(player, RU_arena_err_queue, EN_arena_err_queue));
                CloseGossipMenuFor(player);
                return true;
            } break;

            case 3: // Leave Queue
            {
                uint8 arenaType = ARENA_TYPE_5v5;

                if (!player->InBattlegroundQueueForBattlegroundQueueType(bgQueueTypeId))
                    return true;

                WorldPacket data;
                data << arenaType << (uint8)0x0 << (uint32)BATTLEGROUND_AA << (uint16)0x0 << (uint8)0x0;
                player->GetSession()->HandleBattleFieldPortOpcode(data);
                CloseGossipMenuFor(player);
                return true;
            } break;
        }

        OnGossipHello(player, creature);
        return true;
    }

private:
    bool JoinQueueArena(Player* player, Creature* me, bool isRated)
    {
        if (!player || !me)
            return false;

        if (80 > player->getLevel())
            return false;

        uint8 arenaslot = ArenaTeam::GetSlotByType(ARENA_TEAM_5v5);
        uint8 arenatype = ARENA_TYPE_5v5;
        uint32 arenaRating = 1000;
        uint32 matchmakerRating = 1500;

        // ignore if we already in BG or BG queue
        if (player->InBattleground())
            return false;

        //check existance
        Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(BATTLEGROUND_AA);
        if (!bg)
        {
            LOG_ERROR("module", "Battleground: template bg (all arenas) not found");
            return false;
        }

        if (DisableMgr::IsDisabledFor(DISABLE_TYPE_BATTLEGROUND, BATTLEGROUND_AA, nullptr))
        {
            ChatHandler(player->GetSession()).PSendSysMessage(LANG_ARENA_DISABLED);
            return false;
        }

        PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bg->GetMapId(), player->getLevel());
        if (!bracketEntry)
            return false;

        // check if already in queue
        if (player->GetBattlegroundQueueIndex(bgQueueTypeId) < PLAYER_MAX_BATTLEGROUND_QUEUES)
            return false; // //player is already in this queue

        // check if has free queue slots
        if (!player->HasFreeBattlegroundQueueId())
            return false;

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
            matchmakerRating = arenaRating;
            // the arenateam id must match for everyone in the group

            if (arenaRating <= 0)
                arenaRating = 1;
        }

        BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
        bg->SetRated(isRated);
        bg->SetMaxPlayersPerTeam(1);

        GroupQueueInfo* ginfo = bgQueue.AddGroup(player, nullptr, BATTLEGROUND_AA, bracketEntry, arenatype, isRated, false, arenaRating, matchmakerRating, ateamId);
        uint32 avgTime = bgQueue.GetAverageQueueWaitTime(ginfo);
        uint32 queueSlot = player->AddBattlegroundQueueId(bgQueueTypeId);

        // send status packet (in queue)
        WorldPacket data;
        sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_QUEUE, avgTime, 0, arenatype, TEAM_NEUTRAL, isRated);
        player->GetSession()->SendPacket(&data);

        sBattlegroundMgr->ScheduleQueueUpdate(matchmakerRating, arenatype, bgQueueTypeId, BATTLEGROUND_AA, bracketEntry->GetBracketId());

        return true;
    }

    bool ArenaCheckFullEquipAndTalents(Player* player)
    {
        if (!player)
            return false;

        std::stringstream err;

        if (player->GetFreeTalentPoints() > 0) {
            err << "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Arena Queue]: ";
            if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
                err << "В данный момент у вас еще " << player->GetFreeTalentPoints() << " очков таланта. Прокачайте все таланты.\n";
            else
                err << "At the moment you still have " << player->GetFreeTalentPoints() << " talent points. Pump all the talents.\n";
        }

        Item* newItem = NULL;
        for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
        {
            if (slot == EQUIPMENT_SLOT_OFFHAND || slot == EQUIPMENT_SLOT_RANGED || slot == EQUIPMENT_SLOT_TABARD || slot == EQUIPMENT_SLOT_BODY)
                continue;

            newItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
            if (newItem == NULL)
            {
                err << "|TInterface\\GossipFrame\\Battlemastergossipicon:15:15:|t |cffff9933[Arena Queue]: ";
                if(player->GetSession()->GetSessionDbLocaleIndex() == LOCALE_ruRU)
                    err << "Вы должны надеть фул экипировку.\n";
                else
                    err << "You must wear full equipment.\n";
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

    bool CreateArenateam(Player* player, Creature* me)
    {
        if (!player || !me)
            return false;

        uint8 slot = ArenaTeam::GetSlotByType(ARENA_TEAM_5v5);
        //Just to make sure as some other module might edit this value
        if (slot == 0)
            return false;

        // Check if player is already in an arena team
        if (player->GetArenaTeamId(slot))
        {
            player->GetSession()->SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, player->GetName(), "You are already in an arena team!", ERR_ALREADY_IN_ARENA_TEAM);
            return false;
        }

        // Teamname = playername
        // if teamname exist, we have to choose another name (playername + number)
        int i = 1;
        std::stringstream teamName;
        teamName << player->GetName();
        do
        {
            if (sArenaTeamMgr->GetArenaTeamByName(teamName.str()) != NULL) // teamname exist, so choose another name
            {
                teamName.str(std::string());
                teamName << player->GetName() << (i++);
            }
            else
                break;
        } while (i < 100); // should never happen

        // Create arena team
        ArenaTeam* arenaTeam = new ArenaTeam();
        if (!arenaTeam->Create(player->GetGUID(), ARENA_TEAM_5v5, teamName.str(), 4283124816, 45, 4294242303, 5, 4294705149))
        {
            delete arenaTeam;
            return false;
        }

        // Register arena team
        sArenaTeamMgr->AddArenaTeam(arenaTeam);

        ChatHandler(player->GetSession()).SendSysMessage(GetText(player, RU_arena_team_create_success, EN_arena_team_create_success));

        return true;
    }

    bool Arena1v1CheckTalents(Player* player)
    {
        if (!player)
            return false;

        uint32 count = 0;

        for (uint32 talentId = 0; talentId < sTalentStore.GetNumRows(); ++talentId)
        {
            TalentEntry const* talentInfo = sTalentStore.LookupEntry(talentId);

            if (!talentInfo)
                continue;

            if (std::find(forbiddenTalents.begin(), forbiddenTalents.end(), talentInfo->TalentID) != forbiddenTalents.end())
            {
                ChatHandler(player->GetSession()).SendSysMessage("You can not join because you have forbidden talents.");
                return false;
            }

            for (int8 rank = MAX_TALENT_RANK - 1; rank >= 0; --rank)
                if (talentInfo->RankID[rank] == 0)
                    continue;
        }

        if (count >= 36)
        {
            ChatHandler(player->GetSession()).SendSysMessage(GetText(player, RU_arena_queue_1v1_disable_for_heal, EN_arena_queue_1v1_disable_for_heal));
            return false;
        }

        return true;
    }
};

class team_1v1arena : public ArenaTeamScript
{
public:
    team_1v1arena() : ArenaTeamScript("team_1v1arena") {}

    void OnTypeIDToQueueID(const BattlegroundTypeId, const uint8 arenaType, uint32& _bgQueueTypeId) override
    {
        if (arenaType == ARENA_TYPE_5v5)
        {
            _bgQueueTypeId = bgQueueTypeId;
        }
    }

    void OnSetArenaMaxPlayersPerTeam(const uint8 type, uint32& maxPlayersPerTeam) override
    {
        if (type == ARENA_TYPE_5v5)
        {
            maxPlayersPerTeam = 1;
        }
    }

};

void AddSC_npc_1v1arena()
{
    new npc_1v1arena();
    new team_1v1arena();
}
