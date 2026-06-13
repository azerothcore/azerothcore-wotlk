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
#include "the_black_morass.h"

enum Text
{
    SAY_AGGRO                   = 1,
    SAY_BANISH                  = 2,
    SAY_SLAY                    = 3,
    SAY_DEATH                   = 4
};

enum Spells
{
    SPELL_HASTEN                = 31458,
    SPELL_MORTAL_WOUND          = 31464,
    SPELL_WING_BUFFET           = 31475,
    SPELL_REFLECT               = 38592,
    SPELL_BANISH_DRAGON_HELPER  = 31550
};

struct boss_temporus : public BossAI
{
    boss_temporus(Creature* creature) : BossAI(creature, DATA_TEMPORUS) { }

    void OwnTalk(uint32 id)
    {
        if (me->GetEntry() == NPC_TEMPORUS)
            Talk(id);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        scheduler.Schedule(12s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_HASTEN);
            context.Repeat(20s);
        }).Schedule(5s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_MORTAL_WOUND);
            context.Repeat(10s);
        }).Schedule(20s, [this](TaskContext context)
        {
            DoCastAOE(SPELL_WING_BUFFET);
            context.Repeat(20s);
        });

        if (IsHeroic())
        {
            scheduler.Schedule(28s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_REFLECT);
                context.Repeat(30s);
            });
        }
        OwnTalk(SAY_AGGRO);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
        {
            OwnTalk(SAY_SLAY);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        OwnTalk(SAY_DEATH);
        _JustDied();
    }

    void MoveInLineOfSight(Unit* who) override
    {
        if (who->IsCreature() && who->GetEntry() == NPC_TIME_KEEPER)
        {
            if (me->IsWithinDistInMap(who, 20.0f))
            {
                OwnTalk(SAY_BANISH);
                me->CastSpell(me, SPELL_BANISH_DRAGON_HELPER, true);
                return;
            }
        }
        ScriptedAI::MoveInLineOfSight(who);
    }
};

void AddSC_boss_temporus()
{
    RegisterTheBlackMorassCreatureAI(boss_temporus);
}
