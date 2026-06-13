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
    SPELL_ARCANE_BLAST          = 31457,
    SPELL_ARCANE_DISCHARGE      = 31472,
    SPELL_TIME_LAPSE            = 31467,
    SPELL_ATTRACTION            = 38540,
    SPELL_BANISH_DRAGON_HELPER  = 31550
};

 struct boss_chrono_lord_deja : public BossAI
 {
     boss_chrono_lord_deja(Creature* creature) : BossAI(creature, DATA_CHRONO_LORD_DEJA) { }

     void OwnTalk(uint32 id)
     {
         if (me->GetEntry() == NPC_CHRONO_LORD_DEJA)
         {
             Talk(id);
         }
     }

     void JustEngagedWith(Unit* /*who*/) override
     {
         OwnTalk(SAY_AGGRO);
         _JustEngagedWith();

         scheduler.Schedule(10s, [this](TaskContext context)
         {
             DoCastVictim(SPELL_ARCANE_BLAST);
             context.Repeat(20s);
         }).Schedule(15s, [this](TaskContext context)
         {
             DoCastAOE(SPELL_TIME_LAPSE);
             context.Repeat(20s);
         }).Schedule(20s, [this](TaskContext context)
         {
             DoCastAOE(SPELL_ARCANE_DISCHARGE);
             context.Repeat(25s);
         });

         if (IsHeroic())
         {
             scheduler.Schedule(20s, [this](TaskContext context)
             {
                 DoCastAOE(SPELL_ATTRACTION);
                 context.Repeat(30s);
             });
         }
     }

     void MoveInLineOfSight(Unit* who) override
     {
         if (who->IsCreature() && who->GetEntry() == NPC_TIME_KEEPER)
         {
             if (me->IsWithinDistInMap(who, 20.0f))
             {
                 OwnTalk(SAY_BANISH);
                 DoCastAOE(SPELL_BANISH_DRAGON_HELPER);
                 return;
             }
         }

         ScriptedAI::MoveInLineOfSight(who);
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
 };

void AddSC_boss_chrono_lord_deja()
{
    RegisterTheBlackMorassCreatureAI(boss_chrono_lord_deja);
}
