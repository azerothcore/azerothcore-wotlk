/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
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
    SPELL_IMPALE                    = 28783,
    SPELL_LOCUST_SWARM              = 28785,
    SPELL_SUMMON_CORPSE_SCARABS_5   = 29105,
    SPELL_SUMMON_CORPSE_SCARABS_10  = 28864,
    SPELL_BERSERK                   = 26662
};

enum Misc
{
    ACHIEV_TIMED_START_EVENT        = 9891
};

Position const cryptguardPositions[] = {
    { 3299.732f, -3502.489f, 287.077f, 2.378f },
    { 3299.086f, -3450.929f, 287.077f, 3.999f },
    { 3331.217f, -3476.607f, 287.074f, 3.269f }
};

struct boss_anubrekhan : public BossAI
{
    boss_anubrekhan(Creature* creature) : BossAI(creature, BOSS_ANUB) { }

    void SummonCryptGuards()
    {
        if (Is25ManRaid())
        {
            me->SummonCreature(NPC_CRYPT_GUARD, cryptguardPositions[0], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
            me->SummonCreature(NPC_CRYPT_GUARD, cryptguardPositions[1], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
        }
    }

    void Reset() override
    {
        BossAI::Reset();
        SummonCryptGuards();
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

    void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
    {
        if (summon->GetEntry() == NPC_CRYPT_GUARD)
        {
            summon->CastSpell(summon, SPELL_SUMMON_CORPSE_SCARABS_10, true, nullptr, nullptr, me->GetGUID());
            summon->AI()->Talk(EMOTE_SCARAB);
        }
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        instance->DoStartTimedAchievement(ACHIEVEMENT_TIMED_TYPE_EVENT, ACHIEV_TIMED_START_EVENT);
    }

    void KilledUnit(Unit* victim) override
    {
        if (!victim->IsPlayer())
            return;

        Talk(SAY_SLAY);
        victim->CastSpell(victim, SPELL_SUMMON_CORPSE_SCARABS_5, true, nullptr, nullptr, me->GetGUID());
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
            me->m_Events.AddEventAtOffset([this]()
            {
                me->SummonCreature(NPC_CRYPT_GUARD, cryptguardPositions[2], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
            }, 17500ms);
        }

        ScheduleTimedEvent(15s, [&] {
            DoCastRandomTarget(SPELL_IMPALE);
        }, 20s);

        ScheduleTimedEvent(70s, 2min, [&] {
            Talk(EMOTE_LOCUST);
            DoCastSelf(SPELL_LOCUST_SWARM);

            scheduler.Schedule(3s, [this](TaskContext /*context*/) {
                me->SummonCreature(NPC_CRYPT_GUARD, cryptguardPositions[2], TEMPSUMMON_CORPSE_TIMED_DESPAWN, 60000);
            });
        }, 90s);

        ScheduleEnrageTimer(SPELL_BERSERK, 10min);
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (!_sayGreet && who->IsPlayer())
        {
            Talk(SAY_GREET);
            _sayGreet = true;
        }
        BossAI::MoveInLineOfSight(who);
    }

private:
    bool _sayGreet{false};
};

void AddSC_boss_anubrekhan()
{
    RegisterNaxxramasCreatureAI(boss_anubrekhan);
}
