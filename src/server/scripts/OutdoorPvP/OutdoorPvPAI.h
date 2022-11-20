/*
    ----
    ---- OUTDOOR PVP - AUTOINVITE v1
    ---- Copyright by Goettersohn 2012
    ----
*/

#ifndef OUTDOOR_PVP_AI_
#define OUTDOOR_PVP_AI_

#include "ObjectGuid.h"
#include "OutdoorPvP.h"
#include "SharedDefines.h"
#include "Util.h"
#include "ZoneScript.h"

using namespace std;

#define OutdoorPvPHPBuffZonesNum 1
const uint32 OutdoorPvPHPBuffZones[OutdoorPvPHPBuffZonesNum] = { 47 }; // Hinterland Zone ID = 47

class OutdoorPvPAI : public OutdoorPvP
{
   public:
        OutdoorPvPAI();

        HL_ZONE                             = 47;
        
        bool SetupOutdoorPvP();
        bool AddOrSetPlayerToCorrectBfGroup(Player *plr);
        void HandlePlayerEnterZone(Player* player, uint32 zone);
        void HandlePlayerLeaveZone(Player* plr, uint32 zone);
        Group* GetFreeBfRaid(TeamId TeamId);
        Group* GetGroupPlayer(ObjectGuid guid, TeamId TeamId);

    // from Battlefield.cpp
    // Players info maps
    GuidUnorderedSet m_players[PVP_TEAMS_COUNT];             // Players in zone
    GuidUnorderedSet m_PlayersInQueue[PVP_TEAMS_COUNT];      // Players in the queue
    GuidUnorderedSet m_PlayersInWar[PVP_TEAMS_COUNT];

      protected:
	  GuidSet m_Groups[2];
      uint32 m_BattleId;
	  //PlayerSet m_PlayersInWar[2]; // deactivated for testing

    /// Called when a player accept to join the battle
    virtual void OnPlayerJoinWar(Player* /*player*/) {};

    //Faction buffs Wintergrasp
    //AllianceBuff = 32071,
    //HordeBuff = 32049
    enum OutdoorPvPAISpells
    {
    AllianceBuff = 32071,
    HordeBuff = 32049
    };
};
#endif
