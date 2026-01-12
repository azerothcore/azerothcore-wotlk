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

enum Partygoer_Pather
{
    EVENT_PATH                    = 1,
    EVENT_RANDOM_ACTION_PATHER    = 2,
    EVENT_REMOVE_EQUIPMENT_PATHER = 3,
    EVENT_STOP_DANCING_PATHER     = 4
};

struct npc_partygoer_pather : public ScriptedAI
{
    npc_partygoer_pather(Creature* creature) : ScriptedAI(creature)
    {
        Initialize();
    }

    void Initialize()
    {
        _path = 594440;
    }

    void Reset() override
    {
        _events.ScheduleEvent(EVENT_RANDOM_ACTION_PATHER, 11s, 14s);
    }

    void PathEndReached(uint32 /*pathId*/) override
    {
        ++_path;
        if (_path > 594444)
            _path = 594440;

        _events.ScheduleEvent(EVENT_RANDOM_ACTION_PATHER, 11s, 14s);
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);

        if (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
            case EVENT_PATH:
                me->GetMotionMaster()->MoveWaypoint(_path, false);
                break;
            case EVENT_RANDOM_ACTION_PATHER:
            {
                int8 _action = urand(1, 5);

                switch (_action)
                {
                    case 1:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                        _events.ScheduleEvent(EVENT_PATH, 11s);
                        break;
                    case 2:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                        _events.ScheduleEvent(EVENT_PATH, 11s);
                        break;
                    case 3:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                        _events.ScheduleEvent(EVENT_PATH, 11s);
                        break;
                    case 4:
                        me->LoadEquipment(urand(1, 2));
                        me->HandleEmoteCommand(EMOTE_ONESHOT_EAT_NO_SHEATHE);
                        _events.ScheduleEvent(EVENT_REMOVE_EQUIPMENT_PATHER, 4s);
                        break;
                    case 5:
                        me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_DANCE);
                        _events.ScheduleEvent(EVENT_STOP_DANCING_PATHER, 6s);
                        break;
                }
                break;
            }
            case EVENT_REMOVE_EQUIPMENT_PATHER:
                me->LoadEquipment(0, true);
                _events.ScheduleEvent(EVENT_PATH, 8s);
                break;
            case EVENT_STOP_DANCING_PATHER:
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                _events.ScheduleEvent(EVENT_PATH, 5s);
                break;
            break;
            }
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
    uint32   _path;
};

enum Partygoer
{
    EVENT_RANDOM_ACTION    = 5,
    EVENT_REMOVE_EQUIPMENT = 6,
    EVENT_STOP_DANCING     = 7,
    EVENT_THROW_FIREWORKS  = 8,
    EVENT_RESET_FACING     = 9,
    GO_FIREWORKS_LAUNCHER  = 180771
};

struct npc_partygoer : public ScriptedAI
{
    npc_partygoer(Creature* creature) : ScriptedAI(creature)
    {
        Initialize();
    }

    void Initialize()
    {
        _facing = me->GetOrientation();
    }

    void Reset() override
    {
        _events.ScheduleEvent(EVENT_RANDOM_ACTION, 1s, 20s);
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);

        if (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
            case EVENT_RANDOM_ACTION:
            {
                int8 _action = urand(1, 6);

                switch (_action)
                {
                case 1:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    _events.ScheduleEvent(EVENT_RANDOM_ACTION, 13s, 20s);
                    break;
                case 2:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    _events.ScheduleEvent(EVENT_RANDOM_ACTION, 13s, 20s);
                    break;
                case 3:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_LAUGH);
                    _events.ScheduleEvent(EVENT_RANDOM_ACTION, 13s, 20s);
                    break;
                case 4:
                    me->LoadEquipment(urand(1, 2));
                    me->HandleEmoteCommand(EMOTE_ONESHOT_EAT_NO_SHEATHE);
                    _events.ScheduleEvent(EVENT_REMOVE_EQUIPMENT, 4s);
                    break;
                case 5:
                    me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_STATE_DANCE);
                    _events.ScheduleEvent(EVENT_STOP_DANCING, 8s, 16s);
                    break;
                case 6:
                    if (GameObject* launcher = me->FindNearestGameObject(GO_FIREWORKS_LAUNCHER, 20.0f))
                        me->SetFacingToObject(launcher);
                    _events.ScheduleEvent(EVENT_THROW_FIREWORKS, 1s);
                    break;
                }
                break;
            }
            case EVENT_REMOVE_EQUIPMENT:
                me->LoadEquipment(0, true);
                _events.ScheduleEvent(EVENT_RANDOM_ACTION, 10s, 20s);
                break;
            case EVENT_STOP_DANCING:
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE);
                _events.ScheduleEvent(EVENT_RANDOM_ACTION, 10s, 20s);
                break;
            case EVENT_THROW_FIREWORKS:
                me->CastSpell(me, 26295);
                _events.ScheduleEvent(EVENT_RESET_FACING, 3s);
                break;
            case EVENT_RESET_FACING:
                me->SetFacingTo(_facing);
                _events.ScheduleEvent(EVENT_RANDOM_ACTION, 12s, 20s);
                break;
            }
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
    float    _facing;
};

void AddSC_eversong_woods()
{
    RegisterCreatureAI(npc_partygoer_pather);
    RegisterCreatureAI(npc_partygoer);
}
