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

#include "ScriptObject.h"
#include "ScriptedCreature.h"
#include "steam_vault.h"

enum MekgineerSteamrigger
{
    SAY_MECHANICS               = 0,
    SAY_AGGRO                   = 1,
    SAY_SLAY                    = 2,
    SAY_DEATH                   = 3,

    SPELL_SUPER_SHRINK_RAY      = 31485,
    SPELL_SAW_BLADE             = 31486,
    SPELL_ELECTRIFIED_NET       = 35107,
    SPELL_REPAIR_N              = 31532,
    SPELL_REPAIR_H              = 37936,

    NPC_STREAMRIGGER_MECHANIC   = 17951,

    EVENT_CHECK_HP25            = 1,
    EVENT_CHECK_HP50            = 2,
    EVENT_CHECK_HP75            = 3,
    EVENT_SPELL_SHRINK          = 4,
    EVENT_SPELL_SAW             = 5,
    EVENT_SPELL_NET             = 6
};

class boss_mekgineer_steamrigger : public CreatureScript
{
public:
    boss_mekgineer_steamrigger() : CreatureScript("boss_mekgineer_steamrigger") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetSteamVaultAI<boss_mekgineer_steamriggerAI>(creature);
    }

    struct boss_mekgineer_steamriggerAI : public ScriptedAI
    {
        boss_mekgineer_steamriggerAI(Creature* creature) : ScriptedAI(creature)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;

        void Reset() override
        {
            events.Reset();
            if (instance)
                instance->SetData(TYPE_MEKGINEER_STEAMRIGGER, NOT_STARTED);
        }

        void JustDied(Unit* /*killer*/) override
        {
            Talk(SAY_DEATH);
            if (instance)
                instance->SetData(TYPE_MEKGINEER_STEAMRIGGER, DONE);
        }

        void KilledUnit(Unit* victim) override
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_SLAY);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            Talk(SAY_AGGRO);
            events.ScheduleEvent(EVENT_SPELL_SHRINK, 20000);
            events.ScheduleEvent(EVENT_SPELL_SAW, 15000);
            events.ScheduleEvent(EVENT_SPELL_NET, 10000);
            events.ScheduleEvent(EVENT_CHECK_HP75, 5000);
            events.ScheduleEvent(EVENT_CHECK_HP50, 5000);
            events.ScheduleEvent(EVENT_CHECK_HP25, 5000);

            if (instance)
                instance->SetData(TYPE_MEKGINEER_STEAMRIGGER, IN_PROGRESS);
        }

        void SummonMechanics()
        {
            Talk(SAY_MECHANICS);

            me->SummonCreature(NPC_STREAMRIGGER_MECHANIC, me->GetPositionX() + 15.0f, me->GetPositionY() + 15.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
            me->SummonCreature(NPC_STREAMRIGGER_MECHANIC, me->GetPositionX() - 15.0f, me->GetPositionY() + 15.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
            me->SummonCreature(NPC_STREAMRIGGER_MECHANIC, me->GetPositionX() - 15.0f, me->GetPositionY() - 15.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
            if (urand(0, 1))
                me->SummonCreature(NPC_STREAMRIGGER_MECHANIC, me->GetPositionX() + 15.0f, me->GetPositionY() - 15.0f, me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
        }

        void JustSummoned(Creature* cr) override
        {
            cr->GetMotionMaster()->MoveFollow(me, 0.0f, 0.0f);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            switch (uint32 eventId = events.ExecuteEvent())
            {
                case EVENT_SPELL_SHRINK:
                    me->CastSpell(me->GetVictim(), SPELL_SUPER_SHRINK_RAY, false);
                    events.RepeatEvent(20000);
                    break;
                case EVENT_SPELL_SAW:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 1))
                        me->CastSpell(target, SPELL_SAW_BLADE, false);
                    else
                        me->CastSpell(me->GetVictim(), SPELL_SAW_BLADE, false);
                    events.RepeatEvent(15000);
                    break;
                case EVENT_SPELL_NET:
                    if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                        me->CastSpell(target, SPELL_ELECTRIFIED_NET, false);
                    events.RepeatEvent(10000);
                    break;
                case EVENT_CHECK_HP25:
                case EVENT_CHECK_HP50:
                case EVENT_CHECK_HP75:
                    if (me->HealthBelowPct(eventId * 25))
                    {
                        SummonMechanics();
                        return;
                    }
                    events.RepeatEvent(2000);
                    break;
            }

            DoMeleeAttackIfReady();
        }
    };
};

class npc_steamrigger_mechanic : public CreatureScript
{
public:
    npc_steamrigger_mechanic() : CreatureScript("npc_steamrigger_mechanic") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetSteamVaultAI<npc_steamrigger_mechanicAI>(creature);
    }

    struct npc_steamrigger_mechanicAI : public ScriptedAI
    {
        npc_steamrigger_mechanicAI(Creature* creature) : ScriptedAI(creature)
        {
        }

        uint32 repairTimer;
        ObjectGuid bossGUID;

        void Reset() override
        {
            repairTimer = 0;
            bossGUID.Clear();
            if (InstanceScript* instance = me->GetInstanceScript())
                bossGUID = instance->GetGuidData(TYPE_MEKGINEER_STEAMRIGGER);
        }

        void MoveInLineOfSight(Unit* /*who*/) override {}

        void UpdateAI(uint32 diff) override
        {
            repairTimer += diff;
            if (repairTimer >= 2000)
            {
                repairTimer = 0;
                if (Unit* boss = ObjectAccessor::GetUnit(*me, bossGUID))
                {
                    if (me->IsWithinDistInMap(boss, 13.0f))
                        if (!me->HasUnitState(UNIT_STATE_CASTING))
                            me->CastSpell(me, DUNGEON_MODE(SPELL_REPAIR_N, SPELL_REPAIR_H), false);
                }
                return;
            }

            if (!UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_mekgineer_steamrigger()
{
    new boss_mekgineer_steamrigger();
    new npc_steamrigger_mechanic();
}
