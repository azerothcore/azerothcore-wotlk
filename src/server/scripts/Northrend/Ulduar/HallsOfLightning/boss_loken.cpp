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
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellScript.h"
#include "SpellScriptLoader.h"
#include "halls_of_lightning.h"

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

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHallsOfLightningAI<boss_lokenAI>(creature);
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

        void MoveInLineOfSight(Unit*) override { }

        void Reset() override
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
                me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            }
            else
            {
                me->SetControlled(false, UNIT_STATE_STUNNED);
                me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            }
        }

        void JustEngagedWith(Unit*) override
        {
            me->SetInCombatWithZone();
            Talk(SAY_AGGRO);

            events.ScheduleEvent(EVENT_ARC_LIGHTNING, 10s);
            events.ScheduleEvent(EVENT_SHOCKWAVE, 3s);
            events.ScheduleEvent(EVENT_LIGHTNING_NOVA, 15s);

            if (m_pInstance)
            {
                m_pInstance->SetData(TYPE_LOKEN, IN_PROGRESS);

                if (me->GetMap()->IsHeroic())
                    m_pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEVEMENT_TIMELY_DEATH);
            }
        }

        void JustDied(Unit*) override
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
                    case 75:
                        Talk(SAY_75HEALTH);
                        break;
                    case 50:
                        Talk(SAY_50HEALTH);
                        break;
                    case 25:
                        Talk(SAY_25HEALTH);
                        break;
                }
            }
            else
                Talk(SAY_NOVA);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(SAY_SLAY);
        }

        void UpdateAI(uint32 diff) override
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
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);

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

            switch (events.ExecuteEvent())
            {
                case EVENT_CHECK_HEALTH:
                    if (HealthBelowPct(HealthCheck))
                    {
                        LokenSpeach(true);
                        HealthCheck -= 25;
                    }

                    events.Repeat(1s);
                    break;
                case EVENT_LIGHTNING_NOVA:
                    events.Repeat(15s);
                    me->CastSpell(me, SPELL_LIGHTNING_NOVA_VISUAL, true);
                    me->CastSpell(me, SPELL_LIGHTNING_NOVA_THUNDERS, true);

                    events.DelayEvents(5s);
                    events.ScheduleEvent(EVENT_AURA_REMOVE, me->GetMap()->IsHeroic() ? 4s : 5s);

                    me->CastSpell(me, me->GetMap()->IsHeroic() ? SPELL_LIGHTNING_NOVA_H : SPELL_LIGHTNING_NOVA_N, false);
                    break;
                case EVENT_SHOCKWAVE:
                    me->CastSpell(me, me->GetMap()->IsHeroic() ? SPELL_PULSING_SHOCKWAVE_H : SPELL_PULSING_SHOCKWAVE_N, false);
                    break;
                case EVENT_ARC_LIGHTNING:
                    if (Unit* target = SelectTargetFromPlayerList(100, SPELL_ARC_LIGHTNING))
                        me->CastSpell(target, SPELL_ARC_LIGHTNING, false);

                    events.Repeat(12s);
                    break;
                case EVENT_AURA_REMOVE:
                    me->RemoveAura(SPELL_LIGHTNING_NOVA_THUNDERS);
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

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_loken_pulsing_shockwave_SpellScript::CalculateDamage, EFFECT_0, SPELL_EFFECT_SCHOOL_DAMAGE);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_loken_pulsing_shockwave_SpellScript();
    }
};

void AddSC_boss_loken()
{
    new boss_loken();
    new spell_loken_pulsing_shockwave();
}
