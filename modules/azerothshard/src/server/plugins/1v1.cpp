#include "ScriptMgr.h"
#include "ArenaTeamMgr.h"
#include "Common.h"
#include "DisableMgr.h"
#include "BattlegroundMgr.h"
#include "Battleground.h"
#include "ArenaTeam.h"
#include "Language.h"
#include "Chat.h"
#include "Player.h"
#include "Creature.h"
#include "ScriptedGossip.h"

#define ARENA_1V1_MIN_LEVEL 80 // min level to create an arenateam
#define ARENA_1V1_COST 40 * 10000 // costs for create a team: 40 gold

/* [TODO] fix and re-enable */
 class npc_1v1arena : public CreatureScript {
 public:

     npc_1v1arena() : CreatureScript("npc_1v1arena") {
     }

     bool JoinQueueArena(Player* player, Creature* me) {
         if (ARENA_1V1_MIN_LEVEL > player->getLevel())
             return false;

         uint64 guid = player->GetGUID();
         uint8 arenaslot = ArenaTeam::GetSlotByType(ARENA_TEAM_1v1);
         uint8 arenatype = ARENA_TYPE_1v1;
         uint32 arenaRating = 0;
         uint32 matchmakerRating = 0;
         bool isRated = true;

         // ignore if we already in BG or BG queue
         if (player->InBattleground())
             return false;

         //check existance
         Battleground* bg = sBattlegroundMgr->GetBattlegroundTemplate(BATTLEGROUND_AA);
         if (!bg) {
             //TC_LOG_ERROR(LOG_FILTER_NETWORKIO, "Battleground: template bg (all arenas) not found");
             return false;
         }

         if (DisableMgr::IsDisabledFor(DISABLE_TYPE_BATTLEGROUND, BATTLEGROUND_AA, NULL)) {
             ChatHandler(player->GetSession()).PSendSysMessage(LANG_ARENA_DISABLED);
             return false;
         }

         BattlegroundTypeId bgTypeId = bg->GetBgTypeID();
         BattlegroundQueueTypeId bgQueueTypeId = BattlegroundMgr::BGQueueTypeId(bgTypeId, arenatype);
         PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bg->GetMapId(), player->getLevel());
         if (!bracketEntry)
             return false;

         GroupJoinBattlegroundResult err = ERR_GROUP_JOIN_BATTLEGROUND_FAIL;

         // check if already in queue
         if (player->GetBattlegroundQueueIndex(bgQueueTypeId) < PLAYER_MAX_BATTLEGROUND_QUEUES)
             //player is already in this queue
             return false;
         // check if has free queue slots
         if (!player->HasFreeBattlegroundQueueId())
             return false;

         uint32 ateamId = 0;

         ateamId = player->GetArenaTeamId(arenaslot);
         ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(ateamId);
         if (!at) {
             player->GetSession()->SendNotInArenaTeamPacket(arenatype);
             return false;
         }
         // get the team rating for queueing
         arenaRating = at->GetRating();
         matchmakerRating = arenaRating;
         // the arenateam id must match for everyone in the group

         if (arenaRating <= 0)
             arenaRating = 1;

         BattlegroundQueue &bgQueue = sBattlegroundMgr->GetBattlegroundQueue(bgQueueTypeId);
         bg->SetRated(isRated);

         bgQueue.SetBgTypeIdAndArenaType(bgTypeId, arenatype);
         GroupQueueInfo* ginfo = bgQueue.AddGroup(player, NULL, bracketEntry, isRated, false, arenaRating, matchmakerRating, ateamId);
         // manca BattlegroundTypeId BgTypeId - uint8 ArenaType
 
         uint32 avgTime = bgQueue.GetAverageQueueWaitTime(ginfo);
         uint32 queueSlot = player->AddBattlegroundQueueId(bgQueueTypeId);

         WorldPacket data;
         // send status packet (in queue)
//[AZTH]
         sBattlegroundMgr->BuildBattlegroundStatusPacket(&data, bg, queueSlot, STATUS_WAIT_QUEUE, avgTime, 0, arenatype, player->GetBgTeamId(), 0);
//[/AZTH]
         player->GetSession()->SendPacket(&data);

         sBattlegroundMgr->ScheduleArenaQueueUpdate(matchmakerRating, bgQueueTypeId, bracketEntry->GetBracketId());
         return true;
     }

     bool CreateArenateam(Player* player, Creature* me) {
         uint8 slot = ArenaTeam::GetSlotByType(ARENA_TEAM_1v1);

         // Check if player is already in an arena team
         if (player->GetArenaTeamId(slot)) {
             player->GetSession()->SendArenaTeamCommandResult(ERR_ARENA_TEAM_CREATE_S, player->GetName(), "", ERR_ALREADY_IN_ARENA_TEAM);
             return false;
         }


         // Teamname = playername
         // if teamname exist, we have to choose another name (playername  number)
         int i = 1;
         std::stringstream teamName;
         teamName << player->GetName();

         do {
             if (sArenaTeamMgr->GetArenaTeamByName(teamName.str()) != NULL) // teamname exist, so choose another name
             {
                 teamName.str(std::string());
                 teamName << player->GetName() << i;
             } else
                 break;

             i++;
         } while (i < 100); // should never happen

         // Create arena team
         ArenaTeam* arenaTeam = new ArenaTeam();

         if (!arenaTeam->Create(player->GetGUID(), ARENA_TEAM_1v1, teamName.str(), 0, 0, 0, 0, 0)) {
             delete arenaTeam;
             return false;
         }

         // Register arena team
         sArenaTeamMgr->AddArenaTeam(arenaTeam);

         ChatHandler(player->GetSession()).SendSysMessage("1v1 Arenateam successful created!");

         return true;
     }

     bool OnGossipHello(Player* player, Creature* me) {
         if (player->GetArenaTeamId(ArenaTeam::GetSlotByType(ARENA_TEAM_1v1)) == NULL)
             player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_CHAT, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Create 1v1 Rated Arena Team", GOSSIP_SENDER_MAIN, 1, "Create 1v1 arena team?", ARENA_1V1_COST, false);
         else {
             if (player->InBattlegroundQueueForBattlegroundQueueType(BATTLEGROUND_QUEUE_1v1))
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Leave 1v1 Arena", GOSSIP_SENDER_MAIN, 3);
             else {
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "|TInterface/ICONS/Achievement_Arena_3v3_5:30|t Join 1v1 Rated Arena", GOSSIP_SENDER_MAIN, 2);
                 player->ADD_GOSSIP_ITEM_EXTENDED(GOSSIP_ICON_CHAT, "|TInterface/ICONS/Achievement_Arena_2v2_7:30|t Disband Arena team", GOSSIP_SENDER_MAIN, 5, "Are you sure?", 0, false);
             }

             player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "|TInterface/ICONS/INV_Misc_Coin_01:30|t Show statistics", GOSSIP_SENDER_MAIN, 4);
         }

         player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "|TInterface/ICONS/INV_Misc_Coin_03:30|t How to Use NPC?", GOSSIP_SENDER_MAIN, 8);
         player->SEND_GOSSIP_MENU(68, me->GetGUID());
         return true;
     }

     bool OnGossipSelect(Player* player, Creature* me, uint32 /*uiSender*/, uint32 uiAction) {
         player->PlayerTalkClass->ClearMenus();

         switch (uiAction) {
             case 1: // Create new Arenateam
             {
                 if (ARENA_1V1_MIN_LEVEL <= player->getLevel()) {
                     if (player->GetMoney() >= ARENA_1V1_COST && CreateArenateam(player, me))
                         player->ModifyMoney(-(int32) ARENA_1V1_COST);
                 } else {
                     ChatHandler(player->GetSession()).PSendSysMessage("You need level %u+ to create an 1v1 Arena Team.", ARENA_1V1_MIN_LEVEL);
                 }

                 player->CLOSE_GOSSIP_MENU();
                 return true;
             }
                 break;

             case 2: // Join Queue Arena
             {
                 if (JoinQueueArena(player, me) == false)
                     ChatHandler(player->GetSession()).SendSysMessage("Something went wrong while join queue.");
                 player->CLOSE_GOSSIP_MENU();
                 return true;
             }
                 break;

             case 3: // Leave Queue
             {
                 WorldPacket Data;
                 Data << (uint8) 0x1 << (uint8) 0x0 << (uint32) BATTLEGROUND_AA << (uint16) 0x0 << (uint8) 0x0;
                 player->GetSession()->HandleBattleFieldPortOpcode(Data);
                 player->CLOSE_GOSSIP_MENU();
                 return true;
             }
                 break;

             case 4: // get statistics
             {
                 ArenaTeam* at = sArenaTeamMgr->GetArenaTeamById(player->GetArenaTeamId(ArenaTeam::GetSlotByType(ARENA_TEAM_1v1)));
                 if (at) {
                     std::stringstream s;
                     s << "Rating: " << at->GetStats().Rating;
                     s << "\nRank: " << at->GetStats().Rank;
                     s << "\nSeason Games: " << at->GetStats().SeasonGames;
                     s << "\nSeason Wins: " << at->GetStats().SeasonWins;
                     s << "\nWeek Games: " << at->GetStats().WeekGames;
                     s << "\nWeek Wins: " << at->GetStats().WeekWins;

                     ChatHandler(player->GetSession()).PSendSysMessage(s.str().c_str());
                 }
             }
                 break;


             case 5: // Disband arenateam
             {
                 WorldPacket Data;
                 Data << (uint32) player->GetArenaTeamId(ArenaTeam::GetSlotByType(ARENA_TEAM_1v1));
                 player->GetSession()->HandleArenaTeamLeaveOpcode(Data);
                 ChatHandler(player->GetSession()).PSendSysMessage("Arena team deleted!");
                 player->CLOSE_GOSSIP_MENU();
                 return true;
             }
                 break;

             case 8: // Script Info
             {
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Click on Create new 1v1 Arena team", GOSSIP_SENDER_MAIN, uiAction);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Join 1v1 Arena and ready!", GOSSIP_SENDER_MAIN, uiAction);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Enjoy!", GOSSIP_SENDER_MAIN, uiAction);
                 player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "<- Back", GOSSIP_SENDER_MAIN, 7);
                 player->SEND_GOSSIP_MENU(68, me->GetGUID());
                 return true;
             }
                 break;

         }

         OnGossipHello(player, me);
         return true;
     }
 };

 void AddSC_npc_1v1arena() {
     new npc_1v1arena();
 }
