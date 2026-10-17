/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "InstanceMapScript.h"
#include "ScriptedCreature.h"
#include "onyxias_lair.h"

ObjectData const creatureData[] =
{
    { NPC_ONYXIA, DATA_ONYXIA },
    { 0,          0           }
};

// Leash radius: 95 yards plus Onyxia's 18 yard combat reach
BossBoundaryData const boundaries =
{
    { DATA_ONYXIA, new CircleBoundary(Position(-10.6155f, -219.357f), 113.0) }
};

class instance_onyxias_lair : public InstanceMapScript
{
public:
    instance_onyxias_lair() : InstanceMapScript("instance_onyxias_lair", MAP_ONYXIAS_LAIR) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_onyxias_lair_InstanceMapScript(map);
    }

    struct instance_onyxias_lair_InstanceMapScript : public InstanceScript
    {
        instance_onyxias_lair_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTER);
            LoadObjectData(creatureData, nullptr);
            LoadBossBoundaries(boundaries);
            _manyWhelpsCounter = 0;
            _deepBreath = true;
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_WHELP_SPAWNER:
                    go->CastSpell(nullptr, SPELL_SUMMON_WHELP);
                    if (Creature* onyxia = GetCreature(DATA_ONYXIA))
                    {
                        onyxia->AI()->DoAction(ACTION_WHELP_SUMMONED);
                    }
                    break;
                default:
                    break;
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
            {
                return false;
            }

            if (type == DATA_ONYXIA && state == NOT_STARTED)
            {
                _manyWhelpsCounter = 0;
                _deepBreath = true;
            }

            return true;
        }

        void SetData(uint32 type, uint32 /*data*/) override
        {
            switch (type)
            {
                case DATA_WHELP_SUMMONED:
                    ++_manyWhelpsCounter;
                    break;
                case DATA_DEEP_BREATH_FAILED:
                    _deepBreath = false;
                    break;
                default:
                    break;
            }
        }

        bool CheckAchievementCriteriaMeet(uint32 criteriaId, Player const* /*source*/, Unit const* /*target*/, uint32 /*miscvalue1*/) override
        {
            switch (criteriaId)
            {
                case ACHIEV_CRITERIA_MANY_WHELPS_10_PLAYER:
                case ACHIEV_CRITERIA_MANY_WHELPS_25_PLAYER:
                    return _manyWhelpsCounter >= 50;
                case ACHIEV_CRITERIA_DEEP_BREATH_10_PLAYER:
                case ACHIEV_CRITERIA_DEEP_BREATH_25_PLAYER:
                    return _deepBreath;
                default:
                    return false;
            }
        }

    private:
        uint16 _manyWhelpsCounter;
        bool _deepBreath;
    };
};

void AddSC_instance_onyxias_lair()
{
    new instance_onyxias_lair();
}
