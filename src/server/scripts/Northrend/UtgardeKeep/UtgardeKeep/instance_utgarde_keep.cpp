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

#include "Player.h"
#include "ScriptObject.h"
#include "ScriptedCreature.h"
#include "utgarde_keep.h"

class instance_utgarde_keep : public InstanceMapScript
{
public:
    instance_utgarde_keep() : InstanceMapScript("instance_utgarde_keep", 574) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_utgarde_keep_InstanceMapScript(pMap);
    }

    struct instance_utgarde_keep_InstanceMapScript : public InstanceScript
    {
        instance_utgarde_keep_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {}

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        uint32 ForgeEventMask;
        std::string str_data;

        ObjectGuid GO_ForgeBellowGUID[3];
        ObjectGuid GO_ForgeFireGUID[3];
        ObjectGuid GO_ForgeAnvilGUID[3];
        ObjectGuid GO_PortcullisGUID[2];

        ObjectGuid NPC_KelesethGUID;
        ObjectGuid NPC_DalronnGUID;
        ObjectGuid NPC_SkarvaldGUID;
        ObjectGuid NPC_DalronnGhostGUID;
        ObjectGuid NPC_SkarvaldGhostGUID;
        ObjectGuid NPC_IngvarGUID;
        ObjectGuid NPC_DarkRangerMarrahGUID;
        ObjectGuid NPC_SpecialDrakeGUID;
        bool bRocksAchiev;

        void Initialize() override
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
            ForgeEventMask = 0;

            bRocksAchiev = true;
        }

        bool IsEncounterInProgress() const override
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS) return true;

            return false;
        }

        void OnPlayerEnter(Player* plr) override
        {
            if (Creature* c = instance->GetCreature(NPC_DarkRangerMarrahGUID))
            {
                c->SetReactState(REACT_PASSIVE);
                c->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                if (plr && plr->GetTeamId() == TEAM_HORDE)
                {
                    if (!c->IsVisible())
                        c->SetVisible(true);
                    return;
                }
                else if(c->IsVisible())
                    c->SetVisible(false);
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch(creature->GetEntry())
            {
                case NPC_KELESETH:
                    NPC_KelesethGUID = creature->GetGUID();
                    break;
                case NPC_DALRONN:
                    NPC_DalronnGUID = creature->GetGUID();
                    break;
                case NPC_SKARVALD:
                    NPC_SkarvaldGUID = creature->GetGUID();
                    break;
                case NPC_DALRONN_GHOST:
                    NPC_DalronnGhostGUID = creature->GetGUID();
                    break;
                case NPC_SKARVALD_GHOST:
                    NPC_SkarvaldGhostGUID = creature->GetGUID();
                    break;
                case NPC_INGVAR:
                    NPC_IngvarGUID = creature->GetGUID();
                    break;
                case NPC_DARK_RANGER_MARRAH:
                    NPC_DarkRangerMarrahGUID = creature->GetGUID();
                    break;
                case NPC_ENSLAVED_PROTO_DRAKE:
                    if (creature->GetPositionX() < 250.0f) NPC_SpecialDrakeGUID = creature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch(go->GetEntry())
            {
                case GO_BELLOW_1:
                    GO_ForgeBellowGUID[0] = go->GetGUID();
                    if (ForgeEventMask & 1) HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_BELLOW_2:
                    GO_ForgeBellowGUID[1] = go->GetGUID();
                    if (ForgeEventMask & 2) HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_BELLOW_3:
                    GO_ForgeBellowGUID[2] = go->GetGUID();
                    if (ForgeEventMask & 4) HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_FORGEFIRE_1:
                    GO_ForgeFireGUID[0] = go->GetGUID();
                    if (ForgeEventMask & 1) HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_FORGEFIRE_2:
                    GO_ForgeFireGUID[1] = go->GetGUID();
                    if (ForgeEventMask & 2) HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_FORGEFIRE_3:
                    GO_ForgeFireGUID[2] = go->GetGUID();
                    if (ForgeEventMask & 4) HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_GLOWING_ANVIL_1:
                    GO_ForgeAnvilGUID[0] = go->GetGUID();
                    if (ForgeEventMask & 1) HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_GLOWING_ANVIL_2:
                    GO_ForgeAnvilGUID[1] = go->GetGUID();
                    if (ForgeEventMask & 2) HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_GLOWING_ANVIL_3:
                    GO_ForgeAnvilGUID[2] = go->GetGUID();
                    if (ForgeEventMask & 4) HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_GIANT_PORTCULLIS_1:
                    GO_PortcullisGUID[0] = go->GetGUID();
                    if (m_auiEncounter[2] == DONE) HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_GIANT_PORTCULLIS_2:
                    GO_PortcullisGUID[1] = go->GetGUID();
                    if (m_auiEncounter[2] == DONE) HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch(type)
            {
                case DATA_KELESETH:
                    m_auiEncounter[0] = data;
                    if (data == NOT_STARTED)
                        bRocksAchiev = true;
                    break;
                case DATA_ON_THE_ROCKS_ACHIEV:
                    bRocksAchiev = false;
                    break;
                case DATA_DALRONN_AND_SKARVALD:
                    if (data == NOT_STARTED)
                    {
                        if( Creature* c = instance->GetCreature(NPC_DalronnGUID) )
                            if( c->isDead() )
                            {
                                c->AI()->DoAction(-1);
                                c->Respawn();
                            }
                        if( Creature* c = instance->GetCreature(NPC_SkarvaldGUID) )
                            if( c->isDead() )
                                c->Respawn();
                        if( Creature* c = instance->GetCreature(NPC_DalronnGhostGUID) )
                        {
                            c->AI()->DoAction(-1);
                            c->DespawnOrUnsummon();
                        }
                        NPC_DalronnGhostGUID.Clear();
                        if( Creature* c = instance->GetCreature(NPC_SkarvaldGhostGUID) )
                            c->DespawnOrUnsummon();
                        NPC_SkarvaldGhostGUID.Clear();
                    }
                    if (data == DONE)
                    {
                        if( Creature* c = instance->GetCreature(NPC_DalronnGhostGUID) )
                        {
                            c->AI()->DoAction(-1);
                            c->DespawnOrUnsummon();
                        }
                        NPC_DalronnGhostGUID.Clear();
                        if( Creature* c = instance->GetCreature(NPC_SkarvaldGhostGUID) )
                            c->DespawnOrUnsummon();
                        NPC_SkarvaldGhostGUID.Clear();
                    }

                    m_auiEncounter[1] = data;
                    break;
                case DATA_UNLOCK_SKARVALD_LOOT:
                    if( Creature* c = instance->GetCreature(NPC_SkarvaldGUID) )
                    {
                        c->SetDynamicFlag(UNIT_DYNFLAG_LOOTABLE | UNIT_DYNFLAG_TAPPED | UNIT_DYNFLAG_TAPPED_BY_PLAYER);
                        c->SetLootMode(1);
                        c->loot.clear();
                        if (uint32 lootid = c->GetCreatureTemplate()->lootid)
                            c->loot.FillLoot(lootid, LootTemplates_Creature, c->GetLootRecipient(), false, false, c->GetLootMode(), c);
                        if (c->GetLootMode())
                            c->loot.generateMoneyLoot(c->GetCreatureTemplate()->mingold, c->GetCreatureTemplate()->maxgold);
                        c->DestroyForNearbyPlayers();
                        c->SetVisible(true);
                    }
                    break;
                case DATA_UNLOCK_DALRONN_LOOT:
                    if( Creature* c = instance->GetCreature(NPC_DalronnGUID) )
                    {
                        c->AI()->DoAction(-1);
                        c->SetDynamicFlag(UNIT_DYNFLAG_LOOTABLE | UNIT_DYNFLAG_TAPPED | UNIT_DYNFLAG_TAPPED_BY_PLAYER);
                        c->SetLootMode(1);
                        c->loot.clear();
                        if (uint32 lootid = c->GetCreatureTemplate()->lootid)
                            c->loot.FillLoot(lootid, LootTemplates_Creature, c->GetLootRecipient(), false, false, c->GetLootMode(), c);
                        if (c->GetLootMode())
                            c->loot.generateMoneyLoot(c->GetCreatureTemplate()->mingold, c->GetCreatureTemplate()->maxgold);
                        c->DestroyForNearbyPlayers();
                        c->SetVisible(true);
                    }
                    break;
                case DATA_INGVAR:
                    if (data == DONE)
                    {
                        HandleGameObject(GO_PortcullisGUID[0], true);
                        HandleGameObject(GO_PortcullisGUID[1], true);
                    }
                    m_auiEncounter[2] = data;
                    break;
                case DATA_FORGE_1:
                case DATA_FORGE_2:
                case DATA_FORGE_3:
                    if (data == NOT_STARTED)
                    {
                        HandleGameObject(GO_ForgeBellowGUID[type - 100], false);
                        HandleGameObject(GO_ForgeFireGUID[type - 100], false);
                        HandleGameObject(GO_ForgeAnvilGUID[type - 100], false);
                        ForgeEventMask &= ~((uint32)(1 << (type - 100)));
                    }
                    else
                    {
                        HandleGameObject(GO_ForgeBellowGUID[type - 100], true);
                        HandleGameObject(GO_ForgeFireGUID[type - 100], true);
                        HandleGameObject(GO_ForgeAnvilGUID[type - 100], true);
                        ForgeEventMask |= (uint32)(1 << (type - 100));
                    }
                    break;
                case DATA_SPECIAL_DRAKE:
                    if (Creature* c = instance->GetCreature(NPC_SpecialDrakeGUID))
                        c->AI()->SetData(28, 6);
                    break;
            }

            if (data == DONE)
            {
                SaveToDB();
            }
        }

        ObjectGuid GetGuidData(uint32 id) const override
        {
            switch (id)
            {
                case DATA_KELESETH:
                    return NPC_KelesethGUID;
                case DATA_DALRONN:
                    return NPC_DalronnGUID;
                case DATA_SKARVALD:
                    return NPC_SkarvaldGUID;
                case DATA_INGVAR:
                    return NPC_IngvarGUID;
            }

            return ObjectGuid::Empty;
        }

        uint32 GetData(uint32 id) const override
        {
            switch (id)
            {
                case DATA_KELESETH:
                case DATA_DALRONN_AND_SKARVALD:
                case DATA_INGVAR:
                    return m_auiEncounter[id];
                case DATA_FORGE_1:
                case DATA_FORGE_2:
                case DATA_FORGE_3:
                    return ForgeEventMask & (uint32)(1 << (id - 100));
            }

            return 0;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "U K " << m_auiEncounter[0] << ' ' << m_auiEncounter[1] << ' ' << m_auiEncounter[2] << ' ' << ForgeEventMask;

            str_data = saveStream.str();

            OUT_SAVE_INST_DATA_COMPLETE;
            return str_data;
        }

        void Load(const char* in) override
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            uint32 data0, data1, data2, data3;

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0 >> data1 >> data2 >> data3;

            if (dataHead1 == 'U' && dataHead2 == 'K')
            {
                m_auiEncounter[0] = data0;
                m_auiEncounter[1] = data1;
                m_auiEncounter[2] = data2;
                ForgeEventMask = data3;

                for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    if (m_auiEncounter[i] == IN_PROGRESS)
                        m_auiEncounter[i] = NOT_STARTED;
            }
            else OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch(criteria_id)
            {
                case 7231: // On The Rocks
                    return bRocksAchiev;
            }
            return false;
        }
    };
};

void AddSC_instance_utgarde_keep()
{
    new instance_utgarde_keep();
}
