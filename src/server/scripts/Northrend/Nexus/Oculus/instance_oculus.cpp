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

#include "Group.h"
#include "InstanceMapScript.h"
#include "LFGMgr.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "oculus.h"

class instance_oculus : public InstanceMapScript
{
public:
    instance_oculus() : InstanceMapScript("instance_oculus", 578) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_oculus_InstanceMapScript(pMap);
    }

    struct instance_oculus_InstanceMapScript : public InstanceScript
    {
        instance_oculus_InstanceMapScript(Map* pMap) : InstanceScript(pMap) { Initialize(); }

        uint32 m_auiEncounter[MAX_ENCOUNTER];
        ObjectGuid DragonCageDoorGUID[3];
        ObjectGuid EregosCacheGUID;
        uint32 CentrifugeCount;

        ObjectGuid uiDrakosGUID;
        ObjectGuid uiVarosGUID;
        ObjectGuid uiUromGUID;
        ObjectGuid uiEregosGUID;

        bool bAmberVoid;
        bool bEmeraldVoid;
        bool bRubyVoid;

        void Initialize() override
        {
            SetHeaders(DataHeader);
            CentrifugeCount = 0;
            bAmberVoid = false;
            bEmeraldVoid = false;
            bRubyVoid = false;

            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
        }

        void OnCreatureCreate(Creature* pCreature) override
        {
            switch( pCreature->GetEntry() )
            {
                case NPC_DRAKOS:
                    uiDrakosGUID = pCreature->GetGUID();
                    break;
                case NPC_VAROS:
                    uiVarosGUID = pCreature->GetGUID();
                    break;
                case NPC_UROM:
                    uiUromGUID = pCreature->GetGUID();
                    break;
                case NPC_EREGOS:
                    uiEregosGUID = pCreature->GetGUID();
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* pGo) override
        {
            switch( pGo->GetEntry() )
            {
                case GO_DRAGON_CAGE_DOOR:
                    for( uint8 i = 0; i < 3; ++i )
                    {
                        if( DragonCageDoorGUID[i] )
                            continue;

                        DragonCageDoorGUID[i] = pGo->GetGUID();
                        break;
                    }
                    if( m_auiEncounter[DATA_DRAKOS] == DONE )
                        if( pGo->GetGoState() != GO_STATE_ACTIVE )
                        {
                            pGo->SetLootState(GO_READY);
                            pGo->UseDoorOrButton(0, false);
                        }
                    break;
                case GO_CACHE_OF_EREGOS:
                case GO_CACHE_OF_EREGOS_HERO:
                    EregosCacheGUID = pGo->GetGUID();
                    break;
            }
        }

        void OnPlayerEnter(Player* player) override
        {
            if (m_auiEncounter[DATA_DRAKOS] == DONE && m_auiEncounter[DATA_VAROS] != DONE)
            {
                player->SendUpdateWorldState(WORLD_STATE_CENTRIFUGE_CONSTRUCT_SHOW, 1);
                player->SendUpdateWorldState(WORLD_STATE_CENTRIFUGE_CONSTRUCT_AMOUNT, 10 - CentrifugeCount);
            }
            else
            {
                player->SendUpdateWorldState(WORLD_STATE_CENTRIFUGE_CONSTRUCT_SHOW, 0);
                player->SendUpdateWorldState(WORLD_STATE_CENTRIFUGE_CONSTRUCT_AMOUNT, 0);
            }
        }

        void OnUnitDeath(Unit* unit) override
        {
            if (unit->GetEntry() == NPC_CENTRIFUGE_CONSTRUCT)
                SetData(DATA_CC_COUNT, DONE);
        }

        void SetData(uint32 type, uint32 data) override
        {
            switch( type )
            {
                case DATA_DRAKOS:
                    m_auiEncounter[DATA_DRAKOS] = data;
                    if( data == DONE )
                    {
                        DoUpdateWorldState(WORLD_STATE_CENTRIFUGE_CONSTRUCT_SHOW, 1);
                        DoUpdateWorldState(WORLD_STATE_CENTRIFUGE_CONSTRUCT_AMOUNT, 10 - CentrifugeCount);

                        if (instance->IsHeroic())
                            DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_MAKE_IT_COUNT_TIMED_EVENT);
                    }
                    break;
                case DATA_VAROS:
                    m_auiEncounter[DATA_VAROS] = data;
                    if( data == DONE )
                    {
                        DoUpdateWorldState(WORLD_STATE_CENTRIFUGE_CONSTRUCT_SHOW, 0);

                        if( Creature* urom = instance->GetCreature(uiUromGUID) )
                            urom->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    }
                    break;
                case DATA_UROM:
                    m_auiEncounter[DATA_UROM] = data;
                    if( data == DONE )
                        if( Creature* eregos = instance->GetCreature(uiEregosGUID) )
                            eregos->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                    break;
                case DATA_EREGOS:
                    m_auiEncounter[DATA_EREGOS] = data;
                    if (data == DONE)
                    {
                        DoRespawnGameObject(EregosCacheGUID, 7 * DAY);

                        if (GameObject* cache = instance->GetGameObject(EregosCacheGUID))
                        {
                            if (Creature* eregos = instance->GetCreature(uiEregosGUID))
                            {
                                cache->SetLootRecipient(eregos);
                            }
                        }
                    }
                    break;
                case DATA_CC_COUNT:
                    if( CentrifugeCount < 10 )
                    {
                        ++CentrifugeCount;
                        DoUpdateWorldState(WORLD_STATE_CENTRIFUGE_CONSTRUCT_AMOUNT, 10 - CentrifugeCount);
                    }
                    if( CentrifugeCount >= 10 )
                        if( Creature* varos = instance->GetCreature(uiVarosGUID) )
                        {
                            varos->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                            varos->InterruptNonMeleeSpells(false);
                            varos->RemoveAura(50053);
                        }
                    break;
                case DATA_AMBER_VOID:
                    bAmberVoid = !!data;
                    break;
                case DATA_EMERALD_VOID:
                    bEmeraldVoid = !!data;
                    break;
                case DATA_RUBY_VOID:
                    bRubyVoid = !!data;
                    break;
            }

            if( data == DONE )
                SaveToDB();
        }

        uint32 GetData(uint32 type) const override
        {
            switch( type )
            {
                case DATA_DRAKOS:
                case DATA_VAROS:
                case DATA_UROM:
                case DATA_EREGOS:
                    return m_auiEncounter[type];
                case DATA_CC_COUNT:
                    return CentrifugeCount;
            }

            return 0;
        }

        ObjectGuid GetGuidData(uint32 identifier) const override
        {
            switch( identifier )
            {
                case DATA_DRAKOS:
                    return uiDrakosGUID;
                case DATA_VAROS:
                    return uiVarosGUID;
                case DATA_UROM:
                    return uiUromGUID;
                case DATA_EREGOS:
                    return uiEregosGUID;
                case DATA_DCD_1:
                case DATA_DCD_2:
                case DATA_DCD_3:
                    return DragonCageDoorGUID[identifier - 100];
            }

            return ObjectGuid::Empty;
        }

        void ReadSaveDataMore(std::istringstream& data) override
        {
            data >> m_auiEncounter[0];
            data >> m_auiEncounter[1];
            data >> m_auiEncounter[2];
            data >> m_auiEncounter[3];
            data >> CentrifugeCount;
        }

        void WriteSaveDataMore(std::ostringstream& data) override
        {
            data << m_auiEncounter[0] << ' '
                << m_auiEncounter[1] << ' '
                << m_auiEncounter[2] << ' '
                << m_auiEncounter[3] << ' '
                << CentrifugeCount;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* source, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch(criteria_id)
            {
                case CRITERIA_EXPERIENCED_AMBER:
                    if( source )
                        if( Unit* drake = source->GetVehicleBase() )
                            if( drake->GetEntry() == NPC_AMBER_DRAKE )
                                return true;
                    break;
                case CRITERIA_EXPERIENCED_EMERALD:
                    if( source )
                        if( Unit* drake = source->GetVehicleBase() )
                            if( drake->GetEntry() == NPC_EMERALD_DRAKE )
                                return true;
                    break;
                case CRITERIA_EXPERIENCED_RUBY:
                    if( source )
                        if( Unit* drake = source->GetVehicleBase() )
                            if( drake->GetEntry() == NPC_RUBY_DRAKE )
                                return true;
                    break;
                case CRITERIA_AMBER_VOID:
                    return bAmberVoid;
                case CRITERIA_EMERALD_VOID:
                    return bEmeraldVoid;
                case CRITERIA_RUBY_VOID:
                    return bRubyVoid;
            }
            return false;
        }
    };
};

void AddSC_instance_oculus()
{
    new instance_oculus();
}

