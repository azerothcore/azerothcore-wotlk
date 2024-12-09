#ifndef BOSS_LOATHEB_H_
#define BOSS_LOATHEB_H_

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "naxxramas.h"

namespace Loatheb {

enum Spells
{
    SPELL_NECROTIC_AURA                         = 55593,
    SPELL_SUMMON_SPORE                          = 29234,
    SPELL_DEATHBLOOM_10                         = 29865,
    SPELL_DEATHBLOOM_25                         = 55053,
    SPELL_INEVITABLE_DOOM_10                    = 29204,
    SPELL_INEVITABLE_DOOM_25                    = 55052,
    SPELL_BERSERK                               = 26662
};

enum Events
{
    EVENT_NECROTIC_AURA                         = 1,
    EVENT_DEATHBLOOM                            = 2,
    EVENT_INEVITABLE_DOOM                       = 3,
    EVENT_BERSERK                               = 4,
    EVENT_SUMMON_SPORE                          = 5,
    EVENT_NECROTIC_AURA_FADING                  = 6,
    EVENT_NECROTIC_AURA_REMOVED                 = 7
};

enum Texts
{
    SAY_NECROTIC_AURA_APPLIED                   = 0,
    SAY_NECROTIC_AURA_REMOVED                   = 1,
    SAY_NECROTIC_AURA_FADING                    = 2
};

class boss_loatheb : public CreatureScript
{
public:
    boss_loatheb() : CreatureScript("boss_loatheb") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_loathebAI>(pCreature);
    }

    struct boss_loathebAI : public BossAI
    {
        explicit boss_loathebAI(Creature* c) : BossAI(c, BOSS_LOATHEB), summons(me)
        {
            pInstance = me->GetInstanceScript();
            me->SetHomePosition(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
        }

        InstanceScript* pInstance;
        uint8 doomCounter;
        EventMap events;
        SummonList summons;

        void Reset() override
        {
            BossAI::Reset();
            events.Reset();
            summons.DespawnAll();
            doomCounter = 0;
            if (pInstance)
            {
                pInstance->SetData(BOSS_LOATHEB, NOT_STARTED);
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_LOATHEB_GATE)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
            }
        }

        void JustSummoned(Creature* cr) override
        {
            cr->SetInCombatWithZone();
            summons.Summon(cr);
        }

        void SummonedCreatureDies(Creature*  /*cr*/, Unit*) override
        {
            if (pInstance)
            {
                pInstance->SetData(DATA_SPORE_KILLED, 0);
            }
        }

        void KilledUnit(Unit* who) override
        {
            if (who->IsPlayer() && pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            me->SetInCombatWithZone();
            events.ScheduleEvent(EVENT_NECROTIC_AURA, 10s);
            events.ScheduleEvent(EVENT_DEATHBLOOM, 5s);
            events.ScheduleEvent(EVENT_INEVITABLE_DOOM, 2min);
            events.ScheduleEvent(EVENT_SUMMON_SPORE, 15s);
            events.ScheduleEvent(EVENT_BERSERK, 12min);
            if (pInstance)
            {
                pInstance->SetData(BOSS_LOATHEB, IN_PROGRESS);
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_LOATHEB_GATE)))
                {
                    go->SetGoState(GO_STATE_READY);
                }
            }
        }

        void JustDied(Unit* killer) override
        {
            BossAI::JustDied(killer);
            summons.DespawnAll();
            if (pInstance)
            {
                pInstance->SetData(BOSS_LOATHEB, DONE);
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim() || !IsInRoom())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SUMMON_SPORE:
                    me->CastSpell(me, SPELL_SUMMON_SPORE, true);
                    events.Repeat(35s);
                    break;
                case EVENT_NECROTIC_AURA:
                    me->CastSpell(me, SPELL_NECROTIC_AURA, true);
                    Talk(SAY_NECROTIC_AURA_APPLIED);
                    events.ScheduleEvent(EVENT_NECROTIC_AURA_FADING, 14s);
                    events.ScheduleEvent(EVENT_NECROTIC_AURA_REMOVED, 17s);
                    events.Repeat(20s);
                    break;
                case EVENT_DEATHBLOOM:
                    me->CastSpell(me, RAID_MODE(SPELL_DEATHBLOOM_10, SPELL_DEATHBLOOM_25), false);
                    events.Repeat(30s);
                    break;
                case EVENT_INEVITABLE_DOOM:
                    me->CastSpell(me, RAID_MODE(SPELL_INEVITABLE_DOOM_10, SPELL_INEVITABLE_DOOM_25), false);
                    doomCounter++;
                    events.Repeat(doomCounter < 6 ? 30s : 15s);
                    break;
                case EVENT_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    break;
                case EVENT_NECROTIC_AURA_FADING:
                    Talk(SAY_NECROTIC_AURA_FADING);
                    break;
                case EVENT_NECROTIC_AURA_REMOVED:
                    Talk(SAY_NECROTIC_AURA_REMOVED);
                    break;
            }
            DoMeleeAttackIfReady();
        }

        bool IsInRoom()
        {
            // Calculate the distance between his home position to the gate
            if (me->GetExactDist(me->GetHomePosition().GetPositionX(),
                                 me->GetHomePosition().GetPositionY(),
                                 me->GetHomePosition().GetPositionZ()) > 50.0f)
            {
                EnterEvadeMode();
                return false;
            }
            return true;
        }
    };
};

}

#endif