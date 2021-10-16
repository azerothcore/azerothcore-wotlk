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

#include "blackrock_depths.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"

enum Spells
{
    SPELL_SHADOWBOLT                                       = 17228,
    SPELL_CURSEOFTONGUES                                   = 15470,
    SPELL_CURSEOFWEAKNESS                                  = 17227,
    SPELL_DEMONARMOR                                       = 11735,
    SPELL_ENVELOPINGWEB                                    = 15471
};

class boss_anubshiah : public CreatureScript
{
public:
    boss_anubshiah() : CreatureScript("boss_anubshiah") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockDepthsAI<boss_anubshiahAI>(creature);
    }

    struct boss_anubshiahAI : public ScriptedAI
    {
        boss_anubshiahAI(Creature* creature) : ScriptedAI(creature) { }

        uint32 ShadowBolt_Timer;
        uint32 CurseOfTongues_Timer;
        uint32 CurseOfWeakness_Timer;
        uint32 DemonArmor_Timer;
        uint32 EnvelopingWeb_Timer;

        void Reset() override
        {
            ShadowBolt_Timer = 7000;
            CurseOfTongues_Timer = 24000;
            CurseOfWeakness_Timer = 12000;
            DemonArmor_Timer = 3000;
            EnvelopingWeb_Timer = 16000;
        }

        void EnterCombat(Unit* /*who*/) override { }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            //ShadowBolt_Timer
            if (ShadowBolt_Timer <= diff)
            {
                DoCastVictim(SPELL_SHADOWBOLT);
                ShadowBolt_Timer = 7000;
            }
            else ShadowBolt_Timer -= diff;

            //CurseOfTongues_Timer
            if (CurseOfTongues_Timer <= diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    DoCast(target, SPELL_CURSEOFTONGUES);
                CurseOfTongues_Timer = 18000;
            }
            else CurseOfTongues_Timer -= diff;

            //CurseOfWeakness_Timer
            if (CurseOfWeakness_Timer <= diff)
            {
                DoCastVictim(SPELL_CURSEOFWEAKNESS);
                CurseOfWeakness_Timer = 45000;
            }
            else CurseOfWeakness_Timer -= diff;

            //DemonArmor_Timer
            if (DemonArmor_Timer <= diff)
            {
                DoCast(me, SPELL_DEMONARMOR);
                DemonArmor_Timer = 300000;
            }
            else DemonArmor_Timer -= diff;

            //EnvelopingWeb_Timer
            if (EnvelopingWeb_Timer <= diff)
            {
                if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 100, true))
                    DoCast(target, SPELL_ENVELOPINGWEB);
                EnvelopingWeb_Timer = 12000;
            }
            else EnvelopingWeb_Timer -= diff;

            DoMeleeAttackIfReady();
        }
    };
};

void AddSC_boss_anubshiah()
{
    new boss_anubshiah();
}
