/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "naxxramas.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"
#include "SpellInfo.h"

enum Yells
{
    SAY_GREET                           = 0,
    SAY_AGGRO                           = 1,
    SAY_SLAY                            = 2,
    SAY_DEATH                           = 3,
    EMOTE_WIDOWS_EMBRACE                = 4,
    EMOTE_FRENZY                        = 5,
    SAY_FRENZY                          = 6
};

enum Spells
{
    SPELL_POISON_BOLT_VOLLEY_10         = 28796,
    SPELL_POISON_BOLT_VOLLEY_25         = 54098,
    SPELL_RAIN_OF_FIRE_10               = 28794,
    SPELL_RAIN_OF_FIRE_25               = 54099,
    SPELL_FRENZY_10                     = 28798,
    SPELL_FRENZY_25                     = 54100,
    SPELL_WIDOWS_EMBRACE                = 28732,
    SPELL_MINION_WIDOWS_EMBRACE         = 54097
};

enum Events
{
    EVENT_POISON_BOLT                   = 1,
    EVENT_RAIN_OF_FIRE                  = 2,
    EVENT_FRENZY                        = 3
};

enum Misc
{
    NPC_NAXXRAMAS_WORSHIPPER            = 16506,
    NPC_NAXXRAMAS_FOLLOWER              = 16505
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
            me->SummonCreature(NPC_NAXXRAMAS_WORSHIPPER, 3362.66f, -3620.97f, 261.08f, 4.57276f);
            me->SummonCreature(NPC_NAXXRAMAS_WORSHIPPER, 3344.3f, -3618.31f, 261.08f, 4.69494f);
            me->SummonCreature(NPC_NAXXRAMAS_WORSHIPPER, 3356.71f, -3620.05f, 261.08f, 4.57276f);
            me->SummonCreature(NPC_NAXXRAMAS_WORSHIPPER, 3350.26f, -3619.11f, 261.08f, 4.67748f);
            if (Is25ManRaid())
            {
                me->SummonCreature(NPC_NAXXRAMAS_FOLLOWER, 3347.49f, -3617.59f, 261.0f, 4.49f);
                me->SummonCreature(NPC_NAXXRAMAS_FOLLOWER, 3359.64f, -3619.16f, 261.0f, 4.56f);
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

        void EnterCombat(Unit* who) override
        {
            BossAI::EnterCombat(who);
            me->CallForHelp(VISIBLE_RANGE);
            summons.DoZoneInCombat();
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_POISON_BOLT, urand(7000, 15000));
            events.ScheduleEvent(EVENT_RAIN_OF_FIRE, urand(8000, 18000));
            events.ScheduleEvent(EVENT_FRENZY, urand(60000, 80000), 1);
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
                Talk(SAY_GREET);
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
                Talk(SAY_SLAY);
            }
            if (pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            Talk(SAY_DEATH);
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
                case EVENT_POISON_BOLT:
                    if (!me->HasAura(RAID_MODE(SPELL_WIDOWS_EMBRACE, SPELL_MINION_WIDOWS_EMBRACE)))
                    {
                        me->CastCustomSpell(RAID_MODE(SPELL_POISON_BOLT_VOLLEY_10, SPELL_POISON_BOLT_VOLLEY_25), SPELLVALUE_MAX_TARGETS, RAID_MODE(3, 10), me, false);
                    }
                    events.RepeatEvent(urand(7000, 15000));
                    break;
                case EVENT_RAIN_OF_FIRE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    {
                        me->CastSpell(target, RAID_MODE(SPELL_RAIN_OF_FIRE_10, SPELL_RAIN_OF_FIRE_25), false);
                    }
                    events.RepeatEvent(urand(8000, 18000));
                    break;
                case EVENT_FRENZY:
                    if (!me->HasAura(RAID_MODE(SPELL_FRENZY_10, SPELL_FRENZY_25)))
                    {
                        Talk(SAY_FRENZY);
                        Talk(EMOTE_FRENZY);
                        me->CastSpell(me, RAID_MODE(SPELL_FRENZY_10, SPELL_FRENZY_25), true);
                        events.RepeatEvent(60000);
                    }
                    else
                    {
                        events.RepeatEvent(30000);
                    }
                    break;
            }
            DoMeleeAttackIfReady();
        }

        void SpellHit(Unit* caster, const SpellInfo* spell) override
        {
            if (spell->Id == RAID_MODE(SPELL_WIDOWS_EMBRACE, SPELL_MINION_WIDOWS_EMBRACE))
            {
                Talk(EMOTE_WIDOWS_EMBRACE);
                if (me->HasAura(RAID_MODE(SPELL_FRENZY_10, SPELL_FRENZY_25)))
                {
                    me->RemoveAurasDueToSpell(RAID_MODE(SPELL_FRENZY_10, SPELL_FRENZY_25));
                    events.RescheduleEvent(EVENT_FRENZY, 60000);
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

void AddSC_boss_faerlina()
{
    new boss_faerlina();
}
