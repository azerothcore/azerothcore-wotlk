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

enum Spells
{
    SPELL_ARCANE_EXPLOSION                        = 46608,
    SPELL_CONE_OF_COLD                            = 38384,
    SPELL_FIREBALL                                = 46988,
    SPELL_FROSTBOLT                               = 46987,
    SPELL_SUMMON_WATER_ELEMENTAL                  = 45067,
    SPELL_ICEBLOCK                                = 46604
};

enum Yells
{
    SAY_AGGRO                                   = 0,
    SAY_EVADE                                   = 1,
    SAY_SALVATION                               = 2,
};

enum Creatures
{
    NPC_WATER_ELEMENTAL                           = 25040
};

struct boss_balinda : public ScriptedAI
{
    boss_balinda(Creature* creature) : ScriptedAI(creature), summons(me), _hasCastIceBlock(false)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    void Reset() override
    {
        summons.DespawnAll();
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _hasCastIceBlock = false;

        Talk(SAY_AGGRO);

        ScheduleTimedEvent(3s, [&]
        {
            if (summons.empty())
            {
                DoCast(SPELL_SUMMON_WATER_ELEMENTAL);
            }
        }, 50s, 50s);

        ScheduleTimedEvent(5s, 15s, [&]
        {
            DoCastAOE(SPELL_ARCANE_EXPLOSION);
        }, 5s, 15s);

        ScheduleTimedEvent(8s, [&]
        {
            DoCastVictim(SPELL_CONE_OF_COLD);
        }, 10s, 20s);

        ScheduleTimedEvent(1s, [&]
        {
            DoCastVictim(SPELL_FIREBALL);
        }, 5s, 9s);

        ScheduleTimedEvent(4s, [&]
        {
            DoCastVictim(SPELL_FROSTBOLT);
        }, 4s, 12s);

        ScheduleTimedEvent(5s, [&]
        {
            if (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) > 50)
            {
                EnterEvadeMode();
                Talk(SAY_EVADE);
            }

            if (Creature* elemental = summons.GetCreatureWithEntry(NPC_WATER_ELEMENTAL))
            {
                if (elemental->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) > 50)
                {
                    elemental->AI()->EnterEvadeMode();
                }
            }

        }, 5s, 5s);
    }

    void JustSummoned(Creature* summoned) override
    {
        summoned->AI()->AttackStart(SelectTarget(SelectTargetMethod::Random, 0, 50, true));
        summoned->SetFaction(me->GetFaction());
        summons.Summon(summoned);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage, DamageEffectType /*type*/, SpellSchoolMask /*school*/) override
    {
        if (me->HealthBelowPctDamaged(40, damage) && !_hasCastIceBlock)
        {
            DoCast(SPELL_ICEBLOCK);
            _hasCastIceBlock = true;
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        summons.DespawnAll();
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff,
            std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
    }

private:
    SummonList summons;
    bool _hasCastIceBlock;
};

void AddSC_boss_balinda()
{
    RegisterCreatureAI(boss_balinda);
}
