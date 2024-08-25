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
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "forge_of_souls.h"

enum Yells
{
    SAY_AGGRO           = 0,
    SAY_SLAY            = 1,
    SAY_DEATH           = 2,
    SAY_SOUL_STORM      = 3,
    SAY_CORRUPT_SOUL    = 4,
};

enum eSpells
{
    SPELL_SOULSTORM_CHANNEL_OOC     = 69008,

    SPELL_SHADOW_BOLT               = 70043,
    SPELL_FEAR                      = 68950,
    SPELL_MAGICS_BANE               = 68793,
    SPELL_CORRUPT_SOUL              = 68839,
    SPELL_CONSUME_SOUL              = 68861,
    //SPELL_CONSUME_SOUL_HEAL       = 68858,

    SPELL_TELEPORT                  = 68988,
    SPELL_TELEPORT_VISUAL           = 52096,

    SPELL_SOULSTORM_VISUAL          = 68870,
    SPELL_SOULSTORM_VISUAL2         = 68904,
    SPELL_SOULSTORM                 = 68872,
};

enum eEvents
{
    EVENT_SPELL_SHADOW_BOLT = 1,
    EVENT_SPELL_FEAR,
    EVENT_SPELL_MAGICS_BANE,
    EVENT_SPELL_CORRUPT_SOUL,
    EVENT_START_SOULSTORM,
};

class boss_bronjahm : public CreatureScript
{
public:
    boss_bronjahm() : CreatureScript("boss_bronjahm") { }

    struct boss_bronjahmAI : public ScriptedAI
    {
        boss_bronjahmAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
            pInstance = creature->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        void JustReachedHome() override
        {
            me->CastSpell(me, SPELL_SOULSTORM_CHANNEL_OOC, true);
        }

        void Reset() override
        {
            me->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
            me->CastSpell(me, SPELL_SOULSTORM_CHANNEL_OOC, true);
            events.Reset();
            summons.DespawnAll();
            if (pInstance)
                pInstance->SetData(DATA_BRONJAHM, NOT_STARTED);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            me->RemoveAurasDueToSpell(SPELL_SOULSTORM_CHANNEL_OOC);

            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_SHADOW_BOLT, 2s);
            events.RescheduleEvent(EVENT_SPELL_MAGICS_BANE, 5s, 10s);
            events.RescheduleEvent(EVENT_SPELL_CORRUPT_SOUL, 14s, 20s);

            if (pInstance)
                pInstance->SetData(DATA_BRONJAHM, IN_PROGRESS);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask) override
        {
            if (!me->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE) && me->HealthBelowPctDamaged(35, damage))
            {
                me->SetUnitFlag(UNIT_FLAG_DISABLE_MOVE);
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveIdle();
                me->CastSpell(me, SPELL_TELEPORT, false);
                events.CancelEvent(EVENT_SPELL_CORRUPT_SOUL);
                events.DelayEvents(6000);
                events.RescheduleEvent(EVENT_SPELL_FEAR, 8s, 14s);
            }
        }

        void SpellHitTarget(Unit*  /*target*/, SpellInfo const* spell) override
        {
            if (spell->Id == SPELL_TELEPORT)
            {
                me->CastSpell(me, SPELL_TELEPORT_VISUAL, true);
                events.RescheduleEvent(EVENT_START_SOULSTORM, 1ms);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (me->HasUnitFlag(UNIT_FLAG_DISABLE_MOVE))
                if (me->isAttackReady())
                    me->SetFacingToObject(me->GetVictim());

            switch(events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_SHADOW_BOLT:
                    if (!me->IsWithinMeleeRange(me->GetVictim()))
                        me->CastSpell(me->GetVictim(), SPELL_SHADOW_BOLT, false);
                    events.Repeat(2s);
                    break;
                case EVENT_SPELL_FEAR:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 10.0f, true))
                        me->CastCustomSpell(SPELL_FEAR, SPELLVALUE_MAX_TARGETS, 1, target, false);
                    events.Repeat(8s, 12s);
                    break;
                case EVENT_SPELL_MAGICS_BANE:
                    me->CastSpell(me->GetVictim(), SPELL_MAGICS_BANE, false);
                    events.Repeat(10s, 15s);
                    break;
                case EVENT_SPELL_CORRUPT_SOUL:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 100.0f, true))
                    {
                        Talk(SAY_CORRUPT_SOUL);
                        me->CastSpell(target, SPELL_CORRUPT_SOUL, false);
                    }
                    events.Repeat(20s, 25s);
                    break;
                case EVENT_START_SOULSTORM:
                    Talk(SAY_SOUL_STORM);
                    me->CastSpell(me, SPELL_SOULSTORM, false);
                    me->CastSpell(me, SPELL_TELEPORT_VISUAL, true);
                    me->CastSpell(me, SPELL_SOULSTORM_VISUAL, true);

                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_BRONJAHM, DONE);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            summon->SetReactState(REACT_PASSIVE);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            me->RemoveUnitFlag(UNIT_FLAG_DISABLE_MOVE);
            ScriptedAI::EnterEvadeMode(why);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetForgeOfSoulsAI<boss_bronjahmAI>(creature);
    }
};

class npc_fos_corrupted_soul_fragment : public CreatureScript
{
public:
    npc_fos_corrupted_soul_fragment() : CreatureScript("npc_fos_corrupted_soul_fragment") { }

    struct npc_fos_corrupted_soul_fragmentAI : public NullCreatureAI
    {
        npc_fos_corrupted_soul_fragmentAI(Creature* creature) : NullCreatureAI(creature)
        {
            pInstance = me->GetInstanceScript();
        }

        uint32 timer;
        InstanceScript* pInstance;

        void Reset() override
        {
            timer = 0;
        }

        void UpdateAI(uint32 diff) override
        {
            if (pInstance)
                if (Creature* b = pInstance->instance->GetCreature(pInstance->GetGuidData(DATA_BRONJAHM)))
                {
                    if (me->GetExactDist2d(b) <= 2.0f)
                    {
                        me->GetMotionMaster()->MoveIdle();
                        me->CastSpell(b, SPELL_CONSUME_SOUL, true);
                        me->DespawnOrUnsummon(1);
                        return;
                    }

                    if (timer <= diff)
                    {
                        if (!me->HasUnitState(UNIT_STATE_ROOT | UNIT_STATE_STUNNED))
                            me->GetMotionMaster()->MovePoint(0, *b);
                        timer = 1000;
                    }
                    else
                        timer -= diff;
                }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetForgeOfSoulsAI<npc_fos_corrupted_soul_fragmentAI>(creature);
    }
};

class spell_bronjahm_magic_bane : public SpellScript
{
    PrepareSpellScript(spell_bronjahm_magic_bane);

    void RecalculateDamage()
    {
        if (GetHitUnit()->getPowerType() != POWER_MANA)
            return;

        if (Unit* caster = GetCaster())
        {
            const int32 maxDamage = caster->GetMap()->GetSpawnMode() == 1 ? 15000 : 10000;
            int32 newDamage = GetHitDamage();
            newDamage += GetHitUnit()->GetMaxPower(POWER_MANA) / 2;
            newDamage = std::min<int32>(maxDamage, newDamage);

            SetHitDamage(newDamage);
        }
    }

    void Register() override
    {
        OnHit += SpellHitFn(spell_bronjahm_magic_bane::RecalculateDamage);
    }
};

class spell_bronjahm_soulstorm_channel_ooc_aura : public AuraScript
{
    PrepareAuraScript(spell_bronjahm_soulstorm_channel_ooc_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ SPELL_SOULSTORM_VISUAL2, SPELL_SOULSTORM_VISUAL2+1, SPELL_SOULSTORM_VISUAL2+2, SPELL_SOULSTORM_VISUAL2+3 });
    }

    void HandlePeriodicTick(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), SPELL_SOULSTORM_VISUAL2 + (aurEff->GetTickNumber() % 4), true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_bronjahm_soulstorm_channel_ooc_aura::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_bronjahm_soulstorm_visual_aura : public AuraScript
{
    PrepareAuraScript(spell_bronjahm_soulstorm_visual_aura);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return ValidateSpellInfo({ 68886, 68896, 68897, 68898 });
    }

    void HandlePeriodicTick(AuraEffect const* aurEff)
    {
        PreventDefaultAction();
        uint32 spellId = 0;
        switch (aurEff->GetTickNumber() % 4)
        {
            case 0:
                spellId = 68886;
                break;
            case 1:
                spellId = 68896;
                break;
            case 2:
                spellId = 68897;
                break;
            case 3:
                spellId = 68898;
                break;
        }
        GetTarget()->CastSpell(GetTarget(), spellId, true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_bronjahm_soulstorm_visual_aura::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

class spell_bronjahm_soulstorm_targeting : public SpellScript
{
    PrepareSpellScript(spell_bronjahm_soulstorm_targeting);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove_if(Acore::AllWorldObjectsInExactRange(GetCaster(), 10.0f, false));
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_bronjahm_soulstorm_targeting::FilterTargets, EFFECT_ALL, TARGET_UNIT_DEST_AREA_ENEMY);
    }
};

void AddSC_boss_bronjahm()
{
    new boss_bronjahm();
    new npc_fos_corrupted_soul_fragment();

    RegisterSpellScript(spell_bronjahm_magic_bane);
    RegisterSpellScript(spell_bronjahm_soulstorm_channel_ooc_aura);
    RegisterSpellScript(spell_bronjahm_soulstorm_visual_aura);
    RegisterSpellScript(spell_bronjahm_soulstorm_targeting);
}
