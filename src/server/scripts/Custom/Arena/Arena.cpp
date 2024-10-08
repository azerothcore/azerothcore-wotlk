#include "ArenaTeam.h"
#include "ArenaTeamMgr.h"
#include "BattlegroundMgr.h"
#include "Battleground.h"
#include "BattlegroundQueue.h"
#include "Chat.h"
#include "Config.h"
#include "DisableMgr.h"
#include "GameEventMgr.h"
#include "Language.h"
#include "Log.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Translate.h"
#include "GameTime.h"
#include "ArenaOnevsOne.h"

void ArenaOne::LeaveQueue(Player* player) 
{
    uint8 arenaType = ARENA_TYPE_5v5;
    if (!player->InBattlegroundQueueForBattlegroundQueueType(bgQueueTypeId))
        return;

    WorldPacket data;
    data << arenaType << (uint8)0x0 << (uint32)BATTLEGROUND_AA << (uint16)0x0 << (uint8)0x0;
    player->GetSession()->HandleBattleFieldPortOpcode(data);
    CloseGossipMenuFor(player); 
}

bool ArenaOne::CreateArenateam(Player* player)
{
    if (!player)
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

    ChatHandler(player->GetSession()).SendSysMessage(GetCustomText(player, RU_arena_team_create_success, EN_arena_team_create_success));

    ArenaOneMgr->ArenaMainMenu(player);
    return true;
}

void ArenaOne::JoinQueue(Player* player) 
{
    if (!player)
        return;    

    if (player->GetRankByExp() < 5) {
         ChatHandler(player->GetSession()).PSendSysMessage(GetCustomText(player, RU_glory_win_9, EN_glory_win_9), 5);
         return ArenaOneMgr->ArenaMainMenu(player);
    }
    
    if (!player->GetArenaTeamId(ArenaTeam::GetSlotByType(ARENA_TEAM_5v5))) {
        CreateArenateam(player);
    }    

    if (ArenaOneMgr->Arena1v1CheckTalents(player) && ArenaOneMgr->ArenaCheckFullEquipAndTalents(player) && !ArenaOneMgr->JoinQueueArena(player, true))
        ChatHandler(player->GetSession()).SendSysMessage(GetCustomText(player, RU_arena_err_queue, EN_arena_err_queue));
    CloseGossipMenuFor(player);
}

bool ArenaOne::JoinQueueArena(Player* player, bool isRated)
{
    if (!player)
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
    BattlegroundTypeId bgTypeId = bg->GetBgTypeID();

    bg->SetRated(isRated);
    bg->SetMaxPlayersPerTeam(1);

    GroupQueueInfo* ginfo = bgQueue.AddGroup(player, nullptr, bgTypeId, bracketEntry, arenatype, isRated, false, arenaRating, matchmakerRating, ateamId);
    uint32 avgTime = bgQueue.GetAverageQueueWaitTime(ginfo);
    uint32 queueSlot = player->AddBattlegroundQueueId(bgQueueTypeId);

    // send status packet (in queue)
    WorldPacket data;
    sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_QUEUE, avgTime, 0, arenatype, TEAM_NEUTRAL, isRated);
    player->GetSession()->SendPacket(&data);

    sBattlegroundMgr->ScheduleQueueUpdate(matchmakerRating, arenatype, bgQueueTypeId, bgTypeId, bracketEntry->GetBracketId());
    return true;
}

bool ArenaOne::ArenaCheckFullEquipAndTalents(Player* player)
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
                err << "Вам необходимо одеть полное снаряжение.\n";
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

bool ArenaOne::Arena1v1CheckTalents(Player* player)
{
    if (!player)
        return false;

    if (player->HasHealSpec())
    {
        ChatHandler(player->GetSession()).SendSysMessage(GetCustomText(player, RU_arena_queue_1v1_disable_for_heal, EN_arena_queue_1v1_disable_for_heal));
        return false;
    }

    switch(player->getClass()) {
        case CLASS_DEATH_KNIGHT: {
            if (!player->HasSpell(49206) && !player->HasSpell(49143) && !player->HasSpell(55050)) {
                ChatHandler(player->GetSession()).SendSysMessage(GetCustomText(player, RU_arena_queue_1v1_disable_for_hybrid, EN_arena_queue_1v1_disable_for_hybrid));
                return false;
            } else {
                return true;
            }
        } break;
        case CLASS_PALADIN: {
            if (!player->HasSpell(53385) && !player->HasSpell(53595)) {
                ChatHandler(player->GetSession()).SendSysMessage(GetCustomText(player, RU_arena_queue_1v1_disable_for_hybrid, EN_arena_queue_1v1_disable_for_hybrid));
                return false;
            } else {
                return true;
            }
        }
    }
    return true;
}

void ArenaOne::ArenaMainMenu(Player* player) 
{
    if (!player)
        return;

    ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(player->GetArenaTeamId(ArenaTeam::GetSlotByType(ARENA_TEAM_5v5)));
    std::stringstream s;

    s << "Обновление капа и начисление очков арены через:\n";
    s << "\nНачисление: " <<  secsToTimeString((sWorld->getWorldState(WS_ARENA_DISTRIBUTION_TIME) - GameTime::GetGameTime().count()), true).c_str();
    s << "\nОбновление: " <<  secsToTimeString((sWorld->getWorldState(WS_DAYLY_ARENA_POINTS_CAP) - GameTime::GetGameTime().count()), true).c_str() << "\n";

    if (at) {
        uint32 rating = uint32((at->GetStats().Rating / 50) + player->GetRankByExp());
        s << "\nКаждый бой на арене приносит " << rating << " очков за победу и " << uint32(rating/2) << " за поражение.";
        s << "\nТекущий кап: [ " << player->GetArenaCapToday() << " / " << player->ReturnCapArenaPerDays() << " ]\n";
    }

    s << "\nДругой способ вступить в очередь на 1v1 арену - ввести команду: .join solo\nРегистрация на 1v1 арене требует минимум 5 ранга.";

    if (player->InBattlegroundQueueForBattlegroundQueueType(bgQueueTypeId))
    {
        AddGossipItemFor(player, GOSSIP_ICON_CHAT, GetCustomText(player, RU_arena_leave_queue, EN_arena_leave_queue), GOSSIP_SENDER_MAIN + 6, 3, GetCustomText(player, RU_arena_leave_queue_confirm, EN_arena_leave_queue_confirm), 0, false);
    }
    else
    {
        if (!player->InBattlegroundQueueForBattlegroundQueueType(bgQueueTypeId))
        {
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, GetCustomText(player, RU_arena_join_queue_1vs1, EN_arena_join_queue_1vs1), GOSSIP_SENDER_MAIN + 6, 2);
        }
    }
    AddGossipItemFor(player, GOSSIP_ICON_CHAT, GetCustomText(player, RU_back, EN_back), GOSSIP_SENDER_MAIN + 6, 4);
    player->PlayerTalkClass->SendGossipMenu(s.str().c_str(), player->GetGUID());
}
class npc_1v1arena : public CreatureScript
{
public:
    npc_1v1arena() : CreatureScript("npc_1v1arena") { }
    
    bool OnGossipHello(Player* player, Creature* /*creature*/) override
    {
        ArenaOneMgr->ArenaMainMenu(player);
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

    void OnQueueIdToArenaType(const BattlegroundQueueTypeId _bgQueueTypeId, uint8& arenaType) override
    {
        if (_bgQueueTypeId == bgQueueTypeId)
        {
            arenaType = ARENA_TYPE_5v5;
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
