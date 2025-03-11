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
#include "magisters_terrace.h"

enum Says
{
    SAY_AGGRO                       = 0,
    SAY_ENERGY                      = 1,
    SAY_EMPOWERED                   = 2,
    SAY_KILL                        = 3,
    SAY_DEATH                       = 4,
    EMOTE_CRYSTAL                   = 5
};

enum Spells
{
    SPELL_FEL_CRYSTAL_COSMETIC      = 44374,
    SPELL_MANA_RAGE                 = 44320,
    SPELL_MANA_RAGE_TRIGGER         = 44321,

    //Selin's spells
    SPELL_DRAIN_LIFE                = 44294,
    SPELL_FEL_EXPLOSION             = 44314,
    SPELL_DRAIN_MANA                = 46153
};

const Position crystalSummons[5] =
{
    {248.053f, 14.592f, 3.74882f, 3.94444f},
    {225.969f, -20.0775f, -2.9731f, 0.942478f},
    {226.314f, 20.2183f, -2.98127f, 5.32325f},
    {247.888f, -14.6252f, 3.80777f, 2.33874f},
    {263.149f, 0.309245f, 1.32057f, 3.15905f}
};

struct boss_selin_fireheart : public BossAI
{
    boss_selin_fireheart(Creature* creature) : BossAI(creature, DATA_SELIN_FIREHEART) { }

    bool CanAIAttack(Unit const* who) const override
    {
        return who->GetPositionX() > 216.0f;
    }

    void Reset() override
    {
        BossAI::Reset();
        SpawnCrystals();
        me->SetPower(POWER_MANA, 0);
    }

    void SpawnCrystals()
    {
        for (Position pos : crystalSummons)
            me->SummonCreature(NPC_FEL_CRYSTAL, pos, TEMPSUMMON_CORPSE_DESPAWN);
    }

    void SummonedCreatureDies(Creature* summon, Unit* killer) override
    {
        BossAI::SummonedCreatureDies(summon, killer);
        me->ResumeChasingVictim();
    }

    void OnPowerUpdate(Powers /*power*/, int32 /*gain*/, int32 /*updateVal*/, uint32 currentPower) override
    {
        if (currentPower == me->GetMaxPower(POWER_MANA))
        {
            Talk(SAY_EMPOWERED);
            if (Creature* crystal = SelectNearestCrystal(false))
                crystal->KillSelf();
            scheduler.DelayAll(10s);
            me->ResumeChasingVictim();
        }
    }

    void JustEngagedWith(Unit* who) override
    {
        BossAI::JustEngagedWith(who);
        ScheduleTimedEvent(2500ms, [&]{
            DoCastRandomTarget(SPELL_DRAIN_LIFE);
        }, 10000ms);
        ScheduleTimedEvent(2s, [&]{
            me->RemoveAuraFromStack(SPELL_MANA_RAGE_TRIGGER);
            DoCastAOE(SPELL_FEL_EXPLOSION);
        }, 2s);
        ScheduleTimedEvent(14s, [&]{
            scheduler.DelayAll(10s);
            SelectNearestCrystal(true);
        }, 30s);
        if (IsHeroic())
        {
            ScheduleTimedEvent(7500ms, [&]{
                if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, POWER_MANA, 40.0f, false)))
                    DoCast(target, SPELL_DRAIN_MANA);
            }, 10s);
        }
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
            Talk(SAY_KILL);
    }

    void JustDied(Unit* killer) override
    {
        BossAI::JustDied(killer);
        Talk(SAY_DEATH);
    }

    Creature* SelectNearestCrystal(bool performMovement)
    {
        if (summons.empty())
            return nullptr;

        float closestDistance = 1000.0f;
        Creature* chosenCrystal = nullptr;
        summons.DoForAllSummons([&](WorldObject* summon)
        {
            if (Creature* summonedCreature = summon->ToCreature())
            {
                float checkDistance = me->GetDistance2d(summonedCreature);
                if (checkDistance < closestDistance)
                {
                    closestDistance = checkDistance;
                    chosenCrystal = summonedCreature;
                }
            }
        });
        if (chosenCrystal && performMovement)
        {
            Talk(SAY_ENERGY);
            float x, y, z;
            chosenCrystal->GetClosePoint(x, y, z, me->GetObjectSize(), CONTACT_DISTANCE);
            me->GetMotionMaster()->MovePoint(2, x, y, z);
        }
        return chosenCrystal;
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == 2)
        {
            if (Creature* crystal = SelectNearestCrystal(false))
            {
                Talk(EMOTE_CRYSTAL);
                crystal->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
                crystal->SetInCombatWithZone();
                crystal->AI()->DoCast(me, SPELL_MANA_RAGE, true);
                DoCast(crystal, SPELL_FEL_CRYSTAL_COSMETIC, true);
            }
            else
                me->ResumeChasingVictim();
        }
    }
};

void AddSC_boss_selin_fireheart()
{
    RegisterMagistersTerraceCreatureAI(boss_selin_fireheart);
}
