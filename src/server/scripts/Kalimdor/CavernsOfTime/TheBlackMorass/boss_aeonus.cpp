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
#include "the_black_morass.h"

enum Text
{
    SAY_AGGRO                   = 1,
    SAY_BANISH                  = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4,
    EMOTE_FRENZY                = 5
};

enum Spells
{
    SPELL_CLEAVE                = 40504,
    SPELL_TIME_STOP             = 31422,
    SPELL_ENRAGE                = 37605,
    SPELL_SAND_BREATH           = 31473,
    SPELL_CORRUPT_MEDIVH        = 37853,
    SPELL_BANISH_DRAGON_HELPER  = 31550
};

struct boss_aeonus : public BossAI
{
    boss_aeonus(Creature* creature) : BossAI(creature, DATA_AEONUS) { }

    void JustReachedHome() override
    {
        if (Creature* medivh = instance->GetCreature(DATA_MEDIVH))
        {
            if (me->GetDistance2d(medivh) < 20.0f)
            {
                DoCastAOE(SPELL_CORRUPT_MEDIVH);
            }
        }
    }

    void IsSummonedBy(WorldObject* /*summoner*/) override
    {
        me->SetReactState(REACT_DEFENSIVE);

        if (Creature* medivh = instance->GetCreature(DATA_MEDIVH))
        {
            me->SetHomePosition(medivh->GetPositionX() + 14.0f * cos(medivh->GetAngle(me)), medivh->GetPositionY() + 14.0f * std::sin(medivh->GetAngle(me)), medivh->GetPositionZ(), me->GetAngle(medivh));
            me->GetMotionMaster()->MoveTargetedHome();
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);

        scheduler.Schedule(5s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_CLEAVE);
            context.Repeat(10s);
        }).Schedule(20s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_SAND_BREATH);
            context.Repeat(20s);
        }).Schedule(15s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_TIME_STOP);
            context.Repeat(25s);
        }).Schedule(30s, [this](TaskContext context)
        {
            Talk(EMOTE_FRENZY);
            DoCastSelf(SPELL_ENRAGE);
            context.Repeat(30s);
        });
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (who->IsCreature() && who->GetEntry() == NPC_TIME_KEEPER)
        {
            if (me->IsWithinDistInMap(who, 20.0f))
            {
                Talk(SAY_BANISH);
                DoCastAOE(SPELL_BANISH_DRAGON_HELPER, true);
                return;
            }
        }

        ScriptedAI::MoveInLineOfSight(who);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);
        _JustDied();
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            Talk(SAY_SLAY);
        }
    }
};

void AddSC_boss_aeonus()
{
    RegisterTheBlackMorassCreatureAI(boss_aeonus);
}
