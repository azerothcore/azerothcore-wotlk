/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
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

class boss_selin_fireheart : public CreatureScript
{
public:
    boss_selin_fireheart() : CreatureScript("boss_selin_fireheart") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_selin_fireheartAI>(creature);
    };

    struct boss_selin_fireheartAI : public ScriptedAI
    {
        boss_selin_fireheartAI(Creature* creature) : ScriptedAI(creature), summons(me)
        {
            instance = creature->GetInstanceScript();
        }

        InstanceScript* instance;
        EventMap events;
        SummonList summons;
        uint64 CrystalGUID;

        bool CanAIAttack(const Unit* who) const
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

        void JustSummoned(Creature* summon)
        {
            summon->SetReactState(REACT_PASSIVE);
            summons.Summon(summon);
        }

        void SummonedCreatureDies(Creature* summon, Unit*)
        {
            summons.Despawn(summon);
            if (events.GetPhaseMask() & 0x01)
                events.ScheduleEvent(EVENT_RESTORE_COMBAT, 0);
        }

        void Reset()
        {
            events.Reset();
            summons.DespawnAll();
            SpawnCrystals();
            instance->SetData(DATA_SELIN_EVENT, NOT_STARTED);
            CrystalGUID = 0;
            me->SetPower(POWER_MANA, 0);
        }

        void EnterCombat(Unit* /*who*/)
        {
            Talk(SAY_AGGRO);
            instance->SetData(DATA_SELIN_EVENT, IN_PROGRESS);

            events.ScheduleEvent(EVENT_SPELL_DRAIN_LIFE, 2500, 1);
            events.ScheduleEvent(EVENT_SPELL_FEL_EXPLOSION, 2000);
            events.ScheduleEvent(EVENT_DRAIN_CRYSTAL, 14000);
            
            if (IsHeroic())
                events.ScheduleEvent(EVENT_SPELL_DRAIN_MANA, 7500, 1);
         }

        void KilledUnit(Unit* victim)
        {
            if (victim->GetTypeId() == TYPEID_PLAYER)
                Talk(SAY_KILL);
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);

            instance->SetData(DATA_SELIN_EVENT, DONE);         // Encounter complete!
            summons.DespawnAll();
        }

        void SelectNearestCrystal()
        {
            if (summons.empty())
                return;

            CrystalGUID = 0;
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

        void MovementInform(uint32 type, uint32 id)
        {
            if (type == POINT_MOTION_TYPE && id == 2)
            {
                if (Unit* crystal = ObjectAccessor::GetUnit(*me, CrystalGUID))
                {
                    Talk(EMOTE_CRYSTAL);
                    crystal->SetUInt32Value(UNIT_FIELD_FLAGS, 0);
                    crystal->CastSpell(me, SPELL_MANA_RAGE, true);
                    me->CastSpell(crystal, SPELL_FEL_CRYSTAL_COSMETIC, true);
                    events.SetPhase(1);
                    events.ScheduleEvent(EVENT_EMPOWER, 0, 0, 1);
                }
                else
                    events.ScheduleEvent(EVENT_RESTORE_COMBAT, 0);
            }
        }

        void UpdateAI(uint32 diff)
        {
            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_DRAIN_LIFE:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                        me->CastSpell(target, DUNGEON_MODE(SPELL_DRAIN_LIFE_N, SPELL_DRAIN_LIFE_H), false);
                    events.ScheduleEvent(EVENT_SPELL_DRAIN_LIFE, 10000, 1);
                    return;
                case EVENT_SPELL_DRAIN_MANA:
                    if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, PowerUsersSelector(me, POWER_MANA, 40.0f, false)))
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
};

void AddSC_boss_selin_fireheart()
{
    new boss_selin_fireheart();
}
