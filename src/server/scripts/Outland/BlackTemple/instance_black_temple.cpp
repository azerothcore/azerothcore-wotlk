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

#include "InstanceScript.h"
#include "ScriptMgr.h"
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
    { GO_ILLIDAN_GATE,          DATA_AKAMA_FINISHED,        DOOR_TYPE_PASSAGE  },
    { GO_ILLIDAN_DOOR_L,        DATA_ILLIDAN_STORMRAGE,     DOOR_TYPE_ROOM     },
    { GO_ILLIDAN_DOOR_R,        DATA_ILLIDAN_STORMRAGE,     DOOR_TYPE_ROOM     },
    { 0,                        0,                          DOOR_TYPE_ROOM     }
};

class instance_black_temple : public InstanceMapScript
{
public:
    instance_black_temple() : InstanceMapScript("instance_black_temple", 564) { }

    struct instance_black_temple_InstanceMapScript : public InstanceScript
    {
        instance_black_temple_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(MAX_ENCOUNTERS);
            LoadDoorData(doorData);

            ashtongueGUIDs.clear();
        }

        void OnCreatureCreate(Creature* creature) override
        {
            switch (creature->GetEntry())
            {
                case NPC_SHADE_OF_AKAMA:
                    ShadeOfAkamaGUID = creature->GetGUID();
                    break;
                case NPC_AKAMA_SHADE:
                    AkamaShadeGUID = creature->GetGUID();
                    break;
                case NPC_TERON_GOREFIEND:
                    TeronGorefiendGUID = creature->GetGUID();
                    break;
                case NPC_RELIQUARY_OF_THE_LOST:
                    ReliquaryGUID = creature->GetGUID();
                    break;
                case NPC_GATHIOS_THE_SHATTERER:
                    GathiosTheShattererGUID = creature->GetGUID();
                    break;
                case NPC_HIGH_NETHERMANCER_ZEREVOR:
                    HighNethermancerZerevorGUID = creature->GetGUID();
                    break;
                case NPC_LADY_MALANDE:
                    LadyMalandeGUID = creature->GetGUID();
                    break;
                case NPC_VERAS_DARKSHADOW:
                    VerasDarkshadowGUID = creature->GetGUID();
                    break;
                case NPC_ILLIDARI_COUNCIL:
                    IllidariCouncilGUID = creature->GetGUID();
                    break;
                case NPC_AKAMA:
                    AkamaGUID = creature->GetGUID();
                    break;
                case NPC_ILLIDAN_STORMRAGE:
                    IllidanStormrageGUID = creature->GetGUID();
                    break;
                case NPC_VENGEFUL_SPIRIT:
                case NPC_SHADOWY_CONSTRUCT:
                    if (Creature* teron = instance->GetCreature(TeronGorefiendGUID))
                        teron->AI()->JustSummoned(creature);
                    break;
                case NPC_ENSLAVED_SOUL:
                    if (Creature* reliquary = instance->GetCreature(ReliquaryGUID))
                        reliquary->AI()->JustSummoned(creature);
                    break;
                case NPC_PARASITIC_SHADOWFIEND:
                case NPC_BLADE_OF_AZZINOTH:
                case NPC_FLAME_OF_AZZINOTH:
                    if (Creature* illidan = instance->GetCreature(IllidanStormrageGUID))
                        illidan->AI()->JustSummoned(creature);
                    break;
                case NPC_ANGERED_SOUL_FRAGMENT:
                case NPC_HUNGERING_SOUL_FRAGMENT:
                case NPC_SUFFERING_SOUL_FRAGMENT:
                    creature->SetCorpseDelay(5);
                    break;
            }

            if (creature->GetName().find("Ashtongue") != std::string::npos || creature->GetEntry() == NPC_STORM_FURY)
            {
                ashtongueGUIDs.push_back(creature->GetGUID());
                if (GetBossState(DATA_SHADE_OF_AKAMA) == DONE)
                    creature->SetFaction(FACTION_ASHTONGUE_DEATHSWORN);
            }
        }

        void OnGameObjectCreate(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_NAJENTUS_GATE:
                case GO_SUPREMUS_GATE:
                case GO_SHADE_OF_AKAMA_DOOR:
                case GO_TERON_DOOR_1:
                case GO_TERON_DOOR_2:
                case GO_GURTOGG_DOOR:
                case GO_TEMPLE_DOOR:
                case GO_MOTHER_SHAHRAZ_DOOR:
                case GO_COUNCIL_DOOR_1:
                case GO_COUNCIL_DOOR_2:
                case GO_ILLIDAN_GATE:
                case GO_ILLIDAN_DOOR_R:
                case GO_ILLIDAN_DOOR_L:
                    AddDoor(go, true);
                    break;
            }
        }

        void OnGameObjectRemove(GameObject* go) override
        {
            switch (go->GetEntry())
            {
                case GO_NAJENTUS_GATE:
                case GO_SUPREMUS_GATE:
                case GO_SHADE_OF_AKAMA_DOOR:
                case GO_TERON_DOOR_1:
                case GO_TERON_DOOR_2:
                case GO_GURTOGG_DOOR:
                case GO_TEMPLE_DOOR:
                case GO_MOTHER_SHAHRAZ_DOOR:
                case GO_COUNCIL_DOOR_1:
                case GO_COUNCIL_DOOR_2:
                case GO_ILLIDAN_GATE:
                case GO_ILLIDAN_DOOR_R:
                case GO_ILLIDAN_DOOR_L:
                    AddDoor(go, false);
                    break;
            }
        }

        ObjectGuid GetGuidData(uint32 type) const override
        {
            switch (type)
            {
                case NPC_SHADE_OF_AKAMA:
                    return ShadeOfAkamaGUID;
                case NPC_AKAMA_SHADE:
                    return AkamaShadeGUID;
                case NPC_GATHIOS_THE_SHATTERER:
                    return GathiosTheShattererGUID;
                case NPC_HIGH_NETHERMANCER_ZEREVOR:
                    return HighNethermancerZerevorGUID;
                case NPC_LADY_MALANDE:
                    return LadyMalandeGUID;
                case NPC_VERAS_DARKSHADOW:
                    return VerasDarkshadowGUID;
                case NPC_ILLIDARI_COUNCIL:
                    return IllidariCouncilGUID;
                case NPC_AKAMA:
                    return AkamaGUID;
                case NPC_ILLIDAN_STORMRAGE:
                    return IllidanStormrageGUID;
            }

            return ObjectGuid::Empty;
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
                if (Creature* akama = instance->GetCreature(AkamaGUID))
                    akama->SetVisible(true);
            }

            return true;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "B T " << GetBossSaveData();

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(char const* str) override
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

            if (dataHead1 == 'B' && dataHead2 == 'T')
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
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

    protected:
        ObjectGuid ShadeOfAkamaGUID;
        ObjectGuid AkamaShadeGUID;
        ObjectGuid TeronGorefiendGUID;
        ObjectGuid ReliquaryGUID;
        GuidList ashtongueGUIDs;
        ObjectGuid GathiosTheShattererGUID;
        ObjectGuid HighNethermancerZerevorGUID;
        ObjectGuid LadyMalandeGUID;
        ObjectGuid VerasDarkshadowGUID;
        ObjectGuid IllidariCouncilGUID;
        ObjectGuid AkamaGUID;
        ObjectGuid IllidanStormrageGUID;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_black_temple_InstanceMapScript(map);
    }
};

class spell_black_template_harpooners_mark : public SpellScriptLoader
{
public:
    spell_black_template_harpooners_mark() : SpellScriptLoader("spell_black_template_harpooners_mark") { }

    class spell_black_template_harpooners_mark_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_black_template_harpooners_mark_AuraScript)

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
            OnEffectApply += AuraEffectApplyFn(spell_black_template_harpooners_mark_AuraScript::HandleEffectApply, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
            OnEffectRemove += AuraEffectRemoveFn(spell_black_template_harpooners_mark_AuraScript::HandleEffectRemove, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        }

    private:
        GuidSet _turtleSet;
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_black_template_harpooners_mark_AuraScript();
    }
};

class spell_black_template_free_friend : public SpellScriptLoader
{
public:
    spell_black_template_free_friend() : SpellScriptLoader("spell_black_template_free_friend") { }

    class spell_black_template_free_friend_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_black_template_free_friend_SpellScript);

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);
            Unit* target = GetHitUnit();
            if (!target)
                return;

            target->RemoveAurasDueToSpell(SPELL_AURA_MOD_CHARM);
            target->RemoveAurasDueToSpell(SPELL_AURA_MOD_STUN);
            target->RemoveAurasDueToSpell(SPELL_AURA_MOD_DECREASE_SPEED);
            target->RemoveAurasDueToSpell(SPELL_AURA_MOD_ROOT);
            target->RemoveAurasDueToSpell(SPELL_AURA_MOD_CONFUSE);
            target->RemoveAurasDueToSpell(SPELL_AURA_MOD_FEAR);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_black_template_free_friend_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_black_template_free_friend_SpellScript();
    }
};

class spell_black_temple_curse_of_the_bleakheart : public SpellScriptLoader
{
public:
    spell_black_temple_curse_of_the_bleakheart() : SpellScriptLoader("spell_black_temple_curse_of_the_bleakheart") { }

    class spell_black_temple_curse_of_the_bleakheart_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_black_temple_curse_of_the_bleakheart_AuraScript);

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
            DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_black_temple_curse_of_the_bleakheart_AuraScript::CalcPeriodic, EFFECT_0, SPELL_AURA_DUMMY);
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_black_temple_curse_of_the_bleakheart_AuraScript::Update, EFFECT_0, SPELL_AURA_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_black_temple_curse_of_the_bleakheart_AuraScript();
    }
};

class spell_black_temple_skeleton_shot : public SpellScriptLoader
{
public:
    spell_black_temple_skeleton_shot() : SpellScriptLoader("spell_black_temple_skeleton_shot") { }

    class spell_black_temple_skeleton_shot_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_black_temple_skeleton_shot_AuraScript)

        void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_DEATH)
                GetTarget()->CastSpell(GetTarget(), GetSpellInfo()->Effects[EFFECT_2].CalcValue(), true);
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_black_temple_skeleton_shot_AuraScript::HandleEffectRemove, EFFECT_1, SPELL_AURA_PERIODIC_DAMAGE, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_black_temple_skeleton_shot_AuraScript();
    }
};

class spell_black_temple_wyvern_sting : public SpellScriptLoader
{
public:
    spell_black_temple_wyvern_sting() : SpellScriptLoader("spell_black_temple_wyvern_sting") { }

    class spell_black_temple_wyvern_sting_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_black_temple_wyvern_sting_AuraScript)

        void HandleEffectRemove(AuraEffect const*  /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* caster = GetCaster())
                caster->CastSpell(GetTarget(), SPELL_WYVERN_STING, true);
        }

        void Register() override
        {
            AfterEffectRemove += AuraEffectRemoveFn(spell_black_temple_wyvern_sting_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_MOD_STUN, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_black_temple_wyvern_sting_AuraScript();
    }
};

class spell_black_temple_charge_rage : public SpellScriptLoader
{
public:
    spell_black_temple_charge_rage() : SpellScriptLoader("spell_black_temple_charge_rage") { }

    class spell_black_temple_charge_rage_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_black_temple_charge_rage_AuraScript);

        void Update(AuraEffect const* effect)
        {
            PreventDefaultAction();
            if (Unit* target = GetUnitOwner()->SelectNearbyNoTotemTarget((Unit*)nullptr, 50.0f))
                GetUnitOwner()->CastSpell(target, GetSpellInfo()->Effects[effect->GetEffIndex()].TriggerSpell, true);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_black_temple_charge_rage_AuraScript::Update, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_black_temple_charge_rage_AuraScript();
    }
};

class spell_black_temple_shadow_inferno : public SpellScriptLoader
{
public:
    spell_black_temple_shadow_inferno() : SpellScriptLoader("spell_black_temple_shadow_inferno") { }

    class spell_black_temple_shadow_inferno_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_black_temple_shadow_inferno_AuraScript);

        void Update(AuraEffect const* effect)
        {
            PreventDefaultAction();
            GetUnitOwner()->CastCustomSpell(SPELL_SHADOW_INFERNO_DAMAGE, SPELLVALUE_BASE_POINT0, effect->GetAmount(), GetUnitOwner(), TRIGGERED_FULL_MASK);
            GetAura()->GetEffect(effect->GetEffIndex())->SetAmount(effect->GetAmount() + 500);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_black_temple_shadow_inferno_AuraScript::Update, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_black_temple_shadow_inferno_AuraScript();
    }
};

class spell_black_temple_spell_absorption : public SpellScriptLoader
{
public:
    spell_black_temple_spell_absorption() : SpellScriptLoader("spell_black_temple_spell_absorption") { }

    class spell_black_temple_spell_absorption_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_black_temple_spell_absorption_AuraScript);

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
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_black_temple_spell_absorption_AuraScript::CalculateAmount, EFFECT_2, SPELL_AURA_SCHOOL_ABSORB);
            OnEffectAbsorb += AuraEffectAbsorbFn(spell_black_temple_spell_absorption_AuraScript::Absorb, EFFECT_2);
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_black_temple_spell_absorption_AuraScript::Update, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL_WITH_VALUE);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_black_temple_spell_absorption_AuraScript();
    }
};

class spell_black_temple_bloodbolt : public SpellScriptLoader
{
public:
    spell_black_temple_bloodbolt() : SpellScriptLoader("spell_black_temple_bloodbolt") { }

    class spell_black_temple_bloodbolt_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_black_temple_bloodbolt_SpellScript);

        void HandleScriptEffect(SpellEffIndex effIndex)
        {
            PreventHitEffect(effIndex);
            if (Unit* target = GetHitUnit())
                GetCaster()->CastSpell(target, GetEffectValue(), true);
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_black_temple_bloodbolt_SpellScript::HandleScriptEffect, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_black_temple_bloodbolt_SpellScript();
    }
};

class spell_black_temple_consuming_strikes : public SpellScriptLoader
{
public:
    spell_black_temple_consuming_strikes() : SpellScriptLoader("spell_black_temple_consuming_strikes") { }

    class spell_black_temple_consuming_strikes_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_black_temple_consuming_strikes_AuraScript);

        void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
        {
            PreventDefaultAction();
            GetTarget()->CastCustomSpell(GetSpellInfo()->Effects[EFFECT_1].CalcValue(), SPELLVALUE_BASE_POINT0, eventInfo.GetDamageInfo()->GetDamage(), GetTarget(), true);
        }

        void Register() override
        {
            OnEffectProc += AuraEffectProcFn(spell_black_temple_consuming_strikes_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_black_temple_consuming_strikes_AuraScript();
    }
};

class spell_black_temple_curse_of_vitality : public SpellScriptLoader
{
public:
    spell_black_temple_curse_of_vitality() : SpellScriptLoader("spell_black_temple_curse_of_vitality") { }

    class spell_black_temple_curse_of_vitality_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_black_temple_curse_of_vitality_AuraScript);

        void OnPeriodic(AuraEffect const*  /*aurEff*/)
        {
            if (GetUnitOwner()->HealthBelowPct(50))
                SetDuration(0);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_black_temple_curse_of_vitality_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_black_temple_curse_of_vitality_AuraScript();
    }
};

class spell_black_temple_dementia : public SpellScriptLoader
{
public:
    spell_black_temple_dementia() : SpellScriptLoader("spell_black_temple_dementia") { }

    class spell_black_temple_dementia_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_black_temple_dementia_AuraScript);

        void OnPeriodic(AuraEffect const*  /*aurEff*/)
        {
            if (roll_chance_i(50))
                GetTarget()->CastSpell(GetTarget(), SPELL_DEMENTIA1, true);
            else
                GetTarget()->CastSpell(GetTarget(), SPELL_DEMENTIA2, true);
        }

        void Register() override
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_black_temple_dementia_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const override
    {
        return new spell_black_temple_dementia_AuraScript();
    }
};

void AddSC_instance_black_temple()
{
    new instance_black_temple();
    new spell_black_template_harpooners_mark();
    new spell_black_template_free_friend();
    new spell_black_temple_curse_of_the_bleakheart();
    new spell_black_temple_skeleton_shot();
    new spell_black_temple_wyvern_sting();
    new spell_black_temple_charge_rage();
    new spell_black_temple_shadow_inferno();
    new spell_black_temple_spell_absorption();
    new spell_black_temple_bloodbolt();
    new spell_black_temple_consuming_strikes();
    new spell_black_temple_curse_of_vitality();
    new spell_black_temple_dementia();
}
