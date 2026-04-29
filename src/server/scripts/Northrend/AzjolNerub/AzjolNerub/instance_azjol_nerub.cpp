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

#include "AreaBoundary.h"
#include "CreatureGroups.h"
#include "CreatureScript.h"
#include "InstanceMapScript.h"
#include "ScriptedCreature.h"
#include "SpellScriptLoader.h"
#include "azjol_nerub.h"
#include "SpellScript.h"

DoorData const doorData[] =
{
    { GO_KRIKTHIR_DOORS,    DATA_KRIKTHIR,   DOOR_TYPE_PASSAGE },
    { GO_ANUBARAK_DOORS1,   DATA_ANUBARAK,   DOOR_TYPE_ROOM },
    { GO_ANUBARAK_DOORS2,   DATA_ANUBARAK,   DOOR_TYPE_ROOM },
    { GO_ANUBARAK_DOORS3,   DATA_ANUBARAK,   DOOR_TYPE_ROOM },
    { 0,                    0,               DOOR_TYPE_ROOM }
};

ObjectData const creatureData[] =
{
    { NPC_KRIKTHIR_THE_GATEWATCHER, DATA_KRIKTHIR },
    { NPC_HADRONOX,                 DATA_HADRONOX },
    { NPC_ANUBARAK,                 DATA_ANUBARAK },
    { NPC_WATCHER_GASHRA,           DATA_GASHRA   },
    { NPC_WATCHER_NARJIL,           DATA_NARJIL   },
    { NPC_WATCHER_SILTHIK,          DATA_SILTHIK  },
    { 0,                            0             }
};

ObjectData const summonData[] =
{
    { NPC_SKITTERING_SWARMER,    DATA_KRIKTHIR  },
    { NPC_SKITTERING_INFECTIOR,  DATA_KRIKTHIR  },
    { NPC_ANUB_AR_CHAMPION,      DATA_HADRONOX  },
    { NPC_ANUB_AR_NECROMANCER,   DATA_HADRONOX  },
    { NPC_ANUB_AR_CRYPTFIEND,    DATA_HADRONOX  },
    { NPC_WORLD_TRIGGER_LAOI,    DATA_HADRONOX  },
    { 0, 0 }
};

BossBoundaryData const boundaries =
{
    { DATA_KRIKTHIR, new RectangleBoundary(400.0f, 580.0f, 623.5f, 810.0f) },
    { DATA_HADRONOX, new ZRangeBoundary(666.0f, 776.0f) },
    { DATA_ANUBARAK, new CircleBoundary(Position(550.6178f, 253.5917f), 32.0f) }
};

class instance_azjol_nerub : public InstanceMapScript
{
public:
    instance_azjol_nerub() : InstanceMapScript("instance_azjol_nerub", MAP_AZJOL_NERUB) { }

    struct instance_azjol_nerub_InstanceScript : public InstanceScript
    {
        instance_azjol_nerub_InstanceScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTERS);
            LoadBossBoundaries(boundaries);
            LoadDoorData(doorData);
            LoadObjectData(creatureData, nullptr);
            LoadSummonData(summonData);
        };

        void OnCreatureEvade(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_WATCHER_NARJIL:
                case NPC_WATCHER_GASHRA:
                case NPC_WATCHER_SILTHIK:
                    if (Creature* krikthir = GetCreature(DATA_KRIKTHIR))
                        krikthir->AI()->EnterEvadeMode();
                    break;
                case NPC_ANUBAR_SHADOWCASTER:
                case NPC_ANUBAR_SKIRMISHER:
                case NPC_ANUBAR_WARRIOR:
                    if (CreatureGroup* formation = creature->GetFormation())
                        if (Creature* leader = formation->GetLeader())
                            if (leader->EntryEquals(NPC_WATCHER_GASHRA, NPC_WATCHER_NARJIL, NPC_WATCHER_SILTHIK))
                                if (Creature* krikthir = GetCreature(DATA_KRIKTHIR))
                                    krikthir->AI()->EnterEvadeMode();
                    break;
                case NPC_KRIKTHIR_THE_GATEWATCHER:
                    if (Creature* narjil = GetCreature(DATA_NARJIL))
                        if (CreatureGroup* formation = narjil->GetFormation())
                            formation->DespawnFormation(0s, 20s);

                    if (Creature* gashra = GetCreature(DATA_GASHRA))
                        if (CreatureGroup* formation = gashra->GetFormation())
                            formation->DespawnFormation(0s, 20s);

                    if (Creature* silthik = GetCreature(DATA_SILTHIK))
                        if (CreatureGroup* formation = silthik->GetFormation())
                            formation->DespawnFormation(0s, 20s);
                    break;
                default:
                    break;
            }
        }

        void OnUnitDeath(Unit* unit) override
        {
            if (!unit->EntryEquals(NPC_WATCHER_GASHRA, NPC_WATCHER_NARJIL, NPC_WATCHER_SILTHIK, NPC_ANUBAR_SHADOWCASTER, NPC_ANUBAR_SKIRMISHER, NPC_ANUBAR_WARRIOR))
                return;

            Creature* creature = unit->ToCreature();
            if (!creature)
                return;

            // For trash mobs, ensure their leader is a Watcher
            if (unit->EntryEquals(NPC_ANUBAR_SHADOWCASTER, NPC_ANUBAR_SKIRMISHER, NPC_ANUBAR_WARRIOR))
            {
                CreatureGroup* formation = creature->GetFormation();
                if (!formation)
                    return;

                Creature* leader = formation->GetLeader();
                if (!leader || !leader->EntryEquals(NPC_WATCHER_GASHRA, NPC_WATCHER_NARJIL, NPC_WATCHER_SILTHIK))
                    return;
            }

            ObjectGuid creatureGuid = creature->GetGUID();

            scheduler.CancelAll();
            scheduler.Schedule(1s, [this, creatureGuid](TaskContext /*context*/)
            {
                Creature* creature = instance->GetCreature(creatureGuid);
                if (!creature)
                    return;

                CreatureGroup* formation = creature->GetFormation();
                if (!formation || formation->IsAnyMemberAlive())
                    return;

                if (Creature* krikthir = GetCreature(DATA_KRIKTHIR))
                    krikthir->AI()->DoAction(ACTION_MINION_DIED);
            });
        }
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_azjol_nerub_InstanceScript(map);
    }
};

class spell_azjol_nerub_fixate : public SpellScript
{
    PrepareSpellScript(spell_azjol_nerub_fixate);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->CastSpell(GetCaster(), GetEffectValue(), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_azjol_nerub_fixate::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_azjol_nerub_web_wrap_aura : public AuraScript
{
    PrepareAuraScript(spell_azjol_nerub_web_wrap_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WEB_WRAP_TRIGGER });
    }

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        Unit* target = GetTarget();
        if (!target->HasAura(SPELL_WEB_WRAP_TRIGGER))
            target->CastSpell(target, SPELL_WEB_WRAP_TRIGGER, true);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_azjol_nerub_web_wrap_aura::OnRemove, EFFECT_0, SPELL_AURA_MOD_ROOT, AURA_EFFECT_HANDLE_REAL);
    }
};

enum DrainPowerSpells
{
    SPELL_DRAIN_POWER_AURA = 54315
};

// 54314, 59354 - Drain Power
class spell_azjol_drain_power : public SpellScript
{
    PrepareSpellScript(spell_azjol_drain_power);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DRAIN_POWER_AURA });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetCaster(), SPELL_DRAIN_POWER_AURA, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_azjol_drain_power::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
    }
};

void AddSC_instance_azjol_nerub()
{
    new instance_azjol_nerub();
    RegisterSpellScript(spell_azjol_nerub_fixate);
    RegisterSpellScript(spell_azjol_nerub_web_wrap_aura);
    RegisterSpellScript(spell_azjol_drain_power);
}
