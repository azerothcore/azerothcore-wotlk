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
#include "ScriptedCreature.h"
#include "oculus.h"
#include "SpellAuras.h"

enum Spells
{
    SPELL_ARCANE_BARRAGE_N                      = 50804,
    SPELL_ARCANE_BARRAGE_H                      = 59381,
    SPELL_ARCANE_VOLLEY_N                       = 51153,
    SPELL_ARCANE_VOLLEY_H                       = 59382,
    SPELL_ENRAGED_ASSAULT                       = 51170,
    SPELL_PLANAR_ANOMALIES                      = 57959,
    SPELL_PLANAR_SHIFT                          = 51162,

    SPELL_PLANAR_AURA_DAMAGE                    = 59379,
    SPELL_PLANAR_AURA_VISUAL                    = 57971,
    SPELL_PLANAR_BLAST                          = 57976,
    SPELL_SUMMON_PLANAR_ANOMALY                 = 57963,

    SPELL_DRAKE_STOP_TIME                       = 49838,
};

#define SPELL_ARCANE_BARRAGE                    DUNGEON_MODE(SPELL_ARCANE_BARRAGE_N, SPELL_ARCANE_BARRAGE_H)
#define SPELL_ARCANE_VOLLEY                     DUNGEON_MODE(SPELL_ARCANE_VOLLEY_N, SPELL_ARCANE_VOLLEY_H)

enum VarosNPCs
{
    NPC_LEY_GUARDIAN_WHELP                      = 28276,
    NPC_PLANAR_ANOMALY                          = 30879,
};

enum Events
{
    EVENT_SPELL_ARCANE_BARRAGE                  = 1,
    EVENT_SPELL_ARCANE_VOLLEY                   = 2,
    EVENT_SPELL_ENRAGED_ASSAULT                 = 3,
    EVENT_SPELL_PLANAR_SHIFT                    = 4,
    EVENT_SUMMON_WHELPS                         = 5,
    EVENT_SUMMON_SINGLE_WHELP                   = 6,
};

enum Says
{
    SAY_SPAWN           = 0,
    SAY_AGGRO           = 1,
    SAY_ENRAGE          = 2,
    SAY_KILL            = 3,
    SAY_DEATH           = 4,
    SAY_SHIELD          = 5,
};

class boss_eregos : public CreatureScript
{
public:
    boss_eregos() : CreatureScript("boss_eregos") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetOculusAI<boss_eregosAI>(pCreature);
    }

    struct boss_eregosAI : public ScriptedAI
    {
        boss_eregosAI(Creature* c) : ScriptedAI(c)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        uint8 shiftNumber;

        void Reset() override
        {
            if (pInstance)
            {
                pInstance->SetData(DATA_EREGOS, NOT_STARTED);
                if (pInstance->GetData(DATA_UROM) != DONE )
                    me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
                else
                    me->RemoveUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            }

            events.Reset();
        }

        void JustEngagedWith(Unit*  /*who*/) override
        {
            Talk(SAY_AGGRO);

            if (pInstance)
            {
                pInstance->SetData(DATA_EREGOS, IN_PROGRESS);

                if (me->FindNearestCreature(NPC_AMBER_DRAKE, 750.0f, true))
                    pInstance->SetData(DATA_AMBER_VOID, 0);
                else
                    pInstance->SetData(DATA_AMBER_VOID, 1);

                if (me->FindNearestCreature(NPC_EMERALD_DRAKE, 750.0f, true))
                    pInstance->SetData(DATA_EMERALD_VOID, 0);
                else
                    pInstance->SetData(DATA_EMERALD_VOID, 1);

                if (me->FindNearestCreature(NPC_RUBY_DRAKE, 750.0f, true))
                    pInstance->SetData(DATA_RUBY_VOID, 0);
                else
                    pInstance->SetData(DATA_RUBY_VOID, 1);
            }

            me->SetInCombatWithZone();

            shiftNumber = 0;

            events.RescheduleEvent(EVENT_SPELL_ARCANE_BARRAGE, 0ms);
            events.RescheduleEvent(EVENT_SPELL_ARCANE_VOLLEY, 5s);
            events.RescheduleEvent(EVENT_SPELL_ENRAGED_ASSAULT, 35s);
            events.RescheduleEvent(EVENT_SUMMON_WHELPS, 40s);
        }

        void JustDied(Unit*  /*killer*/) override
        {
            Talk(SAY_DEATH);

            if (pInstance)
                pInstance->SetData(DATA_EREGOS, DONE);

            me->SummonGameObject(GO_SPOTLIGHT, 1018.06f, 1051.09f, 605.619019f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);
        }

        void DamageTaken(Unit*, uint32& /*damage*/, DamageEffectType, SpellSchoolMask) override
        {
            if (!me->GetMap()->IsHeroic())
                return;

            if (shiftNumber <= uint32(1) && uint32(me->GetHealth() * 100 / me->GetMaxHealth()) <= uint32(60 - shiftNumber * 40))
            {
                ++shiftNumber;
                events.RescheduleEvent(EVENT_SPELL_PLANAR_SHIFT, 0ms);
            }
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            Talk(SAY_KILL);
        }

        void MoveInLineOfSight(Unit*  /*who*/) override {}

        void JustSummoned(Creature* pSummon) override
        {
            if (pSummon->GetEntry() != NPC_LEY_GUARDIAN_WHELP )
                return;

            DoZoneInCombat(pSummon, 300.0f);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (me->HasAura(SPELL_PLANAR_SHIFT) || me->HasAura(SPELL_DRAKE_STOP_TIME))
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            DoMeleeAttackIfReady();

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_ARCANE_BARRAGE:
                    if (Unit* v = me->GetVictim())
                        me->CastSpell(v, SPELL_ARCANE_BARRAGE, false);
                    events.Repeat(2500ms);
                    break;
                case EVENT_SPELL_ARCANE_VOLLEY:
                    me->CastSpell(me, SPELL_ARCANE_VOLLEY, false);
                    events.Repeat(8s);
                    break;
                case EVENT_SPELL_ENRAGED_ASSAULT:
                    Talk(SAY_ENRAGE);
                    me->CastSpell(me, SPELL_ENRAGED_ASSAULT, false);
                    events.Repeat(35s);
                    break;
                case EVENT_SUMMON_WHELPS:
                    for( uint8 i = 0; i < 5; ++i )
                        events.ScheduleEvent(EVENT_SUMMON_SINGLE_WHELP, urand(0, 8000));
                    events.Repeat(40s);
                    break;
                case EVENT_SUMMON_SINGLE_WHELP:
                    {
                        float x = rand_norm() * 50.0f - 25.0f;
                        float y = rand_norm() * 50.0f - 25.0f;
                        float z = rand_norm() * 50.0f - 25.0f;
                        me->SummonCreature(NPC_LEY_GUARDIAN_WHELP, me->GetPositionX() + x, me->GetPositionY() + y, me->GetPositionZ() + z, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    }
                    break;
                case EVENT_SPELL_PLANAR_SHIFT:
                    //me->Yell(TEXT_PLANAR_SHIFT_SAY, LANG_UNIVERSAL);
                    Talk(SAY_SHIELD);
                    me->CastSpell(me, SPELL_PLANAR_SHIFT, false);
                    for( uint8 i = 0; i < 3; ++i )
                        if (Unit* t = SelectTarget(SelectTargetMethod::Random, 0, 300.0f, false))
                            if (Creature* pa = me->SummonCreature(NPC_PLANAR_ANOMALY, *me, TEMPSUMMON_TIMED_DESPAWN, 17000))
                            {
                                pa->SetCanFly(true);
                                pa->SetDisableGravity(true);
                                pa->SendMovementFlagUpdate();
                                pa->CastSpell(pa, SPELL_PLANAR_AURA_VISUAL, true);
                                pa->CastSpell(pa, SPELL_PLANAR_AURA_DAMAGE, true);
                                if (Aura* a = pa->GetAura(SPELL_PLANAR_AURA_DAMAGE))
                                    a->SetDuration(15000);
                                if (pa->AI())
                                {
                                    pa->AI()->AttackStart(t);
                                    pa->GetMotionMaster()->MoveChase(t, 0.01f);
                                }
                            }
                    break;
            }
        }
    };
};

void AddSC_boss_eregos()
{
    new boss_eregos();
}
