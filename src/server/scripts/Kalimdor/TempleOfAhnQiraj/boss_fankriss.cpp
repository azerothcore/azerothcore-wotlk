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
#include "temple_of_ahnqiraj.h"

enum Spells
{
    SPELL_MORTAL_WOUND      = 25646,
    SPELL_ENTANGLE_RIGHT    = 720,
    SPELL_ENTANGLE_CENTER   = 731,
    SPELL_ENTANGLE_LEFT     = 1121,

    SPELL_SUMMON_WORM_1     = 518,
    SPELL_SUMMON_WORM_2     = 25831,
    SPELL_SUMMON_WORM_3     = 25832
};

enum Misc
{
    MAX_HATCHLING_SPAWN     = 4,
    NPC_VEKNISS_HATCHLING   = 15962
};

const std::array<Position, 3> hatchlingsSpawnPoints
{
    {
        { -8043.6f, 1254.1f, -84.3f }, // Right
        { -8003.0f, 1222.9f, -82.1f }, // Center
        { -8022.3f, 1149.0f, -89.1f }  // Left
    }
};

const std::array<uint32, 3> entangleSpells = { SPELL_ENTANGLE_RIGHT, SPELL_ENTANGLE_CENTER, SPELL_ENTANGLE_LEFT };

struct boss_fankriss : public BossAI
{
    boss_fankriss(Creature* creature) : BossAI(creature, DATA_FANKRISS)
    {
        me->m_CombatDistance = 80.f;
    }

    void Reset() override
    {
        summonWormSpells = { SPELL_SUMMON_WORM_1, SPELL_SUMMON_WORM_2, SPELL_SUMMON_WORM_3};
        BossAI::Reset();
    }

    void SummonWorms()
    {
        uint32 amount = urand(1, 3);
        Acore::Containers::RandomResize(summonWormSpells, amount);
        for (uint32 summonSpell : summonWormSpells)
            DoCastAOE(summonSpell, true);
        summonWormSpells = { SPELL_SUMMON_WORM_1, SPELL_SUMMON_WORM_2, SPELL_SUMMON_WORM_3 };
    }

    void SummonHatchlingWaves()
    {
        for (Position spawnPos : hatchlingsSpawnPoints)
        {
            for (uint8 i = 0; i < MAX_HATCHLING_SPAWN; i++)
            {
                Position randSpawn = me->GetRandomPoint(spawnPos, 10.f);
                me->SummonCreature(NPC_VEKNISS_HATCHLING, randSpawn, TEMPSUMMON_CORPSE_DESPAWN);
            }
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);

        scheduler.Schedule(7s, 14s, [this](TaskContext context)
            {
                DoCastVictim(SPELL_MORTAL_WOUND);
                context.Repeat();
            })
            .Schedule(30s, 50s, [this](TaskContext context)
            {
                SummonWorms();
                context.Repeat(22s, 70s);
            })
            .Schedule(15s, 20s, [this](TaskContext context)
            {
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 0.0f, true, false))
                {
                    uint32 spellId = Acore::Containers::SelectRandomContainerElement(entangleSpells);
                    DoCast(target, spellId);
                }

                SummonHatchlingWaves();
                context.Repeat(25s, 55s);
            });
    }

private:
    std::vector<uint32> summonWormSpells;
};

void AddSC_boss_fankriss()
{
    RegisterTempleOfAhnQirajCreatureAI(boss_fankriss);
}
