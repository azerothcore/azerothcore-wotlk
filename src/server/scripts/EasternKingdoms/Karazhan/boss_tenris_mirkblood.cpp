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
#include "SpellInfo.h"
#include "karazhan.h"

enum Text
{
    SAY_APPROACH = 0,
    SAY_AGGRO    = 1,
    SAY_SUMMON   = 2
};

enum Spells
{
    SPELL_BLOOD_MIRROR0                  = 50844, // clone, proc 1206
    SPELL_BLOOD_MIRROR1                  = 50845, // script, dummy, dummy
    SPELL_BLOOD_MIRROR_TARGET_PICKER     = 50883, // script
    SPELL_BLOOD_MIRROR_TRANSITION_VISUAL = 50910, // dummy
    SPELL_BLOOD_MIRROR_DAMAGE            = 50846, // damage

    SPELL_BLOOD_TAP = 51135, // drain health

    SPELL_BLOOD_SWOOP                             = 50922, // charge, periodic damage, trigger 50925
    SPELL_DASH_GASH_PRE_SPELL                     = 50923, // script, trigger 50922
    SPELL_DASH_GASH_RETURN_TO_TANK                = 50924, // charge
    SPELL_DASH_GASH_RETURN_TO_TANK_PRE_SPELL      = 50925, // null
    SPELL_DASH_GASH_RETURN_TO_TANK_PRE_SPELL_ROOT = 50932, // null

    SPELL_DESPAWN_SANGUINE_SPIRIT_VISUAL             = 51214, // dummy
    SPELL_DESPAWN_SANGUINE_SPIRITS                   = 51212, // script, dummy
    SPELL_SANGUINE_SPIRIT_AURA                       = 50993, // dummy, periodic trigger 51013
    SPELL_SANGUINE_SPIRIT_PRE_AURA                   = 51282, // dummy
    SPELL_SANGUINE_SPIRIT_PRE_AURA2                  = 51283, // size mod
    SPELL_SUMMON_SANGUINE_SPIRIT0                    = 50996, // null
    SPELL_SUMMON_SANGUINE_SPIRIT1                    = 50998, // trigger missile 50996
    SPELL_SUMMON_SANGUINE_SPIRIT2                    = 51204, // trigger missile 50996
    SPELL_SUMMON_SANGUINE_SPIRIT_MISSILE_BURST       = 51208, // periodic trigger 50998
    SPELL_SUMMON_SANGUINE_SPIRIT_SHORT_MISSILE_BURST = 51280, // periodic trigger 50998
    SPELL_SUMMON_SANGUINE_SPIRIT_ON_KILL             = 51205, // dummy
    SPELL_EXSANGUINATE                               = 51013, // damage
};

struct boss_tenris_mirkblood : public BossAI
{
    boss_tenris_mirkblood(Creature* creature) : BossAI(creature, DATA_MIRKBLOOD)
    {
        scheduler.SetValidator([this]
            {
                return !me->HasUnitState(UNIT_STATE_CASTING);
            });
    }

    void Reset() override
    {
        _Reset();
        ScheduleHealthCheckEvent(50, [&] {
            DoCast(SPELL_SUMMON_SANGUINE_SPIRIT_MISSILE_BURST);
            });
        scheduler.CancelAll();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        DoZoneInCombat();

        scheduler.Schedule(1s, 5s, [this](TaskContext context)
            { // Blood Mirror
                
                context.Repeat(20s, 50s);
            }).Schedule(30s, [this](TaskContext context)
            { // Blood Swoop
                DoCast(SPELL_DASH_GASH_PRE_SPELL);
                context.Repeat(15s, 40s);
            }).Schedule(10s, 15s, [this](TaskContext context)
            {
                DoCast(SPELL_BLOOD_TAP);
                context.Repeat(15s, 40s);
            }).Schedule(6s, 15s, [this](TaskContext context)
            {
                DoCast(SPELL_SUMMON_SANGUINE_SPIRIT_SHORT_MISSILE_BURST);
                context.Repeat(6s, 15s);
            });
    }

    void JustSummoned(Creature* summoned) override
    {
    }

    void KilledUnit(Unit* victim) override
    {
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
    }

    void DoAction(int32 actionId) override
    {
        ObjectGuid guid = ObjectGuid::Create<HighGuid::Player>(instance->GetPersistentData(DATA_MIRKBLOOD_APPROACH));
        if (!guid)
            return;

        if (actionId == DATA_MIRKBLOOD_APPROACH)
            Talk(SAY_APPROACH, ObjectAccessor::FindPlayer(guid));
        else if (actionId == DATA_MIRKBLOOD_ENTRANCE)
        {
            // AREA TRIGGER 5015 MAY ENGAGE OR JUST RELEASE NOT_SELECTABLE FLAG
        }
    }
};

void AddSC_boss_tenris_mirkblood()
{
    RegisterKarazhanCreatureAI(boss_tenris_mirkblood);
}
