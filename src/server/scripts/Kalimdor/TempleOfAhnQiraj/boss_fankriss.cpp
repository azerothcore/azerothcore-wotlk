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

/* ScriptData
SDName: Boss_Fankriss
SD%Complete: 100
SDComment: sound not implemented
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "TaskScheduler.h"
#include "temple_of_ahnqiraj.h"

#define SOUND_SENTENCE_YOU 8588
#define SOUND_SERVE_TO     8589
#define SOUND_LAWS         8590
#define SOUND_TRESPASS     8591
#define SOUND_WILL_BE      8592

enum Spells
{
    SPELL_MORTAL_WOUND      = 25646,
    SPELL_ROOT              = 28858,

    // Enrage for his spawns
    SPELL_ENRAGE            = 28798
};

class boss_fankriss : public CreatureScript
{
public:
    boss_fankriss() : CreatureScript("boss_fankriss") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetTempleOfAhnQirajAI<boss_fankrissAI>(creature);
    }

    struct boss_fankrissAI : public ScriptedAI
    {
        boss_fankrissAI(Creature* creature) : ScriptedAI(creature) { }

        void SummonSpawn()
        {
            Rand = 10 + (rand() % 10);
            switch (rand() % 2)
            {
                case 0:
                    RandX = 0.0f - Rand;
                    break;
                case 1:
                    RandX = 0.0f + Rand;
                    break;
            }

            Rand = 10 + (rand() % 10);
            switch (rand() % 2)
            {
                case 0:
                    RandY = 0.0f - Rand;
                    break;
                case 1:
                    RandY = 0.0f + Rand;
                    break;
            }
            Rand = 0;
            DoSpawnCreature(15630, RandX, RandY, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
        }

        void EnterCombat(Unit* /*who*/) override
        {
            _scheduler.CancelAll();

            _scheduler.Schedule(4s, 8s, [this](TaskContext context) {
                DoCastVictim(SPELL_MORTAL_WOUND);
                context.Repeat();
            }).Schedule(15s, 45s, [this](TaskContext context) {
                switch (urand(0, 2))
                {
                case 0:
                    SummonSpawn();
                    break;
                case 1:
                    SummonSpawn();
                    SummonSpawn();
                    break;
                case 2:
                    SummonSpawn();
                    SummonSpawn();
                    SummonSpawn();
                    break;
                }
                context.Repeat(30s, 60s);
            }).Schedule(15s, 45s, [this](TaskContext context) {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true))
                {
                    DoCast(target, SPELL_ROOT);

                        if (GetThreat(target))
                            ModifyThreatByPercent(target, -100);

                    switch (urand(0, 2))
                    {
                        case 0:
                            DoTeleportPlayer(target, -8106.0142f, 1289.2900f, -74.419533f, 5.112f);
                            me->SummonCreature(15962, target->GetPositionX() - 3, target->GetPositionY() - 3, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            me->SummonCreature(15962, target->GetPositionX() - 3, target->GetPositionY() + 3, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            me->SummonCreature(15962, target->GetPositionX() - 5, target->GetPositionY() - 5, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            me->SummonCreature(15962, target->GetPositionX() - 5, target->GetPositionY() + 5, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            break;
                        case 1:
                            DoTeleportPlayer(target, -7990.135354f, 1155.1907f, -78.849319f, 2.608f);
                            me->SummonCreature(15962, target->GetPositionX() - 3, target->GetPositionY() - 3, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            me->SummonCreature(15962, target->GetPositionX() - 3, target->GetPositionY() + 3, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            me->SummonCreature(15962, target->GetPositionX() - 5, target->GetPositionY() - 5, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            me->SummonCreature(15962, target->GetPositionX() - 5, target->GetPositionY() + 5, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            break;
                        case 2:
                            DoTeleportPlayer(target, -8159.7753f, 1127.9064f, -76.868660f, 0.675f);
                            me->SummonCreature(15962, target->GetPositionX() - 3, target->GetPositionY() - 3, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            me->SummonCreature(15962, target->GetPositionX() - 3, target->GetPositionY() + 3, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            me->SummonCreature(15962, target->GetPositionX() - 5, target->GetPositionY() - 5, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            me->SummonCreature(15962, target->GetPositionX() - 5, target->GetPositionY() + 5, target->GetPositionZ(), 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 15000);
                            break;
                    }
                }
                context.Repeat(45s, 60s);
            });
        }

        void UpdateAI(uint32 diff) override
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            _scheduler.Update(diff,
                std::bind(&ScriptedAI::DoMeleeAttackIfReady, this));
        }

    private:
        TaskScheduler _scheduler;
        int Rand;
        float RandX;
        float RandY;
    };
};

void AddSC_boss_fankriss()
{
    new boss_fankriss();
}
