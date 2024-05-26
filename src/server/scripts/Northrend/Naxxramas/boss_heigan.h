#ifndef BOSS_HEIGAN_H_
#define BOSS_HEIGAN_H_

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"

namespace Heigan {

enum HeiganSays
{
    HEIGAN_SAY_AGGRO                       = 0,
    HEIGAN_SAY_SLAY                        = 1,
    HEIGAN_SAY_TAUNT                       = 2,
    HEIGAN_EMOTE_DEATH                     = 3,
    HEIGAN_EMOTE_DANCE                     = 4,
    HEIGAN_EMOTE_DANCE_END                 = 5,
    HEIGAN_SAY_DANCE                       = 6
};

enum HeiganSpells
{
    HEIGAN_SPELL_SPELL_DISRUPTION          = 29310,
    HEIGAN_SPELL_DECREPIT_FEVER_10         = 29998,
    HEIGAN_SPELL_DECREPIT_FEVER_25         = 55011,
    HEIGAN_SPELL_PLAGUE_CLOUD              = 29350,
    HEIGAN_SPELL_TELEPORT_SELF             = 30211
};

enum HeiganEvents
{
    HEIGAN_EVENT_DISRUPTION                = 1,
    HEIGAN_EVENT_DECEPIT_FEVER             = 2,
    HEIGAN_EVENT_ERUPT_SECTION             = 3,
    HEIGAN_EVENT_SWITCH_PHASE              = 4,
    HEIGAN_EVENT_SAFETY_DANCE              = 5,
    HEIGAN_EVENT_PLAGUE_CLOUD              = 6
};

enum HeiganMisc
{
    HEIGAN_PHASE_SLOW_DANCE                = 0,
    HEIGAN_PHASE_FAST_DANCE                = 1
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

            Talk(HEIGAN_SAY_SLAY);
            if (pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            Talk(HEIGAN_EMOTE_DEATH);
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            me->SetInCombatWithZone();
            Talk(HEIGAN_SAY_AGGRO);
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_HEIGAN_ENTER_GATE)))
                {
                    go->SetGoState(GO_STATE_READY);
                }
            }
            StartFightPhase(HEIGAN_PHASE_SLOW_DANCE);
        }

        void StartFightPhase(uint8 phase)
        {
            currentSection = 3;
            currentPhase = phase;
            events.Reset();
            if (phase == HEIGAN_PHASE_SLOW_DANCE)
            {
                me->CastStop();
                me->SetReactState(REACT_AGGRESSIVE);
                DoZoneInCombat();
                events.ScheduleEvent(HEIGAN_EVENT_DISRUPTION, 12s, 15s);
                events.ScheduleEvent(HEIGAN_EVENT_DECEPIT_FEVER, 17s);
                events.ScheduleEvent(HEIGAN_EVENT_ERUPT_SECTION, 15s);
                events.ScheduleEvent(HEIGAN_EVENT_SWITCH_PHASE, 90s);
            }
            else // if (phase == HEIGAN_PHASE_FAST_DANCE)
            {
                Talk(HEIGAN_EMOTE_DANCE);
                Talk(HEIGAN_SAY_DANCE);
                me->AttackStop();
                me->StopMoving();
                me->SetReactState(REACT_PASSIVE);
                me->CastSpell(me, HEIGAN_SPELL_TELEPORT_SELF, false);
                me->SetFacingTo(2.40f);
                events.ScheduleEvent(HEIGAN_EVENT_PLAGUE_CLOUD, 1s);
                events.ScheduleEvent(HEIGAN_EVENT_ERUPT_SECTION, 7s);
                events.ScheduleEvent(HEIGAN_EVENT_SWITCH_PHASE, 45s);
            }
            events.ScheduleEvent(HEIGAN_EVENT_SAFETY_DANCE, 5s);
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
                case HEIGAN_EVENT_DISRUPTION:
                    me->CastSpell(me, HEIGAN_SPELL_SPELL_DISRUPTION, false);
                    events.Repeat(10s);
                    break;
                case HEIGAN_EVENT_DECEPIT_FEVER:
                    me->CastSpell(me, RAID_MODE(HEIGAN_SPELL_DECREPIT_FEVER_10, HEIGAN_SPELL_DECREPIT_FEVER_25), false);
                    events.Repeat(22s, 25s);
                    break;
                case HEIGAN_EVENT_PLAGUE_CLOUD:
                    me->CastSpell(me, HEIGAN_SPELL_PLAGUE_CLOUD, false);
                    break;
                case HEIGAN_EVENT_SWITCH_PHASE:
                    if (currentPhase == HEIGAN_PHASE_SLOW_DANCE)
                    {
                        StartFightPhase(HEIGAN_PHASE_FAST_DANCE);
                    }
                    else
                    {
                        StartFightPhase(HEIGAN_PHASE_SLOW_DANCE);
                        Talk(HEIGAN_EMOTE_DANCE_END); // avoid play the emote on aggro
                    }
                    break;
                case HEIGAN_EVENT_ERUPT_SECTION:
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
                    if (currentPhase == HEIGAN_PHASE_SLOW_DANCE)
                    {
                        Talk(HEIGAN_SAY_TAUNT);
                    }
                    events.Repeat(currentPhase == HEIGAN_PHASE_SLOW_DANCE ? 10s : 4s);
                    break;
                case HEIGAN_EVENT_SAFETY_DANCE:
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
                        events.Repeat(5s);
                        return;
                    }
            }
            DoMeleeAttackIfReady();
        }
    };
};

}
#endif