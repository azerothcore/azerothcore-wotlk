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

#include "CreatureScript.h"
#include "ScriptedCreature.h"
#include "naxxramas.h"

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_GREET                       = 1,
    SAY_SLAY                        = 2,
    EMOTE_LOCUST                    = 3
};

enum GuardSays
{
    EMOTE_SPAWN                     = 1,
    EMOTE_SCARAB                    = 2
};

enum Spells
{
    SPELL_IMPALE_10                 = 28783,
    SPELL_IMPALE_25                 = 56090,
    SPELL_LOCUST_SWARM_10           = 28785,
    SPELL_LOCUST_SWARM_25           = 54021,
    SPELL_SUMMON_CORPSE_SCRABS_5    = 29105,
    SPELL_SUMMON_CORPSE_SCRABS_10   = 28864,
    SPELL_BERSERK                   = 26662
};

enum Events
{
    EVENT_IMPALE                    = 1,
    EVENT_LOCUST_SWARM              = 2,
    EVENT_BERSERK                   = 3,
    EVENT_SPAWN_GUARD               = 4
};

enum Misc
{
    NPC_CORPSE_SCARAB               = 16698,
    NPC_CRYPT_GUARD                 = 16573,

    ACHIEV_TIMED_START_EVENT        = 9891
};

class boss_anubrekhan : public CreatureScript
{
public:
    boss_anubrekhan() : CreatureScript("boss_anubrekhan") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetNaxxramasAI<boss_anubrekhanAI>(pCreature);
    }

    struct boss_anubrekhanAI : public BossAI
    {
        explicit boss_anubrekhanAI(Creature* c) : BossAI(c, BOSS_ANUB), summons(me)
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
                me->SummonCreature(NPC_CRYPT_GUARD, 3299.732f, -3502.489f, 287.077f, 2.378f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                me->SummonCreature(NPC_CRYPT_GUARD, 3299.086f, -3450.929f, 287.077f, 3.999f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
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
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_ANUB_GATE)))
                {
                    go->SetGoState(GO_STATE_ACTIVE);
                }
            }
        }

        void JustSummoned(Creature* cr) override
        {
            if (me->IsInCombat())
            {
                cr->SetInCombatWithZone();
                if (cr->GetEntry() == NPC_CRYPT_GUARD)
                {
                    cr->AI()->Talk(EMOTE_SPAWN, me);
                }
            }
            summons.Summon(cr);
        }

        void SummonedCreatureDies(Creature* cr, Unit*) override
        {
            if (cr->GetEntry() == NPC_CRYPT_GUARD)
            {
                cr->CastSpell(cr, SPELL_SUMMON_CORPSE_SCRABS_10, true, nullptr, nullptr, me->GetGUID());
                cr->AI()->Talk(EMOTE_SCARAB);
            }
        }

        void SummonedCreatureDespawn(Creature* cr) override
        {
            summons.Despawn(cr);
        }

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
            if (!victim->IsPlayer())
                return;

            Talk(SAY_SLAY);
            victim->CastSpell(victim, SPELL_SUMMON_CORPSE_SCRABS_5, true, nullptr, nullptr, me->GetGUID());
            if (pInstance)
            {
                pInstance->SetData(DATA_IMMORTAL_FAIL, 0);
            }
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            me->CallForHelp(30.0f);
            Talk(SAY_AGGRO);
            if (pInstance)
            {
                if (GameObject* go = me->GetMap()->GetGameObject(pInstance->GetGuidData(DATA_ANUB_GATE)))
                {
                    go->SetGoState(GO_STATE_READY);
                }
            }
            events.ScheduleEvent(EVENT_IMPALE, 15s);
            events.ScheduleEvent(EVENT_LOCUST_SWARM, 70s, 120s);
            events.ScheduleEvent(EVENT_BERSERK, 10min);
            if (!summons.HasEntry(NPC_CRYPT_GUARD))
            {
                SummonCryptGuards();
            }
            if (!Is25ManRaid())
            {
                events.ScheduleEvent(EVENT_SPAWN_GUARD, 15s, 20s);
            }
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (!sayGreet && who->IsPlayer())
            {
                Talk(SAY_GREET);
                sayGreet = true;
            }
            ScriptedAI::MoveInLineOfSight(who);
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
                case EVENT_IMPALE:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                    {
                        me->CastSpell(target, RAID_MODE(SPELL_IMPALE_10, SPELL_IMPALE_25), false);
                    }
                    events.Repeat(20s);
                    break;
                case EVENT_LOCUST_SWARM:
                    Talk(EMOTE_LOCUST);
                    me->CastSpell(me, RAID_MODE(SPELL_LOCUST_SWARM_10, SPELL_LOCUST_SWARM_25), false);
                    events.ScheduleEvent(EVENT_SPAWN_GUARD, 3s);
                    events.Repeat(90s);
                    break;
                case EVENT_SPAWN_GUARD:
                    me->SummonCreature(NPC_CRYPT_GUARD, 3331.217f, -3476.607f, 287.074f, 3.269f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                    break;
                case EVENT_BERSERK:
                    me->CastSpell(me, SPELL_BERSERK, true);
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
