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

    //SPELL_ZURAMAT_ADD_2_N                         = 54342,
    //SPELL_ZURAMAT_ADD_2_H                         = 59747,
};

#define NPC_VOID_SENTRY_BALL                        29365

enum eEvents
{
    EVENT_SPELL_SHROUD_OF_DARKNESS = 1,
    EVENT_SPELL_VOID_SHIFT,
    EVENT_SPELL_SUMMON_VOID_SENTRY,
};

class boss_zuramat : public CreatureScript
{
public:
    boss_zuramat() : CreatureScript("boss_zuramat") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetVioletHoldAI<boss_zuramatAI>(pCreature);
    }

    struct boss_zuramatAI : public ScriptedAI
    {
        boss_zuramatAI(Creature* c) : ScriptedAI(c), summons(me)
        {
            pInstance = c->GetInstanceScript();
        }

        InstanceScript* pInstance;
        EventMap events;
        SummonList summons;

        void Reset() override
        {
            events.Reset();
            summons.DespawnAll();
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            DoZoneInCombat();
            events.Reset();
            events.RescheduleEvent(EVENT_SPELL_SHROUD_OF_DARKNESS, 5s, 7s);
            events.RescheduleEvent(EVENT_SPELL_VOID_SHIFT, 23s, 25s);
            events.RescheduleEvent(EVENT_SPELL_SUMMON_VOID_SENTRY, 10s);
            if (pInstance)
                pInstance->SetData(DATA_ACHIEV, 1);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case 0:
                    break;
                case EVENT_SPELL_SHROUD_OF_DARKNESS:
                    me->CastSpell(me, SPELL_SHROUD_OF_DARKNESS, false);
                    Talk(SAY_SHIELD);
                    events.Repeat(20s);
                    break;
                case EVENT_SPELL_VOID_SHIFT:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 60.0f, true))
                    {
                        me->CastSpell(target, SPELL_VOID_SHIFT, false);
                        me->Whisper("Gaze... into the void.", LANG_UNIVERSAL, target->ToPlayer());
                    }
                    events.Repeat(18s, 22s);
                    break;
                case EVENT_SPELL_SUMMON_VOID_SENTRY:
                    me->CastSpell((Unit*)nullptr, SPELL_SUMMON_VOID_SENTRY, false);
                    events.Repeat(12s);
                    break;
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/) override
        {
            summons.DespawnAll();
            Talk(SAY_DEATH);
            if (pInstance)
                pInstance->SetData(DATA_BOSS_DIED, 0);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim && victim->GetGUID() == me->GetGUID())
                return;

            Talk(SAY_SLAY);
        }

        void JustSummoned(Creature* pSummoned) override
        {
            if (pSummoned)
            {
                summons.Summon(pSummoned);
                pSummoned->SetPhaseMask(16, true);
                if (pInstance)
                    pInstance->SetGuidData(DATA_ADD_TRASH_MOB, pSummoned->GetGUID());
            }
        }

        void SummonedCreatureDespawn(Creature* pSummoned) override
        {
            if (pSummoned)
            {
                summons.Despawn(pSummoned);
                if (pSummoned->IsAIEnabled)
                    pSummoned->AI()->DoAction(-1337);
                if (pInstance)
                    pInstance->SetGuidData(DATA_DELETE_TRASH_MOB, pSummoned->GetGUID());
            }
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        void EnterEvadeMode(EvadeReason why) override
        {
            ScriptedAI::EnterEvadeMode(why);
            events.Reset();
            me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
            if (pInstance)
                pInstance->SetData(DATA_FAILED, 1);
        }
    };
};

class npc_vh_void_sentry : public CreatureScript
{
public:
    npc_vh_void_sentry() : CreatureScript("npc_vh_void_sentry") { }

    CreatureAI* GetAI(Creature* pCreature) const override
    {
        return GetVioletHoldAI<npc_vh_void_sentryAI>(pCreature);
    }

    struct npc_vh_void_sentryAI : public NullCreatureAI
    {
        npc_vh_void_sentryAI(Creature* c) : NullCreatureAI(c)
        {
            pInstance = c->GetInstanceScript();
            SummonedGUID.Clear();
            checkTimer = 5000;
            //me->CastSpell(me, SPELL_SUMMON_VOID_SENTRY_BALL, true);
            if (Creature* pSummoned = me->SummonCreature(NPC_VOID_SENTRY_BALL, *me, TEMPSUMMON_TIMED_DESPAWN, 300000))
            {
                pSummoned->SetPhaseMask(1, true);
                SummonedGUID = pSummoned->GetGUID();
                pInstance->SetGuidData(DATA_ADD_TRASH_MOB, pSummoned->GetGUID());
            }
        }

        InstanceScript* pInstance;
        ObjectGuid SummonedGUID;
        uint16 checkTimer;

        void DoAction(int32 a) override
        {
            if (a == -1337)
                if (Creature* c = pInstance->instance->GetCreature(SummonedGUID))
                    c->DespawnOrUnsummon();
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (pInstance)
            {
                pInstance->SetData(DATA_ACHIEV, 0);
                if (Creature* c = pInstance->instance->GetCreature(SummonedGUID))
                    c->DespawnOrUnsummon();
            }
            me->DespawnOrUnsummon(5s);
        }

        void SummonedCreatureDespawn(Creature* pSummoned) override
        {
            if (pSummoned)
                pInstance->SetGuidData(DATA_DELETE_TRASH_MOB, pSummoned->GetGUID());
        }

        void UpdateAI(uint32 diff) override
        {
            if (checkTimer <= diff)
            {
                checkTimer = 5000;
                bool good = false;
                if (me->IsSummon())
                    if (Unit* s = me->ToTempSummon()->GetSummonerUnit())
                        if (s->IsAlive())
                            good = true;
                if (!good)
                    me->KillSelf();
            }
            else
                checkTimer -= diff;
        }
    };
};

void AddSC_boss_zuramat()
{
    new boss_zuramat();
    new npc_vh_void_sentry();
}
