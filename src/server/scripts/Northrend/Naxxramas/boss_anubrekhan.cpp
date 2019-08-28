/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"

enum Says
{
    SAY_AGGRO           = 0,
    SAY_GREET           = 1,
    SAY_SLAY            = 2,
    EMOTE_LOCUST        = 3
};

enum Spells
{
    SPELL_IMPALE_10                 = 28783,
    SPELL_IMPALE_25                 = 56090,
    SPELL_LOCUST_SWARM_10           = 28785,
    SPELL_LOCUST_SWARM_25           = 54021,
    SPELL_SUMMON_CORPSE_SCRABS_5    = 29105,
    SPELL_SUMMON_CORPSE_SCRABS_10   = 28864,
    SPELL_BERSERK                   = 26662,
};

enum Events
{
    EVENT_SPELL_IMPALE              = 1,
    EVENT_SPELL_LOCUST_SWARM        = 2,
    EVENT_SPELL_BERSERK             = 3,
};

enum Misc
{
    NPC_CORPSE_SCARAB               = 16698,
    NPC_CRYPT_GUARD                 = 16573,

    ACHIEV_TIMED_START_EVENT        = 9891,
};

class boss_anubrekhan : public CreatureScript
{
public:
    boss_anubrekhan() : CreatureScript("boss_anubrekhan") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return new boss_anubrekhanAI (pCreature);
    }

    struct boss_anubrekhanAI : public BossAI
    {
        explicit boss_anubrekhanAI(Creature *c) : BossAI(c, BOSS_ANUB), summons(me)
        {
            pInstance = c->GetInstanceScript();
            sayGreet = false;
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;
        bool sayGreet;

        void SummonCryptGuards()
        {
            if (Is25ManRaid())
            {
                me->SummonCreature(NPC_CRYPT_GUARD, 3299.825f, -3502.27f, 287.16f, M_PI, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                me->SummonCreature(NPC_CRYPT_GUARD, 3299.087f, -3450.93f, 287.16f, M_PI, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
            }
        }

        void Reset() override
        {
            BossAI::Reset();
            events.Reset();
            summons.DespawnAll();
            SummonCryptGuards();

            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_ANUB_GATE)))
                    go->SetGoState(GO_STATE_ACTIVE);
            }
        }

        void JustSummoned(Creature* cr) override
        {
            if (me->IsInCombat())
                cr->SetInCombatWithZone();
            if (cr->GetEntry() == NPC_CORPSE_SCARAB)
            {
                cr->SetReactState(REACT_PASSIVE);
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                    cr->AI()->AttackStart(target);
            }

            summons.Summon(cr);
        }

        void SummonedCreatureDies(Creature* cr, Unit*) override
        {
            if (cr->GetEntry() == NPC_CRYPT_GUARD)
                cr->CastSpell(cr, SPELL_SUMMON_CORPSE_SCRABS_10, true, nullptr, nullptr, me->GetGUID());
        }

        void SummonedCreatureDespawn(Creature* cr) override { summons.Despawn(cr); }

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            summons.DespawnAll();
            if (pInstance)
            {
                pInstance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);
            }
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() != TYPEID_PLAYER)
                return;

            Talk(SAY_SLAY);

            //Force the player to spawn corpse scarabs via spell
            victim->CastSpell(victim, SPELL_SUMMON_CORPSE_SCRABS_5, true, nullptr, nullptr, me->GetGUID());

            if (pInstance)
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
        }

        void EnterCombat(Unit * who) override
        {
            BossAI::EnterCombat(who);
            me->CallForHelp(30.0f); // catch helpers
            Talk(SAY_AGGRO);
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetData64(DATA_ANUB_GATE)))
                    go->SetGoState(GO_STATE_READY);
            }

            events.ScheduleEvent(EVENT_SPELL_IMPALE, 15000);
            events.ScheduleEvent(EVENT_SPELL_LOCUST_SWARM, 70000+urand(0,50000));
            events.ScheduleEvent(EVENT_SPELL_BERSERK, 600000);
            
            if (!summons.HasEntry(NPC_CRYPT_GUARD))
                SummonCryptGuards();
        }

        void MoveInLineOfSight(Unit *who) override
        {
            if (!sayGreet && who->GetTypeId() == TYPEID_PLAYER)
            {
                Talk(SAY_GREET);
                sayGreet = true;
            }

            ScriptedAI::MoveInLineOfSight(who);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.GetEvent())
            {
                case EVENT_SPELL_IMPALE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(target, RAID_MODE(SPELL_IMPALE_10, SPELL_IMPALE_25), false);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_LOCUST_SWARM:
                {
                    Talk(EMOTE_LOCUST);
                    me->CastSpell(me, RAID_MODE(SPELL_LOCUST_SWARM_10, SPELL_LOCUST_SWARM_25), false);
                    Position pos;
                    me->GetNearPosition(pos, 10.0f, rand_norm() * 2 * M_PI);
                    me->SummonCreature(NPC_CRYPT_GUARD, pos);
                    events.RepeatEvent(90000);
                    break;
                }
                case EVENT_SPELL_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
                    events.PopEvent();
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_anubrekhan()
{
    new boss_anubrekhan();
}

