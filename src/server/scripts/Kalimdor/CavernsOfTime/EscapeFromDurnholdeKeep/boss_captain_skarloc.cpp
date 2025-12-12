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
#include "old_hillsbrad.h"

enum Text
{
    SAY_ENTER                = 0,
    SAY_TAUNT                = 1,
    SAY_SLAY                 = 2,
    SAY_DEATH                = 3
};

enum Spells
{
    SPELL_HOLY_LIGHT         = 29427,
    SPELL_CLEANSE            = 29380,
    SPELL_HAMMER_OF_JUSTICE  = 13005,
    SPELL_HOLY_SHIELD        = 31904,
    SPELL_DEVOTION_AURA      = 8258,
    SPELL_CONSECRATION       = 38385
};

enum Misc
{
    WAYPOINTS_COUNT          = 4
};

const Position startPath[WAYPOINTS_COUNT] =
{
    {2008.38f, 281.57f, 65.70f, 0.0f},
    {2035.71f, 271.38f, 63.495f, 0.0f},
    {2049.12f, 252.31f, 62.855f, 0.0f},
    {2058.77f, 236.04f, 63.92f, 0.0f}
};

struct boss_captain_skarloc : public BossAI
{
    boss_captain_skarloc(Creature* creature) : BossAI(creature, DATA_CAPTAIN_SKARLOC), summons(me)
    {
        scheduler.SetValidator([this]
        {
            return !me->HasUnitState(UNIT_STATE_CASTING);
        });
    }

    SummonList summons;
    bool _spawnedAdds;

    void Reset() override
    {
        _Reset();
        summons.DespawnAll();
        _spawnedAdds = false;
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (Creature* thrall = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetGuidData(DATA_THRALL_GUID)))
        {
            thrall->AI()->JustSummoned(summon);
        }
        summon->SetImmuneToAll(true);
        if (summon->GetEntry() == NPC_SKARLOC_MOUNT)
            return;

        if (summons.size() == 1)
        {
            summon->GetMotionMaster()->MovePoint(0, 2060.788f, 237.301f, 63.999f);
        }
        else
        {
            summon->GetMotionMaster()->MovePoint(0, 2056.870f, 234.853f, 63.839f);
        }
    }

    void InitializeAI() override
    {
        ScriptedAI::InitializeAI();
        Movement::PointsArray path;
        path.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
        for (uint8 i = 0; i < WAYPOINTS_COUNT; ++i)
        {
            path.push_back(G3D::Vector3(startPath[i].GetPositionX(), startPath[i].GetPositionY(), startPath[i].GetPositionZ()));
        }
        me->GetMotionMaster()->MoveSplinePath(&path);
        me->SetImmuneToAll(true);
        me->Mount(SKARLOC_MOUNT_MODEL);
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type != ESCORT_MOTION_TYPE)
            return;

        if (!_spawnedAdds)
        {
            if (id == 1)
            {
                me->SummonCreature(NPC_DURNHOLDE_WARDEN, 2038.549f, 273.303f, 63.420f, 5.30f, TEMPSUMMON_MANUAL_DESPAWN);
                me->SummonCreature(NPC_DURNHOLDE_VETERAN, 2032.810f, 269.416f, 63.561f, 5.30f, TEMPSUMMON_MANUAL_DESPAWN);
            }
            else if (id == 2)
            {
                me->Dismount();
                me->SetWalk(true);
                summons.DoForAllSummons([&](WorldObject* summon)
                {
                    if (summon)
                    {
                        summon->ToCreature()->SetWalk(true);
                    }
                });
                if (Creature* mount = me->SummonCreature(NPC_SKARLOC_MOUNT, 2049.12f, 252.31f, 62.855f, me->GetOrientation(), TEMPSUMMON_MANUAL_DESPAWN))
                {
                    mount->SetImmuneToNPC(true);
                    mount->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                }

                _spawnedAdds = true;
            }
        }

        if (me->movespline->Finalized())
        {
            Talk(SAY_ENTER, 500ms);

            me->m_Events.AddEventAtOffset([this]()
            {
                me->SetImmuneToAll(false);
                me->SetInCombatWithZone();
                summons.DoForAllSummons([&](WorldObject* summon)
                {
                    if (Creature* adds = summon->ToCreature())
                    {
                        if (adds->GetEntry() != NPC_SKARLOC_MOUNT)
                        {
                            adds->SetImmuneToAll(false);
                            adds->SetInCombatWithZone();
                        }
                    }
                });
            }, 8s);
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();
        DoCastSelf(SPELL_DEVOTION_AURA);
        scheduler.Schedule(15s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_HOLY_LIGHT);
            context.Repeat(20s);
        }).Schedule(6s, [this](TaskContext context)
        {
            if (roll_chance_i(33))
            {
                Talk(SAY_TAUNT);
            }
            DoCastSelf(SPELL_CLEANSE);
            context.Repeat(10s);
        }).Schedule(20s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_HAMMER_OF_JUSTICE);
            context.Repeat(30s);
        }).Schedule(10s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_HOLY_SHIELD);
            context.Repeat(30s);
        });

        if (IsHeroic())
        {
            scheduler.Schedule(1s, [this](TaskContext context)
            {
                DoCastSelf(SPELL_CONSECRATION);
                context.Repeat(20s);
            });
        }
    }

    void KilledUnit(Unit*  /*victim*/) override
    {
        Talk(SAY_SLAY);
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        Talk(SAY_DEATH);
        me->GetInstanceScript()->SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_SKARLOC_KILLED);
        me->GetInstanceScript()->SetData(DATA_THRALL_ADD_FLAG, 0);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        scheduler.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        DoMeleeAttackIfReady();
    }
};

void AddSC_boss_captain_skarloc()
{
    RegisterOldHillsbradCreatureAI(boss_captain_skarloc);
}
