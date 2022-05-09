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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "blackrock_spire.h"

enum Spells
{
    SPELL_REND_MOUNTS               = 16167, // Change model
    SPELL_CORROSIVE_ACID            = 16359, // Combat (self cast)
    SPELL_FLAMEBREATH               = 16390, // Combat (Self cast)
    SPELL_FREEZE                    = 16350, // Combat (Self cast)
    SPELL_KNOCK_AWAY                = 10101, // Combat
    SPELL_SUMMON_REND               = 16328  // Summons Rend near death
};

enum Misc
{
    NEFARIUS_PATH_2                 = 1379671,
    NEFARIUS_PATH_3                 = 1379672,
    GYTH_PATH_1                     = 1379681,
};

enum Events
{
    EVENT_CORROSIVE_ACID            = 1,
    EVENT_FREEZE                    = 2,
    EVENT_FLAME_BREATH              = 3,
    EVENT_KNOCK_AWAY                = 4,
    EVENT_SUMMONED_1                = 5,
    EVENT_SUMMONED_2                = 6
};

class boss_gyth : public CreatureScript
{
public:
    boss_gyth() : CreatureScript("boss_gyth") { }

    struct boss_gythAI : public BossAI
    {
        boss_gythAI(Creature* creature) : BossAI(creature, DATA_GYTH) { }

        void Reset() override
        {
            _summonedRend = false;
            if (instance->GetBossState(DATA_GYTH) == IN_PROGRESS)
            {
                instance->SetBossState(DATA_GYTH, NOT_STARTED);
                summons.DespawnAll();
                me->DespawnOrUnsummon();
            }
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _EnterCombat();

            events.ScheduleEvent(EVENT_CORROSIVE_ACID, urand(8000, 16000));
            events.ScheduleEvent(EVENT_FREEZE, urand(8000, 16000));
            events.ScheduleEvent(EVENT_FLAME_BREATH, urand(8000, 16000));
            events.ScheduleEvent(EVENT_KNOCK_AWAY, urand(12000, 18000));
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            instance->SetBossState(DATA_WARCHIEF_REND_BLACKHAND, FAIL);
            BossAI::EnterEvadeMode(why);
        }

        void IsSummonedBy(Unit* /*summoner*/) override
        {
            events.ScheduleEvent(EVENT_SUMMONED_1, 1000);
        }

        void JustSummoned(Creature* summon) override
        {
            summons.Summon(summon);
            summon->AI()->AttackStart(me->SelectVictim());
        }

        // Prevent clearing summon list, otherwise Rend despawns if the drake is killed first.
        void JustDied(Unit* /*killer*/) override
        {
            instance->SetBossState(DATA_GYTH, DONE);
        }

        void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellSchoolMask /*school*/) override
        {
            if (!_summonedRend && me->HealthBelowPctDamaged(25, damage))
            {
                if (damage >= me->GetHealth())
                {
                    // Let creature fall to 1 HP but prevent it from dying before boss is summoned.
                    damage = me->GetHealth() - 1;
                }
                DoCast(me, SPELL_SUMMON_REND, true);
                me->RemoveAura(SPELL_REND_MOUNTS);
                _summonedRend = true;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_SUMMONED_1:
                            me->AddAura(SPELL_REND_MOUNTS, me);
                            if (GameObject* portcullis = me->FindNearestGameObject(GO_DR_PORTCULLIS, 40.0f))
                                portcullis->UseDoorOrButton();
                            events.ScheduleEvent(EVENT_SUMMONED_2, 2000);
                            break;
                        case EVENT_SUMMONED_2:
                            me->GetMotionMaster()->MovePath(GYTH_PATH_1, false);
                            break;
                        default:
                            break;
                    }
                }
                return;
            }

            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_CORROSIVE_ACID:
                        DoCast(me, SPELL_CORROSIVE_ACID);
                        events.ScheduleEvent(EVENT_CORROSIVE_ACID, urand(10000, 16000));
                        break;
                    case EVENT_FREEZE:
                        DoCast(me, SPELL_FREEZE);
                        events.ScheduleEvent(EVENT_FREEZE, urand(10000, 16000));
                        break;
                    case EVENT_FLAME_BREATH:
                        DoCast(me, SPELL_FLAMEBREATH);
                        events.ScheduleEvent(EVENT_FLAME_BREATH, urand(10000, 16000));
                        break;
                    case EVENT_KNOCK_AWAY:
                        DoCastVictim(SPELL_KNOCK_AWAY);
                        events.ScheduleEvent(EVENT_KNOCK_AWAY, urand(14000, 20000));
                        break;
                    default:
                        break;
                }
            }
            DoMeleeAttackIfReady();
        }

        private:
            bool _summonedRend;
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockSpireAI<boss_gythAI>(creature);
    }
};

void AddSC_boss_gyth()
{
    new boss_gyth();
}
