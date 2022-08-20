/*
    .__      .___.                
    [__)  .    |   _ ._ _ ._ _   .
    [__)\_|    |  (_)[ | )[ | )\_|
            ._|                    ._|
    
            Was for Omni-WoW
            Now: Released - 5/4/2012
*/

    #ifndef OUTDOOR_PVP_HL_
    #define OUTDOOR_PVP_HL_
    #include "OutdoorPvP.h"
    #include "OutdoorPvPMgr.h"
    #include "Chat.h"
	#include "Player.h"

    using namespace std;

    const uint8 PointsLoseOnPvPKill = 5;
    
    const uint8 OutdoorPvPHLBuffZonesNum = 1;
    const uint32 OutdoorPvPHLBuffZones[OutdoorPvPHLBuffZonesNum] = { 47 };

    const uint8 WinBuffsNum                 = 4;
    const uint8 LoseBuffsNum                = 2;
    const uint32 WinBuffs[WinBuffsNum]      = { 39233, 23693, 53899, 62213 }; // Whoever wins, gets these buffs
    const uint32 LoseBuffs[LoseBuffsNum]    = { 23948, 40079}; // Whoever loses, gets this buff.

    const uint32 HL_RESOURCES_A         = 450;
    const uint32 HL_RESOURCES_H         = 450;

    enum Sounds
    {
        HL_SOUND_ALLIANCE_GOOD  = 8173,
        HL_SOUND_HORDE_GOOD     = 8213,
    };

    enum AllianceNpcs
    {
            Heiler_der_Allianz = 600005,
			Allianzboss = 600007,
			Infantrya = 600010,
			Squadleadera = 600011
    };

    enum HordeNpcs
    {
            Heiler_der_Horde = 600004,
			Squadleader = 600008,
			Infantry = 600009,
			Hordeboss = 14996
    };

    class OutdoorPvPHL : public OutdoorPvP
    {
        public:
            /* OutdoorPvPHL Related */
            OutdoorPvPHL();
            bool SetupOutdoorPvP();

            /* Handle Player Action */
            void HandlePlayerEnterZone(Player * player, uint32 zone);
            void HandlePlayerLeaveZone(Player * player, uint32 zone);

            /* Handle Killer Kill */
            void HandleKill(Player * player, Unit * killed);
			
            /* Handle Randomizer */
            void Randomizer(Player * player);

            /*Handle Boss
            void BossReward(Player *player);      <- ?
            */

            /* Buffs */
            void HandleBuffs(Player * player, bool loser);

            /* Chat */
            void HandleWinMessage(const char * msg);

            /* Reset */
            void HandleReset();

            /* Rewards */
            void HandleRewards(Player * player, uint32 honorpointsorarena, bool honor, bool arena, bool both);

            /* Updates */
            bool Update(uint32 diff);

            /* Sounds */
            void PlaySounds(bool side);

        private:
            uint32 m_ally_gathered;
            uint32 m_horde_gathered;
            uint32 m_LastWin;
            bool IS_ABLE_TO_SHOW_MESSAGE;
            bool IS_RESOURCE_MESSAGE_A;
            bool IS_RESOURCE_MESSAGE_H;
            bool m_FirstLoad;
            int limit_A;
            int limit_H;
            int limit_resources_message_A;
            int limit_resources_message_H;
    };
    #endif