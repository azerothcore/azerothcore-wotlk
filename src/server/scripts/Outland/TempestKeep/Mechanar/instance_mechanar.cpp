/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "InstanceScript.h"
#include "ScriptMgr.h"
#include "mechanar.h"

static DoorData const doorData[] =
{
    { GO_DOOR_MOARG_1,          DATA_GATEWATCHER_IRON_HAND,     DOOR_TYPE_PASSAGE },
    { GO_DOOR_MOARG_2,          DATA_GATEWATCHER_GYROKILL,      DOOR_TYPE_PASSAGE },
    { GO_DOOR_NETHERMANCER,     DATA_NETHERMANCER_SEPRETHREA,   DOOR_TYPE_ROOM },
    { 0,                        0,                              DOOR_TYPE_ROOM }
};

class instance_mechanar : public InstanceMapScript
{
public:
    instance_mechanar(): InstanceMapScript("instance_mechanar", 554) { }

    struct instance_mechanar_InstanceMapScript : public InstanceScript
    {
        instance_mechanar_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(MAX_ENCOUNTER);
            LoadDoorData(doorData);

            _passageEncounter = 0;
            _passageTimer = 0;
            _passageGUIDs.clear();
        }

        void OnGameObjectCreate(GameObject* gameObject) override
        {
            switch (gameObject->GetEntry())
            {
                case GO_DOOR_MOARG_1:
                case GO_DOOR_MOARG_2:
                case GO_DOOR_NETHERMANCER:
                    AddDoor(gameObject, true);
                    break;
                default:
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* gameObject) override
        {
            switch (gameObject->GetEntry())
            {
                case GO_DOOR_MOARG_1:
                case GO_DOOR_MOARG_2:
                case GO_DOOR_NETHERMANCER:
                    AddDoor(gameObject, false);
                    break;
                default:
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            if (creature->GetEntry() == NPC_PATHALEON_THE_CALCULATOR)
                _pathaleonGUID = creature->GetGUID();
        }

        void OnUnitDeath(Unit* unit) override
        {
            if (unit->GetTypeId() == TYPEID_UNIT)
                if (_passageEncounter > ENCOUNTER_PASSAGE_NOT_STARTED && _passageEncounter < ENCOUNTER_PASSAGE_DONE)
                    if (_passageGUIDs.find(unit->GetGUID()) != _passageGUIDs.end())
                        _passageGUIDs.erase(unit->GetGUID());
        }

        Player* GetPassagePlayer(float x)
        {
            Map::PlayerList const& pl = instance->GetPlayers();
            for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                if (Player* player = itr->GetSource())
                    if (player->GetPositionX() < x && player->GetPositionZ() > 24.0f && player->GetPositionY() > -30.0f)
                        return player;
            return nullptr;
        }

        void DoSummonAction(Creature* summon, Player* player)
        {
            summon->CastSpell(summon, SPELL_TELEPORT_VISUAL, true);
            summon->AI()->AttackStart(player);
            _passageGUIDs.insert(summon->GetGUID());
        }

        void Update(uint32 diff) override
        {
            if (_passageEncounter == ENCOUNTER_PASSAGE_DONE)
                return;

            _passageTimer += diff;
            if (_passageTimer >= 1000)
            {
                _passageTimer = 0;
                if (_passageEncounter == ENCOUNTER_PASSAGE_NOT_STARTED)
                {
                    if (Player* player = GetPassagePlayer(250.0f))
                    {
                        _passageEncounter++;
                        for (uint8 i = 0; i < 4; ++i)
                        {
                            Position pos = {238.0f, -27.0f + 3.0f * i, 26.328f, 0.0f};
                            if (Creature* creature = instance->SummonCreature(i == 1 || i == 2 ? NPC_SUNSEEKER_ASTROMAGE : NPC_BLOODWARDER_CENTURION, pos))
                                DoSummonAction(creature, player);
                        }
                    }
                }

                if (!_passageGUIDs.empty())
                    return;

                if (_passageEncounter < ENCOUNTER_PASSAGE_PHASE3)
                {
                    if (Player* player = GetPassagePlayer(250.0f))
                    {
                        if (_passageEncounter == ENCOUNTER_PASSAGE_PHASE1)
                        {
                            Position pos = {214.37f, -23.5f, 24.88f, 0.0f};
                            if (Creature* creature = instance->SummonCreature(NPC_TEMPEST_KEEPER_DESTROYER, pos))
                                DoSummonAction(creature, player);
                        }
                        else if (_passageEncounter == ENCOUNTER_PASSAGE_PHASE2)
                        {
                            for (uint8 i = 0; i < 3; ++i)
                            {
                                Position pos = {199.76f, -26.0f + 2.5f * i, 24.88f, 0.0f};
                                if (Creature* creature = instance->SummonCreature(i == 1 ? NPC_SUNSEEKER_ENGINEER : NPC_BLOODWARDER_PHYSICIAN, pos))
                                    DoSummonAction(creature, player);
                            }
                        }
                        _passageEncounter++;
                        SaveToDB();
                    }
                }
                else
                {
                    if (Player* player = GetPassagePlayer(148.0f))
                    {
                        if (_passageEncounter == ENCOUNTER_PASSAGE_PHASE3)
                        {
                            for (uint8 i = 0; i < 3; ++i)
                            {
                                Position pos = {135.0f + 2.5f * i, 36.76f, 24.88f, M_PI * 1.5f};
                                if (Creature* creature = instance->SummonCreature(i == 1 ? NPC_SUNSEEKER_ASTROMAGE : NPC_BLOODWARDER_PHYSICIAN, pos))
                                    DoSummonAction(creature, player);
                            }
                        }
                        else if (_passageEncounter == ENCOUNTER_PASSAGE_PHASE4)
                        {
                            Position pos = {137.62f, 62.23f, 24.88f, M_PI * 1.5f};
                            if (Creature* creature = instance->SummonCreature(NPC_TEMPEST_KEEPER_DESTROYER, pos))
                                DoSummonAction(creature, player);
                        }
                        else if (_passageEncounter == ENCOUNTER_PASSAGE_PHASE5)
                        {
                            for (uint8 i = 0; i < 4; ++i)
                            {
                                Position pos = {133.0f + 3.5f * i, 92.88f, 26.38f, M_PI * 1.5f};
                                if (Creature* creature = instance->SummonCreature(i == 1 || i == 2 ? NPC_SUNSEEKER_ASTROMAGE : NPC_SUNSEEKER_ENGINEER, pos))
                                    DoSummonAction(creature, player);
                            }
                        }
                        else if (_passageEncounter == ENCOUNTER_PASSAGE_PHASE6)
                        {
                            if (Creature* creature = instance->GetCreature(_pathaleonGUID))
                                creature->AI()->DoAction(1);
                        }
                        _passageEncounter++;
                        SaveToDB();
                    }
                }
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            return true;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            // Xinef: no space needed
            saveStream << "M E " << GetBossSaveData() << _passageEncounter;

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* str) override
        {
            if (!str)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(str);

            char dataHead1, dataHead2;

            std::istringstream loadStream(str);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'M' && dataHead2 == 'E')
            {
                for (uint32 i = 0; i < MAX_ENCOUNTER; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                        tmpState = NOT_STARTED;
                    SetBossState(i, EncounterState(tmpState));
                }

                loadStream >> _passageEncounter;
                if (_passageEncounter == ENCOUNTER_PASSAGE_DONE)
                    _passageEncounter = ENCOUNTER_PASSAGE_PHASE6;
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

    private:
        ObjectGuid _pathaleonGUID;
        uint32 _passageTimer;
        uint32 _passageEncounter;
        GuidSet _passageGUIDs;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_mechanar_InstanceMapScript(map);
    }
};

void AddSC_instance_mechanar()
{
    new instance_mechanar();
}
