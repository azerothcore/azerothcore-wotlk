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
        boss_anubrekhanAI(Creature* c) : BossAI(c, BOSS_ANUB)
        {
            sayGreet = false;
        }

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
            SummonCryptGuards();
            me->m_Events.KillAllEvents(false);
        }

        void JustSummoned(Creature* cr) override
        {
            if (me->IsInCombat())
            {
                cr->SetInCombatWithZone();
                if (cr->GetEntry() == NPC_CRYPT_GUARD)
                    cr->AI()->Talk(EMOTE_SPAWN, me);
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

        void JustDied(Unit*  killer) override
        {
            BossAI::JustDied(killer);
            instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);
        }

        void KilledUnit(Unit* victim) override
        {
            if (!victim->IsPlayer())
                return;

            Talk(SAY_SLAY);
            victim->CastSpell(victim, SPELL_SUMMON_CORPSE_SCRABS_5, true, nullptr, nullptr, me->GetGUID());
            instance->StorePersistentData(PERSISTENT_DATA_IMMORTAL_FAIL, 1);
        }

        void JustEngagedWith(Unit* who) override
        {
            BossAI::JustEngagedWith(who);
            me->CallForHelp(30.0f);
            Talk(SAY_AGGRO);

            if (!summons.HasEntry(NPC_CRYPT_GUARD))
                SummonCryptGuards();
            if (!Is25ManRaid())
            {
                me->m_Events.AddEventAtOffset([&]
                {
                    me->SummonCreature(NPC_CRYPT_GUARD, 3331.217f, -3476.607f, 287.074f, 3.269f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                }, Milliseconds(urand(15000, 20000)));
            }

            ScheduleTimedEvent(15s, [&] {
                DoCastRandomTarget(RAID_MODE(SPELL_IMPALE_10, SPELL_IMPALE_25));
            }, 20s);

            ScheduleTimedEvent(70s, 2min, [&] {
                Talk(EMOTE_LOCUST);
                DoCastSelf(RAID_MODE(SPELL_LOCUST_SWARM_10, SPELL_LOCUST_SWARM_25));

                me->m_Events.AddEventAtOffset([&]
                {
                    me->SummonCreature(NPC_CRYPT_GUARD, 3331.217f, -3476.607f, 287.074f, 3.269f, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
                }, 3s);

            }, 90s);

            me->m_Events.AddEventAtOffset([&]
            {
                DoCastSelf(SPELL_BERSERK, true);
            }, 10min);
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

    private:
        bool sayGreet;
    };
};

void AddSC_boss_anubrekhan()
{
    new boss_anubrekhan();
}
