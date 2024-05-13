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
#include "mechanar.h"

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_DOMINATION                  = 1,
    SAY_SUMMON                      = 2,
    SAY_ENRAGE                      = 3,
    SAY_SLAY                        = 4,
    SAY_DEATH                       = 5,
    SAY_APPEAR                      = 6
};

enum Spells
{
    SPELL_ARCANE_EXPLOSION          = 15453,
    SPELL_DISGRUNTLED_ANGER         = 35289,
    SPELL_ARCANE_TORRENT            = 36022,
    SPELL_MANA_TAP                  = 36021,
    SPELL_DOMINATION                = 35280,
    SPELL_FRENZY                    = 36992,
    SPELL_SUICIDE                   = 35301,
    SPELL_ETHEREAL_TELEPORT         = 34427,
    SPELL_GREATER_INVISIBILITY      = 34426,
    SPELL_SUMMON_NETHER_WRAITH_1    = 35285,
    SPELL_SUMMON_NETHER_WRAITH_2    = 35286,
    SPELL_SUMMON_NETHER_WRAITH_3    = 35287,
    SPELL_SUMMON_NETHER_WRAITH_4    = 35288,
};

enum Misc
{
    ACTION_BRIDGE_MOB_DEATH = 1, // Used by SAI
    EQUIPMENT_NORMAL        = 1,
    EQUIPMENT_FRENZY        = 2,
};

struct boss_pathaleon_the_calculator : public BossAI
{
    boss_pathaleon_the_calculator(Creature* creature) : BossAI(creature, DATA_PATHALEON_THE_CALCULATOR) { }

    bool _isEnraged;

    void Reset() override
    {
        _Reset();
        _isEnraged = false;
        me->LoadEquipment(EQUIPMENT_NORMAL);

        if (instance->GetPersistentData(DATA_BRIDGE_MOB_DEATH_COUNT) < 4)
        {
            DoCastSelf(SPELL_GREATER_INVISIBILITY);
        }
    }

    bool CanAIAttack(Unit const* /*target*/) const override
    {
        return instance->GetPersistentData(DATA_BRIDGE_MOB_DEATH_COUNT) >= 4;
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();

        ScheduleHealthCheckEvent(20, [&]()
        {
            DoCastSelf(SPELL_SUICIDE, true);
            DoCastSelf(SPELL_FRENZY, true);
            Talk(SAY_ENRAGE);
            _isEnraged = true;
            me->LoadEquipment(EQUIPMENT_FRENZY);
        });

        scheduler.Schedule(20s, 25s, [this](TaskContext context)
        {
            if (!_isEnraged)
            {
                for (uint8 i = 0; i < DUNGEON_MODE(3, 4); ++i)
                    me->CastSpell(me, SPELL_SUMMON_NETHER_WRAITH_1 + i, true);

                Talk(SAY_SUMMON);
            }
            context.Repeat(45s, 50s);
        }).Schedule(12s, [this](TaskContext context)
        {
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, POWER_MANA, 40.0f, false)))
            {
                DoCast(target, SPELL_MANA_TAP);
            }
            context.Repeat(18s);
        }).Schedule(16s, [this](TaskContext context)
        {
            me->RemoveAurasDueToSpell(SPELL_MANA_TAP);
            me->ModifyPower(POWER_MANA, 5000);
            DoCastSelf(SPELL_ARCANE_TORRENT);
            context.Repeat(15s);
        }).Schedule(10s, 15s, [this](TaskContext context)
        {
            if (DoCastRandomTarget(SPELL_DOMINATION, 1, 50.0f) == SPELL_CAST_OK)
            {
                Talk(SAY_DOMINATION);
            }
            context.Repeat(27s, 40s);
        }).Schedule(25s, [this](TaskContext context)
        {
            DoCast(SPELL_DISGRUNTLED_ANGER);
            context.Repeat(40s, 90s);
        });

        if (IsHeroic())
        {
            scheduler.Schedule(8s, [this](TaskContext context)
            {
                DoCastAOE(SPELL_ARCANE_EXPLOSION);
                context.Repeat(12s);
            });
        }

        Talk(SAY_AGGRO);
    }

    void DoAction(int32 actionId) override
    {
        if (actionId == ACTION_BRIDGE_MOB_DEATH)
        {
            uint8 mobCount = instance->GetPersistentData(DATA_BRIDGE_MOB_DEATH_COUNT);
            instance->StorePersistentData(DATA_BRIDGE_MOB_DEATH_COUNT, ++mobCount);

            if (mobCount >= 4)
            {
                DoCastSelf(SPELL_ETHEREAL_TELEPORT);
                Talk(SAY_APPEAR);

                scheduler.Schedule(2s, [this](TaskContext)
                {
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_READY1H);
                }).Schedule(25s, [this](TaskContext)
                {
                    DoZoneInCombat();
                });
            }
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
    }
};

void AddSC_boss_pathaleon_the_calculator()
{
    RegisterMechanarCreatureAI(boss_pathaleon_the_calculator);
}
