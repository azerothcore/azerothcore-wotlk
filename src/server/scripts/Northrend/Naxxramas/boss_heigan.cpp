/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Player.h"
#include "ScriptMgr.h"
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
    SPELL_DECREPIT_FEVER_10         = 29998,
    SPELL_DECREPIT_FEVER_25         = 55011,
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

class boss_heigan : public CreatureScript
{
public:
    boss_heigan() : CreatureScript("boss_heigan") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_heiganAI>(pCreature);
    }

    struct boss_heiganAI : public BossAI
    {
        explicit boss_heiganAI(Creature* c) : BossAI(c, BOSS_HEIGAN)
        {
            pInstance = me->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        uint8 currentPhase{};
        uint8 currentSection{};
        bool moveRight{};

        void Reset() override
        {
            BossAI::Reset();
            events.Reset();
            currentPhase = 0;
            currentSection = 3;
            moveRight = true;
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_HEIGAN_ENTER_GATE)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(SAY_SLAY);
            if (pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            Talk(EMOTE_DEATH);
        }

        void EnterCombat(Unit* who) override
        {
            BossAI::EnterCombat(who);
            me->SetInCombatWithZone();
            Talk(SAY_AGGRO);
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_HEIGAN_ENTER_GATE)))
                {
                    go->SetGoState(GO_STATE_READY);
                }
            }
            StartFightPhase(PHASE_SLOW_DANCE);
        }

        void StartFightPhase(uint8 phase)
        {
            currentSection = 3;
            currentPhase = phase;
            events.Reset();
            if (phase == PHASE_SLOW_DANCE)
            {
                me->CastStop();
                me->SetReactState(REACT_AGGRESSIVE);
                DoZoneInCombat();
                events.ScheduleEvent(EVENT_DISRUPTION, urand(12000, 15000));
                events.ScheduleEvent(EVENT_DECEPIT_FEVER, 17000);
                events.ScheduleEvent(EVENT_ERUPT_SECTION, 15000);
                events.ScheduleEvent(EVENT_SWITCH_PHASE, 90000);
            }
            else // if (phase == PHASE_FAST_DANCE)
            {
                Talk(EMOTE_DANCE);
                Talk(SAY_DANCE);
                me->AttackStop();
                me->StopMoving();
                me->SetReactState(REACT_PASSIVE);
                me->CastSpell(me, SPELL_TELEPORT_SELF, false);
                me->SetFacingTo(2.40f);
                events.ScheduleEvent(EVENT_PLAGUE_CLOUD, 1000);
                events.ScheduleEvent(EVENT_ERUPT_SECTION, 7000);
                events.ScheduleEvent(EVENT_SWITCH_PHASE, 45000);
            }
            events.ScheduleEvent(EVENT_SAFETY_DANCE, 5000);
        }

        bool IsInRoom(Unit* who)
        {
            if (who->GetPositionX() > 2826 || who->GetPositionX() < 2723 || who->GetPositionY() > -3641 || who->GetPositionY() < -3736)
            {
                if (who->GetGUID() == me->GetGUID())
                    EnterEvadeMode();

                return false;
            }
            return true;
        }

        void UpdateAI(uint32 diff) override
        {
            if (!IsInRoom(me))
                return;

            if (!UpdateVictim())
                return;

            events.Update(diff);

            switch (events.ExecuteEvent())
            {
                case EVENT_DISRUPTION:
                    me->CastSpell(me, SPELL_SPELL_DISRUPTION, false);
                    events.RepeatEvent(10000);
                    break;
                case EVENT_DECEPIT_FEVER:
                    me->CastSpell(me, RAID_MODE(SPELL_DECREPIT_FEVER_10, SPELL_DECREPIT_FEVER_25), false);
                    events.RepeatEvent(urand(22000, 25000));
                    break;
                case EVENT_PLAGUE_CLOUD:
                    me->CastSpell(me, SPELL_PLAGUE_CLOUD, false);
                    break;
                case EVENT_SWITCH_PHASE:
                    if (currentPhase == PHASE_SLOW_DANCE)
                    {
                        StartFightPhase(PHASE_FAST_DANCE);
                    }
                    else
                    {
                        StartFightPhase(PHASE_SLOW_DANCE);
                        Talk(EMOTE_DANCE_END); // avoid play the emote on aggro
                    }
                    break;
                case EVENT_ERUPT_SECTION:
                    if (pInstance)
                    {
                        pInstance->SetData(DATA_HEIGAN_ERUPTION, currentSection);
                        if (currentSection == 3)
                        {
                            moveRight = false;
                        }
                        else if (currentSection == 0)
                        {
                            moveRight = true;
                        }
                        moveRight ? currentSection++ : currentSection--;
                    }
                    if (currentPhase == PHASE_SLOW_DANCE)
                    {
                        Talk(SAY_TAUNT);
                    }
                    events.RepeatEvent(currentPhase == PHASE_SLOW_DANCE ? 10000 : 4000);
                    break;
                case EVENT_SAFETY_DANCE:
                    {
                        Map::PlayerList const& pList = me->GetMap()->GetPlayers();
                        for (const auto& itr : pList)
                        {
                            if (IsInRoom(itr.GetSource()) && !itr.GetSource()->IsAlive())
                            {
                                pInstance->SetData(DATA_DANCE_FAIL, 0);
                                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
                                return;
                            }
                        }
                        events.RepeatEvent(5000);
                        return;
                    }
            }
            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_heigan()
{
    new boss_heigan();
}
