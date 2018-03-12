/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "halls_of_lightning.h"
#include "Player.h"

enum LokenSpells
{
    SPELL_ARC_LIGHTNING             = 52921,
    SPELL_LIGHTNING_NOVA_N          = 52960,
    SPELL_LIGHTNING_NOVA_H          = 59835,
    SPELL_LIGHTNING_NOVA_VISUAL     = 56502,
    SPELL_LIGHTNING_NOVA_THUNDERS   = 52663,

    SPELL_PULSING_SHOCKWAVE_N       = 52961,
    SPELL_PULSING_SHOCKWAVE_H       = 59836,

    // Achievement
    ACHIEVEMENT_TIMELY_DEATH        = 20384
};

enum Yells
{
    SAY_INTRO_1                     = 0,
    SAY_INTRO_2                     = 1,
    SAY_AGGRO                       = 2,
    SAY_NOVA                        = 3,
    SAY_SLAY                        = 4,
    SAY_75HEALTH                    = 5,
    SAY_50HEALTH                    = 6,
    SAY_25HEALTH                    = 7,
    SAY_DEATH                       = 8,
    EMOTE_NOVA                      = 9
};

enum LokenEvents
{
    EVENT_LIGHTNING_NOVA            = 1,
    EVENT_SHOCKWAVE                 = 2,
    EVENT_ARC_LIGHTNING             = 3,
    EVENT_CHECK_HEALTH              = 4,
    EVENT_AURA_REMOVE               = 5
};

class boss_loken : public CreatureScript
{
public:
    boss_loken() : CreatureScript("boss_loken") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_lokenAI (creature);
    }

    struct boss_lokenAI : public ScriptedAI
    {
        boss_lokenAI(Creature* creature) : ScriptedAI(creature)
        {
            m_pInstance = creature->GetInstanceScript();
            if (m_pInstance)
                isActive = m_pInstance->GetData(TYPE_LOKEN_INTRO);
        }

        InstanceScript* m_pInstance;
        EventMap events;

        bool isActive;
        uint32 IntroTimer;
        uint8 HealthCheck;

        void MoveInLineOfSight(Unit*) { }

        void Reset()
        {
            events.Reset();
            if (m_pInstance)
            {
                m_pInstance->DoStopTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEVEMENT_TIMELY_DEATH);
                m_pInstance->SetData(TYPE_LOKEN, NOT_STARTED);
            }

            HealthCheck = 75;
            IntroTimer = 0;
            me->RemoveAllAuras();

            if (!isActive)
            {
                me->SetControlled(true, UNIT_STATE_STUNNED);
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }
            else
            {
                me->SetControlled(false, UNIT_STATE_STUNNED);
                me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            }
        }

        void EnterCombat(Unit*)
        {
            me->SetInCombatWithZone();
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_ARC_LIGHTNING, 10000);
            events.ScheduleEvent(EVENT_SHOCKWAVE, 3000);
            events.ScheduleEvent(EVENT_LIGHTNING_NOVA, 15000);

            if (m_pInstance)
            {
                m_pInstance->SetData(TYPE_LOKEN, IN_PROGRESS);

                if (me->GetMap()->IsHeroic())
                    m_pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEVEMENT_TIMELY_DEATH);
            }
        }

        void JustDied(Unit*)
        {
            Talk(SAY_DEATH);

            if (m_pInstance)
                m_pInstance->SetData(TYPE_LOKEN, DONE);
        }

        void LokenSpeach(bool hp)
        {
            if (hp)
            {
                switch(HealthCheck)
                {
                    case 75: Talk(SAY_75HEALTH); break;
                    case 50: Talk(SAY_50HEALTH); break;
                    case 25: Talk(SAY_25HEALTH); break;
                }
            }
            else
                Talk(SAY_NOVA);
        }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(SAY_SLAY);
        }

        void UpdateAI(uint32 diff)
        {
            if (!isActive)
            {
                IntroTimer += diff;
                if (IntroTimer > 5000 && IntroTimer < 10000)
                {
                    if (SelectTargetFromPlayerList(60))
                    {
                        Talk(SAY_INTRO_1);
                        IntroTimer = 10000;
                    }
                    else
                        IntroTimer = 0;
                }

                if (IntroTimer >= 30000 && IntroTimer < 40000)
                {
                    Talk(SAY_INTRO_2);
                    IntroTimer = 40000;
                }
                if (IntroTimer >= 60000)
                {
                    isActive = true;
                    if (m_pInstance)
                        m_pInstance->SetData(TYPE_LOKEN_INTRO, 1);

                    me->SetControlled(false, UNIT_STATE_STUNNED);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    
                    if (Player* target = SelectTargetFromPlayerList(80))
                        AttackStart(target);
                }

                return;
            }

            //Return since we have no target
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_CHECK_HEALTH:
                    if (HealthBelowPct(HealthCheck))
                    {
                        LokenSpeach(true);
                        HealthCheck -= 25;
                    }

                    events.RepeatEvent(1000);
                    break;
                case EVENT_LIGHTNING_NOVA:
                    events.RepeatEvent(15000);
                    me->CastSpell(me, SPELL_LIGHTNING_NOVA_VISUAL, true);
                    me->CastSpell(me, SPELL_LIGHTNING_NOVA_THUNDERS, true);

                    events.DelayEvents(5001);
                    events.ScheduleEvent(EVENT_AURA_REMOVE, me->GetMap()->IsHeroic() ? 4000 : 5000);

                    me->CastSpell(me, me->GetMap()->IsHeroic() ? SPELL_LIGHTNING_NOVA_H : SPELL_LIGHTNING_NOVA_N, false);
                    break;
                case EVENT_SHOCKWAVE:
                    me->CastSpell(me, me->GetMap()->IsHeroic() ? SPELL_PULSING_SHOCKWAVE_H : SPELL_PULSING_SHOCKWAVE_N, false);
                    events.PopEvent();
                    break;
                case EVENT_ARC_LIGHTNING:
                    if (Unit* target = SelectTargetFromPlayerList(100, SPELL_ARC_LIGHTNING))
                        me->CastSpell(target, SPELL_ARC_LIGHTNING, false);

                    events.RepeatEvent(12000);
                    break;
                case EVENT_AURA_REMOVE:
                    me->RemoveAura(SPELL_LIGHTNING_NOVA_THUNDERS);
                    events.PopEvent();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class spell_loken_pulsing_shockwave : public SpellScriptLoader
{
    public:
        spell_loken_pulsing_shockwave() : SpellScriptLoader("spell_loken_pulsing_shockwave") { }

        class spell_loken_pulsing_shockwave_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_loken_pulsing_shockwave_SpellScript);

            void CalculateDamage(SpellEffIndex /*effIndex*/)
            {
                if (!GetHitUnit())
                    return;

                float distance = GetCaster()->GetDistance2d(GetHitUnit());
                if (distance > 1.0f)
                    SetHitDamage(int32(GetHitDamage() * distance));
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_loken_pulsing_shockwave_SpellScript::CalculateDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_loken_pulsing_shockwave_SpellScript();
        }
};

void AddSC_boss_loken()
{
    new boss_loken();
    new spell_loken_pulsing_shockwave();
}
