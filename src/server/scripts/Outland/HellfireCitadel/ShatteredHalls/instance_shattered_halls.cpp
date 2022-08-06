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

#include "CreatureTextMgr.h"
#include "InstanceScript.h"
#include "ScriptObject.h"
#include "shattered_halls.h"

class instance_shattered_halls : public InstanceMapScript
{
public:
    instance_shattered_halls() : InstanceMapScript("instance_shattered_halls", 540) { }

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_shattered_halls_InstanceMapScript(map);
    }

    struct instance_shattered_halls_InstanceMapScript : public InstanceScript
    {
        instance_shattered_halls_InstanceMapScript(Map* map) : InstanceScript(map) { }

        void Initialize() override
        {
            SetBossNumber(ENCOUNTER_COUNT);

            TeamIdInInstance = TEAM_NEUTRAL;
            RescueTimer = 100 * MINUTE * IN_MILLISECONDS;
        }

        void OnPlayerEnter(Player* player) override
        {
            if (TeamIdInInstance == TEAM_NEUTRAL)
                TeamIdInInstance = player->GetTeamId();
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_GRAND_WARLOCK_CHAMBER_DOOR_1:
                    nethekurseDoor1GUID = go->GetGUID();
                    if (GetBossState(DATA_NETHEKURSE) == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
                case GO_GRAND_WARLOCK_CHAMBER_DOOR_2:
                    nethekurseDoor2GUID = go->GetGUID();
                    if (GetBossState(DATA_NETHEKURSE) == DONE)
                        HandleGameObject(ObjectGuid::Empty, true, go);
                    break;
            }
        }

        void OnCreatureCreate(Creature* creature) override
        {
            if (TeamIdInInstance == TEAM_NEUTRAL)
            {
                Map::PlayerList const& players = instance->GetPlayers();
                if (!players.IsEmpty())
                    if (Player* player = players.begin()->GetSource())
                        TeamIdInInstance = player->GetTeamId();
            }

            switch (creature->GetEntry())
            {
                case NPC_WARCHIEF_KARGATH:
                    warchiefKargathGUID = creature->GetGUID();
                    break;
                case NPC_SHATTERED_EXECUTIONER:
                    if (RescueTimer > 25 * MINUTE * IN_MILLISECONDS)
                        creature->AddLootMode(2);
                    executionerGUID = creature->GetGUID();
                    break;
                case NPC_RIFLEMAN_BROWNBEARD:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_KORAG_PROUDMANE);
                    prisonerGUID[0] = creature->GetGUID();
                    break;
                case NPC_CAPTAIN_ALINA:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_CAPTAIN_BONESHATTER);
                    prisonerGUID[1] = creature->GetGUID();
                    break;
                case NPC_PRIVATE_JACINT:
                    if (TeamIdInInstance == TEAM_HORDE)
                        creature->UpdateEntry(NPC_SCOUT_ORGARR);
                    prisonerGUID[2] = creature->GetGUID();
                    break;
            }
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            switch (type)
            {
                case DATA_NETHEKURSE:
                    if (state == IN_PROGRESS)
                    {
                        HandleGameObject(nethekurseDoor1GUID, false);
                        HandleGameObject(nethekurseDoor2GUID, false);
                    }
                    else
                    {
                        HandleGameObject(nethekurseDoor1GUID, true);
                        HandleGameObject(nethekurseDoor2GUID, true);
                    }
                    break;
            }
            return true;
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type == DATA_ENTERED_ROOM && data == DATA_ENTERED_ROOM && RescueTimer == 100 * MINUTE * IN_MILLISECONDS)
            {
                DoCastSpellOnPlayers(SPELL_KARGATHS_EXECUTIONER_1);
                instance->LoadGrid(230, -80);

                if (Creature* kargath = instance->GetCreature(warchiefKargathGUID))
                    sCreatureTextMgr->SendChat(kargath, TeamIdInInstance == TEAM_ALLIANCE ? 3 : 4, nullptr, CHAT_MSG_ADDON, LANG_ADDON, TEXT_RANGE_MAP);

                RescueTimer = 80 * MINUTE * IN_MILLISECONDS;
            }
        }

        ObjectGuid GetGuidData(uint32 data) const override
        {
            switch (data)
            {
                case DATA_PRISONER_1:
                case DATA_PRISONER_2:
                case DATA_PRISONER_3:
                    return prisonerGUID[data - DATA_PRISONER_1];
                case DATA_EXECUTIONER:
                    return executionerGUID;
            }

            return ObjectGuid::Empty;
        }

        void Update(uint32 diff) override
        {
            if (RescueTimer && RescueTimer < 100 * MINUTE * IN_MILLISECONDS)
            {
                RescueTimer -= std::min(RescueTimer, diff);

                if ((RescueTimer / IN_MILLISECONDS) == 25 * MINUTE)
                {
                    DoRemoveAurasDueToSpellOnPlayers(SPELL_KARGATHS_EXECUTIONER_1);
                    DoCastSpellOnPlayers(SPELL_KARGATHS_EXECUTIONER_2);
                    if (Creature* prisoner = instance->GetCreature(prisonerGUID[0]))
                        Unit::Kill(prisoner, prisoner);
                    if (Creature* executioner = instance->GetCreature(executionerGUID))
                        executioner->RemoveLootMode(2);
                }
                else if ((RescueTimer / IN_MILLISECONDS) == 15 * MINUTE)
                {
                    DoRemoveAurasDueToSpellOnPlayers(SPELL_KARGATHS_EXECUTIONER_2);
                    DoCastSpellOnPlayers(SPELL_KARGATHS_EXECUTIONER_3);
                    if (Creature* prisoner = instance->GetCreature(prisonerGUID[1]))
                        Unit::Kill(prisoner, prisoner);
                }
                else if ((RescueTimer / IN_MILLISECONDS) == 0)
                {
                    DoRemoveAurasDueToSpellOnPlayers(SPELL_KARGATHS_EXECUTIONER_3);
                    if (Creature* prisoner = instance->GetCreature(prisonerGUID[2]))
                        Unit::Kill(prisoner, prisoner);
                }
            }
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "S H " << GetBossSaveData() << ' ' << RescueTimer;

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(const char* strIn) override
        {
            if (!strIn)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(strIn);

            char dataHead1, dataHead2;

            std::istringstream loadStream(strIn);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'S' && dataHead2 == 'H')
            {
                for (uint8 i = 0; i < ENCOUNTER_COUNT; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                        tmpState = NOT_STARTED;
                    SetBossState(i, EncounterState(tmpState));
                }

                loadStream >> RescueTimer;
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

    protected:
        ObjectGuid warchiefKargathGUID;
        ObjectGuid nethekurseDoor1GUID;
        ObjectGuid nethekurseDoor2GUID;

        ObjectGuid executionerGUID;
        ObjectGuid prisonerGUID[3];
        uint32 RescueTimer;
        TeamId TeamIdInInstance;
    };
};

class spell_tsh_shoot_flame_arrow : public SpellScriptLoader
{
public:
    spell_tsh_shoot_flame_arrow() : SpellScriptLoader("spell_tsh_shoot_flame_arrow") { }

    class spell_tsh_shoot_flame_arrow_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_tsh_shoot_flame_arrow_SpellScript);

        void FilterTargets(std::list<WorldObject*>& unitList)
        {
            Acore::Containers::RandomResize(unitList, 1);
        }

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            if (Unit* target = GetHitUnit())
                target->CastSpell(target, 30953, true);
        }

        void Register() override
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_tsh_shoot_flame_arrow_SpellScript::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
            OnEffectHitTarget += SpellEffectFn(spell_tsh_shoot_flame_arrow_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_tsh_shoot_flame_arrow_SpellScript();
    }
};

class at_shattered_halls_execution : public AreaTriggerScript
{
public:
    at_shattered_halls_execution() : AreaTriggerScript("at_shattered_halls_execution") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*areaTrigger*/) override
    {
        if (InstanceScript* instanceScript = player->GetInstanceScript())
            instanceScript->SetData(DATA_ENTERED_ROOM, DATA_ENTERED_ROOM);

        return true;
    }
};

void AddSC_instance_shattered_halls()
{
    new instance_shattered_halls();
    new spell_tsh_shoot_flame_arrow();
    new at_shattered_halls_execution();
}
