/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Ouro
SD%Complete: 85
SDComment: No model for submerging. Currently just invisible.
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "temple_of_ahnqiraj.h"

enum Spells
{
    // Ouro
    SPELL_SWEEP                 = 26103,
    SPELL_SANDBLAST             = 26102,
    SPELL_GROUND_RUPTURE        = 26100,
    SPELL_BIRTH                 = 26262, // The Birth Animation
    SPELL_DIRTMOUND_PASSIVE     = 26092,

    // Ouro Spawner
    SPELL_SUMMON_OURO           = 26061 // Summons Ouro, used by the Ouro Spawner
};

enum Events
{
    EVENT_SPELL_SWEEP = 1,
    EVENT_SPELL_SANDBLAST = 2,
    EVENT_SUBMERGE = 3,
    EVENT_BACK = 4,
    EVENT_CHARGE_TARGET = 5,
    EVENT_SPAWN = 6
};

class npc_ouro_spawner : public CreatureScript
{
public:
    npc_ouro_spawner() : CreatureScript("npc_ouro_spawner") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_ouro_spawnerAI(creature);
    }

    struct npc_ouro_spawnerAI : public ScriptedAI
    {
        npc_ouro_spawnerAI(Creature* creature) : ScriptedAI(creature) { Reset(); }

        bool hasSummoned;

        void Reset() override
        {
            hasSummoned = false;
            DoCast(me, SPELL_DIRTMOUND_PASSIVE);
        }

        void MoveInLineOfSight(Unit* who) override
        {
            // Spawn Ouro on LoS check
            if (!hasSummoned && who->GetTypeId() == TYPEID_PLAYER && me->IsWithinDistInMap(who, 25.0f))
            {
                DoCast(me, SPELL_SUMMON_OURO);
                hasSummoned = true;
            }

            ScriptedAI::MoveInLineOfSight(who);
        }

        void JustSummoned(Creature* creature) override
        {
            // Despawn when Ouro is spawned
            if (creature->GetEntry() == NPC_OURO)
            {
                creature->SetInCombatWithZone();
                creature->CastSpell(creature, SPELL_BIRTH, false);
                me->DespawnOrUnsummon();
            }
        }

        void UpdateAI(uint32 const /*uiDiff*/) override { me->StopMoving(); }
    };

};

class boss_ouro : public CreatureScript
{
public:
    boss_ouro() : CreatureScript("boss_ouro") { Submerged = false; }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_ouroAI(creature);
    }

    struct boss_ouroAI : public ScriptedAI
    {
        boss_ouroAI(Creature* creature) : ScriptedAI(creature) { me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE); }

        EventMap events;

        bool Submerged;

        void Reset()
        {
            events.Reset();

            Submerged = false;
        }

        void JustDied(Unit* /*killer*/)
        {
            if (InstanceScript* instance = me->GetInstanceScript())
                instance->SetBossState(NPC_OURO, DONE);
        }

        void EnterCombat(Unit* /*who*/)
        {
            Submerged = false;

            events.Reset();
            events.ScheduleEvent(EVENT_SPELL_SWEEP, urand(5000, 10000));
            events.ScheduleEvent(EVENT_SPELL_SANDBLAST, urand(20000, 35000));
            events.ScheduleEvent(EVENT_SUBMERGE, urand(90000, 150000));
            events.ScheduleEvent(EVENT_CHARGE_TARGET, urand(5000, 8000));
            events.ScheduleEvent(EVENT_SPAWN, urand(10000, 20000));
        }

        void UpdateAI(uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while(uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case 0:
                        break;
                    case EVENT_SPELL_SWEEP:
                    {
                        DoCastVictim(SPELL_SWEEP);
                        events.ScheduleEvent(EVENT_SPELL_SWEEP, urand(15000, 30000));
                        break;
                    }
                    case EVENT_SPELL_SANDBLAST:
                    {
                        DoCastVictim(SPELL_SANDBLAST);
                        events.ScheduleEvent(EVENT_SPELL_SANDBLAST, urand(20000, 35000));
                        break;
                    }
                    case EVENT_SUBMERGE:
                    {
                        if (Submerged == false)
                        {
                            // Cast
                            me->HandleEmoteCommand(EMOTE_ONESHOT_SUBMERGE);
                            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            me->setFaction(35);
                            DoCast(me, SPELL_DIRTMOUND_PASSIVE);

                            Submerged = true;
                        }
                        events.ScheduleEvent(EVENT_BACK, urand(30000, 45000));
                        break;
                    }
                    case EVENT_CHARGE_TARGET:
                    {
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                            me->NearTeleportTo(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), me->GetOrientation());
                        events.ScheduleEvent(EVENT_CHARGE_TARGET, urand(10000, 20000));
                        break;
                    }
                    case EVENT_BACK:
                    {
                        if (Submerged == true)
                        {
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            me->setFaction(14);

                            DoCastVictim(SPELL_GROUND_RUPTURE);

                            Submerged = false;
                        }
                        events.ScheduleEvent(EVENT_SUBMERGE, urand(60000, 120000));
                        break;
                    }
                }
            }

            DoMeleeAttackIfReady();
        }
    };

};

void AddSC_boss_ouro()
{
    new npc_ouro_spawner();
    new boss_ouro();
}
