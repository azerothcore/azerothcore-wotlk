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

#include "scholomance.h"
#include "ScriptedCreature.h"

enum Spells
{
    SPELL_ARCANE_MISSILES = 15790,
    SPELL_CURSE_DARKMASTER = 18702,
    SPELL_SHADOW_SHIELD = 12040,
    SPELL_SHADOW_PORTAL = 17950
};

// official timers
/* enum Timers
{
    TIMER_ARCANE_MIN = 8000,
    TIMER_ARCANE_MAX = 14000,
    TIMER_CURSE_MIN = 20000,
    TIMER_CURSE_MAX = 30000,
    TIMER_SHIELD_MIN = 30000,
    TIMER_SHIELD_MAX = 40000,
    TIMER_PORTAL = 25000
};*/

// temp debug timers
 enum Timers
{
    TIMER_ARCANE_MIN = 8000,
    TIMER_ARCANE_MAX = 14000,
    TIMER_CURSE_MIN = 10000,
    TIMER_CURSE_MAX = 15000,
    TIMER_SHIELD_MIN = 20000,
    TIMER_SHIELD_MAX = 25000,
    TIMER_PORTAL = 40000
};

enum Rooms
{
    ROOM_HALL_OF_SECRETS       = 0,
    ROOM_HALL_OF_THE_DAMNED    = 1,
    ROOM_THE_COVEN             = 2,
    ROOM_THE_SHADOW_VAULT      = 3,
    ROOM_BAROV_FAMILY_VAULT    = 4,
    ROOM_VAULT_OF_THE_RAVENIAN = 5,
    ROOM_MAX                   = 6,
};

enum DoorState
{
    OPEN = true,
    CLOSED = false
};

class boss_darkmaster_gandling : public CreatureScript
{
public:
    boss_darkmaster_gandling() : CreatureScript("boss_darkmaster_gandling") {}

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScholomanceAI<boss_darkmaster_gandlingAI>(creature);
    }

    struct boss_darkmaster_gandlingAI : public BossAI
    {
        boss_darkmaster_gandlingAI(Creature* creature) : BossAI(creature, DATA_DARKMASTER_GANDLING), summons(me) { }

        SummonList summons;
        Player* portedPlayer;

        Creature* GuardiansList[6][3]; // 6 rooms, 3 mobs, access through GuardiansList[NORTH+EAST][1]

        // Only the 6 gates that gandling plays with.
        void SetGate(uint8 gate, bool open)
        {
            if (gate < 6)
            {
                instance->HandleGameObject(instance->GetGuidData(GandlingGateIds[gate]), open);
            }
        }

        void JustSummoned(Creature* cr) override
        {
            summons.Summon(cr);
            if (portedPlayer)
            {
                cr->AI()->AttackStart(portedPlayer);
            }
            LOG_FATAL("Entities:unit", "just summoned someone");
        }

        void EnterCombat(Unit* /*who*/) override
        {
            DoZoneInCombat();
            instance->SetData(DATA_DARKMASTER_GANDLING, IN_PROGRESS);
            events.Reset();
            events.ScheduleEvent(SPELL_ARCANE_MISSILES, TIMER_ARCANE_MIN);
            events.ScheduleEvent(SPELL_CURSE_DARKMASTER, TIMER_CURSE_MIN);
            events.ScheduleEvent(SPELL_SHADOW_SHIELD, TIMER_SHIELD_MIN);
            events.ScheduleEvent(SPELL_SHADOW_PORTAL, TIMER_PORTAL);
        }

        void JustDied(Unit* /*killer*/) override
        {
            instance->SetData(DATA_DARKMASTER_GANDLING, DONE);
        }

        void EnterEvadeMode() override
        {
            _EnterEvadeMode();
            instance->SetData(DATA_DARKMASTER_GANDLING, NOT_STARTED);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case SPELL_ARCANE_MISSILES:
                    DoCastVictim(SPELL_ARCANE_MISSILES);
                    events.ScheduleEvent(SPELL_ARCANE_MISSILES, urand(TIMER_ARCANE_MIN, TIMER_ARCANE_MAX));
                    break;
                case SPELL_CURSE_DARKMASTER:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 0.0f, true))
                        DoCast(target, SPELL_CURSE_DARKMASTER);
                    events.ScheduleEvent(SPELL_ARCANE_MISSILES, urand(TIMER_ARCANE_MIN, TIMER_ARCANE_MAX));
                    break;
                case SPELL_SHADOW_SHIELD:
                    DoCastSelf(SPELL_SHADOW_SHIELD);
                    events.ScheduleEvent(SPELL_ARCANE_MISSILES, urand(TIMER_ARCANE_MIN, TIMER_ARCANE_MAX));
                    break;

                case SPELL_SHADOW_PORTAL:
                    LOG_FATAL("Entities:unit", "shadow portal goes here");
                    events.ScheduleEvent(SPELL_SHADOW_PORTAL, TIMER_PORTAL);
                    break;
                default:
                    break;
                }
            }

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_darkmaster_gandling()
{
    new boss_darkmaster_gandling();
}
