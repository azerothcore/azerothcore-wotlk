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

// Trash Waves
const Position NalorakkWay[8] =
{
    { 18.569f, 1414.512f, 11.42f}, // waypoint 1
    {-17.264f, 1419.551f, 12.62f},
    {-52.642f, 1419.357f, 27.31f}, // waypoint 2
    {-69.908f, 1419.721f, 27.31f},
    {-79.929f, 1395.958f, 27.31f},
    {-80.072f, 1374.555f, 40.87f}, // waypoint 3
    {-80.072f, 1314.398f, 40.87f},
    {-80.072f, 1295.775f, 48.60f} // waypoint 4
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
                    scheduler.Schedule(5s, [this](TaskContext context)
                    {
                        if (CheckFullyDeadGroup(_waveList))
                        {
                            scheduler.CancelAll();
                            _waveList.clear();
                            _phase = PHASE_SEND_GUARDS_2;
                            me->GetMotionMaster()->MovePoint(POINT_SECOND_RAMP, NalorakkWay[0]);
                            scheduler.Schedule(2s, [this](TaskContext)
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
                    scheduler.Schedule(5s, [this](TaskContext context)
                    {
                        if (CheckFullyDeadGroup(_waveList))
                        {
                            scheduler.CancelAll();
                            _waveList.clear();
                            _phase = PHASE_SEND_GUARDS_3;
                            me->GetMotionMaster()->MovePoint(POINT_THIRD_RAMP, NalorakkWay[2]);
                            scheduler.Schedule(2s, [this](TaskContext)
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
                    scheduler.Schedule(5s, [this](TaskContext context)
                    {
                        if (CheckFullyDeadGroup(_waveList))
                        {
                            scheduler.CancelAll();
                            _waveList.clear();
                            _phase = PHASE_SEND_GUARDS_4;
                            me->GetMotionMaster()->MovePoint(POINT_FOURTH_RAMP, NalorakkWay[5]);
                            scheduler.Schedule(2s, [this](TaskContext)
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
                    scheduler.Schedule(5s, [this](TaskContext context)
                    {
                        if (CheckFullyDeadGroup(_waveList))
                        {
                            scheduler.CancelAll();
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

    void GroupedAttack(std::list<Creature* > attackerList)
    {
        for (Creature* attacker : attackerList)
        {
            attacker->SetInCombatWithZone();
        }
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
    std::list<Creature *> _waveList;
};

void AddSC_boss_nalorakk()
{
    RegisterZulAmanCreatureAI(boss_nalorakk);
}
