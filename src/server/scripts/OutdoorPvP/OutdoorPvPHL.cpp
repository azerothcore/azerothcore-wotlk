/*
    .__      .___.                
    [__)  .    |   _ ._ _ ._ _   .
    [__)\_|    |  (_)[ | )[ | )\_|
            ._|                    ._|

            Was for Omni-WoW
            Now: Released - 5/4/2012
*/
    #include "OutdoorPvPHL.h"
    #include "Player.h"
    #include "OutdoorPvP.h"
    #include "World.h"
    #include "WorldPacket.h"

    OutdoorPvPHL::OutdoorPvPHL()
    {
        m_TypeId = OUTDOOR_PVP_HL;
        
        m_ally_gathered = HL_RESOURCES_A;
        m_horde_gathered = HL_RESOURCES_H;

        IS_ABLE_TO_SHOW_MESSAGE = false;
        IS_RESOURCE_MESSAGE_A = false;
        IS_RESOURCE_MESSAGE_H = false;

        m_FirstLoad = false;

        limit_A = 0;
        limit_H = 0;

        m_LastWin = 0;

        limit_resources_message_A = 0;
        limit_resources_message_H = 0;
    }

    bool OutdoorPvPHL::SetupOutdoorPvP()
    {
        for (uint8 i = 0; i < OutdoorPvPHLBuffZonesNum; ++i)
            RegisterZone(OutdoorPvPHLBuffZones[i]);
        return true;
    }

    void OutdoorPvPHL::HandlePlayerEnterZone(Player* player, uint32 zone)
    {

		m_ally_gathered = HL_RESOURCES_A;
		m_horde_gathered = HL_RESOURCES_H;

        //char message[250];
        if(player->GetTeam() == ALLIANCE)
            //snprintf(message, 250, "[Hinterland Verteidigung]: Die Allianz hat noch %u Ressourcen uebrig!", m_ally_gathered);
        player->TextEmote(", Alliance has under 250 resources remaining!");
        else
        player->TextEmote(", Horde has under 250 resources remaining!");
            //snprintf(message, 250, "[Hinterland Verteidigung]: Die Horde hat %u Ressourcen uebrig!", m_horde_gathered);

        if (HL_RESOURCES_A <= 250)
        {
        player->TextEmote(", Alliance has under 250 resources remaining!");
        //    sWorld->SendZoneText(zone, "[Hinterland Verteidigung]: Die Allianz hat noch %u Ressourcen uebrig!", TEAM_ALLIANCE);
        }

        if (HL_RESOURCES_H <= 250)
        {
        player->TextEmote(", Horde has under 250 resources remaining!");
        //    sWorld->SendZoneText(zone, "[Hinterland Verteidigung]: Die Horde hat %u Ressourcen uebrig!", TEAM_HORDE);
        }           
             
        //player->TextEmote(message);
        OutdoorPvP::HandlePlayerEnterZone(player, zone);
    }

    void OutdoorPvPHL::HandlePlayerLeaveZone(Player* player, uint32 zone)
    {
        //player->MonsterTextEmote("Du verl�sst die Zone, w�hrend ein PvP-Kampf l�uft!", player->GetGUID());
        player->TextEmote("HEY, you are leaving the zone, while a battle is on going!");
        OutdoorPvP::HandlePlayerLeaveZone(player, zone);
    }

    void OutdoorPvPHL::HandleWinMessage(const char* message)
    {
        for (uint8 i = 0; i < OutdoorPvPHLBuffZonesNum; ++i)
            sWorld->SendZoneText(OutdoorPvPHLBuffZones[i], message);
    }

    void OutdoorPvPHL::PlaySounds(bool side)
    {
        SessionMap m_sessions = sWorld->GetAllSessions();
        SessionMap::iterator itr;
        for(SessionMap::iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
        {
            for (uint8 i = 0; i < OutdoorPvPHLBuffZonesNum; ++i)
            {
                if(!itr->second || !itr->second->GetPlayer() || !itr->second->GetPlayer()->IsInWorld() || itr->second->GetPlayer()->GetZoneId() != OutdoorPvPHLBuffZones[i])
                    continue;

                if(itr->second->GetPlayer()->GetZoneId() == OutdoorPvPHLBuffZones[i])
                {
                    if(itr->second->GetPlayer()->GetTeamId() == TEAM_ALLIANCE && side == true)
                        itr->second->GetPlayer()->PlayDirectSound(HL_SOUND_ALLIANCE_GOOD, itr->second->GetPlayer());
                    else
                        itr->second->GetPlayer()->PlayDirectSound(HL_SOUND_HORDE_GOOD, itr->second->GetPlayer());
                }
            }
        }
    }

    void OutdoorPvPHL::HandleReset()
    {
        m_ally_gathered = HL_RESOURCES_A;
        m_horde_gathered = HL_RESOURCES_H;

        IS_ABLE_TO_SHOW_MESSAGE = false;
        IS_RESOURCE_MESSAGE_A = false;
        IS_RESOURCE_MESSAGE_H = false;

        m_FirstLoad = false;

        limit_A = 0;
        limit_H = 0;

        limit_resources_message_A = 0;
        limit_resources_message_H = 0;

        //sLog->outMessage("[OutdoorPvPHL]: Hinterland: Reset Hinterland BG", 1,);
        LOG_INFO("misc", "[OutdoorPvPHL]: Reset Hinterland BG");
    }

    void OutdoorPvPHL::HandleBuffs(Player* player, bool loser)
    {
        if(loser)
        {
            for(int i = 0; i < LoseBuffsNum; i++)
                player->CastSpell(player, LoseBuffs[i], true);
        }
        else
        {
            for(int i = 0; i < WinBuffsNum; i++)
                player->CastSpell(player, WinBuffs[i], true);
        }
    }

    void OutdoorPvPHL::HandleRewards(Player* player, uint32 honorpointsorarena, bool honor, bool arena, bool both)
    {
        char msg[250];
        uint32 m_GetHonorPoints = player->GetHonorPoints();
        uint32 m_GetArenaPoints = player->GetArenaPoints();

        if(honor)
        {
            player->SetHonorPoints(m_GetHonorPoints + honorpointsorarena);
            snprintf(msg, 250, "You got %u bonus honor!", honorpointsorarena);
        }
        else if(arena)
        {
            player->SetArenaPoints(m_GetArenaPoints + honorpointsorarena);
            snprintf(msg, 250, "You got amount of %u additional arena points!", honorpointsorarena);
        }
        else if(both)
        {
            player->SetHonorPoints(m_GetHonorPoints + honorpointsorarena);
            player->SetArenaPoints(m_GetArenaPoints + honorpointsorarena);
            snprintf(msg, 250, "You got amount of %u additional arena points and bonus honor!", honorpointsorarena);
        }
        HandleWinMessage(msg);
    }

    bool OutdoorPvPHL::Update(uint32 diff)
    {
        OutdoorPvP::Update(diff);
        if(m_FirstLoad == false)
        {
            if(m_LastWin == ALLIANCE) //sLog->outmessage("[OutdoorPvPHL]: Die Schlacht um das Hinterland hat begonnen! Letzter Sieger: Alliance(%u)", ALLIANCE);
            {
                LOG_INFO("misc", "[OutdoorPvPHL]: The battle of Hinterland has started! Last winner: Alliance");                
            }
             
            else if(m_LastWin == HORDE) //sLog->outString("[OutdoorPvPHL]: Die Schlacht um das Hinterland hat begonnen! Letzter Sieger: Horde(%u)", HORDE);
            {
                LOG_INFO("misc", "[OutdoorPvPHL]: The battle of Hinterland has started! Last winner: Horde ");
            }
                
            else if(m_LastWin == 0) //sLog->outString("[OutdoorPvPHL]: Die Schlacht um das Hinterland hat begonnen! Es gab letztes mal keinen Sieger!(0)");
            {
                LOG_INFO("misc", "[OutdoorPvPHL]: The battle of Hinterland has started! There was no winner last time!");
            }
                
            m_FirstLoad = true;
        }

        if(m_ally_gathered <= 50 && limit_A == 0)
        {
            IS_ABLE_TO_SHOW_MESSAGE = true; // We allow the message to pass
            IS_RESOURCE_MESSAGE_A = true; // We allow the message to be shown
            limit_A = 1; // We set this to one to stop the spamming
            PlaySounds(false);
        }
        else if(m_horde_gathered <= 50 && limit_H == 0)
        {
            IS_ABLE_TO_SHOW_MESSAGE = true; // We allow the message to pass
            IS_RESOURCE_MESSAGE_H = true; // We allow the message to be shown
            limit_H = 1; // Same as above
            PlaySounds(true);
        }
        else if(m_ally_gathered <= 0 && limit_A == 1)
        {
            IS_ABLE_TO_SHOW_MESSAGE = true; // We allow the message to pass
            IS_RESOURCE_MESSAGE_A = true; // We allow the message to be shown
            limit_A = 2;
            PlaySounds(false);
        }
        else if(m_horde_gathered <= 0 && limit_H == 1)
        {
            IS_ABLE_TO_SHOW_MESSAGE = true; // We allow the message to pass
            IS_RESOURCE_MESSAGE_H = true; // We allow the message to be shown
            limit_H = 2;
            PlaySounds(true);
        }
        else if(m_ally_gathered <= 300 && limit_resources_message_A == 0)
        {
            IS_ABLE_TO_SHOW_MESSAGE = true;
            limit_resources_message_A = 1;
            PlaySounds(false);
        }
        else if(m_horde_gathered <= 300 && limit_resources_message_H == 0)
        {
            IS_ABLE_TO_SHOW_MESSAGE = true;
            limit_resources_message_H = 1;
            PlaySounds(true);
        }
        else if(m_ally_gathered <= 200 && limit_resources_message_A == 1)
        {
            IS_ABLE_TO_SHOW_MESSAGE = true;
            limit_resources_message_A = 2;
            PlaySounds(false);
        }
        else if(m_horde_gathered <= 200 && limit_resources_message_H == 1)
        {
            IS_ABLE_TO_SHOW_MESSAGE = true;
            limit_resources_message_H = 2;
            PlaySounds(true);
        }
        else if(m_ally_gathered <= 100 && limit_resources_message_A == 2)
        {
            IS_ABLE_TO_SHOW_MESSAGE = true;
            limit_resources_message_A = 3;
            PlaySounds(false);
        }
        else if(m_horde_gathered <= 100 && limit_resources_message_H == 2)
        {
            IS_ABLE_TO_SHOW_MESSAGE = true;
            limit_resources_message_H = 3;
            PlaySounds(true);
        }
     
        if(IS_ABLE_TO_SHOW_MESSAGE == true) // This will limit the spam
        {
            SessionMap m_sessions = sWorld->GetAllSessions();
            for(SessionMap::iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr) // We're searching for all the sessions(Players)
            {
                if(!itr->second || !itr->second->GetPlayer() || !itr->second->GetPlayer()->IsInWorld() ||
                    itr->second->GetPlayer()->GetZoneId() != 47)
                    continue;
     
                if(itr->second->GetPlayer()->GetZoneId() == 47)
                {
                    char msg[250];
                    if(limit_resources_message_A == 1 || limit_resources_message_A == 2 || limit_resources_message_A == 3)
                    {
                        //snprintf(msg, 250, "[Hinterland Defence]: The Alliance got %u resources left!", m_ally_gathered);
                        itr->second->GetPlayer()->TextEmote("[Hinterland Defence]: The Alliance got %u resources left!");
                    }
                    else if(limit_resources_message_H == 1 || limit_resources_message_H == 2 || limit_resources_message_H == 3)
                    {
                        //snprintf(msg, 250, "[Hinterland Defence]: The Horde got %u resources left!", m_horde_gathered);
                        itr->second->GetPlayer()->TextEmote("[Hinterland Defence]: The Horde got %u resources left!");
                    }
     
                    if(IS_RESOURCE_MESSAGE_A == true)
                    {
                        if(limit_A == 1)
                        {
                            //snprintf(msg, 250, "[Hinterland Defence]: The Alliance got %u resources left!", m_ally_gathered);
                            itr->second->GetPlayer()->TextEmote("[Hinterland Defence]: The Alliance got %u resources left!");
                            IS_RESOURCE_MESSAGE_A = false; // Reset
                        }
                        else if(limit_A == 2)
                        {
                            itr->second->GetPlayer()->TextEmote("[Hinterland Defence]: The Alliance got no more resources left! Horde wins!");
                            //itr->second->GetPlayer()->GetGUID();
                            HandleWinMessage("For the HORDE!");
                            HandleRewards(itr->second->GetPlayer(), 1500, true, false, false);
                            
                            switch(itr->second->GetPlayer()->GetTeamId())
                            {
                                case TEAM_ALLIANCE:
                                    HandleBuffs(itr->second->GetPlayer(), true);
                                    break;
     
                                default: //Horde
                                    HandleBuffs(itr->second->GetPlayer(), false);
                                    break;
                            }
                            
                            m_LastWin = HORDE;
                            IS_RESOURCE_MESSAGE_A = false; // Reset
                        }
                    }
                    else if(IS_RESOURCE_MESSAGE_H == true)
                    {
                        if(limit_H == 1)
                        {
                            //snprintf(msg, 250	, "[Hinterland Defence]: The Horde got %u resources left!", m_horde_gathered);
                            itr->second->GetPlayer()->TextEmote("[Hinterland Defence]: The Horde got %u resources left!");
                            IS_RESOURCE_MESSAGE_H = false; // Reset
                        }
                        else if(limit_H == 2)
                        {
                            itr->second->GetPlayer()->TextEmote("[Hinterland Defence]: The Horde has no more resources left! Alliance wins!");
                            //itr->second->GetPlayer()->GetGUID();
                            HandleWinMessage("For the Alliance!");
                            HandleRewards(itr->second->GetPlayer(), 1500, true, false, false);
                            switch(itr->second->GetPlayer()->GetTeamId())
                            {
                                case TEAM_ALLIANCE:
                                    HandleBuffs(itr->second->GetPlayer(), false);
                                    break;
     
                                default: //Horde
                                    HandleBuffs(itr->second->GetPlayer(), true);
                                    break;
                            }
                            m_LastWin = ALLIANCE;
                            IS_RESOURCE_MESSAGE_H = false; // Reset
                        }
                    }
                }
            }
        }

        IS_ABLE_TO_SHOW_MESSAGE = false; // Reset
        return false;
    }
     
    void OutdoorPvPHL::Randomizer(Player* player)
    {
        switch(urand(0, 4))
        {
            case 0:
                HandleRewards(player, 17, true, false, false); // Anpassen?
                break;
            case 1:
                HandleRewards(player, 11, true, false, false); // Anpassen?
                break;
            case 2:
                HandleRewards(player, 19, true, false, false); // Anpassen?
                break;
            case 3:
                HandleRewards(player, 22, true, false, false); // Anpassen?
                break;
        }
    }

    /*
    void outdoorPvPHL::BossReward(Player * player)
    {
        HandleRewards(player, 5000, true, false, false);
        HandleRewards(player, 200, false, true, false);   <- Anpassen?
        
        char message[250];
        if(player->GetTeam() == ALLIANCE)
            snprintf(message, 250, "Der Boss der Horde wurde soeben besiegt!");
        else
            snprintf(message, 250, "Der Boss der Allianz wurde soeben besiegt!);
    */

	void OutdoorPvPHL::HandleKill(Player* player, Unit* killed)
    {
        if(killed->GetTypeId() == TYPEID_PLAYER) // Killing players will take their Resources away. It also gives extra honor.
        {
            if(player->GetGUID() != killed->GetGUID())
                    return;
     
            switch(killed->ToPlayer()->GetTeamId())
            {
               case TEAM_ALLIANCE:
                    m_ally_gathered -= PointsLoseOnPvPKill;
					player->AddItem(40752, 1);
                    Randomizer(player);					
                    break;
               default: //Horde
                    m_horde_gathered -= PointsLoseOnPvPKill;					
                    Randomizer(player);
					player->AddItem(40752, 1);
                    break;
            }
        }
        else // If is something besides a player
        {
            if(player->GetTeamId() == TEAM_ALLIANCE)
            {
                switch(killed->GetEntry()) // Alliance killing horde guards
                {
                    case Horde_Infantry:
                        m_horde_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    case Horde_Squadleader: // 2?
                        m_horde_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    case Horde_Boss:
                        m_horde_gathered -= PointsLoseOnPvPKill;
                        /*BossReward(player); */
                        break;
                    case Horde_Heal:
                        m_horde_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    /*
                    case WARSONG_HONOR_GUARD:
                        m_horde_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    case WARSONG_MARKSMAN:
                        m_horde_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    case WARSONG_RECRUITMENT_OFFICER:
                        m_horde_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    case WARSONG_SCOUT:
                        m_horde_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    case WARSONG_WIND_RIDER:
                        m_horde_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    */
                }
            }
            else // Team Horde
            {
                switch(killed->GetEntry()) // Horde killing alliance guards
                {
                    case Alliance_Healer:
                        m_ally_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    case Alliance_Boss:
                        m_ally_gathered -= PointsLoseOnPvPKill;
                        /*BossReward(player); <- NEU? */
                        break;
                    case Alliance_Infantry:
                        m_ally_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    case Alliance_Squadleader: // Wrong?
                        m_ally_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    /*
                    case VALIANCE_KEEP_FOOTMAN_2: // 2?
                        m_ally_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    case VALIANCE_KEEP_OFFICER:
                        m_ally_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    case VALIANCE_KEEP_RIFLEMAN:
                        m_ally_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    case VALIANCE_KEEP_WORKER:
                        m_ally_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    case DURDAN_THUNDERBEAK:
                        m_ally_gathered -= PointsLoseOnPvPKill;
                        Randomizer(player); // Randomizes the honor reward
                        break;
                    */
                }
            }
        }
    }
    
    class OutdoorPvP_hinterland : public OutdoorPvPScript
    {
        public:
     
        OutdoorPvP_hinterland()
            : OutdoorPvPScript("outdoorpvp_hl") {}
     
        OutdoorPvP* GetOutdoorPvP() const
        {
            return new OutdoorPvPHL();
        }
    };

     
    void AddSC_outdoorpvp_hl()
    {
        new OutdoorPvP_hinterland;
	}
