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

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Spell.h"
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

    // Razzashi Cobra (11373)
    SPELL_COBRA_POISON              = 24097
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

Position const SpawnCobras[4] =
{
    { -12021.20f, -1719.73f, 39.34f, 0.85f },
    { -12029.40f, -1714.54f, 39.36f, 0.68f },
    { -12036.79f, -1704.27f, 40.06f, 0.45f },
    { -12037.70f, -1694.20f, 39.35f, 0.27f }
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

        _spawnCobras();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        me->SetReactState(REACT_AGGRESSIVE);

        _setCobrasInCombat();

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

private:
    // Spawns the Razzashi Cobra adds before the encounter starts
    void _spawnCobras()
    {
        for (uint8 i = 0; i < 4; ++i)
        {
            BossAI::JustSummoned(me->SummonCreature(NPC_RAZZASHI_COBRA, SpawnCobras[i], TEMPSUMMON_CORPSE_DESPAWN));
        }
    }

    // Sets all Razzashi Cobras in combat with the zone
    void _setCobrasInCombat()
    {
        BossAI::summons.DoForAllSummons([&](WorldObject* cobra)
        {
            cobra->ToCreature()->SetInCombatWithZone();
        });
    }
};

// Razzashi Cobra (11373) - Venoxis adds
struct npc_razzashi_cobra_venoxis : public CreatureAI
{
public:
    npc_razzashi_cobra_venoxis(Creature* creature) : CreatureAI(creature) {}

    void InitializeAI() override
    {
        _scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });

        if (me->ToTempSummon() &&
            me->ToTempSummon()->GetSummoner() &&
            me->ToTempSummon()->GetSummoner()->ToCreature()
        )
        {
            _venoxis = me->ToTempSummon()->GetSummoner()->ToCreature();
        }

        Reset();
    }

    void Reset() override
    {
        _scheduler.CancelAll();
        CreatureAI::Reset();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        if (_venoxis)
        {
            // Venoxis pulls with his adds
            _venoxis->SetInCombatWithZone();
        }

        _scheduler.Schedule(8s, [this](TaskContext context)
        {
            me->CastSpell(me->GetVictim(), SPELL_COBRA_POISON);
            context.Repeat(15s);
        });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
        {
            return;
        }

        _scheduler.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
        {
            return;
        }

        DoMeleeAttackIfReady();
    }

private:
    TaskScheduler _scheduler;
    Creature* _venoxis;
};

void AddSC_boss_venoxis()
{
    RegisterCreatureAI(boss_venoxis);
    RegisterCreatureAI(npc_razzashi_cobra_venoxis);
}
