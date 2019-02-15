/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "vault_of_archavon.h"
#include "Battlefield.h"
#include "BattlefieldMgr.h"
#include "SpellAuras.h"
#include "Player.h"

/* Vault of Archavon encounters:
1 - Archavon the Stone Watcher event
2 - Emalon the Storm Watcher event
3 - Koralon the Flame Watcher event
4 - Toravon the Ice Watcher event
*/

class instance_vault_of_archavon : public InstanceMapScript
{
    public:
        instance_vault_of_archavon() : InstanceMapScript("instance_vault_of_archavon", 624) { }

        struct instance_vault_of_archavon_InstanceMapScript : public InstanceScript
        {
            instance_vault_of_archavon_InstanceMapScript(Map* map) : InstanceScript(map)
            {
            }

            void Initialize()
            {
                memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
                memset(&bossGUIDs, 0, sizeof(bossGUIDs));

                ArchavonDeath = 0;
                EmalonDeath = 0;
                KoralonDeath = 0;
                checkTimer = 0;
                stoned = false;
            }

            void OnPlayerEnter(Player* )
            {
                if (stoned)
                {
                    for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                        if (Creature* cr = instance->GetCreature(bossGUIDs[i]))
                            if (!cr->IsInCombat())
                                cr->RemoveAllAuras();

                    stoned = false;
                }
            }

            void Update(uint32 diff)
            {
                checkTimer += diff;
                if (checkTimer >= 60000)
                {
                    checkTimer -= 60000; // one minute
                    if (Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG))
                    {
                        if (!bf->IsWarTime())
                        {
                            if (bf->GetTimer() <= (16 * MINUTE * IN_MILLISECONDS) && bf->GetTimer() >= (15 * MINUTE * IN_MILLISECONDS))
                            {
                                Map::PlayerList const &PlayerList = instance->GetPlayers();
                                if (!PlayerList.isEmpty())
                                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                        if (Player* player = i->GetSource())
                                            player->MonsterTextEmote("This instance will reset in 15 minutes.", 0, true);
                            }
                            else if (bf->GetTimer() <= (10 * MINUTE * IN_MILLISECONDS) && bf->GetTimer() >= (9 * MINUTE * IN_MILLISECONDS))
                            {
                                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                                    if (Creature* cr = instance->GetCreature(bossGUIDs[i]))
                                        if (!cr->IsInCombat())
                                        {
                                            cr->RemoveAllAuras();
                                            if (Aura* aur = cr->AddAura(SPELL_STONED_AURA, cr))
                                            {
                                                aur->SetMaxDuration(60 * MINUTE* IN_MILLISECONDS);
                                                aur->SetDuration(60 * MINUTE* IN_MILLISECONDS);
                                            }
                                        }

                                stoned = true;
                            }
                            else if (bf->GetTimer() <= (2 * MINUTE * IN_MILLISECONDS) && bf->GetTimer() > (MINUTE * IN_MILLISECONDS))
                            {
                                Map::PlayerList const &PlayerList = instance->GetPlayers();
                                if (!PlayerList.isEmpty())
                                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                        if (Player* player = i->GetSource())
                                            player->MonsterTextEmote("This instance is about to reset. Prepare to be removed.", 0, true);
                            }
                            else if (bf->GetTimer() <= MINUTE * IN_MILLISECONDS)
                            {
                                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                                    if (Creature* cr = instance->GetCreature(bossGUIDs[i]))
                                        if (cr->IsInCombat() && cr->AI())
                                            cr->AI()->EnterEvadeMode();

                                Map::PlayerList const &PlayerList = instance->GetPlayers();
                                if (!PlayerList.isEmpty())
                                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                        if (Player* player = i->GetSource())
                                            player->TeleportTo(player->m_homebindMapId, player->m_homebindX, player->m_homebindY, player->m_homebindZ, player->GetOrientation());
                            }
                        }
                    }
                }
            }

            bool IsEncounterInProgress() const
            {
                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    if (m_auiEncounter[i] == IN_PROGRESS)
                        return true;

                Battlefield* bf = sBattlefieldMgr->GetBattlefieldByBattleId(BATTLEFIELD_BATTLEID_WG);
                if (!bf || bf->IsWarTime() || bf->GetTimer() <= 10 * MINUTE * IN_MILLISECONDS)
                    return true;

                return false;
            }

            void OnCreatureCreate(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                    case CREATURE_TORAVON:
                        bossGUIDs[EVENT_TORAVON] = creature->GetGUID();
                        break;
                    case CREATURE_ARCHAVON:
                        bossGUIDs[EVENT_ARCHAVON] = creature->GetGUID();
                        break;
                    case CREATURE_KORALON:
                        bossGUIDs[EVENT_KORALON] = creature->GetGUID();
                        break;
                    case CREATURE_EMALON:
                        bossGUIDs[EVENT_EMALON] = creature->GetGUID();
                        break;
                }
            }

            uint64 GetData64(uint32 identifier) const
            {
                if (identifier < MAX_ENCOUNTER)
                    return bossGUIDs[identifier];
                return 0;
            }

            uint32 GetData(uint32 identifier) const
            {
                if (identifier == DATA_STONED)
                    return (uint32)stoned;
                return 0;
            }

            void SetData(uint32 type, uint32 data)
            {
                switch(type)
                {
                    case EVENT_ARCHAVON:
                    case EVENT_EMALON:
                    case EVENT_KORALON:
                    case EVENT_TORAVON:
                        m_auiEncounter[type] = data;
                        break;
                }

                if (data == DONE)
                {
                    SaveToDB();
                    switch (type)
                    {
                        case EVENT_ARCHAVON:
                            ArchavonDeath = time(NULL);
                            break;
                        case EVENT_EMALON:
                            EmalonDeath = time(NULL);
                            break;
                        case EVENT_KORALON:
                            KoralonDeath = time(NULL);
                            break;
                        default:
                            return;
                    }

                    // on every death of Archavon, Emalon and Koralon check our achievement
                    DoCastSpellOnPlayers(SPELL_EARTH_WIND_FIRE_ACHIEVEMENT_CHECK);
                }
            }

            bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* /*source*/, Unit const* /*target*/, uint32 /*miscvalue1*/)
            {
                switch (criteria_id)
                {
                    case CRITERIA_EARTH_WIND_FIRE_10:
                    case CRITERIA_EARTH_WIND_FIRE_25:
                        if (ArchavonDeath && EmalonDeath && KoralonDeath)
                        {
                            // instance difficulty check is already done in db (achievement_criteria_data)
                            // int() for Visual Studio, compile errors with abs(time_t)
                            return (abs(int(ArchavonDeath-EmalonDeath)) < MINUTE && \
                                abs(int(EmalonDeath-KoralonDeath)) < MINUTE && \
                                abs(int(KoralonDeath-ArchavonDeath)) < MINUTE);
                        }
                        break;
                    default:
                        break;
                }

                return false;
            }

            std::string GetSaveData()
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << "V O A " << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' ' << m_auiEncounter[2] << ' ' << m_auiEncounter[3];

                OUT_SAVE_INST_DATA_COMPLETE;
                return saveStream.str();
            }

            void Load(const char* in)
            {
                if (!in)
                {
                    OUT_LOAD_INST_DATA_FAIL;
                    return;
                }

                OUT_LOAD_INST_DATA(in);

                char dataHead1, dataHead2, dataHead3;
                std::istringstream loadStream(in);
                loadStream >> dataHead1 >> dataHead2 >> dataHead3;

                if (dataHead1 == 'V' && dataHead2 == 'O' && dataHead3 == 'A')
                {
                    for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    {
                        loadStream >> m_auiEncounter[i];
                        if (m_auiEncounter[i] == IN_PROGRESS)
                            m_auiEncounter[i] = NOT_STARTED;
                    }

                    OUT_LOAD_INST_DATA_COMPLETE;
                }
                else
                    OUT_LOAD_INST_DATA_FAIL;
            }

            private:
                time_t ArchavonDeath;
                time_t EmalonDeath;
                time_t KoralonDeath;
                uint32 checkTimer;
                bool stoned;

                uint32 m_auiEncounter[MAX_ENCOUNTER];
                uint64 bossGUIDs[MAX_ENCOUNTER];
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_vault_of_archavon_InstanceMapScript(map);
        }
};

void AddSC_instance_vault_of_archavon()
{
    new instance_vault_of_archavon();
}
