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

/* ScriptData
SDName: Boss_Nalorakk
SD%Complete: 100
SDComment:
SDCategory: Zul'Aman
EndScriptData */

#include "CellImpl.h"
#include "CreatureScript.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "ScriptedCreature.h"
#include "zulaman.h"

enum Spells
{
    SPELL_BERSERK           = 45078,

    // Troll form
    SPELL_BRUTALSWIPE       = 42384,
    SPELL_MANGLE            = 42389,
    SPELL_MANGLEEFFECT      = 44955,
    SPELL_SURGE             = 42402,
    SPELL_BEARFORM          = 42377,

    // Bear form
    SPELL_LACERATINGSLASH   = 42395,
    SPELL_RENDFLESH         = 42397,
    SPELL_DEAFENINGROAR     = 42398
};

enum Talks
{
    SAY_WAVE1 = 0,
    SAY_WAVE2,
    SAY_WAVE3,
    SAY_WAVE4,
    SAY_AGGRO,
    SAY_SURGE,
    SAY_SHIFTEDTOBEAR,
    SAY_SHIFTEDTOTROLL,
    SAY_BERSERK,
    SAY_KILL_ONE,
    SAY_KILL_TWO,
    SAY_DEATH,
    SAY_NALORAKK_EVENT1, // Not implemented
    SAY_NALORAKK_EVENT2 // Not implemented
};

enum Points
{
    POINT_FIRST_RAMP            = 0,
    POINT_SECOND_RAMP           = 1,
    POINT_THIRD_RAMP            = 2,
    POINT_FOURTH_RAMP           = 3,
    POINT_FIFTH_RAMP            = 4
};

enum Phases
{
    PHASE_SEND_GUARDS_1         = 0,
    PHASE_SEND_GUARDS_2         = 1,
    PHASE_SEND_GUARDS_3         = 2,
    PHASE_SEND_GUARDS_4         = 3,
    PHASE_SEND_GUARDS_5         = 4,
    PHASE_START_COMBAT          = 5
};

struct boss_nalorakk : public BossAI
{
    boss_nalorakk(Creature* creature) : BossAI(creature, DATA_NALORAKKEVENT)
    {
        _ranIntro = false;
        _active = true;
        creature->SetReactState(REACT_PASSIVE);
    }

    void Reset() override
    {
        BossAI::Reset();
        _waveList.clear();
        _introScheduler.CancelAll();
        if (_ranIntro)
        {
            _phase = PHASE_START_COMBAT;
            me->SetReactState(REACT_AGGRESSIVE);
            _active = false;
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (who->IsPlayer() && _phase < PHASE_START_COMBAT && _active)
        {
            _active = false;
            switch (_phase)
            {
                case PHASE_SEND_GUARDS_1:
                    me->GetCreaturesWithEntryInRange(_waveList, 10.0f, NPC_AMANISHI_AXE_THROWER);
                    me->GetCreaturesWithEntryInRange(_waveList, 10.0f, NPC_AMANISHI_TRIBESMAN);
                    GroupedAttack(_waveList);
                    Talk(SAY_WAVE1);
                    _introScheduler.Schedule(5s, [this](TaskContext context)
                    {
                        if (CheckFullyDeadGroup(_waveList))
                        {
                            _introScheduler.CancelAll();
                            _waveList.clear();
                            _phase = PHASE_SEND_GUARDS_2;
                            me->GetMotionMaster()->MovePath(me->GetEntry()*100+1, false);
                            _introScheduler.Schedule(4s, [this](TaskContext)
                            {
                                _active = true;
                            });
                        }
                        context.Repeat(5s);
                    });
                    break;
                case PHASE_SEND_GUARDS_2:
                    me->GetCreaturesWithEntryInRange(_waveList, 10.0f, NPC_AMANISHI_AXE_THROWER);
                    me->GetCreaturesWithEntryInRange(_waveList, 10.0f, NPC_AMANISHI_TRIBESMAN);
                    me->GetCreaturesWithEntryInRange(_waveList, 10.0f, NPC_AMANISHI_MEDICINE_MAN);
                    GroupedAttack(_waveList);
                    Talk(SAY_WAVE2);
                    _introScheduler.Schedule(5s, [this](TaskContext context)
                    {
                        if (CheckFullyDeadGroup(_waveList))
                        {
                            _introScheduler.CancelAll();
                            _waveList.clear();
                            _phase = PHASE_SEND_GUARDS_3;
                            me->GetMotionMaster()->MovePath(me->GetEntry()*100+2, false);
                            _introScheduler.Schedule(6s, [this](TaskContext)
                            {
                                _active = true;
                            });
                        }
                        context.Repeat(5s);
                    });
                    break;
                case PHASE_SEND_GUARDS_3:
                    me->GetCreaturesWithEntryInRange(_waveList, 10.0f, NPC_AMANISHI_WARBRINGER);
                    GroupedAttack(_waveList);
                    Talk(SAY_WAVE3);
                    _introScheduler.Schedule(5s, [this](TaskContext context)
                    {
                        if (CheckFullyDeadGroup(_waveList))
                        {
                            _introScheduler.CancelAll();
                            _waveList.clear();
                            _phase = PHASE_SEND_GUARDS_4;
                            me->GetMotionMaster()->MovePath(me->GetEntry()*100+3, false);
                            _introScheduler.Schedule(2s, [this](TaskContext)
                            {
                                _active = true;
                            });
                        }
                        context.Repeat(5s);
                    });
                    break;
                case PHASE_SEND_GUARDS_4:
                    me->GetCreaturesWithEntryInRange(_waveList, 10.0f, NPC_AMANISHI_WARBRINGER);
                    me->GetCreaturesWithEntryInRange(_waveList, 10.0f, NPC_AMANISHI_MEDICINE_MAN);
                    GroupedAttack(_waveList);
                    Talk(SAY_WAVE4);
                    _introScheduler.Schedule(5s, [this](TaskContext context)
                    {
                        if (CheckFullyDeadGroup(_waveList))
                        {
                            _introScheduler.CancelAll();
                            _waveList.clear();
                            _phase = PHASE_START_COMBAT;
                        }
                        context.Repeat(5s);
                    });
                    break;
            }
        }
        BossAI::MoveInLineOfSight(who);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
    }

    void GroupedAttack(std::list<Creature* > attackerList)
    {
        for (Creature* attacker : attackerList)
        {
            attacker->SetInCombatWithZone();
        }
    }

    void UpdateAI(uint32 diff) override
    {
        _introScheduler.Update(diff);
        BossAI::UpdateAI(diff);
    }

    bool CheckFullyDeadGroup(std::list<Creature* > groupToCheck)
    {
        for (Creature* member : groupToCheck)
        {
            if (member->IsAlive())
            {
                return false;
            }
        }
        return true;
    }
private:
    uint8 _phase;
    bool _ranIntro;
    bool _active;
    TaskScheduler _introScheduler;
    std::list<Creature *> _waveList;
};

void AddSC_boss_nalorakk()
{
    RegisterZulAmanCreatureAI(boss_nalorakk);
}
