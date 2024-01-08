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

#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "blackrock_spire.h"

enum Spells
{
    SPELL_FLAMEBREAK                = 16785,
    SPELL_IMMOLATE                  = 15570,
    SPELL_TERRIFYINGROAR            = 14100,
    SPELL_BERSERKER_CHARGE          = 16636,
    SPELL_FIREBALL                  = 16788,
    SPELL_FIREBLAST                 = 16144,
    SPELL_SUICIDE                   = 8329
};

enum Events
{
    EVENT_FLAME_BREAK               = 1,
    EVENT_IMMOLATE                  = 2,
    EVENT_TERRIFYING_ROAR           = 3,
    EVENT_BERSERKER_CHARGE          = 4,
    EVENT_FIREBALL                  = 5,
    EVENT_FIREBLAST                 = 6
};

enum BeastMisc
{
    DATA_BEAST_REACHED              = 1,
    DATA_BEAST_ROOM                 = 2,
    BEAST_MOVEMENT_ID               = 1379690,

    NPC_BLACKHAND_ELITE             = 10317,

    SAY_BLACKHAND_DOOMED            = 0
};

Position const OrcsRunawayPosition = { 34.163567f, -536.852356f, 110.935196f, 6.056306f };

class OrcMoveEvent : public BasicEvent
{
public:
    OrcMoveEvent(Creature* me) : _me(me) {}

    bool Execute(uint64 /*time*/, uint32 /*diff*/) override
    {
        _me->SetReactState(REACT_PASSIVE);
        Position movePos = _me->GetRandomPoint(OrcsRunawayPosition, 10.0f);
        _me->GetMotionMaster()->MovePoint(1, movePos);
        return true;
    }

private:
    Creature* _me;
};

class OrcDeathEvent : public BasicEvent
{
public:
    OrcDeathEvent(Creature* me) : _me(me) { }

    bool Execute(uint64 /*time*/, uint32 /*diff*/) override
    {
        _me->CastSpell(_me, SPELL_SUICIDE, true);
        return true;
    }

private:
    Creature* _me;
};

// Used to make Hodir disengage whenever he leaves his room
constexpr static float FirewalPositionY = -505.f;

class boss_the_beast : public CreatureScript
{
public:
    boss_the_beast() : CreatureScript("boss_the_beast") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetBlackrockSpireAI<boss_thebeastAI>(creature);
    }

    struct boss_thebeastAI : public BossAI
    {
        boss_thebeastAI(Creature* creature) : BossAI(creature, DATA_THE_BEAST), _beastReached(false), _orcYelled(false) {}

        void Reset() override
        {
            _Reset();

            if (_beastReached)
            {
                me->GetMotionMaster()->MovePath(BEAST_MOVEMENT_ID, true);
            }
        }

        void JustEngagedWith(Unit* /*who*/) override
        {
            _JustEngagedWith();
            events.ScheduleEvent(EVENT_FLAME_BREAK, 12s);
            events.ScheduleEvent(EVENT_IMMOLATE, 3s);
            events.ScheduleEvent(EVENT_TERRIFYING_ROAR, 23s);
            events.ScheduleEvent(EVENT_BERSERKER_CHARGE, 2s);
            events.ScheduleEvent(EVENT_FIREBALL, 8s, 21s);
            events.ScheduleEvent(EVENT_FIREBLAST, 5s, 8s);
        }

        void SetData(uint32 type, uint32 /*data*/) override
        {
            switch (type)
            {
                case DATA_BEAST_ROOM:
                {
                    if (!_orcYelled)
                    {
                        if (_nearbyOrcsGUIDs.empty())
                        {
                            FindNearbyOrcs();
                        }

                        //! vector still empty, creatures are missing
                        if (_nearbyOrcsGUIDs.empty())
                        {
                            return;
                        }

                        _orcYelled = true;

                        bool yelled = false;
                        for (ObjectGuid guid : _nearbyOrcsGUIDs)
                        {
                            if (Creature* orc = ObjectAccessor::GetCreature(*me, guid))
                            {
                                if (!yelled)
                                {
                                    yelled = true;
                                    orc->AI()->Talk(SAY_BLACKHAND_DOOMED);
                                }

                                orc->m_Events.AddEvent(new OrcMoveEvent(orc), me->m_Events.CalculateTime(3 * IN_MILLISECONDS));
                                orc->m_Events.AddEvent(new OrcDeathEvent(orc), me->m_Events.CalculateTime(9 * IN_MILLISECONDS));
                            }
                        }
                    }
                    break;
                }
                case DATA_BEAST_REACHED:
                {
                    if (!_beastReached)
                    {
                        _beastReached = true;
                        me->GetMotionMaster()->MovePath(BEAST_MOVEMENT_ID, true);

                        // There is a chance player logged in between areatriggers (realm crash or restart)
                        // executing part of script which happens when player enters boss room
                        // otherwise we will see weird behaviour when someone steps on the previous areatrigger (dead mob yelling/moving)
                        SetData(DATA_BEAST_ROOM, DATA_BEAST_ROOM);
                    }
                    break;
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
            {
                return;
            }

            if (me->GetPositionY() > FirewalPositionY)
            {
                EnterEvadeMode();
                return;
            }

            events.Update(diff);

            if (me->HasUnitState(UNIT_STATE_CASTING))
            {
                return;
            }

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_FLAME_BREAK:
                        DoCastVictim(SPELL_FLAMEBREAK);
                        events.ScheduleEvent(EVENT_FLAME_BREAK, 10s);
                        break;
                    case EVENT_IMMOLATE:
                        DoCastRandomTarget(SPELL_IMMOLATE, 0, 100.0f);
                        events.ScheduleEvent(EVENT_IMMOLATE, 8s);
                        break;
                    case EVENT_TERRIFYING_ROAR:
                        DoCastVictim(SPELL_TERRIFYINGROAR);
                        events.ScheduleEvent(EVENT_TERRIFYING_ROAR, 20s);
                        break;
                    case EVENT_BERSERKER_CHARGE:
                        if (Unit* target = SelectTarget(SelectTargetMethod::Random, 0, 38.f, true))
                        {
                            DoCast(target, SPELL_BERSERKER_CHARGE);
                        }
                        events.ScheduleEvent(EVENT_BERSERKER_CHARGE, 15s, 23s);
                        break;
                    case EVENT_FIREBALL:
                        DoCastVictim(SPELL_FIREBALL);
                        events.ScheduleEvent(EVENT_FIREBALL, 8s, 21s);
                        if (events.GetNextEventTime(EVENT_FIREBLAST) < 3 * IN_MILLISECONDS)
                        {
                            events.RescheduleEvent(EVENT_FIREBLAST, 3s);
                        }
                        break;
                    case EVENT_FIREBLAST:
                        DoCastVictim(SPELL_FIREBLAST);
                        events.ScheduleEvent(EVENT_FIREBLAST, 5s, 8s);
                        if (events.GetNextEventTime(EVENT_FIREBALL) < 3 * IN_MILLISECONDS)
                        {
                            events.RescheduleEvent(EVENT_FIREBALL, 3s);
                        }
                        break;
                }

                if (me->HasUnitState(UNIT_STATE_CASTING))
                {
                    return;
                }
            }

            DoMeleeAttackIfReady();
        }

        void FindNearbyOrcs()
        {
            std::list<Creature*> temp;
            me->GetCreatureListWithEntryInGrid(temp, NPC_BLACKHAND_ELITE, 50.0f);
            for (Creature* creature : temp)
            {
                if (creature->IsAlive())
                {
                    _nearbyOrcsGUIDs.push_back(creature->GetGUID());
                }
            }
        }

    private:
        bool _beastReached;
        bool _orcYelled;
        GuidVector _nearbyOrcsGUIDs;
    };
};

//! The beast room areatrigger, this one triggers boss pathing. (AT Id 2066)
class at_trigger_the_beast_movement : public AreaTriggerScript
{
public:
    at_trigger_the_beast_movement() : AreaTriggerScript("at_trigger_the_beast_movement") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*at*/) override
    {
        if (player->IsGameMaster())
        {
            return false;
        }

        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (Creature* beast = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_THE_BEAST)))
            {
                beast->AI()->SetData(DATA_BEAST_REACHED, DATA_BEAST_REACHED);
            }

            return true;
        }

        return false;
    }
};

class at_the_beast_room : public AreaTriggerScript
{
public:
    at_the_beast_room() : AreaTriggerScript("at_the_beast_room") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*at*/) override
    {
        if (player->IsGameMaster())
        {
            return false;
        }

        if (InstanceScript* instance = player->GetInstanceScript())
        {
            if (Creature* beast = ObjectAccessor::GetCreature(*player, instance->GetGuidData(DATA_THE_BEAST)))
            {
                beast->AI()->SetData(DATA_BEAST_ROOM, DATA_BEAST_ROOM);
            }

            return true;
        }

        return false;
    }
};

void AddSC_boss_thebeast()
{
    new boss_the_beast();
    new at_trigger_the_beast_movement();
    new at_the_beast_room();
}
