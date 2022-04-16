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

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_hun_".
 */

#include "ScriptMgr.h"
#include "CreatureAIImpl.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "TemporarySummon.h"

enum HunterSpells
{
    SPELL_HUNTER_CRIPPLING_POISON       = 30981, // Viper
    SPELL_HUNTER_DEADLY_POISON_PASSIVE  = 34657, // Venomous Snake
    SPELL_HUNTER_MIND_NUMBING_POISON    = 25810, // Viper
    SPELL_HUNTER_GLYPH_OF_SNAKE_TRAP    = 56849,
    SPELL_HUNTER_PET_SCALING            = 62915
};

enum HunterCreatures
{
    NPC_HUNTER_VIPER                    = 19921
};

enum PetSpellsMisc
{
    SPELL_PET_GUARD_DOG_HAPPINESS   = 54445,
    SPELL_PET_SILVERBACK_RANK_1     = 62800,
    SPELL_PET_SILVERBACK_RANK_2     = 62801,

    SPELL_PET_SWOOP                 = 52825,
    SPELL_PET_CHARGE                = 61685,

    PET_ICON_ID_GROWL               = 201,
    PET_ICON_ID_CLAW                = 262,
    PET_ICON_ID_BITE                = 1680,
    PET_ICON_ID_SMACK               = 473
};

struct npc_pet_hunter_snake_trap : public ScriptedAI
{
    npc_pet_hunter_snake_trap(Creature* creature) : ScriptedAI(creature) { _init = false; }

    void Reset() override
    {
        _spellTimer = urand(1500, 3000);

        // Start attacking attacker of owner on first ai update after spawn - move in line of sight may choose better target
        if (!me->GetVictim())
            if (Unit* tgt = me->SelectNearestTarget(10.0f))
            {
                me->AddThreat(tgt, 100000.0f);
                AttackStart(tgt);
            }
    }

    void EnterEvadeMode(EvadeReason /*why*/) override
    {
        // _EnterEvadeMode();
        me->DeleteThreatList();
        me->CombatStop(true);
        me->LoadCreaturesAddon(true);
        me->SetLootRecipient(nullptr);
        me->ResetPlayerDamageReq();
        me->SetLastDamagedTime(0);

        me->AddUnitState(UNIT_STATE_EVADE);
        me->GetMotionMaster()->MoveTargetedHome();

        Reset();
    }

    //Redefined for random target selection:
    void MoveInLineOfSight(Unit* who) override
    {
        if (!me->GetVictim() && who->isTargetableForAttack() && (me->IsHostileTo(who)) && who->isInAccessiblePlaceFor(me))
        {
            if (me->GetDistanceZ(who) > CREATURE_Z_ATTACK_RANGE)
                return;

            if (me->IsWithinDistInMap(who, 10.0f))
            {
                me->AddThreat(who, 100000.0f);
                AttackStart(who);
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (me->GetVictim()->HasBreakableByDamageCrowdControlAura(me))
        {
            me->InterruptNonMeleeSpells(false);
            return;
        }

        if (!_init)
        {
            _init = true;

            CreatureTemplate const* Info = me->GetCreatureTemplate();
            CreatureBaseStats const* stats = sObjectMgr->GetCreatureBaseStats(me->getLevel(), Info->unit_class);
            uint32 health = uint32(107 * (me->getLevel() - 40) * 0.025f);
            me->SetCreateHealth(health);

            for (uint8 stat = 0; stat < MAX_STATS; ++stat)
            {
                me->SetStat(Stats(stat), 0);
                me->SetCreateStat(Stats(stat), 0);
            }

            me->SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, (float)health);
            me->SetMaxHealth(health);
            //Add delta to make them not all hit the same time
            uint32 delta = urand(0, 700);
            me->SetAttackTime(BASE_ATTACK, Info->BaseAttackTime + delta);
            me->SetStatFloatValue(UNIT_FIELD_RANGED_ATTACK_POWER, float(stats->AttackPower));
            me->CastSpell(me, SPELL_HUNTER_DEADLY_POISON_PASSIVE, true);

            // Glyph of Snake Trap
            if (Unit* owner = me->GetOwner())
                if (owner->GetAuraEffectDummy(SPELL_HUNTER_GLYPH_OF_SNAKE_TRAP))
                    me->CastSpell(me, SPELL_HUNTER_PET_SCALING, true);
        }

        _spellTimer += diff;
        if (_spellTimer >= 3000)
        {
            if (urand(0, 2) == 0) // 33% chance to cast
                DoCastVictim(RAND(SPELL_HUNTER_MIND_NUMBING_POISON, SPELL_HUNTER_CRIPPLING_POISON));

            _spellTimer = 0;
        }

        DoMeleeAttackIfReady();
    }

private:
    bool _init;
    uint32 _spellTimer;
};

// 57627 - Charge
class spell_pet_charge : public AuraScript
{
    PrepareAuraScript(spell_pet_charge);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo(
        {
                SPELL_PET_SWOOP,
                SPELL_PET_CHARGE
        });
    }

    void HandleDummy(AuraEffect const* /*aurEff*/, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        // Remove +% AP aura
        Unit* pet = eventInfo.GetActor();
        Aura* aura = pet->GetAura(SPELL_PET_SWOOP, pet->GetGUID());
        if (!aura)
            aura = pet->GetAura(SPELL_PET_CHARGE, pet->GetGUID());

        if (!aura)
            return;

        aura->DropCharge(AURA_REMOVE_BY_EXPIRE);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_pet_charge::HandleDummy, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -53178 - Guard Dog
class spell_pet_guard_dog : public AuraScript
{
    PrepareAuraScript(spell_pet_guard_dog);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PET_GUARD_DOG_HAPPINESS });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        // Growl shares family flags with other spells
        // filter by spellIcon instead
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo || spellInfo->SpellIconID != PET_ICON_ID_GROWL)
            return false;

        return true;
    }

    void HandleProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Unit* caster = eventInfo.GetActor();
        caster->CastSpell((Unit*)nullptr, SPELL_PET_GUARD_DOG_HAPPINESS, true);

        float addThreat = CalculatePct(eventInfo.GetSpellInfo()->Effects[EFFECT_0].CalcValue(caster), aurEff->GetAmount());
        eventInfo.GetProcTarget()->AddThreat(caster, addThreat);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pet_guard_dog::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pet_guard_dog::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -62764 - Silverback
class spell_pet_silverback : public AuraScript
{
    PrepareAuraScript(spell_pet_silverback);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_PET_GUARD_DOG_HAPPINESS });
    }

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        // Growl shares family flags with other spells
        // filter by spellIcon instead
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo || spellInfo->SpellIconID != PET_ICON_ID_GROWL)
            return false;

        return true;
    }

    void HandleProc(AuraEffect const* /* aurEff */, ProcEventInfo& eventInfo)
    {
        static uint32 const triggerSpell[2] = { SPELL_PET_SILVERBACK_RANK_1, SPELL_PET_SILVERBACK_RANK_2 };

        PreventDefaultAction();

        uint32 spellId = triggerSpell[GetSpellInfo()->GetRank() - 1];
        eventInfo.GetActor()->CastSpell((Unit*)nullptr, spellId, true);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pet_silverback::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_pet_silverback::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// -61680 - Culling the Herd
class spell_pet_culling_the_herd : public AuraScript
{
    PrepareAuraScript(spell_pet_culling_the_herd);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        // Claw, Bite and Smack share FamilyFlags with other spells
        // filter by spellIcon instead
        SpellInfo const* spellInfo = eventInfo.GetSpellInfo();
        if (!spellInfo)
            return false;

        switch (spellInfo->SpellIconID)
        {
            case PET_ICON_ID_CLAW:
            case PET_ICON_ID_BITE:
            case PET_ICON_ID_SMACK:
                break;
            default:
                return false;
        }

        return true;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_pet_culling_the_herd::CheckProc);
    }
};

void AddSC_hunter_pet_scripts()
{
    RegisterCreatureAI(npc_pet_hunter_snake_trap);
    RegisterSpellScript(spell_pet_charge);
    RegisterSpellScript(spell_pet_guard_dog);
    RegisterSpellScript(spell_pet_silverback);
    RegisterSpellScript(spell_pet_culling_the_herd);
}
