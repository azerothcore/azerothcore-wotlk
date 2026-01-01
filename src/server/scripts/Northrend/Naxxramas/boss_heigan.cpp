/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_SLAY                        = 1,
    SAY_TAUNT                       = 2,
    EMOTE_DEATH                     = 3,
    EMOTE_DANCE                     = 4,
    EMOTE_DANCE_END                 = 5,
    SAY_DANCE                       = 6
};

enum Spells
{
    SPELL_SPELL_DISRUPTION          = 29310,
    SPELL_DECREPIT_FEVER            = 29998,
    SPELL_PLAGUE_CLOUD              = 29350,
    SPELL_TELEPORT_SELF             = 30211
};

enum Events
{
    EVENT_DISRUPTION                = 1,
    EVENT_DECEPIT_FEVER             = 2,
    EVENT_ERUPT_SECTION             = 3,
    EVENT_SWITCH_PHASE              = 4,
    EVENT_SAFETY_DANCE              = 5,
    EVENT_PLAGUE_CLOUD              = 6
};

enum Misc
{
    PHASE_SLOW_DANCE                = 0,
    PHASE_FAST_DANCE                = 1
};

float const heiganFastDanceFaceDirection = 2.40f;

struct boss_heigan : public BossAI
{
    boss_heigan(Creature* creature) : BossAI(creature, BOSS_HEIGAN) { }

    void Reset() override
    {
        BossAI::Reset();
        _currentPhase = 0;
        _currentSection = 3;
        _moveRight = true;
        _eruptionScheduler.CancelAll();
    }

    void KilledUnit(Unit* who) override
    {
        if (!who->IsPlayer())
            return;

        Talk(SAY_SLAY);
        instance->StorePersistentData(PERSISTENT_DATA_IMMORTAL_FAIL, 1);
    }

    void JustDied(Unit*  killer) override
    {
        _eruptionScheduler.CancelAll();
        BossAI::JustDied(killer);
        Talk(EMOTE_DEATH);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        me->SetInCombatWithZone();
        Talk(SAY_AGGRO);
        StartFightPhase(PHASE_SLOW_DANCE);
    }

    void StartFightPhase(uint8 phase)
    {
        _currentSection = 3;
        _currentPhase = phase;
        scheduler.CancelAll();
        _eruptionScheduler.CancelAll();
        if (phase == PHASE_SLOW_DANCE)
        {
            me->CastStop();
            me->SetReactState(REACT_AGGRESSIVE);
            DoZoneInCombat();
            ScheduleTimedEvent(12s, 15s, [&] {
                DoCastSelf(SPELL_SPELL_DISRUPTION);
            }, 10s);
            ScheduleTimedEvent(17s, [&] {
                DoCastSelf(SPELL_DECREPIT_FEVER);
            }, 22s, 25s);
            _eruptionScheduler.Schedule(15s, [this](TaskContext context){
                instance->SetData(DATA_HEIGAN_ERUPTION, _currentSection);
                if (_currentSection == 3)
                    _moveRight = false;
                else if (_currentSection == 0)
                    _moveRight = true;

                _moveRight ? _currentSection++ : _currentSection--;
                Talk(SAY_TAUNT);
                context.Repeat(10s);
            }).Schedule(90s, [this](TaskContext /*context*/) {
                StartFightPhase(PHASE_FAST_DANCE);
            });
        }
        else // if (phase == PHASE_FAST_DANCE)
        {
            Talk(EMOTE_DANCE);
            Talk(SAY_DANCE);
            me->AttackStop();
            me->StopMoving();
            me->SetReactState(REACT_PASSIVE);
            me->CastSpell(me, SPELL_TELEPORT_SELF, false);
            me->SetFacingTo(heiganFastDanceFaceDirection);
            scheduler.Schedule(1s, [this](TaskContext /*context*/) {
                DoCastSelf(SPELL_PLAGUE_CLOUD);
            });
            _eruptionScheduler.Schedule(7s, [this](TaskContext context){
                instance->SetData(DATA_HEIGAN_ERUPTION, _currentSection);
                if (_currentSection == 3)
                    _moveRight = false;
                else if (_currentSection == 0)
                    _moveRight = true;

                _moveRight ? _currentSection++ : _currentSection--;
                context.Repeat(4s);
            }).Schedule(45s, [this](TaskContext /*context*/) {
                StartFightPhase(PHASE_SLOW_DANCE);
                Talk(EMOTE_DANCE_END); // avoid play the emote on aggro
            });
        }
        ScheduleTimedEvent(5s, [&] {
            CheckSafetyDance();
        }, 5s);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        _eruptionScheduler.Update(diff);

        BossAI::UpdateAI(diff);
    }

    void CheckSafetyDance()
    {
        if (Map* map = me->GetMap())
        {
            map->DoForAllPlayers([&](Player* p)
            {
                if (IsInBoundary(p) && !p->IsAlive())
                {
                    instance->SetData(DATA_DANCE_FAIL, 0);
                    instance->StorePersistentData(PERSISTENT_DATA_IMMORTAL_FAIL, 1);
                    return;
                }
            });
        }
    }
private:
    uint8 _currentPhase{};
    uint8 _currentSection{};
    bool _moveRight{true};
    TaskScheduler _eruptionScheduler;
};

void AddSC_boss_heigan()
{
    RegisterNaxxramasCreatureAI(boss_heigan);
}
