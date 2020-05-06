/*
 * Originally written by Pussywizard - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "forge_of_souls.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "PassiveAI.h"

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

        void JustReachedHome()
        {
            me->CastSpell(me, SPELL_SOULSTORM_CHANNEL_OOC, true);
        }

        void Reset()
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            me->CastSpell(me, SPELL_SOULSTORM_CHANNEL_OOC, true);
            events.Reset();
            summons.DespawnAll();
            if (pInstance)
                pInstance->SetData(DATA_BRONJAHM, NOT_STARTED);
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
            me->RemoveAurasDueToSpell(SPELL_SOULSTORM_CHANNEL_OOC);

            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_SHADOW_BOLT, 2000);
            events.RescheduleEvent(EVENT_SPELL_MAGICS_BANE, urand(5000, 10000));
            events.RescheduleEvent(EVENT_SPELL_CORRUPT_SOUL, urand(14000, 20000));

            if (pInstance)
                pInstance->SetData(DATA_BRONJAHM, IN_PROGRESS);
        }

        void DamageTaken(Unit*, uint32& damage, DamageEffectType, SpellSchoolMask)
        {
            if (!me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE) && me->HealthBelowPctDamaged(35, damage))
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveIdle();
                me->CastSpell(me, SPELL_TELEPORT, false);
                events.CancelEvent(EVENT_SPELL_CORRUPT_SOUL);
                events.DelayEvents(6000);
                events.RescheduleEvent(EVENT_SPELL_FEAR, urand(8000, 14000));
            }
        }

        void SpellHitTarget(Unit*  /*target*/, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_TELEPORT)
            {
                me->CastSpell(me, SPELL_TELEPORT_VISUAL, true);
                events.RescheduleEvent(EVENT_START_SOULSTORM, 1);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE))
                if (me->isAttackReady())
                    me->SetFacingToObject(me->GetVictim());

            switch(events.GetEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_SHADOW_BOLT:
                    if (!me->IsWithinMeleeRange(me->GetVictim()))
                        me->CastSpell(me->GetVictim(), SPELL_SHADOW_BOLT, false);
                    events.RepeatEvent(2000);
                    break;
                case EVENT_SPELL_FEAR:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 10.0f, true))
                        me->CastCustomSpell(SPELL_FEAR, SPELLVALUE_MAX_TARGETS, 1, target, false);
                    events.RepeatEvent(urand(8000, 12000));
                    break;
                case EVENT_SPELL_MAGICS_BANE:
                    me->CastSpell(me->GetVictim(), SPELL_MAGICS_BANE, false);
                    events.RepeatEvent(urand(10000, 15000));
                    break;
                case EVENT_SPELL_CORRUPT_SOUL:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100.0f, true))
                    {
                        Talk(SAY_CORRUPT_SOUL);
                        me->CastSpell(target, SPELL_CORRUPT_SOUL, false);
                    }
                    events.RepeatEvent(urand(20000, 25000));
                    break;
                case EVENT_START_SOULSTORM:
                    Talk(SAY_SOUL_STORM);
                    me->CastSpell(me, SPELL_SOULSTORM, false);
                    me->CastSpell(me, SPELL_TELEPORT_VISUAL, true);
                    me->CastSpell(me, SPELL_SOULSTORM_VISUAL, true);
                    events.PopEvent();
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_BRONJAHM, DONE);
        }

        void KilledUnit(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
            summon->SetReactState(REACT_PASSIVE);
        }

        void EnterEvadeMode()
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
            ScriptedAI::EnterEvadeMode();
        }
    };

    CreatureAI *GetAI(Creature* creature) const
    {
        return new boss_bronjahmAI(creature);
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

        void Reset()
        {
            timer = 0;
        }

        void UpdateAI(uint32 diff)
        {
            if (pInstance)
                if (Creature* b = pInstance->instance->GetCreature(pInstance->GetData64(DATA_BRONJAHM)))
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

    CreatureAI *GetAI(Creature* creature) const
    {
        return new npc_fos_corrupted_soul_fragmentAI(creature);
    }
};


class spell_bronjahm_magic_bane : public SpellScriptLoader
{
public:
    spell_bronjahm_magic_bane() :  SpellScriptLoader("spell_bronjahm_magic_bane") { }

    class spell_bronjahm_magic_bane_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_bronjahm_magic_bane_SpellScript);

        void RecalculateDamage()
        {
            if (GetHitUnit()->getPowerType() != POWER_MANA)
                return;

            if (Unit* caster = GetCaster())
            {
                const int32 maxDamage = caster->GetMap()->GetSpawnMode() == 1 ? 15000 : 10000;
                int32 newDamage = GetHitDamage();
                newDamage += GetHitUnit()->GetMaxPower(POWER_MANA)/2;
                newDamage = std::min<int32>(maxDamage, newDamage);

                SetHitDamage(newDamage);
            }
        }

        void Register()
        {
            OnHit += SpellHitFn(spell_bronjahm_magic_bane_SpellScript::RecalculateDamage);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_bronjahm_magic_bane_SpellScript();
    }
};


class spell_bronjahm_soulstorm_channel_ooc : public SpellScriptLoader
{
public:
    spell_bronjahm_soulstorm_channel_ooc() : SpellScriptLoader("spell_bronjahm_soulstorm_channel_ooc") { }

    class spell_bronjahm_soulstorm_channel_ooc_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_bronjahm_soulstorm_channel_ooc_AuraScript);

        void HandlePeriodicTick(AuraEffect const* aurEff)
        {
            PreventDefaultAction();
            GetTarget()->CastSpell(GetTarget(), 68904+(aurEff->GetTickNumber()%4), true);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_bronjahm_soulstorm_channel_ooc_AuraScript::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_bronjahm_soulstorm_channel_ooc_AuraScript();
    }
};


class spell_bronjahm_soulstorm_visual : public SpellScriptLoader
{
public:
    spell_bronjahm_soulstorm_visual() : SpellScriptLoader("spell_bronjahm_soulstorm_visual") { }

    class spell_bronjahm_soulstorm_visual_AuraScript : public AuraScript
    {
        PrepareAuraScript(spell_bronjahm_soulstorm_visual_AuraScript);

        void HandlePeriodicTick(AuraEffect const* aurEff)
        {
            PreventDefaultAction();
            uint32 spellId = 0;
            switch (aurEff->GetTickNumber()%4)
            {
                case 0: spellId = 68886; break;
                case 1: spellId = 68896; break;
                case 2: spellId = 68897; break;
                case 3: spellId = 68898; break;
            }
            GetTarget()->CastSpell(GetTarget(), spellId, true);
        }

        void Register()
        {
            OnEffectPeriodic += AuraEffectPeriodicFn(spell_bronjahm_soulstorm_visual_AuraScript::HandlePeriodicTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        }
    };

    AuraScript* GetAuraScript() const
    {
        return new spell_bronjahm_soulstorm_visual_AuraScript();
    }
};


class spell_bronjahm_soulstorm_targeting : public SpellScriptLoader
{
public:
    spell_bronjahm_soulstorm_targeting() : SpellScriptLoader("spell_bronjahm_soulstorm_targeting") { }

    class spell_bronjahm_soulstorm_targeting_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_bronjahm_soulstorm_targeting_SpellScript);

        void FilterTargets(std::list<WorldObject*>& targets)
        {
            targets.remove_if(acore::AllWorldObjectsInExactRange(GetCaster(), 10.0f, false));
        }

        void Register()
        {
            OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_bronjahm_soulstorm_targeting_SpellScript::FilterTargets, EFFECT_ALL, TARGET_UNIT_DEST_AREA_ENEMY);
        }
    };

    SpellScript* GetSpellScript() const
    {
        return new spell_bronjahm_soulstorm_targeting_SpellScript();
    }
};


void AddSC_boss_bronjahm()
{
    new boss_bronjahm();
    new npc_fos_corrupted_soul_fragment();

    new spell_bronjahm_magic_bane();
    new spell_bronjahm_soulstorm_channel_ooc();
    new spell_bronjahm_soulstorm_visual();
    new spell_bronjahm_soulstorm_targeting();
}
