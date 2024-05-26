#ifndef BOSS_FAERLINA_H_
#define BOSS_FAERLINA_H_

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"
#include "naxxramas.h"

namespace Faerlina {

enum FaerlinaYells
{
    FAERLINA_SAY_GREET                           = 0,
    FAERLINA_SAY_AGGRO                           = 1,
    FAERLINA_SAY_SLAY                            = 2,
    FAERLINA_SAY_DEATH                           = 3,
    FAERLINA_EMOTE_WIDOWS_EMBRACE                = 4,
    FAERLINA_EMOTE_FRENZY                        = 5,
    FAERLINA_SAY_FRENZY                          = 6
};

enum Faerlinapells
{
    FAERLINA_SPELL_POISON_BOLT_VOLLEY_10         = 28796,
    FAERLINA_SPELL_POISON_BOLT_VOLLEY_25         = 54098,
    FAERLINA_SPELL_RAIN_OF_FIRE_10               = 28794,
    FAERLINA_SPELL_RAIN_OF_FIRE_25               = 54099,
    FAERLINA_SPELL_FRENZY_10                     = 28798,
    FAERLINA_SPELL_FRENZY_25                     = 54100,
    FAERLINA_SPELL_WIDOWS_EMBRACE                = 28732,
    FAERLINA_SPELL_MINION_WIDOWS_EMBRACE         = 54097
};

enum FaerlinaEvents
{
    FAERLINA_EVENT_POISON_BOLT                   = 1,
    FAERLINA_EVENT_RAIN_OF_FIRE                  = 2,
    FAERLINA_EVENT_FRENZY                        = 3
};

enum FaerlinaMisc
{
    FAERLINA_NPC_NAXXRAMAS_WORSHIPPER            = 16506,
    FAERLINA_NPC_NAXXRAMAS_FOLLOWER              = 16505
};

class boss_faerlina : public CreatureScript
{
public:
    boss_faerlina() : CreatureScript("boss_faerlina") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_faerlinaAI>(pCreature);
    }

    struct boss_faerlinaAI : public BossAI
    {
        boss_faerlinaAI(Creature* c) : BossAI(c, BOSS_FAERLINA), summons(me)
        {
            pInstance = me->GetInstanceScript();
            sayGreet = false;
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        bool sayGreet;

        void SummonHelpers()
        {
            me->SummonCreature(FAERLINA_NPC_NAXXRAMAS_WORSHIPPER, 3362.66f, -3620.97f, 261.08f, 4.57276f);
            me->SummonCreature(FAERLINA_NPC_NAXXRAMAS_WORSHIPPER, 3344.3f, -3618.31f, 261.08f, 4.69494f);
            me->SummonCreature(FAERLINA_NPC_NAXXRAMAS_WORSHIPPER, 3356.71f, -3620.05f, 261.08f, 4.57276f);
            me->SummonCreature(FAERLINA_NPC_NAXXRAMAS_WORSHIPPER, 3350.26f, -3619.11f, 261.08f, 4.67748f);
            if (Is25ManRaid())
            {
                me->SummonCreature(FAERLINA_NPC_NAXXRAMAS_FOLLOWER, 3347.49f, -3617.59f, 261.0f, 4.49f);
                me->SummonCreature(FAERLINA_NPC_NAXXRAMAS_FOLLOWER, 3359.64f, -3619.16f, 261.0f, 4.56f);
            }
        }

        void JustSummoned(Creature* cr) override
        {
            summons.Summon(cr);
        }

        void Reset() override
        {
            BossAI::Reset();
            events.Reset();
            summons.DespawnAll();
            SummonHelpers();
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_FAERLINA_WEB)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            me->CallForHelp(VISIBLE_RANGE);
            summons.DoZoneInCombat();
            Talk(static_cast<uint8>(FAERLINA_SAY_AGGRO));
            events.ScheduleEvent(static_cast<uint8>(FAERLINA_EVENT_POISON_BOLT), 7s, 15s);
            events.ScheduleEvent(static_cast<uint8>(FAERLINA_EVENT_RAIN_OF_FIRE), 8s, 18s);
            events.ScheduleEvent(static_cast<uint8>(FAERLINA_EVENT_FRENZY), 60s, 80s, 1);
            events.SetPhase(1);
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_FAERLINA_WEB)))
                {
                    go->SetGoState(GO_STATE_READY);
                }
            }
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!sayGreet && who->GetTypeId() == TYPEID_PLAYER)
            {
                Talk(FAERLINA_SAY_GREET);
                sayGreet = true;
            }
            ScriptedAI::MoveInLineOfSight(who);
        }

        void KilledUnit(Unit* who) override
        {
            if (who->GetTypeId() != TYPEID_PLAYER)
                return;

            if (!urand(0, 3))
            {
                Talk(FAERLINA_SAY_SLAY);
            }
            if (pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            Talk(FAERLINA_SAY_DEATH);
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_FAERLINA_WEB)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!me->IsInCombat() && sayGreet)
            {
                for (SummonList::iterator itr = summons.begin(); itr != summons.end(); ++itr)
                {
                    if (pInstance)
                    {
                        if (Creature* cr = pInstance->instance->GetCreature(*itr))
                        {
                            if (cr->IsInCombat())
                                DoZoneInCombat();
                        }
                    }
                }
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case FAERLINA_EVENT_POISON_BOLT:
                    if (!me->HasAura(RAID_MODE(FAERLINA_SPELL_WIDOWS_EMBRACE, FAERLINA_SPELL_MINION_WIDOWS_EMBRACE)))
                    {
                        me->CastCustomSpell(RAID_MODE(FAERLINA_SPELL_POISON_BOLT_VOLLEY_10, FAERLINA_SPELL_POISON_BOLT_VOLLEY_25), SPELLVALUE_MAX_TARGETS, RAID_MODE(3, 10), me, false);
                    }
                    events.Repeat(7s, 15s);
                    break;
                case FAERLINA_EVENT_RAIN_OF_FIRE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                    {
                        me->CastSpell(target, RAID_MODE(FAERLINA_SPELL_RAIN_OF_FIRE_10, FAERLINA_SPELL_RAIN_OF_FIRE_25), false);
                    }
                    events.Repeat(8s, 18s);
                    break;
                case FAERLINA_EVENT_FRENZY:
                    if (!me->HasAura(RAID_MODE(FAERLINA_SPELL_FRENZY_10, FAERLINA_SPELL_FRENZY_25)))
                    {
                        Talk(FAERLINA_SAY_FRENZY);
                        Talk(FAERLINA_EMOTE_FRENZY);
                        me->CastSpell(me, RAID_MODE(FAERLINA_SPELL_FRENZY_10, FAERLINA_SPELL_FRENZY_25), true);
                        events.Repeat(1min);
                    }
                    else
                    {
                        events.Repeat(30s);
                    }
                    break;
            }
            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* caster, SpellInfo const* spell) override
        {
            if (spell->Id == RAID_MODE(FAERLINA_SPELL_WIDOWS_EMBRACE, FAERLINA_SPELL_MINION_WIDOWS_EMBRACE))
            {
                Talk(FAERLINA_EMOTE_WIDOWS_EMBRACE);
                if (me->HasAura(RAID_MODE(FAERLINA_SPELL_FRENZY_10, FAERLINA_SPELL_FRENZY_25)))
                {
                    me->RemoveAurasDueToSpell(RAID_MODE(FAERLINA_SPELL_FRENZY_10, FAERLINA_SPELL_FRENZY_25));
                    events.RescheduleEvent(FAERLINA_EVENT_FRENZY, 1min);
                }
                pInstance->SetData(DATA_FRENZY_REMOVED, 0);
                if (Is25ManRaid())
                {
                    Unit::Kill(caster, caster);
                }
            }
        }
    };
};

}

#endif