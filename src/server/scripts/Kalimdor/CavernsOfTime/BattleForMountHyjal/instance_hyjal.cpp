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

            m_uiAncientGemGUID.clear();

            RaidDamage         = 0;
            Trash              = 0;
            hordeRetreat       = 0;
            allianceRetreat    = 0;

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
                    m_uiAncientGemGUID.push_back(go->GetGUID());
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case RAGE_WINTERCHILL:
                    RageWinterchill = creature->GetGUID();
                    break;
                case ANETHERON:
                    Anetheron = creature->GetGUID();
                    break;
                case KAZROGAL:
                    Kazrogal = creature->GetGUID();
                    break;
                case AZGALOR:
                    Azgalor = creature->GetGUID();
                    break;
                case ARCHIMONDE:
                    Archimonde = creature->GetGUID();
                    break;
                case JAINA:
                    JainaProudmoore = creature->GetGUID();
                    break;
                case THRALL:
                    Thrall = creature->GetGUID();
                    break;
                case TYRANDE:
                    TyrandeWhisperwind = creature->GetGUID();
                    break;
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
                    Trash = 0;
                    break;
                case DATA_TRASH:
                    if (data)
                        Trash = data;
                    else
                        Trash--;
                    DoUpdateWorldState(WORLD_STATE_ENEMYCOUNT, Trash);
                    break;
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
                    return Trash;
                case DATA_ALLIANCE_RETREAT:
                    return allianceRetreat;
                case DATA_HORDE_RETREAT:
                    return hordeRetreat;
                case DATA_RAIDDAMAGE:
                    return RaidDamage;
            }
            return 0;
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
        GuidList m_uiAncientGemGUID;
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
        uint32 Trash;
        uint32 hordeRetreat;
        uint32 allianceRetreat;
        uint32 RaidDamage;
        bool ArchiYell;
    };
};

void AddSC_instance_mount_hyjal()
{
    new instance_hyjal();
}
