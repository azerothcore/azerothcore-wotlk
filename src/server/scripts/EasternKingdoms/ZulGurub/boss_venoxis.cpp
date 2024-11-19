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
#include "zulgurub.h"

/*
 * @todo
 * - Fix timers (research some more)
 */

enum Says
{
    SAY_VENOXIS_TRANSFORM           = 1,        // Let the coils of hate unfurl!
    SAY_VENOXIS_DEATH               = 2         // Ssserenity.. at lassst!
};

enum Spells
{
    // High Priest Venoxis (14507)
    // All Phases
    SPELL_THRASH                    = 3391,

    // Phase 1 - Troll Form
    SPELL_DISPEL_MAGIC              = 23859,
    SPELL_RENEW                     = 23895,
    SPELL_HOLY_NOVA                 = 23858,
    SPELL_HOLY_FIRE                 = 23860,
    SPELL_HOLY_WRATH                = 23979,

    // Transform
    SPELL_VENOXIS_TRANSFORM         = 23849,

    // Phase 2 - Snake Form
    SPELL_POISON_CLOUD              = 23861,
    SPELL_VENOM_SPIT                = 23862,
    SPELL_SUMMON_PARASITIC_SERPENT  = 23866,
    SPELL_FRENZY                    = 8269,
};

enum Phases
{
    PHASE_ONE                       = 1,    // troll form
    PHASE_TWO                       = 2     // snake form
};

enum NPCs
{
    BOSS_VENOXIS                    = 14507,
    NPC_RAZZASHI_COBRA              = 11373,
    NPC_PARASITIC_SERPENT           = 14884
};

// High Priest Venoxis (14507)
struct boss_venoxis : public BossAI
{
public:
    boss_venoxis(Creature* creature) : BossAI(creature, DATA_VENOXIS) { }

    void InitializeAI() override
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });

        Reset();
    }

    void Reset() override
    {
        BossAI::Reset();

        me->RemoveAllAuras();
        me->SetReactState(REACT_PASSIVE);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        me->SetReactState(REACT_AGGRESSIVE);

        // Both phases
        scheduler.Schedule(8s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_THRASH, true);
            context.Repeat(10s, 20s);
        });

        //
        // Phase 1 - Troll Form
        //
        scheduler.Schedule(5s, 15s, PHASE_ONE, [this](TaskContext context)
        {
            DoCastSelf(SPELL_HOLY_NOVA);
            context.Repeat(10s, 24s);
        }).Schedule(35s, PHASE_ONE, [this](TaskContext context)
        {
            DoCastSelf(SPELL_DISPEL_MAGIC);
            context.Repeat(15s, 20s);
        }).Schedule(10s, 20s, PHASE_ONE, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_HOLY_FIRE);
            context.Repeat(10s, 24s);
        }).Schedule(30s, PHASE_ONE, [this](TaskContext context)
        {
            DoCastSelf(SPELL_RENEW);
            context.Repeat(25s, 30s);
        }).Schedule(15s, 25s, PHASE_ONE, [this](TaskContext context)
        {
            DoCastRandomTarget(SPELL_HOLY_WRATH);
            context.Repeat(12s, 22s);
        });

        //
        // Phase 2 - Snake Form (50% health)
        //
        ScheduleHealthCheckEvent(50, [&]
        {
            scheduler.CancelGroup(PHASE_ONE);

            DoCastSelf(SPELL_VENOXIS_TRANSFORM);
            Talk(SAY_VENOXIS_TRANSFORM);
            DoResetThreatList();

            scheduler.Schedule(5s, PHASE_TWO, [this](TaskContext context)
            {
                DoCastSelf(SPELL_VENOM_SPIT);
                context.Repeat(5s, 15s);
            }).Schedule(10s, PHASE_TWO, [this](TaskContext context)
            {
                DoCastSelf(SPELL_POISON_CLOUD);
                context.Repeat(15s, 20s);
            }).Schedule(30s, PHASE_TWO, [this](TaskContext context)
            {
                DoCastSelf(SPELL_SUMMON_PARASITIC_SERPENT);
                context.Repeat(15s);
            });

            // frenzy at 20% health
            ScheduleHealthCheckEvent(20, [&]
            {
                DoCastSelf(SPELL_FRENZY, true);
            });
        });
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_VENOXIS_DEATH);
        me->RemoveAllAuras();       // removes transform
    }
};

void AddSC_boss_venoxis()
{
    RegisterCreatureAI(boss_venoxis);
}
