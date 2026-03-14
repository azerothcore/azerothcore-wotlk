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
#include "ObjectGuid.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"

/*######
## npc_ranger_lilatha
######*/

enum RangerLilatha
{
    SAY_START                           = 0,
    SAY_PROGRESS1                       = 1,
    SAY_PROGRESS2                       = 2,
    SAY_PROGRESS3                       = 3,
    SAY_END1                            = 4,
    SAY_END2                            = 5,
    SAY_CAPTAIN_ANSWER                  = 0,
    QUEST_ESCAPE_FROM_THE_CATACOMBS     = 9212,
    GO_CAGE                             = 181152,
    NPC_CAPTAIN_HELIOS                  = 16220,
    NPC_MUMMIFIED_HEADHUNTER            = 16342,
    NPC_SHADOWPINE_ORACLE               = 16343
};

struct npc_ranger_lilatha : public npc_escortAI
{
    npc_ranger_lilatha(Creature* creature) : npc_escortAI(creature) { }

    void WaypointReached(uint32 waypointId) override
    {
        Player* player = GetPlayerForEscort();
        if (!player)
            return;

        switch (waypointId)
        {
        case 0:
            me->SetUInt32Value(UNIT_FIELD_BYTES_1, UNIT_STAND_STATE_STAND);
            if (GameObject* Cage = me->FindNearestGameObject(GO_CAGE, 20.0f))
                Cage->SetGoState(GO_STATE_ACTIVE);
            Talk(SAY_START, player);
            break;
        case 5:
            Talk(SAY_PROGRESS1, player);
            break;
        case 11:
            Talk(SAY_PROGRESS2, player);
            me->SetFacingTo(4.762841f);
            break;
        case 18:
        {
            Talk(SAY_PROGRESS3, player);
            Creature* Summ1 = me->SummonCreature(NPC_MUMMIFIED_HEADHUNTER, 7627.083984f, -7532.538086f, 152.128616f, 1.082733f, TEMPSUMMON_DEAD_DESPAWN, 0);
            Creature* Summ2 = me->SummonCreature(NPC_SHADOWPINE_ORACLE, 7620.432129f, -7532.550293f, 152.454865f, 0.827478f, TEMPSUMMON_DEAD_DESPAWN, 0);
            if (Summ1 && Summ2)
            {
                Summ1->Attack(me, true);
                Summ2->Attack(player, true);
            }
            AttackStart(Summ1);
        }
        break;
        case 19:
            me->SetWalk(false);
            break;
        case 25:
            me->SetWalk(true);
            break;
        case 30:
            player->GroupEventHappens(QUEST_ESCAPE_FROM_THE_CATACOMBS, me);
            break;
        case 32:
            me->SetFacingTo(2.978281f);
            Talk(SAY_END1, player);
            break;
        case 33:
            me->SetFacingTo(5.858011f);
            Talk(SAY_END2, player);
            Creature* CaptainHelios = me->FindNearestCreature(NPC_CAPTAIN_HELIOS, 50.0f);
            if (CaptainHelios)
                CaptainHelios->AI()->Talk(SAY_CAPTAIN_ANSWER, player);
            break;
        }
    }

    void Reset() override
    {
        if (GameObject* Cage = me->FindNearestGameObject(GO_CAGE, 20.0f))
            Cage->SetGoState(GO_STATE_READY);
    }

    void sQuestAccept(Player* player, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_ESCAPE_FROM_THE_CATACOMBS)
        {
            me->SetFaction(FACTION_ESCORTEE_N_NEUTRAL_PASSIVE);
            me->SetWalk(true);
            Start(true, player->GetGUID());
        }
    }
};

/*######
## npc_sentinel_leader
######*/

enum SentinelLeader
{
    EVENT_QUESTION        = 1,
    EVENT_TALK            = 2,
    EVENT_SINISTER_STRIKE = 3,
    EVENT_BACKSTAB        = 4,
    NPC_SENTINEL_SPY      = 16330,
    SPELL_SINISTER_STRIKE = 14873,
    SPELL_BACKSTAB        = 7159
};

struct npc_sentinel_leader : public ScriptedAI
{
    npc_sentinel_leader(Creature* creature) : ScriptedAI(creature) {}

    void Reset() override
    {
        _helpCalled = false;
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == WAYPOINT_MOTION_TYPE)
        {
            switch (id)
            {
            case 2:
            case 5:
            case 8:
            case 9:
            case 14:
            case 15:
            case 18:
                Creature* SentinelSpy = me->FindNearestCreature(NPC_SENTINEL_SPY, 2.0f, true);
                if (SentinelSpy)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                    SentinelSpy->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                    _events.ScheduleEvent(EVENT_QUESTION, 5s);
                }
                break;
            }
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EVENT_SINISTER_STRIKE, 5s, 9s);
        _events.ScheduleEvent(EVENT_BACKSTAB, 3s, 5s);
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);

        if (!UpdateVictim())
        {
            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_QUESTION:
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);
                    _events.ScheduleEvent(EVENT_TALK, 1s);
                    break;
                }
                case EVENT_TALK:
                {
                    Creature* SentinelSpy = me->FindNearestCreature(NPC_SENTINEL_SPY, 2.0f, true);
                    if (SentinelSpy)
                    {
                        SentinelSpy->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    }
                    break;
                }
                default:
                    break;
                }
            }
            return;
        }

        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
            case EVENT_SINISTER_STRIKE:
                DoCastVictim(SPELL_SINISTER_STRIKE, true);
                _events.ScheduleEvent(EVENT_SINISTER_STRIKE, 5s, 9s);
                break;
            case EVENT_BACKSTAB:
                DoCastVictim(SPELL_BACKSTAB, true);
                _events.ScheduleEvent(EVENT_BACKSTAB, 7s, 11s);
                break;
            default:
                break;
            }
        }

        if (me->HealthBelowPct(15) && !_helpCalled)
        {
            _helpCalled = true;
            me->CallForHelp(20.0f);
        }

        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
    bool     _helpCalled;
};

/*######
## npc_sentinel_infiltrator
######*/

enum SentinelInfiltrator
{
    EMOTE_FLEE               = 0,
    EVENT_TALK2              = 1,
    EVENT_QUESTION2          = 2,
    EVENT_EXCLAMATION        = 3,
    EVENT_SALUTE             = 4,
    EVENT_GOUGE2             = 5,
    EVENT_BACKSTAB2          = 6,
    NPC_SENTINEL_INFILTRATOR = 16333,
    PATH_ONE                 = 841030,
    PATH_TWO                 = 859400,
    SPELL_GOUGE              = 12540
};

struct npc_sentinel_infiltrator : public ScriptedAI
{
    npc_sentinel_infiltrator(Creature* creature) : ScriptedAI(creature)
    {
        Initialize();
    }

    void Initialize()
    {
        _path = me->GetWaypointPath();
    }

    void Reset() override
    {
        _fleedForAssistance = false;
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == WAYPOINT_MOTION_TYPE)
        {
            switch (_path)
            {
            case PATH_ONE:
                switch (id)
                {
                    case 6:
                    case 9:
                    case 15:
                    case 19:
                        Creature* SentinelInfiltrator = me->FindNearestCreature(NPC_SENTINEL_INFILTRATOR, 3.5f, true);
                        if (SentinelInfiltrator)
                        {
                            me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                            SentinelInfiltrator->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                            _events.ScheduleEvent(EVENT_TALK2, 2s);
                        }
                        break;
                }
                break;
            case PATH_TWO:
                switch (id)
                {
                    case 6:
                    case 8:
                    case 15:
                    case 18:
                        Creature* SentinelInfiltrator = me->FindNearestCreature(NPC_SENTINEL_INFILTRATOR, 3.5f, true);
                        if (SentinelInfiltrator)
                        {
                            me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                            SentinelInfiltrator->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                            _events.ScheduleEvent(EVENT_TALK, 2s);
                        }
                        break;
                }
                break;
            }
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _events.ScheduleEvent(EVENT_GOUGE2, 9s, 15s);
        _events.ScheduleEvent(EVENT_BACKSTAB2, 3s, 5s);
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);

        if (!UpdateVictim())
        {
            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_TALK2:
                {
                    Creature* SentinelInfiltrator = me->FindNearestCreature(NPC_SENTINEL_INFILTRATOR, 3.5f, true);
                    if (SentinelInfiltrator)
                    {
                        SentinelInfiltrator->HandleEmoteCommand(EMOTE_ONESHOT_TALK);
                    }
                    _events.ScheduleEvent(EVENT_QUESTION, 2s);
                    break;
                }
                case EVENT_QUESTION2:
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);
                    _events.ScheduleEvent(EVENT_EXCLAMATION, 1s);
                    break;
                }
                case EVENT_EXCLAMATION:
                {
                    Creature* SentinelInfiltrator = me->FindNearestCreature(NPC_SENTINEL_INFILTRATOR, 3.5f, true);
                    if (SentinelInfiltrator)
                    {
                        SentinelInfiltrator->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                    }
                    _events.ScheduleEvent(EVENT_SALUTE, 3s);
                    break;
                }
                case EVENT_SALUTE:
                {
                    Creature* SentinelInfiltrator = me->FindNearestCreature(NPC_SENTINEL_INFILTRATOR, 3.5f, true);
                    if (SentinelInfiltrator)
                    {
                        me->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                        SentinelInfiltrator->HandleEmoteCommand(EMOTE_ONESHOT_SALUTE);
                        break;
                    }
                }
                default:
                    break;
                }
            }
            return;
        }

        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
            case EVENT_GOUGE2:
                DoCastVictim(SPELL_GOUGE, true);
                _events.ScheduleEvent(EVENT_GOUGE2, 9s, 15s);
                break;
            case EVENT_BACKSTAB2:
                DoCastVictim(SPELL_BACKSTAB, true);
                _events.ScheduleEvent(EVENT_BACKSTAB, 7s, 11s);
                break;
            default:
                break;
            }
        }

        if (me->HealthBelowPct(15) && !_fleedForAssistance)
        {
            _fleedForAssistance = true;
            me->DoFleeToGetAssistance();
            Talk(EMOTE_FLEE);
        }
        DoMeleeAttackIfReady();
    }

private:
    EventMap _events;
    bool     _fleedForAssistance;
    int32    _path;
};

void AddSC_ghostlands()
{
    RegisterCreatureAI(npc_ranger_lilatha);
    RegisterCreatureAI(npc_sentinel_leader);
    RegisterCreatureAI(npc_sentinel_infiltrator);
}
