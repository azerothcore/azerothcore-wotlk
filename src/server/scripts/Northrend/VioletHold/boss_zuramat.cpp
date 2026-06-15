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
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "violet_hold.h"

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_SLAY                                    = 1,
    SAY_DEATH                                   = 2,
    SAY_SPAWN                                   = 3,
    SAY_SHIELD                                  = 4,
    SAY_WHISPER                                 = 5
};

enum eSpells
{
    SPELL_SHROUD_OF_DARKNESS                        = 54524,
    SPELL_VOID_SHIFT                                = 54361,
    SPELL_SUMMON_VOID_SENTRY                        = 54369,
    SPELL_SUMMON_VOID_SENTRY_BALL                   = 58650,
};

enum eCreatures
{
    NPC_VOID_SENTRY_BALL                            = 29365,
};

enum eEvents
{
    EVENT_SPELL_SHROUD_OF_DARKNESS = 1,
    EVENT_SPELL_VOID_SHIFT,
    EVENT_SPELL_SUMMON_VOID_SENTRY,
};

enum eVoidSentryEvents
{
    EVENT_CHECK_SUMMONER = 1,
};

struct boss_zuramat : public BossAI
{
    boss_zuramat(Creature* c) : BossAI(c, BOSS_ZURAMAT) { }

    void JustEngagedWith(Unit* who) override
    {
        Talk(SAY_AGGRO);
        BossAI::JustEngagedWith(who);
        events.RescheduleEvent(EVENT_SPELL_SHROUD_OF_DARKNESS, 5s, 7s);
        events.RescheduleEvent(EVENT_SPELL_VOID_SHIFT, 23s, 25s);
        events.RescheduleEvent(EVENT_SPELL_SUMMON_VOID_SENTRY, 10s);
        instance->SetData(DATA_ACHIEV, 1);
    }

    void ExecuteEvent(uint32 eventId) override
    {
        switch (eventId)
        {
            case EVENT_SPELL_SHROUD_OF_DARKNESS:
                DoCastSelf(SPELL_SHROUD_OF_DARKNESS);
                Talk(SAY_SHIELD);
                events.Repeat(20s);
                break;
            case EVENT_SPELL_VOID_SHIFT:
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 60.0f, true))
                {
                    DoCast(target, SPELL_VOID_SHIFT);
                    me->Whisper("Gaze... into the void.", LANG_UNIVERSAL, target->ToPlayer());
                }
                events.Repeat(18s, 22s);
                break;
            case EVENT_SPELL_SUMMON_VOID_SENTRY:
                DoCastAOE(SPELL_SUMMON_VOID_SENTRY);
                events.Repeat(12s);
                break;
        }
    }

    void JustDied(Unit* killer) override
    {
        Talk(SAY_DEATH);
        BossAI::JustDied(killer);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim && victim->GetGUID() == me->GetGUID())
            return;

        Talk(SAY_SLAY);
    }

    void JustSummoned(Creature* summoned) override
    {
        if (summoned)
        {
            BossAI::JustSummoned(summoned);
            summoned->SetPhaseMask(16, true);
            instance->SetGuidData(DATA_ADD_TRASH_MOB, summoned->GetGUID());
        }
    }

    void SummonedCreatureDespawn(Creature* summoned) override
    {
        if (summoned)
        {
            BossAI::SummonedCreatureDespawn(summoned);
            if (summoned->IsAIEnabled)
                summoned->AI()->DoAction(-1337);
            instance->SetGuidData(DATA_DELETE_TRASH_MOB, summoned->GetGUID());
        }
    }

    void MoveInLineOfSight(Unit* /*who*/) override {}

    void EnterEvadeMode(EvadeReason why) override
    {
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
        _EnterEvadeMode(why);
    }
};

struct npc_vh_void_sentry : public NullCreatureAI
{
    npc_vh_void_sentry(Creature* c) : NullCreatureAI(c)
    {
        _instance = c->GetInstanceScript();
        _summonedGuid.Clear();
        _events.ScheduleEvent(EVENT_CHECK_SUMMONER, 5s);
        if (Creature* summoned = me->SummonCreature(NPC_VOID_SENTRY_BALL, *me, TEMPSUMMON_TIMED_DESPAWN, 300000))
        {
            summoned->SetPhaseMask(1, true);
            _summonedGuid = summoned->GetGUID();
            _instance->SetGuidData(DATA_ADD_TRASH_MOB, summoned->GetGUID());
        }
    }

    void DoAction(int32 action) override
    {
        if (action == -1337)
            if (Creature* voidSentry = _instance->instance->GetCreature(_summonedGuid))
                voidSentry->DespawnOrUnsummon();
    }

    void JustDied(Unit* /*killer*/) override
    {
        _instance->SetData(DATA_ACHIEV, 0);
        if (Creature* voidSentry = _instance->instance->GetCreature(_summonedGuid))
            voidSentry->DespawnOrUnsummon();
        me->DespawnOrUnsummon(5s);
    }

    void SummonedCreatureDespawn(Creature* summoned) override
    {
        if (summoned)
            _instance->SetGuidData(DATA_DELETE_TRASH_MOB, summoned->GetGUID());
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);

        if (_events.ExecuteEvent() == EVENT_CHECK_SUMMONER)
        {
            bool good = false;
            if (me->IsSummon())
                if (Unit* s = me->ToTempSummon()->GetSummonerUnit())
                    if (s->IsAlive())
                        good = true;
            if (!good)
                me->KillSelf();
            _events.Repeat(5s);
        }
    }

private:
    InstanceScript* _instance;
    ObjectGuid _summonedGuid;
    EventMap _events;
};

void AddSC_boss_zuramat()
{
    RegisterVioletHoldCreatureAI(boss_zuramat);
    RegisterVioletHoldCreatureAI(npc_vh_void_sentry);
}
