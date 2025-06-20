////////////////////////////////////////////////////////////////////////////////
//
//  MILLENIUM-STUDIO
//  Copyright 2016 Millenium-studio SARL
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////

#include "ScriptMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "Player.h"
#include "GridNotifiers.h"

// TODO: move this to a global script library
// Generic script for creating a dummy unit at the destination of a spell
class create_dummy_unit_at_dest : public SpellScript
{
    PrepareSpellScript(create_dummy_unit_at_dest);

protected:
    create_dummy_unit_at_dest(uint32 dummyEntry) : _dummyEntry(dummyEntry)
    {
    }

    void HandleDummy(SpellEffIndex effIndex)
    {
        if (Unit* caster = GetCaster())
        {
            if (WorldLocation const* dest = GetExplTargetDest())
            {
                // create dummy
                caster->SummonCreature(_dummyEntry, *dest, TEMPSUMMON_TIMED_DESPAWN, GetHitSpell()->GetDuration());
            }
        }
    }

    uint32 _dummyEntry;
};

// 28730 - Presence of Mind
class spell_mage_presence_of_mind : public SpellScriptLoader
{
public:
    spell_mage_presence_of_mind() : SpellScriptLoader("spell_mage_presence_of_mind") { }

    class spell_mage_presence_of_mind_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mage_presence_of_mind_AuraScript);

        bool Validate(SpellInfo const* /*spell*/)
        {
            return true;
        }

        void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* target = GetTarget())
            {
                // On Apply, create a dummy spell an cast it on the player, this spell has a dummy effect used to track the presence of mind buff
                target->CastSpell(target, 70837, true);
            }
        }

        bool CheckCast(SpellInfo const* spell)
        {
            // not proc on presence of mind and other
            if (spell->Id == 12043 || spell->Id == 70837 || spell->Id == 28730)
                return false;

            // only for mage spells
            if (spell->GetSchoolMask() & SPELL_SCHOOL_MASK_ARCANE ||
                spell->GetSchoolMask() & SPELL_SCHOOL_MASK_FIRE   ||
                spell->GetSchoolMask() & SPELL_SCHOOL_MASK_FROST)
                if (spell->CalcCastTime() > 0)
                    return true;

            return false;
        }

        void Register()
        {
            DoCheckCast += AuraCheckCastFn(spell_mage_presence_of_mind_AuraScript::CheckCast);
            OnEffectApply += AuraEffectApplyFn(spell_mage_presence_of_mind_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_MOD_CASTING_TIME_NOT_STACK, AURA_EFFECT_HANDLE_REAL);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mage_presence_of_mind_AuraScript();
    }
};

// Arcane Blast
class spell_mage_arcane_blast : public SpellScriptLoader
{
public:
    spell_mage_arcane_blast() : SpellScriptLoader("spell_mage_arcane_blast") { }

    class spell_mage_arcane_blast_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mage_arcane_blast_AuraScript);

        void CalculateAmount(AuraEffect const* aurEff, int32& amount, bool& canBeRecalculated)
        {
            if (GetSpellInfo()->Id != aurEff->GetSpellInfo()->Id)
                amount += GetCaster()->GetAura(GetSpellInfo()->Id, GetCaster()->GetGUID())->GetEffect(aurEff->GetEffIndex())->GetAmount();
        }

        void Register()
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_mage_arcane_blast_AuraScript::CalculateAmount, EFFECT_1, SPELL_AURA_MOD_CASTING_TIME_NOT_STACK);
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_mage_arcane_blast_AuraScript::CalculateAmount, EFFECT_2, SPELL_AURA_MOD_MANA_COST_PCT);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mage_arcane_blast_AuraScript();
    }
};

// 31661 - Dragon's Breath
enum DragonsBreath
{
    SPELL_MAGE_DRAGONS_BREATH_DUMMY = 31662
};

class spell_mage_dragons_breath : public SpellScriptLoader
{
public:
    spell_mage_dragons_breath() : SpellScriptLoader("spell_mage_dragons_breath") { }

    class spell_mage_dragons_breath_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_mage_dragons_breath_SpellScript);

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Unit* caster = GetCaster())
            {
                for (uint8 i = 0; i < 3; ++i)
                {
                    if (GetSpell()->m_targets.HasDst())
                    {
                        if (Creature* creature = caster->SummonCreature(17508, *GetSpell()->m_targets.GetDstPos(), TEMPSUMMON_TIMED_DESPAWN, 100))
                        {
                            std::list<Unit*> unitList;
                            float range = 10.0f;
                            float angle = 2.0f * M_PI * i / 3.0f;
                            float x = creature->GetPositionX() + range * cos(angle);
                            float y = creature->GetPositionY() + range * sin(angle);
                            creature->GetNearList(unitList, range);

                            for (Unit* unit : unitList)
                                if (unit != caster && creature->IsValidAttackTarget(unit) && creature->IsWithinFront(unit, M_PI/4))
                                    creature->CastSpell(unit, SPELL_MAGE_DRAGONS_BREATH_DUMMY, true);
                        }
                    }
                }
            }
        }

        void Register()
        {
            OnEffectHit += SpellEffectFn(spell_mage_dragons_breath_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_mage_dragons_breath_SpellScript();
    }
};

// 31589 - Slow
class spell_mage_slow : public SpellScriptLoader
{
public:
    spell_mage_slow() : SpellScriptLoader("spell_mage_slow") { }

    class spell_mage_slow_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mage_slow_AuraScript);

        bool Validate(SpellInfo const* /*spell*/)
        {
            return true;
        }

        void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
        {
            if (Unit* caster = GetCaster())
                if (Unit* target = GetTarget())
                    if (AuraEffect* slow = target->GetAuraEffect(GetId(), 1))
                        if (roll_chance_i(slow->GetAmount()))
                            target->RemoveAurasDueToSpell(GetId());
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mage_slow_AuraScript::HandleEffectPeriodic, EFFECT_2, SPELL_AURA_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mage_slow_AuraScript();
    }
};

// 12472 - Icy Veins
class spell_mage_icy_veins : public SpellScriptLoader
{
public:
    spell_mage_icy_veins() : SpellScriptLoader("spell_mage_icy_veins") { }

    class spell_mage_icy_veins_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mage_icy_veins_AuraScript);

        bool Validate(SpellInfo const* /*spell*/)
        {
            return true;
        }

        void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
        {
            if (Unit* caster = GetCaster())
                if (caster->HasAura(44544)) // Fingers of Frost
                    amount = 0;
        }

        void Register()
        {
            DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_mage_icy_veins_AuraScript::CalculateAmount, EFFECT_2, SPELL_AURA_MOD_PUSHBACK_RESISTANCE);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mage_icy_veins_AuraScript();
    }
};

// 120 - Cone of Cold
class spell_mage_cone_of_cold : public SpellScriptLoader
{
public:
    spell_mage_cone_of_cold() : SpellScriptLoader("spell_mage_cone_of_cold") { }

    class spell_mage_cone_of_cold_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_mage_cone_of_cold_SpellScript);

        bool Validate(SpellInfo const* /*spell*/)
        {
            return true;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Unit* caster = GetCaster())
            {
                if (AuraEffect* chill = caster->GetAuraEffect(GetSpellInfo()->Effects[EFFECT_0].BasePoints, 0))
                {
                    int32 duration = chill->GetDuration();
                    if (Unit* target = GetHitUnit())
                        if (target->HasAura(44544)) // Fingers of Frost
                            duration += 1500;
                    GetSpell()->m_appliedAuras.GetAt(0)->SetDuration(duration);
                }
            }
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_mage_cone_of_cold_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_mage_cone_of_cold_SpellScript();
    }
};

// 122 - Frost Nova
class spell_mage_frost_nova : public SpellScriptLoader
{
public:
    spell_mage_frost_nova() : SpellScriptLoader("spell_mage_frost_nova") { }

    class spell_mage_frost_nova_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_mage_frost_nova_SpellScript);

        bool Validate(SpellInfo const* /*spell*/)
        {
            return true;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            if (Unit* caster = GetCaster())
                if (Unit* target = GetHitUnit())
                    if (AuraEffect* frostNova = target->GetAuraEffect(GetSpellInfo()->Id, 0))
                        if (target->HasAura(44544))
                            frostNova->SetDuration(frostNova->GetDuration() + 1500);
        }

        void Register()
        {
            OnEffectHitTarget += SpellEffectFn(spell_mage_frost_nova_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_mage_frost_nova_SpellScript();
    }
};

////////////////////////////////////////////////////////////////////////////////
///
///                            START OF REPLACED BLOCK
///
////////////////////////////////////////////////////////////////////////////////

// This is the class you are replacing.
// The code below is correctly formatted according to the AzerothCore C++ Standard.
class spell_mage_blizzard : public SpellScript
{
    PrepareSpellScript(spell_mage_blizzard);

    void OnCast(SpellEffIndex /*effIndex*/)
    {
        // Logic removed from here as it was incorrect.
    }

    void OnEffectPeriodic(SpellEffIndex /*effIndex*/)
    {
        // Logic moved here to run on every damage tick.
        if (Unit* caster = GetCaster())
        {
            if (Player* player = caster->ToPlayer())
            {
                // Proc check for Arcane Concentration (talent ID 12575)
                if (Aura* arcaneConcentration = player->GetAura(12575))
                {
                    if (roll_chance_i(arcaneConcentration->GetEffect(0)->GetAmount()))
                    {
                        // Apply Clearcasting buff (spell ID 12536)
                        player->CastSpell(player, 12536, true);
                    }
                }
            }
        }
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_mage_blizzard::OnCast);
        OnEffectPeriodic += SpellEffectFn(spell_mage_blizzard::OnEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DAMAGE);
    }
};

////////////////////////////////////////////////////////////////////////////////
///
///                             END OF REPLACED BLOCK
///
////////////////////////////////////////////////////////////////////////////////

// 44457 - Living Bomb
class spell_mage_living_bomb : public SpellScriptLoader
{
public:
    spell_mage_living_bomb() : SpellScriptLoader("spell_mage_living_bomb") { }

    class spell_mage_living_bomb_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mage_living_bomb_AuraScript);

        bool Validate(SpellInfo const* /*spell*/)
        {
            return true;
        }

        void HandleEffectPeriodic(AuraEffect const* /*aurEff*/)
        {
            if (Unit* target = GetTarget())
            {
                if (Aura* bomb = target->GetAura(GetId()))
                {
                    if (bomb->GetStackAmount() == 3)
                    {
                        target->RemoveAurasDueToSpell(GetId());
                        target->CastSpell(target, 44461, true);
                    }
                }
            }
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_mage_living_bomb_AuraScript::HandleEffectPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mage_living_bomb_AuraScript();
    }
};

// 44544 - Fingers of Frost
class spell_mage_fingers_of_frost : public SpellScriptLoader
{
public:
    spell_mage_fingers_of_frost() : SpellScriptLoader("spell_mage_fingers_of_frost") { }

    class spell_mage_fingers_of_frost_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mage_fingers_of_frost_AuraScript);

        bool Validate(SpellInfo const* /*spell*/)
        {
            return true;
        }

        void HandleProc(AuraEffect const* aurEff, ProcEventInfo& /*eventInfo*/)
        {
            PreventDefaultAction();

            if (Aura* fof = GetTarget()->GetAura(44544))
            {
                if (roll_chance_i(aurEff->GetAmount()))
                    fof->SetCharges(fof->GetCharges() + 1);
            }
        }

        void Register()
        {
            OnEffectProc += AuraEffectProcFn(spell_mage_fingers_of_frost_AuraScript::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mage_fingers_of_frost_AuraScript();
    }
};

// 66 - Invisibility
class spell_mage_invisibility : public SpellScriptLoader
{
public:
    spell_mage_invisibility() : SpellScriptLoader("spell_mage_invisibility") { }

    class spell_mage_invisibility_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_mage_invisibility_AuraScript);

        bool Validate(SpellInfo const* /*spell*/)
        {
            return true;
        }

        void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
        {
            if (Unit* caster = GetCaster())
            {
                if (Aura* invis = caster->GetAura(66))
                {
                    caster->CastSpell(caster, 58994, true); // this spell forces threat drop
                    //invis->SetDuration(invis->GetDuration() - 2000);
                }
            }
        }

        void OnUpdate(uint32 diff)
        {
            if (Unit* caster = GetCaster())
            {
                if (Aura* invis = caster->GetAura(66))
                {
                    if (invis->GetDuration() <= invis->GetMaxDuration() - 2000)
                    {
                        caster->RemoveAurasDueToSpell(58994);
                        // a bit of a hack, but this ensures that the aura is faded
                        invis->SetDuration(invis->GetDuration() + 1);
                    }
                }
            }
        }

        void Register()
        {
            OnEffectApply += AuraEffectApplyFn(spell_mage_invisibility_AuraScript::OnApply, EFFECT_0, SPELL_AURA_MOD_STEALTH, AURA_EFFECT_HANDLE_REAL);
            OnAuraUpdate += AuraUpdateFn(spell_mage_invisibility_AuraScript::OnUpdate);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_mage_invisibility_AuraScript();
    }
};

// 55342 - Mirror Image
enum MirrorImage
{
    SPELL_MIRROR_IMAGE_SUMMON = 58832,
    SPELL_MIRROR_IMAGE_CLONE_ME = 58836,
};

class spell_mage_mirror_image : public SpellScriptLoader
{
public:
    spell_mage_mirror_image() : SpellScriptLoader("spell_mage_mirror_image") { }

    class spell_mage_mirror_image_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_mage_mirror_image_SpellScript);

        bool Validate(SpellInfo const* /*spell*/)
        {
            return true;
        }

        void HandleDummy(SpellEffIndex /*effIndex*/)
        {
            Unit* caster = GetCaster();

            caster->CastSpell(caster, SPELL_MIRROR_IMAGE_SUMMON, true);

            std::list<Creature*> existingImages;
            caster->GetAllMinionsByEntry(existingImages, 31216);

            for (Creature* image : existingImages)
                image->CastSpell(caster, SPELL_MIRROR_IMAGE_CLONE_ME, true);
        }

        void Register()
        {
            OnEffectHit += SpellEffectFn(spell_mage_mirror_image_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_mage_mirror_image_SpellScript();
    }
};

// 58832 - Mirror Image Summon
class spell_mage_mirror_image_summon : public create_dummy_unit_at_dest
{
public:
    spell_mage_mirror_image_summon() : create_dummy_unit_at_dest(31216) {}

    void Register()
    {
        OnEffectHit += SpellEffectFn(spell_mage_mirror_image_summon::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_mage_spell_scripts()
{
    new spell_mage_presence_of_mind();
    new spell_mage_arcane_blast();
    new spell_mage_dragons_breath();
    new spell_mage_slow();
    new spell_mage_icy_veins();
//     new spell_mage_cone_of_cold();
//     new spell_mage_frost_nova();
    new spell_mage_blizzard();
    new spell_mage_living_bomb();
    new spell_mage_fingers_of_frost();
//     new spell_mage_invisibility();
    new spell_mage_mirror_image();
    new spell_mage_mirror_image_summon();
}
