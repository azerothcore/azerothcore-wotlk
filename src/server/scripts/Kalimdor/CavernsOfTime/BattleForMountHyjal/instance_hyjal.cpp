/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/* ScriptData
SDName: Instance_Mount_Hyjal
SD%Complete: 100
SDComment: Instance Data Scripts and functions to acquire mobs and set encounter status for use in various Hyjal Scripts
SDCategory: Caverns of Time, Mount Hyjal
EndScriptData */

#include "Chat.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "Opcodes.h"
#include "WorldPacket.h"
#include "hyjal_trash.h"

/* Battle of Mount Hyjal encounters:
0 - Rage Winterchill event
1 - Anetheron event
2 - Kaz'rogal event
3 - Azgalor event
4 - Archimonde event
*/

/*
Rage Winterchill
Wave 1: 130000
Wave 2: 130000
Wave 3: 130000
Wave 4: 130000
Wave 5: 130000
Wave 6: 130000
Wave 7: 130000
Wave 8: 190000

Anetheron
Wave 1: 130000
Wave 2: 130000
Wave 3: 130000
Wave 4: 130000
Wave 5: 130000
Wave 6: 130000
Wave 7: 130000
Wave 8: 190000

Alliance Overrun
Wave 1: 10000
Wave 2: 4000

3rd Boss
Wave 1: 130000
Wave 2: 155000
Wave 3: 130000
Wave 4: 155000
Wave 5: 130000
Wave 6: 130000
Wave 7: 155000
Wave 8: 225000

4rd Boss
Wave 1: 130000
Wave 2: 190000
Wave 3: 190000
Wave 4: 190000
Wave 5: 130000
Wave 6: 155000
Wave 7: 190000
Wave 8: 225000

Horde Overrun
Wave 1: 10000
Wave 2: 40000
*/

#define YELL_EFFORTS        "All of your efforts have been in vain, for the draining of the World Tree has already begun. Soon the heart of your world will beat no more."

class instance_hyjal : public InstanceMapScript
{
public:
    instance_hyjal() : InstanceMapScript("instance_hyjal", 534) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_mount_hyjal_InstanceMapScript(map);
    }

    struct instance_mount_hyjal_InstanceMapScript : public InstanceScript
    {
        instance_mount_hyjal_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            SetHeaders(DataHeader);
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            RaidDamage         = 0;
            trash              = 0;
            hordeRetreat       = 0;
            allianceRetreat    = 0;

            _encounterNPCs.clear();
            _baseAlliance.clear();
            _baseHorde.clear();
            _infernalTargets.clear();
            _baseNightElf.clear();
            _roaringFlameAlliance.clear();
            _roaringFlameHorde.clear();
            _ancientGemAlliance.clear();
            _ancientGemHorde.clear();

            ArchiYell          = false;
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < EncounterCount; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS)
                    return true;

            return false;
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_HORDE_ENCAMPMENT_PORTAL:
                    HordeGate = go->GetGUID();
                    if (allianceRetreat)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    else
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_NIGHT_ELF_VILLAGE_PORTAL:
                    ElfGate = go->GetGUID();
                    if (hordeRetreat)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    else
                        HandleGameObject(ObjectGuid::Empty, false, go);
                    break;
                case GO_ANCIENT_GEM:
                    if (go->GetPositionY() > -2500.f)
                        _ancientGemAlliance.insert(go->GetGUID());
                    else
                        _ancientGemHorde.insert(go->GetGUID());
                    go->DespawnOrUnsummon();
                    break;
                case GO_FLAME:
                    if (go->GetPositionX() < 5360.f)
                        _roaringFlameAlliance.insert(go->GetGUID());
                    else
                        _roaringFlameHorde.insert(go->GetGUID());
                    go->DespawnOrUnsummon();
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_ARCHIMONDE:
                    Archimonde = creature->GetGUID();
                    break;
                case NPC_JAINA:
                    JainaProudmoore = creature->GetGUID();
                    break;
                case NPC_THRALL:
                    Thrall = creature->GetGUID();
                    break;
                case NPC_TYRANDE:
                    TyrandeWhisperwind = creature->GetGUID();
                    break;

                    // Alliance base
                case NPC_ALLIANCE_PEASANT:
                case NPC_ALLIANCE_KNIGHT:
                case NPC_ALLIANCE_FOOTMAN:
                case NPC_ALLIANCE_RIFLEMAN:
                case NPC_ALLIANCE_PRIEST:
                case NPC_ALLIANCE_SORCERESS:
                    _baseAlliance.insert(creature->GetGUID());
                    break;
                    // Horde base
                case NPC_HORDE_HEADHUNTER:
                case NPC_HORDE_SHAMAN:
                case NPC_HORDE_GRUNT:
                case NPC_HORDE_HEALING_WARD:
                case NPC_TAUREN_WARRIOR:
                case NPC_HORDE_WITCH_DOCTOR:
                case NPC_HORDE_PEON:
                    _baseHorde.insert(creature->GetGUID());
                    break;
                    // Elf base
                case NPC_DRUID_OF_THE_TALON:
                case NPC_DRUID_OF_THE_CLAW:
                case NPC_NELF_ANCIENT_PROT:
                case NPC_NELF_ANCIENT_OF_LORE:
                case NPC_NELF_ANCIENT_OF_WAR:
                case NPC_NELF_ARCHER:
                case NPC_NELF_HUNTRESS:
                case NPC_DRYAD:
                    _baseNightElf.insert(creature->GetGUID());
                    break;

                case NPC_INFERNAL_TARGET:
                    _infernalTargets.insert(creature->GetGUID());
                    break;

                case NPC_WINTERCHILL:
                case NPC_ANETHERON:
                case NPC_KAZROGAL:
                case NPC_AZGALOR:
                {
                    switch (creature->GetEntry())
                    {
                    case NPC_WINTERCHILL: SetData(DATA_RAGEWINTERCHILL, IN_PROGRESS); break;
                    case NPC_ANETHERON: SetData(DATA_ANETHERON, IN_PROGRESS); break;
                    case NPC_KAZROGAL: SetData(DATA_KAZROGAL, IN_PROGRESS); break;
                    case NPC_AZGALOR: SetData(DATA_AZGALOR, IN_PROGRESS); break;
                    }
                    // no break
                }
                case NPC_NECRO:
                case NPC_ABOMI:
                case NPC_GHOUL:
                case NPC_BANSH:
                case NPC_CRYPT:
                case NPC_GARGO:
                case NPC_FROST:
                case NPC_INFER:
                case NPC_STALK:
                    if (creature->IsSummon())
                    {
                        DoUpdateWorldState(WORLD_STATE_ENEMYCOUNT, ++trash);    // Update the instance wave count on new trash spawn
                        _encounterNPCs.insert(creature->GetGUID());                 // Used for despawning on wipe
                    }
            }
        }

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            switch (identifier)
            {
                case DATA_RAGEWINTERCHILL:
                    return RageWinterchill;
                case DATA_ANETHERON:
                    return Anetheron;
                case DATA_KAZROGAL:
                    return Kazrogal;
                case DATA_AZGALOR:
                    return Azgalor;
                case DATA_ARCHIMONDE:
                    return Archimonde;
                case DATA_JAINAPROUDMOORE:
                    return JainaProudmoore;
                case DATA_THRALL:
                    return Thrall;
                case DATA_TYRANDEWHISPERWIND:
                    return TyrandeWhisperwind;
            }

            return ObjectGuid::Empty;
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch (type)
            {
                case DATA_RAGEWINTERCHILLEVENT:
                    m_auiEncounter[0] = data;
                    break;
                case DATA_ANETHERONEVENT:
                    m_auiEncounter[1] = data;
                    break;
                case DATA_KAZROGALEVENT:
                    m_auiEncounter[2] = data;
                    break;
                case DATA_AZGALOREVENT:
                    {
                        m_auiEncounter[3] = data;
                        if (data == DONE)
                        {
                            if (ArchiYell)
                                break;

                            ArchiYell = true;

                            Creature* creature = instance->GetCreature(Azgalor);
                            if (creature)
                            {
                                Creature* unit = creature->SummonCreature(NPC_WORLD_TRIGGER_TINY, creature->GetPositionX(), creature->GetPositionY(), creature->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN, 10000);

                                Map* map = creature->GetMap();
                                if (map->IsDungeon() && unit)
                                {
                                    unit->SetVisible(false);
                                    Map::PlayerList const& PlayerList = map->GetPlayers();
                                    if (PlayerList.IsEmpty())
                                        return;

                                    for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                                    {
                                        if (Player* player = i->GetSource())
                                        {
                                            WorldPacket packet;
                                            ChatHandler::BuildChatPacket(packet, CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, unit, player, YELL_EFFORTS);
                                            player->SendDirectMessage(&packet);
                                            player->PlayDirectSound(10986, player);
                                        }
                                    }
                                }
                            }
                        }
                    }
                    break;
                case DATA_ARCHIMONDEEVENT:
                    m_auiEncounter[4] = data;
                    break;
                case DATA_RESET_TRASH_COUNT:
                    trash = 0;
                    break;
                case DATA_TRASH:
                    if (data)
                        trash = data;
                    else
                        trash--;
                    DoUpdateWorldState(WORLD_STATE_ENEMYCOUNT, trash);
                    break;
                    /*
                case TYPE_RETREAT:
                    if (data == SPECIAL)
                    {
                        if (!m_uiAncientGemGUID.empty())
                        {
                            for (ObjectGuid const& guid : m_uiAncientGemGUID)
                            {
                                //don't know how long it expected
                                DoRespawnGameObject(guid, DAY);
                            }
                        }
                    }
                    break;
                    */
                case DATA_ALLIANCE_RETREAT:
                    allianceRetreat = data;
                    HandleGameObject(HordeGate, true);
                    SaveToDB();
                    break;
                case DATA_HORDE_RETREAT:
                    hordeRetreat = data;
                    HandleGameObject(ElfGate, true);
                    SaveToDB();
                    break;
                case DATA_RAIDDAMAGE:
                    RaidDamage += data;
                    if (RaidDamage >= MINRAIDDAMAGE)
                        RaidDamage = MINRAIDDAMAGE;
                    break;
                case DATA_RESET_RAIDDAMAGE:
                    RaidDamage = 0;
                    break;
            }

            // LOG_DEBUG("scripts", "Instance Hyjal: Instance data updated for event {} (Data={})", type, data);

            if (data == DONE)
            {
                SaveToDB();
            }
        }

        uint32 GetData(uint32 type) const override
        {
            switch (type)
            {
                case DATA_RAGEWINTERCHILLEVENT:
                    return m_auiEncounter[0];
                case DATA_ANETHERONEVENT:
                    return m_auiEncounter[1];
                case DATA_KAZROGALEVENT:
                    return m_auiEncounter[2];
                case DATA_AZGALOREVENT:
                    return m_auiEncounter[3];
                case DATA_ARCHIMONDEEVENT:
                    return m_auiEncounter[4];
                case DATA_TRASH:
                    return trash;
                case DATA_ALLIANCE_RETREAT:
                    return allianceRetreat;
                case DATA_HORDE_RETREAT:
                    return hordeRetreat;
                case DATA_RAIDDAMAGE:
                    return RaidDamage;
            }
            return 0;
        }

        void StartStandardWaves(std::array<hyjalWaves, MAX_WAVES> data)
        {
            int i = 0;
            _scheduler.Schedule(1ms, [this](TaskContext context)
                {
                    for (std::array<hyjalWaves, MAX_WAVES> wave : data[i])
                    {
                        instance->SummonCreatureGroup
                    }
                    context.Repeat();
                });
        }

        void Update(uint32 diff) override
        {
            _scheduler.Update(diff);
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> m_auiEncounter[0];
            data >> m_auiEncounter[1];
            data >> m_auiEncounter[2];
            data >> m_auiEncounter[3];
            data >> m_auiEncounter[4];
            data >> allianceRetreat;
            data >> hordeRetreat;
            data >> RaidDamage;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << m_auiEncounter[0] << ' '
                << m_auiEncounter[1] << ' '
                << m_auiEncounter[2] << ' '
                << m_auiEncounter[3] << ' '
                << m_auiEncounter[4]<< ' '
                << allianceRetreat << ' '
                << hordeRetreat << ' '
                << RaidDamage;
        }

    protected:
        uint32 m_auiEncounter[EncounterCount];
        ObjectGuid RageWinterchill;
        ObjectGuid Anetheron;
        ObjectGuid Kazrogal;
        ObjectGuid Azgalor;
        ObjectGuid Archimonde;
        ObjectGuid JainaProudmoore;
        ObjectGuid Thrall;
        ObjectGuid TyrandeWhisperwind;
        ObjectGuid HordeGate;
        ObjectGuid ElfGate;
        uint32 trash;
        uint32 hordeRetreat;
        uint32 allianceRetreat;
        uint32 RaidDamage;
        bool ArchiYell;

        TaskScheduler _scheduler;
        GuidSet _encounterNPCs;
        GuidSet _baseAlliance;
        GuidSet _baseHorde;
        GuidSet _infernalTargets;
        GuidSet _baseNightElf;
        GuidSet _ancientGemAlliance;
        GuidSet _ancientGemHorde;
        GuidSet _roaringFlameAlliance;
        GuidSet _roaringFlameHorde;
    };
};

void AddSC_instance_mount_hyjal()
{
    new instance_hyjal();
}
