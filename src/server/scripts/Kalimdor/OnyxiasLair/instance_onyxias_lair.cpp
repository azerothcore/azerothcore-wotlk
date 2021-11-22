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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "onyxias_lair.h"

class instance_onyxias_lair : public InstanceMapScript
{
public:
    instance_onyxias_lair() : InstanceMapScript("instance_onyxias_lair", 249) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const override
    {
        return new instance_onyxias_lair_InstanceMapScript(pMap);
    }

    struct instance_onyxias_lair_InstanceMapScript : public InstanceScript
    {
        instance_onyxias_lair_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {Initialize();};

        ObjectGuid m_uiOnyxiasGUID;
        uint32 m_auiEncounter[MAX_ENCOUNTER];
        std::string str_data;
        uint16 ManyWhelpsCounter;
        GuidVector minions;
        bool bDeepBreath;

        void Initialize() override
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));
            ManyWhelpsCounter = 0;
            bDeepBreath = true;
        }

        bool IsEncounterInProgress() const override
        {
            for( uint8 i = 0; i < MAX_ENCOUNTER; ++i )
                if( m_auiEncounter[i] == IN_PROGRESS )
                    return true;

            return false;
        }

        void OnCreatureCreate(Creature* pCreature) override
        {
            switch( pCreature->GetEntry() )
            {
                case NPC_ONYXIA:
                    m_uiOnyxiasGUID = pCreature->GetGUID();
                    break;
                case NPC_ONYXIAN_WHELP:
                case NPC_ONYXIAN_LAIR_GUARD:
                    minions.push_back(pCreature->GetGUID());
                    break;
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch( go->GetEntry() )
            {
                case GO_WHELP_SPAWNER:
                    go->CastSpell((Unit*)nullptr, 17646);
                    if( Creature* onyxia = instance->GetCreature(m_uiOnyxiasGUID) )
                        onyxia->AI()->DoAction(-1);
                    break;
            }
        }

        void SetData(uint32 uiType, uint32 uiData) override
        {
            switch(uiType)
            {
                case DATA_ONYXIA:
                    m_auiEncounter[0] = uiData;
                    ManyWhelpsCounter = 0;
                    bDeepBreath = true;
                    if( uiData == NOT_STARTED )
                    {
                        for (ObjectGuid const& guid : minions)
                            if (Creature* c = instance->GetCreature(guid))
                                c->DespawnOrUnsummon();
                        minions.clear();
                    }
                    break;
                case DATA_WHELP_SUMMONED:
                    ++ManyWhelpsCounter;
                    break;
                case DATA_DEEP_BREATH_FAILED:
                    bDeepBreath = false;
                    break;
            }

            if (uiType < MAX_ENCOUNTER && uiData == DONE)
                SaveToDB();
        }

        uint32 GetData(uint32 uiType) const override
        {
            switch(uiType)
            {
                case DATA_ONYXIA:
                    return m_auiEncounter[0];
            }

            return 0;
        }

        ObjectGuid GetGuidData(uint32 uiData) const override
        {
            switch (uiData)
            {
                case DATA_ONYXIA:
                    return m_uiOnyxiasGUID;
            }

            return ObjectGuid::Empty;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;
            std::ostringstream saveStream;
            saveStream << "O L " << m_auiEncounter[0];
            str_data = saveStream.str();
            OUT_SAVE_INST_DATA_COMPLETE;
            return str_data;
        }

        void Load(const char* in) override
        {
            if( !in )
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            uint16 data0;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> data0;

            if( dataHead1 == 'O' && dataHead2 == 'L' )
            {
                m_auiEncounter[0] = data0;

                for( uint8 i = 0; i < MAX_ENCOUNTER; ++i )
                    if( m_auiEncounter[i] == IN_PROGRESS )
                        m_auiEncounter[i] = NOT_STARTED;
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

        bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const*  /*source*/, Unit const*  /*target*/, uint32  /*miscvalue1*/) override
        {
            switch(criteria_id)
            {
                case ACHIEV_CRITERIA_MANY_WHELPS_10_PLAYER:
                case ACHIEV_CRITERIA_MANY_WHELPS_25_PLAYER:
                    return ManyWhelpsCounter >= 50;
                case ACHIEV_CRITERIA_DEEP_BREATH_10_PLAYER:
                case ACHIEV_CRITERIA_DEEP_BREATH_25_PLAYER:
                    return bDeepBreath;
            }
            return false;
        }
    };
};

void AddSC_instance_onyxias_lair()
{
    new instance_onyxias_lair();
}
