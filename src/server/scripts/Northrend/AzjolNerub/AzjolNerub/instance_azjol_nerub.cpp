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

#include "AreaBoundary.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "azjol_nerub.h"

DoorData const doorData[] =
{
    { GO_KRIKTHIR_DOORS,    DATA_KRIKTHIR_THE_GATEWATCHER_EVENT,    DOOR_TYPE_PASSAGE },
    { GO_ANUBARAK_DOORS1,   DATA_ANUBARAK_EVENT,    DOOR_TYPE_ROOM },
    { GO_ANUBARAK_DOORS2,   DATA_ANUBARAK_EVENT,    DOOR_TYPE_ROOM },
    { GO_ANUBARAK_DOORS3,   DATA_ANUBARAK_EVENT,    DOOR_TYPE_ROOM },
    { 0,                    0,                      DOOR_TYPE_ROOM }
};

ObjectData const creatureData[] =
{
    { NPC_KRIKTHIR_THE_GATEWATCHER, DATA_KRIKTHIR_THE_GATEWATCHER_EVENT },
    { NPC_HADRONOX,                 DATA_HADRONOX_EVENT                 }
};

BossBoundaryData const boundaries =
{
    { DATA_KRIKTHIR_THE_GATEWATCHER_EVENT, new RectangleBoundary(400.0f, 580.0f, 623.5f, 810.0f) },
    { DATA_HADRONOX_EVENT, new ZRangeBoundary(666.0f, 776.0f) },
    { DATA_ANUBARAK_EVENT, new CircleBoundary(Position(550.6178f, 253.5917f), 26.0f) }
};

class instance_azjol_nerub : public InstanceMapScript
{
public:
    instance_azjol_nerub() : InstanceMapScript("instance_azjol_nerub", 601) { }

    struct instance_azjol_nerub_InstanceScript : public InstanceScript
    {
        instance_azjol_nerub_InstanceScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(MAX_ENCOUNTERS);
            LoadBossBoundaries(boundaries);
            LoadDoorData(doorData);
            LoadObjectData(creatureData, nullptr);
        };

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_SKITTERING_SWARMER:
                case NPC_SKITTERING_INFECTIOR:
                    if (Creature* krikthir = GetCreature((DATA_KRIKTHIR_THE_GATEWATCHER_EVENT)))
                        krikthir->AI()->JustSummoned(creature);
                    break;
                case NPC_ANUB_AR_CHAMPION:
                case NPC_ANUB_AR_NECROMANCER:
                case NPC_ANUB_AR_CRYPTFIEND:
                    if (Creature* hadronox = GetCreature(DATA_HADRONOX_EVENT))
                        hadronox->AI()->JustSummoned(creature);
                    break;
            }

            InstanceScript::OnCreatureCreate(creature);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_KRIKTHIR_DOORS:
                case GO_ANUBARAK_DOORS1:
                case GO_ANUBARAK_DOORS2:
                case GO_ANUBARAK_DOORS3:
                    AddDoor(go, true);
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_KRIKTHIR_DOORS:
                case GO_ANUBARAK_DOORS1:
                case GO_ANUBARAK_DOORS2:
                case GO_ANUBARAK_DOORS3:
                    AddDoor(go, false);
                    break;
            }
        }

        bool SetBossState(uint32 id, EncounterState state) override
        {
            return InstanceScript::SetBossState(id, state);
        }

        std::string GetSaveData() override
        {
            std::ostringstream saveStream;
            saveStream << "A N " << GetBossSaveData();
            return saveStream.str();
        }

        void Load(const char* in) override
        {
            if( !in )
                return;

            char dataHead1, dataHead2;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2;
            if (dataHead1 == 'A' && dataHead2 == 'N')
            {
                for (uint8 i = 0; i < MAX_ENCOUNTERS; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                        tmpState = NOT_STARTED;
                    SetBossState(i, EncounterState(tmpState));
                }
            }
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_azjol_nerub_InstanceScript(map);
    }
};

class spell_azjol_nerub_fixate : public SpellScriptLoader
{
public:
    spell_azjol_nerub_fixate() : SpellScriptLoader("spell_azjol_nerub_fixate") { }

    class spell_azjol_nerub_fixate_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_azjol_nerub_fixate_SpellScript);

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            if (Unit* target = GetHitUnit())
                target->CastSpell(GetCaster(), GetEffectValue(), true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_azjol_nerub_fixate_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_azjol_nerub_fixate_SpellScript();
    }
};

class spell_azjol_nerub_web_wrap : public SpellScriptLoader
{
public:
    spell_azjol_nerub_web_wrap() : SpellScriptLoader("spell_azjol_nerub_web_wrap") { }

    class spell_azjol_nerub_web_wrap_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_azjol_nerub_web_wrap_AuraScript);

        void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            Unit* target = GetTarget();
            if (!target->HasAura(SPELL_WEB_WRAP_TRIGGER))
                target->CastSpell(target, SPELL_WEB_WRAP_TRIGGER, true);
        }

        void Register() override
        {
            OnEffectRemove += AuraEffectRemoveFn(spell_azjol_nerub_web_wrap_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_MOD_ROOT, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_azjol_nerub_web_wrap_AuraScript();
    }
};

void AddSC_instance_azjol_nerub()
{
    new instance_azjol_nerub();
    new spell_azjol_nerub_fixate();
    new spell_azjol_nerub_web_wrap();
}
