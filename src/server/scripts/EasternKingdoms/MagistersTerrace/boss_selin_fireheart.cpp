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
    SPELL_DRAIN_LIFE_N              = 44294,
    SPELL_DRAIN_LIFE_H              = 46155,
    SPELL_FEL_EXPLOSION             = 44314,
    SPELL_DRAIN_MANA                = 46153
};

enum Events
{
    EVENT_SPELL_DRAIN_LIFE          = 1,
    EVENT_SPELL_FEL_EXPLOSION       = 2,
    EVENT_SPELL_DRAIN_MANA          = 3,
    EVENT_DRAIN_CRYSTAL             = 4,
    EVENT_EMPOWER                   = 5,
    EVENT_RESTORE_COMBAT            = 6
};

struct boss_selin_fireheart : public ScriptedAI
{
    boss_selin_fireheart(Creature* creature) : ScriptedAI(creature), summons(me)
    {
        instance = creature->GetInstanceScript();
    }

    InstanceScript* instance;
    EventMap events;
    SummonList summons;
    ObjectGuid CrystalGUID;

    bool CanAIAttack(Unit const* who) const override
    {
        return who->GetPositionX() > 216.0f;
    }

    void SpawnCrystals()
    {
        me->SummonCreature(NPC_FEL_CRYSTAL, 248.053f, 14.592f, 3.74882f, 3.94444f, TEMPSUMMON_CORPSE_DESPAWN);
        me->SummonCreature(NPC_FEL_CRYSTAL, 225.969f, -20.0775f, -2.9731f, 0.942478f, TEMPSUMMON_CORPSE_DESPAWN);
        me->SummonCreature(NPC_FEL_CRYSTAL, 226.314f, 20.2183f, -2.98127f, 5.32325f, TEMPSUMMON_CORPSE_DESPAWN);
        me->SummonCreature(NPC_FEL_CRYSTAL, 247.888f, -14.6252f, 3.80777f, 2.33874f, TEMPSUMMON_CORPSE_DESPAWN);
        me->SummonCreature(NPC_FEL_CRYSTAL, 263.149f, 0.309245f, 1.32057f, 3.15905f, TEMPSUMMON_CORPSE_DESPAWN);
    }

    void JustSummoned(Creature* summon) override
    {
        summon->SetReactState(REACT_PASSIVE);
        summons.Summon(summon);
    }

    void SummonedCreatureDies(Creature* summon, Unit*) override
    {
        summons.Despawn(summon);
        if (events.GetPhaseMask() & 0x01)
            events.ScheduleEvent(EVENT_RESTORE_COMBAT, 0);
    }

    void Reset() override
    {
        events.Reset();
        summons.DespawnAll();
        SpawnCrystals();
        instance->SetBossState(DATA_SELIN_FIREHEART, NOT_STARTED);
        CrystalGUID.Clear();
        me->SetPower(POWER_MANA, 0);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        Talk(SAY_AGGRO);
        instance->SetBossState(DATA_SELIN_FIREHEART, IN_PROGRESS);

        events.ScheduleEvent(EVENT_SPELL_DRAIN_LIFE, 2500, 1);
        events.ScheduleEvent(EVENT_SPELL_FEL_EXPLOSION, 2000);
        events.ScheduleEvent(EVENT_DRAIN_CRYSTAL, 14000);

        if (IsHeroic())
            events.ScheduleEvent(EVENT_SPELL_DRAIN_MANA, 7500, 1);
    }

    void KilledUnit(Unit* victim) override
    {
        if (victim->IsPlayer())
            Talk(SAY_KILL);
    }

    void JustDied(Unit* /*killer*/) override
    {
        Talk(SAY_DEATH);

        instance->SetBossState(DATA_SELIN_FIREHEART, DONE);         // Encounter complete!
        summons.DespawnAll();
    }

    void SelectNearestCrystal()
    {
        if (summons.empty())
            return;

        CrystalGUID.Clear();
        Unit* crystal = nullptr;
        for (SummonList::const_iterator i = summons.begin(); i != summons.end(); )
            if (Creature* summon = ObjectAccessor::GetCreature(*me, *i++))
                if (!crystal || me->GetDistanceOrder(summon, crystal, false))
                    crystal = summon;

        if (crystal)
        {
            Talk(SAY_ENERGY);
            float x, y, z;
            crystal->GetClosePoint(x, y, z, me->GetObjectSize(), CONTACT_DISTANCE);
            CrystalGUID = crystal->GetGUID();
            me->GetMotionMaster()->MovePoint(2, x, y, z);
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == POINT_MOTION_TYPE && id == 2)
        {
            if (Unit* crystal = ObjectAccessor::GetUnit(*me, CrystalGUID))
            {
                Talk(EMOTE_CRYSTAL);
                crystal->ReplaceAllUnitFlags(UNIT_FLAG_NONE);
                crystal->CastSpell(me, SPELL_MANA_RAGE, true);
                me->CastSpell(crystal, SPELL_FEL_CRYSTAL_COSMETIC, true);
                events.SetPhase(1);
                events.ScheduleEvent(EVENT_EMPOWER, 0, 0, 1);
            }
            else
                events.ScheduleEvent(EVENT_RESTORE_COMBAT, 0);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        switch (events.ExecuteEvent())
        {
        case EVENT_SPELL_DRAIN_LIFE:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0))
                me->CastSpell(target, DUNGEON_MODE(SPELL_DRAIN_LIFE_N, SPELL_DRAIN_LIFE_H), false);
            events.ScheduleEvent(EVENT_SPELL_DRAIN_LIFE, 10000, 1);
            return;
        case EVENT_SPELL_DRAIN_MANA:
            if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, PowerUsersSelector(me, POWER_MANA, 40.0f, false)))
                me->CastSpell(target, SPELL_DRAIN_MANA, false);
            events.ScheduleEvent(EVENT_SPELL_DRAIN_MANA, 10000, 1);
            return;
        case EVENT_SPELL_FEL_EXPLOSION:
            me->RemoveAuraFromStack(SPELL_MANA_RAGE_TRIGGER);
            me->CastSpell(me, SPELL_FEL_EXPLOSION, false);
            events.ScheduleEvent(EVENT_SPELL_FEL_EXPLOSION, 2000);
            break;
        case EVENT_DRAIN_CRYSTAL:
            events.DelayEvents(10001);
            events.ScheduleEvent(EVENT_EMPOWER, 10000);
            events.ScheduleEvent(EVENT_DRAIN_CRYSTAL, 30000);
            SelectNearestCrystal();
            break;
        case EVENT_EMPOWER:
            if (me->GetPower(POWER_MANA) == me->GetMaxPower(POWER_MANA))
            {
                Talk(SAY_EMPOWERED);
                if (Unit* crystal = ObjectAccessor::GetUnit(*me, CrystalGUID))
                    Unit::Kill(crystal, crystal);
                events.DelayEvents(10000, 1);
                events.ScheduleEvent(EVENT_RESTORE_COMBAT, 0);
            }
            else
                events.ScheduleEvent(EVENT_EMPOWER, 0, 0, 1);
            break;
        case EVENT_RESTORE_COMBAT:
            events.SetPhase(0);
            me->GetMotionMaster()->MoveChase(me->GetVictim());
            break;
        }

        DoMeleeAttackIfReady();
    }
};

void AddSC_boss_selin_fireheart()
{
    RegisterMagistersTerraceCreatureAI(boss_selin_fireheart);
}
