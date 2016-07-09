#include "Player.h"
#include "Group.h"
#include "AzthPlayer.h"
#include "Define.h"
#include "ObjectAccessor.h"
#include "World.h"

/* [TODO] fix and re-enable */
 AzthPlayer::AzthPlayer(Player *origin) {
     playerQuestRate = sWorld->getRate(RATE_XP_QUEST);
     player = origin;
 }

// void AzthPlayer::SetPlayerQuestRate(float rate) {
//     playerQuestRate = rate;
// }

 uint32 AzthPlayer::getArena1v1Info(uint8 type) {
     return arena1v1Info[type];
 }

 void AzthPlayer::setArena1v1Info(uint8 type, uint32 value) {
     arena1v1Info[type] = value;
 }
//
// float AzthPlayer::GetPlayerQuestRate() {
//     return playerQuestRate;
// }
//
// uint32 AzthPlayer::getOriginalTeam() {
//     return player->TeamForRace(player->getRace());
// }
//
// bool AzthPlayer::setFactionForRace(uint8 race) {
//
//     /* [TODO] implement zone check
//      * we already notify setFactionForRace on zone change in our AzthPlayerPlg
//
//     if (zone in limited list from custom db table) then
//      return false;
//
//      */
//
//     if (player->InBattleground()) {
//         if (Battleground * bg = player->GetBattleground()) {
//             player->m_team = player->GetBGTeam();
//
//             player->setFaction(player->m_team == ALLIANCE ? 1 : 2);
//
//             return true;
//         }
//     }
//
//     ObjectGuid leaderGuid = player->GetGroup() ? player->GetGroup()->GetLeaderGUID() : player->GetGUID();
//     if (leaderGuid != player->GetGUID()) {
//         Player* leader = ObjectAccessor::FindPlayer(leaderGuid);
//
//         if (leader) {
//             player->m_team = leader->GetTeam();
//             player->setFaction(leader->getFaction());
//         } else {
//             // Query informations from the DB
//             PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_PINFO);
//             stmt->setUInt32(0, leaderGuid.GetCounter());
//             PreparedQueryResult result = CharacterDatabase.Query(stmt);
//
//             if (!result)
//                 return false;
//
//             Field* fields = result->Fetch();
//             uint8 raceid = fields[4].GetUInt8();
//
//             player->m_team = Player::TeamForRace(raceid);
//
//             ChrRacesEntry const* rEntry = sChrRacesStore.LookupEntry(raceid);
//             player->setFaction(rEntry ? rEntry->FactionID : 0);
//         }
//
//         return true;
//     }
//
//     return false;
// }
