/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "old_hillsbrad.h"

enum CaptainSkarloc
{
    SAY_ENTER                   = 0,
    SAY_TAUNT                   = 1,
    SAY_SLAY                    = 2,
    SAY_DEATH                   = 3,

    SPELL_HOLY_LIGHT            = 29427,
    SPELL_CLEANSE               = 29380,
    SPELL_HAMMER_OF_JUSTICE     = 13005,
    SPELL_HOLY_SHIELD           = 31904,
    SPELL_DEVOTION_AURA         = 8258,
    SPELL_CONSECRATION          = 38385,

    WAYPOINTS_COUNT             = 4,

    EVENT_INITIAL_TALK          = 1,
    EVENT_START_FIGHT           = 2,
    EVENT_SPELL_CLEANSE         = 10,
    EVENT_SPELL_HAMMER          = 11,
    EVENT_SPELL_HOLY_LIGHT      = 12,
    EVENT_SPELL_HOLY_SHIELD     = 13,
    EVENT_SPELL_CONSECRATION    = 14
};

const Position startPath[WAYPOINTS_COUNT] =
{
    {2008.38f, 281.57f, 65.70f, 0.0f},
    {2035.71f, 271.38f, 63.495f, 0.0f},
    {2049.12f, 252.31f, 62.855f, 0.0f},
    {2058.77f, 236.04f, 63.92f, 0.0f}
};

class boss_captain_skarloc : public CreatureScript
{
public:
    boss_captain_skarloc() : CreatureScript("boss_captain_skarloc") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return GetInstanceAI<boss_captain_skarlocAI>(creature);
    }

    struct boss_captain_skarlocAI : public ScriptedAI
    {
        boss_captain_skarlocAI(Creature* creature) : ScriptedAI(creature), summons(me) { }

        EventMap events;
        EventMap events2;
        SummonList summons;

        void Reset()
        {
            events.Reset();
            events2.Reset();
            summons.DespawnAll();
        }

        void JustSummoned(Creature* summon)
        {
            summons.Summon(summon);
            if (Creature* thrall = ObjectAccessor::GetCreature(*me, me->GetInstanceScript()->GetData64(DATA_THRALL_GUID)))
                thrall->AI()->JustSummoned(summon);
            summon->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);

            if (summon->GetEntry() == NPC_SKARLOC_MOUNT)
                return;

            if (summons.size() == 1)
                summon->GetMotionMaster()->MovePoint(0, 2060.788f, 237.301f, 63.999f);
            else
                summon->GetMotionMaster()->MovePoint(0, 2056.870f, 234.853f, 63.839f);
        }

        void InitializeAI()
        {
            ScriptedAI::InitializeAI(); 

            Movement::PointsArray path;
            path.push_back(G3D::Vector3(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ()));
            for (uint8 i = 0; i < WAYPOINTS_COUNT; ++i) 
                path.push_back(G3D::Vector3(startPath[i].GetPositionX(), startPath[i].GetPositionY(), startPath[i].GetPositionZ()));

            me->GetMotionMaster()->MoveSplinePath(&path);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
            me->Mount(SKARLOC_MOUNT_MODEL);
        }

        void MovementInform(uint32 type, uint32 id)
        {
            if (type != ESCORT_MOTION_TYPE)
                return;

            // Xinef: we can rely here on internal counting
            if (id == 1)
            {
                me->SummonCreature(NPC_DURNHOLDE_MAGE, 2038.549f, 273.303f, 63.420f, 5.30f, TEMPSUMMON_MANUAL_DESPAWN);
                me->SummonCreature(NPC_DURNHOLDE_VETERAN, 2032.810f, 269.416f, 63.561f, 5.30f, TEMPSUMMON_MANUAL_DESPAWN);
            }
            else if (id == 2)
            {
                me->SummonCreature(NPC_SKARLOC_MOUNT, 2049.12f, 252.31f, 62.855f, me->GetOrientation(), TEMPSUMMON_MANUAL_DESPAWN);
                me->Dismount();
                me->SetWalk(true);
                for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                    if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                        summon->SetWalk(true);
            }

            if (me->movespline->Finalized())
            {
                events2.ScheduleEvent(EVENT_INITIAL_TALK, 500);
                events2.ScheduleEvent(EVENT_START_FIGHT, 8000);
            }
        }

        void EnterCombat(Unit* /*who*/)
        {
            me->CastSpell(me, SPELL_DEVOTION_AURA, true);

            events.ScheduleEvent(EVENT_SPELL_HOLY_LIGHT, 15000);
            events.ScheduleEvent(EVENT_SPELL_CLEANSE, 6000);
            events.ScheduleEvent(EVENT_SPELL_HAMMER, 20000);
            events.ScheduleEvent(EVENT_SPELL_HOLY_SHIELD, 10000);
            if (IsHeroic())
                events.ScheduleEvent(EVENT_SPELL_CONSECRATION, 1000);
        }

        void KilledUnit(Unit*  /*victim*/)
        {
            Talk(SAY_SLAY);
        }

        void JustDied(Unit* /*killer*/)
        {
            Talk(SAY_DEATH);
            me->GetInstanceScript()->SetData(DATA_ESCORT_PROGRESS, ENCOUNTER_PROGRESS_SKARLOC_KILLED);
            me->GetInstanceScript()->SetData(DATA_THRALL_ADD_FLAG, 0);
        }

        void UpdateAI(uint32 diff)
        {
            events2.Update(diff);
            switch (events2.ExecuteEvent())
            {
                case EVENT_INITIAL_TALK:
                    Talk(SAY_ENTER);
                    break;
                case EVENT_START_FIGHT:
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                    me->SetInCombatWithZone();
                    for (SummonList::const_iterator itr = summons.begin(); itr != summons.end(); ++itr)
                        if (Creature* summon = ObjectAccessor::GetCreature(*me, *itr))
                            if (summon->GetEntry() != NPC_SKARLOC_MOUNT)
                            {
                                summon->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC|UNIT_FLAG_IMMUNE_TO_NPC);
                                summon->SetInCombatWithZone();
                            }
                    break;
            }

            if (!UpdateVictim())
                return;

            events.Update(diff);
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            switch (events.ExecuteEvent())
            {
                case EVENT_SPELL_HOLY_LIGHT:
                    me->CastSpell(me, SPELL_HOLY_LIGHT, false);
                    events.ScheduleEvent(EVENT_SPELL_HOLY_LIGHT, 20000);
                    break;
                case EVENT_SPELL_CLEANSE:
                    if (roll_chance_i(33))
                        Talk(SAY_TAUNT);
                    me->CastSpell(me, SPELL_CLEANSE, false);
                    events.ScheduleEvent(EVENT_SPELL_CLEANSE, 10000);
                    break;
                case EVENT_SPELL_HAMMER:
                    me->CastSpell(me->GetVictim(), SPELL_HAMMER_OF_JUSTICE, false);
                    events.ScheduleEvent(EVENT_SPELL_HAMMER, 30000);
                    break;
                case EVENT_SPELL_HOLY_SHIELD:
                    me->CastSpell(me, SPELL_CLEANSE, false);
                    events.ScheduleEvent(SPELL_HOLY_SHIELD, 30000);
                    break;
                case EVENT_SPELL_CONSECRATION:
                    me->CastSpell(me, SPELL_CONSECRATION, false);
                    events.ScheduleEvent(EVENT_SPELL_CONSECRATION, 20000);
                    break;

            }

            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_boss_captain_skarloc()
{
    new boss_captain_skarloc();
}
