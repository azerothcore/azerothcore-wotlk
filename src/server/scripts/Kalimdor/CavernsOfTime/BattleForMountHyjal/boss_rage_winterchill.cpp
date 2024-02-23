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
#include "hyjal.h"
#include "hyjal_trash.h"

enum Spells
{
    SPELL_FROST_ARMOR           = 31256,
    SPELL_DEATH_AND_DECAY       = 31258,
    SPELL_FROST_NOVA            = 31250,
    SPELL_ICEBOLT               = 31249
};

enum Texts
{
    SAY_ONDEATH                 = 0,
    SAY_ONSLAY                  = 1,
    SAY_DECAY                   = 2,
    SAY_NOVA                    = 3,
    SAY_ONAGGRO                 = 4
};

enum Misc
{
    PATH_RAGE_WINTERCHILL       = 177670,
    POINT_COMBAT_START          = 7
};

class boss_rage_winterchill : public CreatureScript
{
public:
    boss_rage_winterchill() : CreatureScript("boss_rage_winterchill") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetHyjalAI<boss_rage_winterchillAI>(creature);
    }

    struct boss_rage_winterchillAI : public hyjal_trashAI
    {
        boss_rage_winterchillAI(Creature* creature) : hyjal_trashAI(creature)
        {
            instance = creature->GetInstanceScript();
            go = false;
        }

        uint32 FrostArmorTimer;
        uint32 DecayTimer;
        uint32 NovaTimer;
        uint32 IceboltTimer;
        bool go;

        void Reset() override
        {
            damageTaken = 0;
            FrostArmorTimer = 37000;
            DecayTimer = 45000;
            NovaTimer = 15000;
            IceboltTimer = 10000;

            if (IsEvent)
                instance->SetData(DATA_RAGEWINTERCHILLEVENT, NOT_STARTED);
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            if (IsEvent)
                instance->SetData(DATA_RAGEWINTERCHILLEVENT, IN_PROGRESS);
            Talk(SAY_ONAGGRO);
        }

        void KilledUnit(Unit* /*victim*/) override
        {
            Talk(SAY_ONSLAY);
        }

        void WaypointReached(uint32 waypointId) override
        {
            if (waypointId == POINT_COMBAT_START && instance)
            {
                Unit* target = ObjectAccessor::GetUnit(*me, instance->GetGuidData(DATA_JAINAPROUDMOORE));
                if (target && target->IsAlive())
                    me->AddThreat(target, 0.0f);
            }
        }

        void JustDied(Unit* killer) override
        {
            hyjal_trashAI::JustDied(killer);
            if (IsEvent)
                instance->SetData(DATA_RAGEWINTERCHILLEVENT, DONE);
            Talk(SAY_ONDEATH);
        }

        void UpdateAI(uint32 diff) override
        {
            if (IsEvent)
            {
                //Must update npc_escortAI
                npc_escortAI::UpdateAI(diff);
                if (!go)
                {
                    go = true;
                    me->GetMotionMaster()->MovePath(PATH_RAGE_WINTERCHILL, false);
                }
            }

            //Return since we have no target
            if (!UpdateVictim())
                return;

            if (FrostArmorTimer <= diff)
            {
                DoCast(me, SPELL_FROST_ARMOR);
                FrostArmorTimer = 40000 + rand() % 20000;
            }
            else FrostArmorTimer -= diff;
            if (DecayTimer <= diff)
            {
                DoCastVictim(SPELL_DEATH_AND_DECAY);
                DecayTimer = 60000 + rand() % 20000;
                Talk(SAY_DECAY);
            }
            else DecayTimer -= diff;
            if (NovaTimer <= diff)
            {
                DoCastVictim(SPELL_FROST_NOVA);
                NovaTimer = 30000 + rand() % 15000;
                Talk(SAY_NOVA);
            }
            else NovaTimer -= diff;
            if (IceboltTimer <= diff)
            {
                DoCast(SelectTarget(SelectTargetMethod::Random, 0, 40, true), SPELL_ICEBOLT);
                IceboltTimer = 11000 + rand() % 20000;
            }
            else IceboltTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_rage_winterchill()
{
    new boss_rage_winterchill();
}
