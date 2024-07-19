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

#include "CreatureScript.h"
#include "InstanceMapScript.h"
#include "InstanceScript.h"
#include "SpellScriptLoader.h"
#include "black_temple.h"

DoorData const doorData[] =
{
    { GO_NAJENTUS_GATE,         DATA_HIGH_WARLORD_NAJENTUS, DOOR_TYPE_PASSAGE  },
    { GO_NAJENTUS_GATE,         DATA_SUPREMUS,              DOOR_TYPE_ROOM     },
    { GO_SUPREMUS_GATE,         DATA_SUPREMUS,              DOOR_TYPE_PASSAGE  },
    { GO_SHADE_OF_AKAMA_DOOR,   DATA_SHADE_OF_AKAMA,        DOOR_TYPE_ROOM     },
    { GO_TERON_DOOR_1,          DATA_TERON_GOREFIEND,       DOOR_TYPE_ROOM     },
    { GO_TERON_DOOR_2,          DATA_TERON_GOREFIEND,       DOOR_TYPE_ROOM     },
    { GO_GURTOGG_DOOR,          DATA_GURTOGG_BLOODBOIL,     DOOR_TYPE_PASSAGE  },
    { GO_TEMPLE_DOOR,           DATA_GURTOGG_BLOODBOIL,     DOOR_TYPE_PASSAGE  },
    { GO_TEMPLE_DOOR,           DATA_TERON_GOREFIEND,       DOOR_TYPE_PASSAGE  },
    { GO_TEMPLE_DOOR,           DATA_RELIQUARY_OF_SOULS,    DOOR_TYPE_PASSAGE  },
    { GO_MOTHER_SHAHRAZ_DOOR,   DATA_MOTHER_SHAHRAZ,        DOOR_TYPE_PASSAGE  },
    { GO_COUNCIL_DOOR_1,        DATA_ILLIDARI_COUNCIL,      DOOR_TYPE_ROOM     },
    { GO_COUNCIL_DOOR_2,        DATA_ILLIDARI_COUNCIL,      DOOR_TYPE_ROOM     },
    { GO_ILLIDAN_GATE,          DATA_AKAMA_ILLIDAN,         DOOR_TYPE_PASSAGE  },
    { GO_ILLIDAN_DOOR_L,        DATA_ILLIDAN_STORMRAGE,     DOOR_TYPE_ROOM     },
    { GO_ILLIDAN_DOOR_R,        DATA_ILLIDAN_STORMRAGE,     DOOR_TYPE_ROOM     },
    { 0,                        0,                          DOOR_TYPE_ROOM     }
};

ObjectData const creatureData[] =
{
    { NPC_HIGH_WARLORD_NAJENTUS,     DATA_HIGH_WARLORD_NAJENTUS     },
    { NPC_SUPREMUS,                  DATA_SUPREMUS                  },
    { NPC_SHADE_OF_AKAMA,            DATA_SHADE_OF_AKAMA            },
    { NPC_AKAMA_SHADE,               DATA_AKAMA_SHADE               },
    { NPC_TERON_GOREFIEND,           DATA_TERON_GOREFIEND           },
    { NPC_GURTOGG_BLOODBOIL,         DATA_GURTOGG_BLOODBOIL         },
    { NPC_RELIQUARY_OF_THE_LOST,     DATA_RELIQUARY_OF_SOULS        },
    { NPC_MOTHER_SHAHRAZ,            DATA_MOTHER_SHAHRAZ            },
    { NPC_ILLIDARI_COUNCIL,          DATA_ILLIDARI_COUNCIL          },
    { NPC_GATHIOS_THE_SHATTERER,     DATA_GATHIOS_THE_SHATTERER     },
    { NPC_HIGH_NETHERMANCER_ZEREVOR, DATA_HIGH_NETHERMANCER_ZEREVOR },
    { NPC_LADY_MALANDE,              DATA_LADY_MALANDE              },
    { NPC_VERAS_DARKSHADOW,          DATA_VERAS_DARKSHADOW          },
    { NPC_AKAMA_ILLIDAN,             DATA_AKAMA_ILLIDAN             },
    { NPC_ILLIDAN_STORMRAGE,         DATA_ILLIDAN_STORMRAGE         },
    { 0,                             0                              }
};

ObjectData const objectData[] =
{
    { 0, 0 }
};

BossBoundaryData const boundaries =
{
    { DATA_HIGH_WARLORD_NAJENTUS, new RectangleBoundary(394.0f, 479.4f, 707.8f, 859.1f)      },
    { DATA_SUPREMUS,              new RectangleBoundary(556.1f, 850.2f, 542.0f, 1001.0f)     },
    { DATA_SHADE_OF_AKAMA,        new RectangleBoundary(406.8f, 564.0f, 327.9f, 473.5f)      },
    { DATA_TERON_GOREFIEND,       new RectangleBoundary(512.5f, 613.3f, 373.2f, 432.0f)      },
    { DATA_TERON_GOREFIEND,       new ZRangeBoundary(179.5f, 223.6f)                         },
    { DATA_GURTOGG_BLOODBOIL,     new RectangleBoundary(720.5f, 864.5f, 159.3f, 316.0f)      },
    { DATA_RELIQUARY_OF_SOULS,    new RectangleBoundary(435.9f, 660.3f, 21.2f, 229.6f)       },
    { DATA_RELIQUARY_OF_SOULS,    new ZRangeBoundary(81.8f, 148.0f)                          },
    { DATA_MOTHER_SHAHRAZ,        new RectangleBoundary(903.4f, 982.1f, 92.4f, 313.2f)       },
    { DATA_ILLIDARI_COUNCIL,      new EllipseBoundary(Position(696.6f, 305.0f), 70.0 , 85.0) },
    { DATA_ILLIDAN_STORMRAGE,     new EllipseBoundary(Position(694.8f, 309.0f), 80.0 , 95.0) }
};

class instance_black_temple : public InstanceMapScript
{
public:
    instance_black_temple() : InstanceMapScript("instance_black_temple", 564) { }

    struct instance_black_temple_InstanceMapScript : public InstanceScript
    {
        instance_black_temple_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetHeaders(DataHeader);
            SetBossNumber(MAX_ENCOUNTERS);
            LoadDoorData(doorData);
            LoadBossBoundaries(boundaries);
            LoadObjectData(creatureData, objectData);

            ashtongueGUIDs.clear();
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_SHADOWY_CONSTRUCT:
                    if (Creature* teron = GetCreature(DATA_TERON_GOREFIEND))
                        teron->AI()->JustSummoned(creature);
                    break;
                case NPC_ENSLAVED_SOUL:
                    if (Creature* reliquary = GetCreature(DATA_RELIQUARY_OF_SOULS))
                        reliquary->AI()->JustSummoned(creature);
                    break;
                case NPC_PARASITIC_SHADOWFIEND:
                case NPC_BLADE_OF_AZZINOTH:
                case NPC_FLAME_OF_AZZINOTH:
                    if (Creature* illidan = GetCreature(DATA_ILLIDAN_STORMRAGE))
                        illidan->AI()->JustSummoned(creature);
                    break;
                case NPC_ANGERED_SOUL_FRAGMENT:
                case NPC_HUNGERING_SOUL_FRAGMENT:
                case NPC_SUFFERING_SOUL_FRAGMENT:
                    creature->SetCorpseDelay(5);
                    break;
                case NPC_ASHTONGUE_BATTLELORD:
                case NPC_ASHTONGUE_MYSTIC:
                case NPC_ASHTONGUE_STORMCALLER:
                case NPC_ASHTONGUE_PRIMALIST:
                case NPC_ASHTONGUE_FERAL_SPIRIT:
                case NPC_ASHTONGUE_STALKER:
                case NPC_STORM_FURY:
                    if (GetBossState(DATA_SHADE_OF_AKAMA) == DONE)
                        creature->SetFaction(FACTION_ASHTONGUE_DEATHSWORN);
                    else
                        ashtongueGUIDs.insert(creature->GetGUID());
                    break;
                default:
                    break;
            }

            InstanceScript::OnCreatureCreate(creature);
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            // If created after Illidari Council is done, then skip Akama's event. Used for crashes/reset
            if (go->GetEntry() == GO_ILLIDAN_GATE)
            {
                if (GetBossState(DATA_ILLIDARI_COUNCIL) == DONE)
                {
                    SetBossState(DATA_AKAMA_ILLIDAN, DONE);
                    HandleGameObject(ObjectGuid::Empty, true, go);
                }
            }

            InstanceScript::OnGameObjectCreate(go);
        }

        bool SetBossState(uint32 type, EncounterState state) override
        {
            if (!InstanceScript::SetBossState(type, state))
                return false;

            if (type == DATA_SHADE_OF_AKAMA && state == DONE)
            {
                for (ObjectGuid const& guid : ashtongueGUIDs)
                    if (Creature* ashtongue = instance->GetCreature(guid))
                        ashtongue->SetFaction(FACTION_ASHTONGUE_DEATHSWORN);
            }
            else if (type == DATA_ILLIDARI_COUNCIL && state == DONE)
            {
                if (Creature* akama = GetCreature(DATA_AKAMA_ILLIDAN))
                    akama->AI()->DoAction(0);
            }

            return true;
        }

    protected:
        GuidSet ashtongueGUIDs;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_black_temple_InstanceMapScript(map);
    }
};

class spell_black_template_harpooners_mark_aura : public AuraScript
{
    PrepareAuraScript(spell_black_template_harpooners_mark_aura);

    bool Load() override
    {
        _turtleSet.clear();
        return true;
    }

    void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        std::list<Creature*> creatureList;
        GetUnitOwner()->GetCreaturesWithEntryInRange(creatureList, 80.0f, NPC_DRAGON_TURTLE);
        for (std::list<Creature*>::const_iterator itr = creatureList.begin(); itr != creatureList.end(); ++itr)
        {
            (*itr)->TauntApply(GetUnitOwner());
            (*itr)->AddThreat(GetUnitOwner(), 10000000.0f);
            _turtleSet.insert((*itr)->GetGUID());
        }
    }

    void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        for (ObjectGuid const& guid : _turtleSet)
            if (Creature* turtle = ObjectAccessor::GetCreature(*GetUnitOwner(), guid))
            {
                turtle->TauntFadeOut(GetUnitOwner());
                turtle->AddThreat(GetUnitOwner(), -10000000.0f);
            }
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_black_template_harpooners_mark_aura::HandleEffectApply, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_black_template_harpooners_mark_aura::HandleEffectRemove, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }

private:
    GuidSet _turtleSet;
};

class spell_black_template_free_friend : public SpellScript
{
    PrepareSpellScript(spell_black_template_free_friend);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        if (Unit* target = GetHitUnit())
            target->RemoveAurasWithMechanic(IMMUNE_TO_MOVEMENT_IMPAIRMENT_AND_LOSS_CONTROL_MASK);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_black_template_free_friend::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_black_temple_curse_of_the_bleakheart_aura : public AuraScript
{
    PrepareAuraScript(spell_black_temple_curse_of_the_bleakheart_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_CHEST_PAINS });
    }

    void CalcPeriodic(AuraEffect const* /*effect*/, bool& isPeriodic, int32& amplitude)
    {
        isPeriodic = true;
        amplitude = 5000;
    }

    void Update(AuraEffect const*  /*effect*/)
    {
        PreventDefaultAction();
        if (roll_chance_i(20))
            GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_CHEST_PAINS, true);
    }

    void Register() override
    {
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_black_temple_curse_of_the_bleakheart_aura::CalcPeriodic, EFFECT_0, SPELL_AURA_DUMMY);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_black_temple_curse_of_the_bleakheart_aura::Update, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

class spell_black_temple_skeleton_shot_aura : public AuraScript
{
    PrepareAuraScript(spell_black_temple_skeleton_shot_aura);

    void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_DEATH)
            GetTarget()->CastSpell(GetTarget(), GetSpellInfo()->Effects[EFFECT_2].CalcValue(), true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_black_temple_skeleton_shot_aura::HandleEffectRemove, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_black_temple_wyvern_sting_aura : public AuraScript
{
    PrepareAuraScript(spell_black_temple_wyvern_sting_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_WYVERN_STING });
    }

    void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* caster = GetCaster())
            caster->CastSpell(GetTarget(), SPELL_WYVERN_STING, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_black_temple_wyvern_sting_aura::HandleEffectRemove, EFFECT_0, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_black_temple_charge_rage_aura : public AuraScript
{
    PrepareAuraScript(spell_black_temple_charge_rage_aura);

    void Update(AuraEffect const* effect)
    {
        PreventDefaultAction();
        if (Unit* target = GetUnitOwner()->SelectNearbyNoTotemTarget((Unit*)nullptr, 50.0f))
            GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[effect->GetEffIndex()].TriggerSpell, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_black_temple_charge_rage_aura::Update, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_black_temple_shadow_inferno_aura : public AuraScript
{
    PrepareAuraScript(spell_black_temple_shadow_inferno_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SHADOW_INFERNO_DAMAGE });
    }

    void Update(AuraEffect const* effect)
    {
        PreventDefaultAction();
        GetUnitOwner()->CastCustomSpell(SPELL_SHADOW_INFERNO_DAMAGE, SPELLVALUE_BASE_POINT0, effect->GetAmount(), GetUnitOwner(), TRIGGERED_FULL_MASK);
        GetAura()->GetEffect(effect->GetEffIndex())->SetAmount(effect->GetAmount() + 500);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_black_temple_shadow_inferno_aura::Update, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

class spell_black_temple_spell_absorption_aura : public AuraScript
{
    PrepareAuraScript(spell_black_temple_spell_absorption_aura);

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        // Set absorbtion amount to unlimited
        amount = -1;
    }

    void Absorb(AuraEffect* /*aurEff*/, DamageInfo& dmgInfo, uint32& absorbAmount)
    {
        absorbAmount = dmgInfo.GetDamage();
    }

    void Update(AuraEffect const* effect)
    {
        PreventDefaultAction();
        uint32 count = GetUnitOwner()->GetAuraCount(SPELL_CHAOTIC_CHARGE);
        if (count == 0)
            return;

        GetUnitOwner()->CastCustomSpell(GetSpellInfo()->Effects[effect->GetEffIndex()].TriggerSpell, SPELLVALUE_BASE_POINT0, effect->GetAmount()*count, GetUnitOwner(), TRIGGERED_FULL_MASK);
        GetUnitOwner()->RemoveAurasDueToSpell(SPELL_CHAOTIC_CHARGE);
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_black_temple_spell_absorption_aura::CalculateAmount, EFFECT_2, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_black_temple_spell_absorption_aura::Absorb, EFFECT_2);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_black_temple_spell_absorption_aura::Update, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL_WITH_VALUE);
    }
};

class spell_black_temple_bloodbolt : public SpellScript
{
    PrepareSpellScript(spell_black_temple_bloodbolt);

    void HandleScriptEffect(SpellEffIndex effIndex)
    {
        PreventHitEffect(effIndex);
        if (Unit* target = GetHitUnit())
            GetCaster()->CastSpell(target, GetEffectValue(), true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_black_temple_bloodbolt::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

class spell_black_temple_consuming_strikes_aura : public AuraScript
{
    PrepareAuraScript(spell_black_temple_consuming_strikes_aura);

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();
        GetTarget()->CastCustomSpell(GetSpellInfo()->Effects[EFFECT_1].CalcValue(), SPELLVALUE_BASE_POINT0, eventInfo.GetDamageInfo()->GetDamage(), GetTarget(), true);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_black_temple_consuming_strikes_aura::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

class spell_black_temple_curse_of_vitality_aura : public AuraScript
{
    PrepareAuraScript(spell_black_temple_curse_of_vitality_aura);

    void OnPeriodic(AuraEffect const*  /*aurEff*/)
    {
        if (GetUnitOwner()->HealthBelowPct(50))
            SetDuration(0);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_black_temple_curse_of_vitality_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

class spell_black_temple_dementia_aura : public AuraScript
{
    PrepareAuraScript(spell_black_temple_dementia_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_DEMENTIA1, SPELL_DEMENTIA2 });
    }

    void OnPeriodic(AuraEffect const*  /*aurEff*/)
    {
        if (roll_chance_i(50))
            GetTarget()->CastSpell(GetTarget(), SPELL_DEMENTIA1, true);
        else
            GetTarget()->CastSpell(GetTarget(), SPELL_DEMENTIA2, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_black_temple_dementia_aura::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 39649 - Summon Shadowfiends
class spell_black_temple_summon_shadowfiends : public SpellScript
{
    PrepareSpellScript(spell_black_temple_summon_shadowfiends);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SUMMON_SHADOWFIENDS });
    }

    void HandleScriptEffect(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        if (!caster)
            return;

        for (uint8 i = 0; i < 11; i++)
            caster->CastSpell(caster, SPELL_SUMMON_SHADOWFIENDS, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_black_temple_summon_shadowfiends::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

void AddSC_instance_black_temple()
{
    new instance_black_temple();
    RegisterSpellScript(spell_black_template_harpooners_mark_aura);
    RegisterSpellScript(spell_black_template_free_friend);
    RegisterSpellScript(spell_black_temple_curse_of_the_bleakheart_aura);
    RegisterSpellScript(spell_black_temple_skeleton_shot_aura);
    RegisterSpellScript(spell_black_temple_wyvern_sting_aura);
    RegisterSpellScript(spell_black_temple_charge_rage_aura);
    RegisterSpellScript(spell_black_temple_shadow_inferno_aura);
    RegisterSpellScript(spell_black_temple_spell_absorption_aura);
    RegisterSpellScript(spell_black_temple_bloodbolt);
    RegisterSpellScript(spell_black_temple_consuming_strikes_aura);
    RegisterSpellScript(spell_black_temple_curse_of_vitality_aura);
    RegisterSpellScript(spell_black_temple_dementia_aura);
    RegisterSpellScript(spell_black_temple_summon_shadowfiends);
}

