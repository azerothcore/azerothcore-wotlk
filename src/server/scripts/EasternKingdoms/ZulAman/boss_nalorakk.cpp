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
    SAY_NALORAKK_EVENT2, // Not implemented
    SAY_RUN_AWAY,
    EMOTE_BEAR
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

enum NalorakkGroups
{
    GROUP_CHECK_DEAD            = 1,
    GROUP_CHECK_EVADE           = 2,
    GROUP_MOVE                  = 3,
    GROUP_BERSERK               = 4,
    GROUP_HUMAN                 = 5,
    GROUP_BEAR                  = 6
};

struct boss_nalorakk : public BossAI
{
    boss_nalorakk(Creature* creature) : BossAI(creature, DATA_NALORAKK)
    {
        _phase = PHASE_SEND_GUARDS_1;
        _ranIntro = false;
        _active = true;
        creature->SetReactState(REACT_PASSIVE);
        me->SetImmuneToAll(true);
    }

    void Reset() override
    {
        BossAI::Reset();
        _waveList.clear();
        _introScheduler.CancelAll();
        if (_bearForm)
        {
            me->RemoveAurasDueToSpell(SPELL_BEARFORM);
            _bearForm = false;
        }
        if (_ranIntro)
        {
            _phase = PHASE_START_COMBAT;
            me->SetReactState(REACT_AGGRESSIVE);
            _active = false;
        }
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (who->IsPlayer() && !who->ToPlayer()->IsGameMaster() && _phase < PHASE_START_COMBAT && _active)
        {
            _active = false;
            switch (_phase)
            {
                case PHASE_SEND_GUARDS_1:
                    me->GetCreaturesWithEntryInRange(_waveList, 10.0f, NPC_AMANISHI_AXE_THROWER);
                    me->GetCreaturesWithEntryInRange(_waveList, 10.0f, NPC_AMANISHI_TRIBESMAN);
                    GroupedAttack(_waveList);
                    Talk(SAY_WAVE1);
                    _introScheduler.Schedule(5s, GROUP_CHECK_DEAD, [this](TaskContext context)
                    {
                        if (CheckFullyDeadGroup(_waveList))
                            if (_phase == PHASE_SEND_GUARDS_1)
                            {
                                _introScheduler.CancelGroup(GROUP_CHECK_DEAD);
                                _waveList.clear();
                                me->GetMotionMaster()->MovePath(me->GetEntry()*100+1, false);
                                Talk(SAY_RUN_AWAY);
                                _introScheduler.Schedule(5s, [this](TaskContext)
                                {
                                    me->SetFacingTo(6.25f);
                                    _active = true;
                                });
                                _phase = PHASE_SEND_GUARDS_2;
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
                    _introScheduler.Schedule(5s, GROUP_CHECK_DEAD, [this](TaskContext context)
                    {
                        if (CheckFullyDeadGroup(_waveList))
                            if (_phase == PHASE_SEND_GUARDS_2)
                            {
                                _introScheduler.CancelGroup(GROUP_CHECK_DEAD);
                                _waveList.clear();
                                Talk(SAY_RUN_AWAY);
                                me->GetMotionMaster()->MovePath(me->GetEntry()*100+2, false);
                                _introScheduler.Schedule(6s, [this](TaskContext)
                                {
                                    me->SetFacingTo(1.54f);
                                    _active = true;
                                });
                                _phase = PHASE_SEND_GUARDS_3;
                            }
                        context.Repeat(5s);
                    });
                    break;
                case PHASE_SEND_GUARDS_3:
                    me->GetCreaturesWithEntryInRange(_waveList, 10.0f, NPC_AMANISHI_WARBRINGER);
                    GroupedAttack(_waveList);
                    Talk(SAY_WAVE3);
                    _introScheduler.Schedule(5s, GROUP_CHECK_DEAD, [this](TaskContext context)
                    {
                        if (CheckFullyDeadGroup(_waveList))
                            if (_phase == PHASE_SEND_GUARDS_3)
                            {
                                _introScheduler.CancelGroup(GROUP_CHECK_DEAD);
                                _waveList.clear();
                                Talk(SAY_RUN_AWAY);
                                me->GetMotionMaster()->MovePath(me->GetEntry() * 100 + 3, false);
                                _introScheduler.Schedule(6s, [this](TaskContext)
                                {
                                    me->SetFacingTo(1.54f);
                                    _active = true;
                                });
                                _phase = PHASE_SEND_GUARDS_4;
                            }
                        context.Repeat(5s);
                    });
                    break;
                case PHASE_SEND_GUARDS_4:
                    me->GetCreaturesWithEntryInRange(_waveList, 25.0f, NPC_AMANISHI_WARBRINGER);
                    me->GetCreaturesWithEntryInRange(_waveList, 25.0f, NPC_AMANISHI_MEDICINE_MAN);
                    GroupedAttack(_waveList);
                    Talk(SAY_WAVE4);
                    _waveList.clear();
                    _phase = PHASE_START_COMBAT;
                    _ranIntro = true;
                    me->SetImmuneToAll(false);
                    me->SetReactState(REACT_AGGRESSIVE);
                    me->SetHomePosition(me->GetPosition());
                    break;
            }
            _introScheduler.Schedule(10s, GROUP_CHECK_EVADE, [this](TaskContext context)
            {
                if (CheckAnyEvadeGroup(_waveList))
                {
                    _introScheduler.CancelGroup(GROUP_CHECK_DEAD);
                    _introScheduler.Schedule(5s, GROUP_CHECK_EVADE, [this](TaskContext context)
                    {
                        for (Creature* member : _waveList)
                            if (member->isMoving())
                            {
                                context.Repeat(1s);
                                return;
                            }
                        _active = true;
                    });
                }
                else
                    context.Repeat(10s);
            });
        }
        BossAI::MoveInLineOfSight(who);
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        Talk(SAY_AGGRO);
        scheduler.Schedule(15s, 20s, GROUP_HUMAN, [this](TaskContext context)
        {
            Talk(SAY_SURGE);
            DoCastRandomTarget(SPELL_SURGE, 0, 45.0f, false, false, false);
            context.Repeat();
        }).Schedule(15s, 25s, GROUP_HUMAN, [this](TaskContext context)
        {
            DoCastVictim(SPELL_BRUTALSWIPE);
            context.Repeat();
        }).Schedule(6s, 34s, GROUP_HUMAN, [this](TaskContext context)
        {
            if (me->GetVictim() && !me->GetVictim()->HasAura(SPELL_MANGLE))
            {
                DoCastVictim(SPELL_MANGLE);
                context.Repeat(1s);
            }
            else
                context.Repeat();
        }).Schedule(10min, GROUP_BERSERK, [this](TaskContext)
        {
            Talk(SAY_BERSERK);
            DoCastSelf(SPELL_BERSERK, true);
        }).Schedule(45s, 50s, GROUP_HUMAN, [this](TaskContext)
        {
            ShapeShift(_bearForm);
        });
    }

    void ShapeShift(bool currentlyInBearForm)
    {
        if (currentlyInBearForm)
        {
            Talk(SAY_SHIFTEDTOTROLL);
            scheduler.CancelGroup(GROUP_BEAR);
            _bearForm = false;

            me->SetCanDualWield(true);

            scheduler.Schedule(15s, 20s, GROUP_HUMAN, [this](TaskContext context)
            {
                Talk(SAY_SURGE);
                DoCastRandomTarget(SPELL_SURGE, 0, 45.0f, false, false, false);
                context.Repeat();
            }).Schedule(15s, 25s, GROUP_HUMAN, [this](TaskContext context)
            {
                DoCastVictim(SPELL_BRUTALSWIPE);
                context.Repeat();
            }).Schedule(6s, 34s, GROUP_HUMAN, [this](TaskContext context)
            {
                DoCastVictim(SPELL_MANGLE);
                context.Repeat();
            }).Schedule(10min, GROUP_BERSERK, [this](TaskContext)
            {
                Talk(SAY_BERSERK);
                DoCastSelf(SPELL_BERSERK, true);
            }).Schedule(45s, 50s, GROUP_HUMAN, [this](TaskContext)
            {
                ShapeShift(_bearForm);
            });
        }
        else
        {
            Talk(SAY_SHIFTEDTOBEAR);
            Talk(EMOTE_BEAR);
            DoCastSelf(SPELL_BEARFORM, true);
            scheduler.CancelGroup(GROUP_HUMAN);
            _bearForm = true;

            me->SetCanDualWield(false);

            scheduler.Schedule(4s, 26s, GROUP_BEAR, [this](TaskContext context)
            {
                DoCastVictim(SPELL_LACERATINGSLASH);
                context.Repeat(4s, 26s);
            }).Schedule(6s, 21s, GROUP_BEAR, [this](TaskContext context)
            {
                DoCastVictim(SPELL_RENDFLESH);
                context.Repeat(6s, 21s);
            }).Schedule(11s, 24s, GROUP_BEAR, [this](TaskContext context)
            {
                DoCastSelf(SPELL_DEAFENINGROAR);
                context.Repeat(11s, 24s);
            }).Schedule(30s, GROUP_BEAR, [this](TaskContext)
            {
                ShapeShift(_bearForm);
            });
        }
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

    bool CheckFullyDeadGroup(std::list<Creature*> groupToCheck)
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

    bool CheckAnyEvadeGroup(std::list<Creature*> groupToCheck)
    {
        for (Creature* member : groupToCheck)
            if (member->IsAlive() && !member->IsInCombat())
                return true;
        return false;
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }

private:
    uint8 _phase;
    bool _ranIntro;
    bool _active;
    bool _bearForm;
    TaskScheduler _introScheduler;
    std::list<Creature *> _waveList;
};

void AddSC_boss_nalorakk()
{
    RegisterZulAmanCreatureAI(boss_nalorakk);
}
