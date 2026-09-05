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

#include "blackrock_depths.h"
#include "AreaTriggerScript.h"
#include "CreatureScript.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "GameTime.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "ScriptedGossip.h"

#include <iterator>
#include <limits>

enum IronhandData
{
    IRONHAND_N_GROUPS          = 3,
    SPELL_GOUT_OF_FLAMES       = 15529
};

constexpr Milliseconds IRONHAND_FLAMES_TIMER = 16s;
constexpr Milliseconds IRONHAND_FLAMES_TIMER_RAND = 3s;

struct go_shadowforge_brazier : public GameObjectAI
{
    go_shadowforge_brazier(GameObject* go) : GameObjectAI(go) {}

    bool GossipHello(Player* /*player*/, bool reportUse) override
    {
        if (reportUse)
            return false;

        if (InstanceScript* instance = me->GetInstanceScript())
        {
            GameObject* northBrazier = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(DATA_SF_BRAZIER_N));
            GameObject* southBrazier = ObjectAccessor::GetGameObject(*me, instance->GetGuidData(DATA_SF_BRAZIER_S));

            if (!northBrazier || !southBrazier)
                return false;

            // should only happen on first brazier
            if (instance->GetData(TYPE_LYCEUM) == NOT_STARTED)
                instance->SetData(TYPE_LYCEUM, IN_PROGRESS);

            // Check if the opposite brazier is lit - if it is, open the gates.
            if ((me->GetGUID() == northBrazier->GetGUID() && southBrazier->GetGoState() == GO_STATE_ACTIVE) || (me->GetGUID() == southBrazier->GetGUID() && northBrazier->GetGoState() == GO_STATE_ACTIVE))
            {
                instance->SetData(TYPE_LYCEUM, DONE);
            }
            return false;
        }
        return false;
    }
};

struct brd_ironhand_guardian : public CreatureAI
{
    brd_ironhand_guardian(Creature* creature) : CreatureAI(creature) {}

    void SetData(uint32 id, uint32 value) override
    {
        if (id  == 0)
            if (value == 0 || value == 1)
            {
                _flamesEnabled = (bool) (value);
                events.ScheduleEvent(SPELL_GOUT_OF_FLAMES, urand(1, IRONHAND_N_GROUPS) * IRONHAND_FLAMES_TIMER / IRONHAND_N_GROUPS);
            }
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        if (_flamesEnabled)
        {
            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case SPELL_GOUT_OF_FLAMES:
                        DoCast(SPELL_GOUT_OF_FLAMES);
                        events.RescheduleEvent(SPELL_GOUT_OF_FLAMES, IRONHAND_FLAMES_TIMER - IRONHAND_FLAMES_TIMER_RAND, IRONHAND_FLAMES_TIMER + IRONHAND_FLAMES_TIMER_RAND);
                        break;
                    default:
                        break;
                }
            }
        }
    }

private:
    bool _flamesEnabled = false;
    EventMap events;
};

struct WaveCreature
{
    uint32 entry;
    uint32 amount;
};

static WaveCreature RingMobs[] = // different amounts based on the type
{
    {NPC_DREDGE_WORM, 3},
    {NPC_DEEP_STINGER, 3},
    {NPC_DARK_SCREECHER, 3},
    {NPC_THUNDERSNOUT, 2},
    {NPC_CAVE_CREEPER, 3},
    {NPC_BORER_BEETLE, 6}};

uint32 RingBoss[] =
{
    NPC_GOROSH,
    NPC_GRIZZLE,
    NPC_EVISCERATOR,
    NPC_OKTHOR,
    NPC_ANUBSHIAH,
    NPC_HEDRUM
};

class at_ring_of_law : public AreaTriggerScript
{
public:
    at_ring_of_law() : AreaTriggerScript("at_ring_of_law") { }

    bool OnTrigger(Player* player, AreaTrigger const* /*at*/) override
    {
        if (InstanceScript* instance = player->GetInstanceScript())
        {
            time_t now = GameTime::GetGameTime().count();
            if (instance->GetData(TYPE_RING_OF_LAW) == IN_PROGRESS || instance->GetData(TYPE_RING_OF_LAW) == DONE)
                return false;

            if (now - instance->GetData(DATA_TIME_RING_FAIL) < 2 * 60) // in case of wipe, so people can rez.
                return false;

            instance->SetData(TYPE_RING_OF_LAW, IN_PROGRESS);
            return true;
        }
        return false;
    }
};

// npc_grimstone
enum GrimstoneTexts
{
    SAY_TEXT1          = 0,
    SAY_TEXT2          = 1,
    SAY_TEXT3          = 2,
    SAY_TEXT4          = 3,
    SAY_TEXT5          = 4,
    SAY_TEXT6          = 5
};

struct npc_grimstone : public npc_escortAI
{
    npc_grimstone(Creature* creature) : npc_escortAI(creature), summons(me)
    {
        instance = creature->GetInstanceScript();
        MobSpawnId    = instance ? instance->GetData(DATA_ARENA_MOBS) : urand(0, 5);
        BossSpawnId   = instance ? instance->GetData(DATA_ARENA_BOSS) : urand(0, 5);
        eventPhase = 0;
        eventTimer = 1000;
        resetTimer = 0;
        theldrenEvent = false;
        summons.DespawnAll();
    }

    InstanceScript* instance;
    SummonList summons;

    uint8 eventPhase;
    uint32 eventTimer;
    uint32 resetTimer;
    uint8 MobSpawnId;
    uint8  BossSpawnId;
    bool theldrenEvent;

    void Reset() override
    {
        me->SetUnitFlag(UNIT_FLAG_NON_ATTACKABLE);
    }

    void JustSummoned(Creature* summon) override
    {
        summons.Summon(summon);
        if (Unit* target = SelectTargetFromPlayerList(100.0f))
            summon->AI()->AttackStart(target);
    }

    void SummonedCreatureDies(Creature* summon, Unit*) override
    {
        summons.Despawn(summon);
        // All Summons killed, next phase
        if (summons.empty())
        {
            resetTimer = 0;
            eventTimer = 5000;
        }
    }

    using CreatureAI::WaypointReached;
    void WaypointReached(uint32 waypointId) override
    {
        switch (waypointId)
        {
            case 0:
                Talk(SAY_TEXT1);
                SetEscortPaused(true);
                eventTimer = 5000;
                break;
            case 1:
                Talk(SAY_TEXT2);
                SetEscortPaused(true);
                eventTimer = 5000;
                break;
            case 2:
                SetEscortPaused(true);
                break;
            case 3:
                Talk(SAY_TEXT3);
                break;
            case 4:
                Talk(SAY_TEXT4);
                SetEscortPaused(true);
                eventTimer = 5000;
                break;
            case 5:
                if (instance)
                {
                    me->GetMap()->UpdateEncounterState(ENCOUNTER_CREDIT_KILL_CREATURE, NPC_GRIMSTONE, me);
                    instance->SetData(TYPE_RING_OF_LAW, DONE);
                }
                break;
        }
    }

    void HandleGameObject(uint32 id, bool open)
    {
        instance->HandleGameObject(instance->GetGuidData(id), open);
    }

    void SummonBoss()
    {
        if (me->FindNearestGameObject(GO_BANNER_OF_PROVOCATION, 100.0f))
        {
            theldrenEvent = true;
            me->SummonCreature(NPC_THELDREN, 644.300f, -175.989f, -53.739f, 3.418f, TEMPSUMMON_DEAD_DESPAWN, 0);
            uint8 rand = urand(0, 4);
            for (uint8 i = rand; i < rand + 4; ++i)
                me->SummonCreature(theldrenTeam[i], 644.300f, -175.989f, -53.739f, 3.418f, TEMPSUMMON_DEAD_DESPAWN, 0);
        }
        else
            me->SummonCreature(RingBoss[BossSpawnId], 644.300f, -175.989f, -53.739f, 3.418f, TEMPSUMMON_DEAD_DESPAWN, 0);
        resetTimer = 30000;
    }

    bool updateReset(uint32 diff)
    {
        // as long as the summoned creatures have someone to attack, we reset the timer.
        // once they don't find anyone, the timer will count down until it is smaller than diff and reset.
        bool doReset = false;
        if (resetTimer > 0)
        {
            for (auto const& sum : summons)
            {
                if (Creature* creature = ObjectAccessor::GetCreature(*me, sum))
                {
                    if (creature->IsAlive() && creature->GetVictim())
                    {
                        resetTimer = 30000;
                        break; // only need to find one.
                    }
                }
            }

            resetTimer -= diff;
            if (resetTimer <= diff)
                doReset = true;
        }
        return doReset;
    }

    void SpawnWave(uint32 mobId)
    {
        for (uint32 i = 0; i < RingMobs[mobId].amount; i++)
            me->SummonCreature(RingMobs[mobId].entry, 608.960f + 0.4f * i, -235.322f, -53.907f, 1.857f, TEMPSUMMON_DEAD_DESPAWN, 0);
        resetTimer = 30000;
    }

    void UpdateEscortAI(uint32 diff) override
    {
        if (!instance)
            return;

        // reset if our mobs don't have a target.
        if (updateReset(diff))
        {
            summons.DespawnAll();
            HandleGameObject(DATA_ARENA4, true);
            HandleGameObject(DATA_ARENA3, false);
            HandleGameObject(DATA_ARENA2, false);
            HandleGameObject(DATA_ARENA1, false);
            instance->SetData(TYPE_RING_OF_LAW, FAIL);
        }

        if (eventTimer)
        {
            if (eventTimer <= diff)
            {
                switch (eventPhase)
                {
                    case 0:
                        Talk(SAY_TEXT5);
                        HandleGameObject(DATA_ARENA4, false);
                        me->SetWalk(true);
                        Start(false);
                        eventTimer = 0;
                        break;
                    case 1:
                        SetEscortPaused(false);
                        eventTimer = 0;
                        break;
                    case 2:
                        eventTimer = 2000;
                        break;
                    case 3:
                        HandleGameObject(DATA_ARENA1, true);
                        eventTimer = 3000;
                        break;
                    case 4:
                        SetEscortPaused(false);
                        me->SetVisible(false);
                        SpawnWave(MobSpawnId); // wave 1
                        eventTimer = 15000;
                        break;
                    case 5:
                        SpawnWave(MobSpawnId); // wave 2
                        eventTimer = 0; // will be set from SummonedCreatureDies
                        break;
                    case 6:
                        me->SetVisible(true);
                        HandleGameObject(DATA_ARENA1, false);
                        Talk(SAY_TEXT6);
                        SetEscortPaused(false);
                        eventTimer = 0;
                        break;
                    case 7:
                        HandleGameObject(DATA_ARENA2, true);
                        eventTimer = 5000;
                        break;
                    case 8:
                        me->SetVisible(false);
                        SummonBoss();
                        eventTimer = 0;
                        break;
                    case 9:
                        if (theldrenEvent)
                        {
                            // All objects are removed from world once tempsummons despawn, so have a player spawn it instead.
                            Player* player = me->SelectNearestPlayer(100.0f);
                            if (GameObject* go = player->SummonGameObject(GO_ARENA_SPOILS, 596.48f, -187.91f, -54.14f, 4.9f, 0.0f, 0.0f, 0.0f, 0.0f, 300))
                                go->SetOwnerGUID(ObjectGuid::Empty);

                            Map::PlayerList const& pl = me->GetMap()->GetPlayers();
                            for (Map::PlayerList::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
                                itr->GetSource()->KilledMonsterCredit(16166);
                        }

                        HandleGameObject(DATA_ARENA2, false);
                        HandleGameObject(DATA_ARENA3, true);
                        HandleGameObject(DATA_ARENA4, true);
                        SetEscortPaused(false);
                        break;
                }
                ++eventPhase;
            }
            else
                eventTimer -= diff;
        }
    }
};

// npc_phalanx
enum PhalanxSpells
{
    SPELL_THUNDERCLAP                   = 8732,
    SPELL_FIREBALLVOLLEY                = 22425,
    SPELL_MIGHTYBLOW                    = 14099
};

struct npc_phalanx : public ScriptedAI
{
    npc_phalanx(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override
    {
        _thunderClapTimer = 12000;
        _fireballVolleyTimer = 0;
        _mightyBlowTimer = 15000;
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (_thunderClapTimer <= diff)
        {
            DoCastVictim(SPELL_THUNDERCLAP);
            _thunderClapTimer = 10000;
        }
        else _thunderClapTimer -= diff;

        if (HealthBelowPct(51))
        {
            if (_fireballVolleyTimer <= diff)
            {
                DoCastVictim(SPELL_FIREBALLVOLLEY);
                _fireballVolleyTimer = 15000;
            }
            else _fireballVolleyTimer -= diff;
        }

        if (_mightyBlowTimer <= diff)
        {
            DoCastVictim(SPELL_MIGHTYBLOW);
            _mightyBlowTimer = 10000;
        }
        else _mightyBlowTimer -= diff;

        DoMeleeAttackIfReady();
    }

private:
    uint32 _thunderClapTimer;
    uint32 _fireballVolleyTimer;
    uint32 _mightyBlowTimer;
};

// npc_mistress_nagmara
enum GrimGuzzlerNPCs
{
    NPC_PRIVATE_ROCKNOT  = 9503,
    NPC_MISTRESS_NAGMARA = 9500
};

enum NagmaraSpells
{
    SPELL_POTION_LOVE     = 14928,
    SPELL_NAGMARA_ROCKNOT = 15064
};

enum NagmaraTexts
{
    SAY_NAGMARA_AMBIENT = 0,
    SAY_NAGMARA_1 = 1,
    SAY_NAGMARA_2 = 2,
    EMOTE_ROCKNOT = 5
};

enum NagmaraQuests
{
    QUEST_POTION_LOVE = 4201
};

enum NagmaraData
{
    DATA_AMBIENT_ORDER = 1
};

enum NagmaraCreatures
{
    NPC_GRIM_PATRON     = 9545,
    NPC_GUZZLING_PATRON = 9547
};

enum RocknotActions
{
    ACTION_START_LOVE_POTION          = 1,
    ACTION_CANCEL_LOVE_POTION         = 2,
    ACTION_BEGIN_LOVERS_FOLLOW        = 3,
    ACTION_MOVE_TO_LOVERS_STOP        = 4,
    ACTION_ROCKNOT_AT_LOVERS_STOP     = 5,
    ACTION_COMPLETE_LOVE_POTION       = 6,
    ACTION_PAUSE_AT_BAR_DOOR          = 7,
    ACTION_RESUME_AFTER_BAR_DOOR      = 8
};

enum RocknotData
{
    DATA_CAN_START_LOVE_POTION = 1,
    DATA_LOVE_POTION_ACTIVE    = 2
};

enum NagmaraEvents
{
    EVENT_SAY_NAGMARA_2       = 1,
    EVENT_CAST_LOVE_POTION    = 2,
    EVENT_START_LOVERS_ROUTE  = 3,
    EVENT_OPEN_BAR_DOOR       = 4,
    EVENT_CONTINUE_AFTER_DOOR = 5,
    EVENT_KISS_ROCKNOT        = 6,
    EVENT_CLEAR_HEARTS        = 7,
    EVENT_MOVEMENT_TIMEOUT    = 8,
    EVENT_AMBIENT_REPLY       = 9,
    EVENT_MOVE_APPROACH       = 10,
    EVENT_MOVE_GREETING       = 11,
    EVENT_GREET_ROCKNOT       = 12,
    EVENT_MOVE_LOVERS_ROUTE   = 13,
    EVENT_REACH_LOVERS_STOP   = 14
};

enum NagmaraGossip
{
    GOSSIP_MENU_NAGMARA = 2076
};

enum NagmaraPoints
{
    POINT_APPROACH_PATROL   = 100,
    POINT_APPROACH_GREETING = 108,
    POINT_LOVERS_ROUTE      = 200,
    POINT_ROCKNOT_FINAL     = 300
};

// Follow Nagmara's database patrol in its proven forward order. Reversing or skipping
// between these points can make the pathfinder choose furniture geometry.
Position const NagmaraPatrolPath[] =
{
    { 868.316f, -202.803f, -43.7035f },
    { 862.011f, -213.808f, -43.7035f },
    { 869.180f, -201.151f, -43.7035f },
    { 876.730f, -190.959f, -43.7035f },
    { 894.625f, -191.886f, -43.7035f },
    { 879.334f, -192.750f, -43.7035f },
    { 871.198f, -197.966f, -43.7035f },
    { 866.826f, -204.465f, -43.7035f }
};

Position const NagmaraGreetingPosition = { 887.900f, -197.050f, -43.6204f };

// Keep left of Phalanx (868.97, -224.979), wait for the doorway to open, and
// follow the lower corner around the ramp masonry instead of cutting across it.
Position const NagmaraLoversPath[] =
{
    { 879.334f, -192.750f, -43.7035f },
    { 871.198f, -197.966f, -43.7035f },
    { 866.826f, -204.465f, -43.7035f },
    { 864.244f, -210.826f, -43.4590f },
    { 866.824f, -220.959f, -43.4472f },
    // Near side of Bar Door (GO 170571), 2.5 yards along its approach normal.
    { 869.295f, -226.863f, -43.7523f },
    { 875.050f, -230.300f, -43.7523f },
    { 877.919f, -229.425f, -43.5566f },
    { 882.395f, -225.949f, -46.7405f },
    { 885.895f, -223.699f, -49.2405f },
    { 878.178f, -222.066f, -49.9671f, 0.25003412f }
};

constexpr uint8 NAGMARA_DOOR_WAIT_POINT = 5;
constexpr float NAGMARA_GREETING_DISTANCE = 14.0f;
Position const RocknotFinalPosition = { 880.825f, -221.390f, -49.9562f, 3.3916268f };

struct npc_mistress_nagmara : public CreatureAI
{
    npc_mistress_nagmara(Creature* creature) : CreatureAI(creature), _instance(creature->GetInstanceScript()),
        _approachPoint(0), _routePoint(0), _doorOpenAttempts(0), _lovePotionEvent(false),
        _lovePotionComplete(false), _doorOpenedByEvent(false) { }

    void Reset() override
    {
        if (_lovePotionComplete)
        {
            if (!_events.HasTimeUntilEvent(EVENT_CLEAR_HEARTS))
                me->setActive(false);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
            me->GetMotionMaster()->MoveIdle();
            return;
        }

        if (_instance && _instance->GetData(DATA_LOVE_POTION_EVENT) == DONE)
        {
            _events.Reset();
            _ambientEvents.Reset();
            _rocknotGuid.Clear();
            _approachPoint = 0;
            _routePoint = 0;
            _doorOpenAttempts = 0;
            _lovePotionEvent = false;
            _lovePotionComplete = true;
            _doorOpenedByEvent = false;
            me->GetMotionMaster()->Clear();
            Position const& finalPosition = NagmaraLoversPath[std::size(NagmaraLoversPath) - 1];
            me->NearTeleportTo(finalPosition.GetPositionX(), finalPosition.GetPositionY(),
                finalPosition.GetPositionZ(), finalPosition.GetOrientation());
            me->SetHomePosition(finalPosition);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP);
            me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
            me->GetMotionMaster()->MoveIdle();
            me->setActive(false);
            return;
        }

        if (_lovePotionEvent)
        {
            AbortLovePotionEvent(true);
            return;
        }

        _events.Reset();
        _rocknotGuid.Clear();
        _approachPoint = 0;
        _routePoint = 0;
        _doorOpenAttempts = 0;
        _doorOpenedByEvent = false;
    }

    void sGossipSelect(Player* player, uint32 menuId, uint32 gossipListId) override
    {
        if (menuId != GOSSIP_MENU_NAGMARA || gossipListId != 0 || !player->GetQuestRewardStatus(QUEST_POTION_LOVE))
            return;

        CloseGossipMenuFor(player);

        if (!_instance || _instance->GetData(TYPE_BAR) != NOT_STARTED)
            return;

        Creature* rocknot = me->FindNearestCreature(NPC_PRIVATE_ROCKNOT, 100.0f);
        if (!rocknot || !rocknot->AI() || !rocknot->AI()->GetData(DATA_CAN_START_LOVE_POTION))
            return;

        rocknot->AI()->DoAction(ACTION_START_LOVE_POTION);
        if (!rocknot->AI()->GetData(DATA_LOVE_POTION_ACTIVE))
            return;

        me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
        _lovePotionEvent = true;
        _rocknotGuid = rocknot->GetGUID();
        me->setActive(true);

        me->SetWalk(false);
        me->GetMotionMaster()->Clear();
        StartApproach();
        _events.ScheduleEvent(EVENT_MOVEMENT_TIMEOUT, 45s);
    }

    void SetData(uint32 id, uint32 value) override
    {
        if (!_lovePotionComplete && id == DATA_AMBIENT_ORDER && value == 1 && !_ambientEvents.HasTimeUntilEvent(EVENT_AMBIENT_REPLY))
            _ambientEvents.ScheduleEvent(EVENT_AMBIENT_REPLY, 4s);
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_CANCEL_LOVE_POTION)
            AbortLovePotionEvent(false);
        else if (action == ACTION_ROCKNOT_AT_LOVERS_STOP && _lovePotionEvent)
        {
            Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid);
            if (!rocknot)
            {
                AbortLovePotionEvent(false);
                return;
            }

            me->SetFacingToObject(rocknot);
            rocknot->SetFacingToObject(me);
            _events.CancelEvent(EVENT_MOVEMENT_TIMEOUT);
            _events.ScheduleEvent(EVENT_KISS_ROCKNOT, 2s);
        }
    }

    void MovementInform(uint32 type, uint32 pointId) override
    {
        if (type != POINT_MOTION_TYPE || !_lovePotionEvent)
            return;

        _events.RescheduleEvent(EVENT_MOVEMENT_TIMEOUT, 45s);

        if (pointId == POINT_APPROACH_GREETING)
            _events.ScheduleEvent(EVENT_GREET_ROCKNOT, 1ms);
        else if (pointId >= POINT_APPROACH_PATROL && pointId < POINT_APPROACH_PATROL + std::size(NagmaraPatrolPath))
        {
            _approachPoint = pointId - POINT_APPROACH_PATROL;
            if (me->GetExactDist2d(&NagmaraGreetingPosition) <= NAGMARA_GREETING_DISTANCE)
                _events.ScheduleEvent(EVENT_MOVE_GREETING, 1ms);
            else
            {
                _approachPoint = (_approachPoint + 1) % std::size(NagmaraPatrolPath);
                _events.ScheduleEvent(EVENT_MOVE_APPROACH, 1ms);
            }
        }
        else if (pointId >= POINT_LOVERS_ROUTE && pointId < POINT_LOVERS_ROUTE + std::size(NagmaraLoversPath))
        {
            _routePoint = pointId - POINT_LOVERS_ROUTE;
            if (_routePoint == NAGMARA_DOOR_WAIT_POINT)
            {
                _doorOpenAttempts = 0;
                if (Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid))
                    if (rocknot->AI())
                        rocknot->AI()->DoAction(ACTION_PAUSE_AT_BAR_DOOR);

                _events.ScheduleEvent(EVENT_OPEN_BAR_DOOR, 1ms);
            }
            else if (++_routePoint < std::size(NagmaraLoversPath))
                _events.ScheduleEvent(EVENT_MOVE_LOVERS_ROUTE, 1ms);
            else
                _events.ScheduleEvent(EVENT_REACH_LOVERS_STOP, 1ms);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!_lovePotionEvent && !_lovePotionComplete)
        {
            _ambientEvents.Update(diff);
            if (_ambientEvents.ExecuteEvent() == EVENT_AMBIENT_REPLY)
                if (Creature* patron = FindNearestPatron())
                    Talk(SAY_NAGMARA_AMBIENT, patron);
        }

        _events.Update(diff);

        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_SAY_NAGMARA_2:
                    Talk(SAY_NAGMARA_2);
                    _events.ScheduleEvent(EVENT_CAST_LOVE_POTION, 1s);
                    break;
                case EVENT_CAST_LOVE_POTION:
                    DoCast(me, SPELL_POTION_LOVE);
                    if (ObjectAccessor::GetCreature(*me, _rocknotGuid))
                        _events.ScheduleEvent(EVENT_START_LOVERS_ROUTE, 2s);
                    else
                        AbortLovePotionEvent(false);
                    break;
                case EVENT_START_LOVERS_ROUTE:
                    if (Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid))
                    {
                        if (rocknot->AI())
                        {
                            rocknot->AI()->DoAction(ACTION_BEGIN_LOVERS_FOLLOW);
                            if (!rocknot->AI()->GetData(DATA_LOVE_POTION_ACTIVE))
                            {
                                AbortLovePotionEvent(false);
                                break;
                            }

                            _routePoint = 0;
                            MoveToRoutePoint();
                        }
                    }
                    else
                        AbortLovePotionEvent(false);
                    break;
                case EVENT_OPEN_BAR_DOOR:
                    if (OpenBarDoor())
                    {
                        _doorOpenedByEvent = true;
                        _events.ScheduleEvent(EVENT_CONTINUE_AFTER_DOOR, 3s);
                    }
                    else if (++_doorOpenAttempts < 30)
                        _events.ScheduleEvent(EVENT_OPEN_BAR_DOOR, 1s);
                    else
                        AbortLovePotionEvent(true);
                    break;
                case EVENT_CONTINUE_AFTER_DOOR:
                    if (Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid))
                        if (rocknot->AI())
                            rocknot->AI()->DoAction(ACTION_RESUME_AFTER_BAR_DOOR);
                    if (++_routePoint < std::size(NagmaraLoversPath))
                        MoveToRoutePoint();
                    else
                        ReachLoversStop();
                    break;
                case EVENT_KISS_ROCKNOT:
                    if (Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid); rocknot && rocknot->AI())
                    {
                        me->SetFacingToObject(rocknot);
                        rocknot->SetFacingToObject(me);
                        rocknot->AI()->Talk(EMOTE_ROCKNOT);
                        DoCast(me, SPELL_NAGMARA_ROCKNOT, true);
                        rocknot->CastSpell(rocknot, SPELL_NAGMARA_ROCKNOT, true);
                        _events.ScheduleEvent(EVENT_CLEAR_HEARTS, 6s);

                        _lovePotionEvent = false;
                        _lovePotionComplete = true;
                        _doorOpenedByEvent = false;
                        _ambientEvents.Reset();
                        me->SetHomePosition(me->GetPosition());
                        rocknot->AI()->DoAction(ACTION_COMPLETE_LOVE_POTION);
                        me->SetNpcFlag(UNIT_NPC_FLAG_QUESTGIVER);
                        if (_instance)
                            _instance->SetData(DATA_LOVE_POTION_EVENT, DONE);
                    }
                    else
                        AbortLovePotionEvent(false);
                    break;
                case EVENT_CLEAR_HEARTS:
                    me->RemoveAurasDueToSpell(SPELL_NAGMARA_ROCKNOT);
                    if (Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid))
                        rocknot->RemoveAurasDueToSpell(SPELL_NAGMARA_ROCKNOT);
                    me->setActive(false);
                    break;
                case EVENT_MOVEMENT_TIMEOUT:
                    AbortLovePotionEvent(true);
                    break;
                case EVENT_MOVE_APPROACH:
                    MoveToApproachPoint();
                    break;
                case EVENT_MOVE_GREETING:
                    MoveToGreetingPosition();
                    break;
                case EVENT_GREET_ROCKNOT:
                    GreetRocknot();
                    break;
                case EVENT_MOVE_LOVERS_ROUTE:
                    MoveToRoutePoint();
                    break;
                case EVENT_REACH_LOVERS_STOP:
                    ReachLoversStop();
                    break;
            }
        }
    }

private:
    Creature* FindNearestPatron() const
    {
        Creature* patron = me->FindNearestCreature(NPC_GRIM_PATRON, 50.0f);
        if (Creature* guzzlingPatron = me->FindNearestCreature(NPC_GUZZLING_PATRON, 50.0f);
            guzzlingPatron && (!patron || me->GetExactDist2d(guzzlingPatron) < me->GetExactDist2d(patron)))
            patron = guzzlingPatron;

        return patron;
    }

    void StartApproach()
    {
        float shortestDistance = std::numeric_limits<float>::max();
        uint8 nearestPoint = 0;
        for (uint8 i = 0; i < std::size(NagmaraPatrolPath); ++i)
        {
            float distance = me->GetExactDist2d(&NagmaraPatrolPath[i]);
            if (distance < shortestDistance)
            {
                shortestDistance = distance;
                nearestPoint = i;
            }
        }

        if (me->GetExactDist2d(&NagmaraGreetingPosition) <= NAGMARA_GREETING_DISTANCE)
            MoveToGreetingPosition();
        else
        {
            _approachPoint = (nearestPoint + 1) % std::size(NagmaraPatrolPath);
            MoveToApproachPoint();
        }
    }

    void MoveToApproachPoint()
    {
        me->GetMotionMaster()->MovePoint(POINT_APPROACH_PATROL + _approachPoint, NagmaraPatrolPath[_approachPoint],
            FORCED_MOVEMENT_NONE, 0.0f, false);
    }

    void MoveToGreetingPosition()
    {
        me->GetMotionMaster()->MovePoint(POINT_APPROACH_GREETING, NagmaraGreetingPosition, FORCED_MOVEMENT_NONE, 0.0f, false);
    }

    void GreetRocknot()
    {
        Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid);
        if (!rocknot || !me->IsWithinDistInMap(rocknot, 6.0f))
        {
            AbortLovePotionEvent(true);
            return;
        }

        me->GetMotionMaster()->MoveIdle();
        me->SetFacingToObject(rocknot);
        rocknot->SetFacingToObject(me);
        Talk(SAY_NAGMARA_1);
        _events.ScheduleEvent(EVENT_SAY_NAGMARA_2, 1s);
    }

    void MoveToRoutePoint()
    {
        me->GetMotionMaster()->MovePoint(POINT_LOVERS_ROUTE + _routePoint, NagmaraLoversPath[_routePoint],
            FORCED_MOVEMENT_NONE, 0.0f, false);
    }

    bool OpenBarDoor()
    {
        if (!_instance)
            return false;

        GameObject* door = _instance->instance->GetGameObject(_instance->GetGuidData(DATA_GO_BAR_DOOR));
        if (!door)
            return false;

        door->SetGoState(GO_STATE_ACTIVE);
        return true;
    }

    void ReachLoversStop()
    {
        me->GetMotionMaster()->MoveIdle();

        if (Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid))
            if (rocknot->AI())
            {
                rocknot->AI()->DoAction(ACTION_MOVE_TO_LOVERS_STOP);
                return;
            }

        AbortLovePotionEvent(false);
    }

    void AbortLovePotionEvent(bool notifyRocknot)
    {
        if (_lovePotionComplete)
            return;

        Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid);
        if (_doorOpenedByEvent && _instance)
            if (GameObject* door = _instance->instance->GetGameObject(_instance->GetGuidData(DATA_GO_BAR_DOOR)))
                door->SetGoState(GO_STATE_READY);

        _events.Reset();
        _rocknotGuid.Clear();
        _lovePotionEvent = false;
        _approachPoint = 0;
        _routePoint = 0;
        _doorOpenAttempts = 0;
        _doorOpenedByEvent = false;
        me->setActive(false);
        me->GetMotionMaster()->Clear();
        me->GetMotionMaster()->MoveTargetedHome();
        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);

        if (notifyRocknot && rocknot && rocknot->AI())
            rocknot->AI()->DoAction(ACTION_CANCEL_LOVE_POTION);
    }

    InstanceScript* _instance;
    EventMap _events;
    EventMap _ambientEvents;
    ObjectGuid _rocknotGuid;
    uint8 _approachPoint;
    uint8 _routePoint;
    uint8 _doorOpenAttempts;
    bool _lovePotionEvent;
    bool _lovePotionComplete;
    bool _doorOpenedByEvent;
};

// npc_rocknot
enum RocknotSays
{
    SAY_GOT_BEER                       = 0
};

enum RocknotSpells
{
    SPELL_DRUNKEN_RAGE                 = 14872
};

enum RocknotQuests
{
    QUEST_ALE                          = 4295
};

struct npc_rocknot : public npc_escortAI
{
    npc_rocknot(Creature* creature) : npc_escortAI(creature), _instance(creature->GetInstanceScript()),
        _breakKegTimer(0), _breakDoorTimer(0), _lovePotionEvent(false), _lovePotionComplete(false),
        _aleEventStarted(false) { }

    void Reset() override
    {
        if (_instance && _instance->GetData(DATA_LOVE_POTION_EVENT) == DONE)
        {
            _nagmaraGuid.Clear();
            _breakKegTimer = 0;
            _breakDoorTimer = 0;
            _lovePotionEvent = false;
            _lovePotionComplete = true;
            _aleEventStarted = false;
            me->GetMotionMaster()->Clear();
            me->NearTeleportTo(RocknotFinalPosition.GetPositionX(), RocknotFinalPosition.GetPositionY(),
                RocknotFinalPosition.GetPositionZ(), RocknotFinalPosition.GetOrientation());
            me->SetHomePosition(RocknotFinalPosition);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
            me->GetMotionMaster()->MoveIdle();
            me->setActive(false);
            return;
        }

        if (HasEscortState(STATE_ESCORT_ESCORTING))
            return;

        if (_lovePotionEvent && !_lovePotionComplete)
        {
            AbortLovePotionEvent();
            return;
        }

        _breakKegTimer = 0;
        _breakDoorTimer = 0;
        if (!_lovePotionComplete)
            _lovePotionEvent = false;
        _aleEventStarted = false;

        if (_lovePotionComplete)
        {
            me->setActive(false);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
            me->GetMotionMaster()->MoveIdle();
        }
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_START_LOVE_POTION)
        {
            if (!CanStartLovePotionEvent())
                return;

            _lovePotionEvent = true;
            _lovePotionComplete = false;
            me->setActive(true);
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
        }
        else if (action == ACTION_CANCEL_LOVE_POTION)
            AbortLovePotionEvent();
        else if (action == ACTION_BEGIN_LOVERS_FOLLOW && _lovePotionEvent)
        {
            if (me->IsInCombat())
            {
                AbortLovePotionEvent();
                return;
            }

            Creature* nagmara = me->FindNearestCreature(NPC_MISTRESS_NAGMARA, 100.0f);
            if (!nagmara)
            {
                AbortLovePotionEvent();
                return;
            }

            _nagmaraGuid = nagmara->GetGUID();
            me->SetWalk(false);
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveFollow(nagmara, 3.0f, M_PI);
        }
        else if (action == ACTION_MOVE_TO_LOVERS_STOP && _lovePotionEvent)
        {
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MovePoint(POINT_ROCKNOT_FINAL, RocknotFinalPosition);
        }
        else if (action == ACTION_PAUSE_AT_BAR_DOOR && _lovePotionEvent)
        {
            me->GetMotionMaster()->Clear();
            me->GetMotionMaster()->MoveIdle();
        }
        else if (action == ACTION_RESUME_AFTER_BAR_DOOR && _lovePotionEvent)
        {
            if (Creature* nagmara = ObjectAccessor::GetCreature(*me, _nagmaraGuid))
            {
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveFollow(nagmara, 3.0f, M_PI);
            }
        }
        else if (action == ACTION_COMPLETE_LOVE_POTION && _lovePotionEvent)
        {
            _lovePotionEvent = false;
            _lovePotionComplete = true;
            me->SetHomePosition(me->GetPosition());
            me->GetMotionMaster()->MoveIdle();
            me->RemoveNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);
            me->setActive(false);
        }
    }

    uint32 GetData(uint32 type) const override
    {
        if (type == DATA_CAN_START_LOVE_POTION)
            return CanStartLovePotionEvent();
        if (type == DATA_LOVE_POTION_ACTIVE)
            return _lovePotionEvent;

        return 0;
    }

    void MovementInform(uint32 type, uint32 pointId) override
    {
        npc_escortAI::MovementInform(type, pointId);

        if (type != POINT_MOTION_TYPE || pointId != POINT_ROCKNOT_FINAL || !_lovePotionEvent)
            return;

        me->GetMotionMaster()->MoveIdle();

        if (Creature* nagmara = ObjectAccessor::GetCreature(*me, _nagmaraGuid))
            if (nagmara->AI())
                nagmara->AI()->DoAction(ACTION_ROCKNOT_AT_LOVERS_STOP);
    }

    void sQuestReward(Player* /*player*/, Quest const* quest, uint32 /*opt*/) override
    {
        if (!_instance || _lovePotionEvent)
            return;

        if (_instance->GetData(TYPE_BAR) == DONE || _instance->GetData(TYPE_BAR) == SPECIAL)
            return;

        if (quest->GetQuestId() == QUEST_ALE)
        {
            if (_instance->GetData(TYPE_BAR) != IN_PROGRESS)
                _instance->SetData(TYPE_BAR, IN_PROGRESS);

            _instance->SetData(TYPE_BAR, SPECIAL);

            //keep track of amount in instance script, returns SPECIAL if amount ok and event in progress
            if (_instance->GetData(TYPE_BAR) == SPECIAL)
            {
                Talk(SAY_GOT_BEER);
                me->CastSpell(me, SPELL_DRUNKEN_RAGE, false);
                me->SetWalk(true);
                _aleEventStarted = true;
                Start(false);
            }
        }
    }

    void DoGo(uint32 id, uint32 state)
    {
        if (!_instance)
            return;

        if (GameObject* go = _instance->instance->GetGameObject(_instance->GetGuidData(id)))
            go->SetGoState((GOState)state);
    }

    using CreatureAI::WaypointReached;
    void WaypointReached(uint32 waypointId) override
    {
        switch (waypointId)
        {
            case 1:
                me->HandleEmoteCommand(EMOTE_ONESHOT_KICK);
                break;
            case 2:
                me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK_UNARMED);
                break;
            case 3:
                me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK_UNARMED);
                break;
            case 4:
                me->HandleEmoteCommand(EMOTE_ONESHOT_KICK);
                break;
            case 5:
                me->HandleEmoteCommand(EMOTE_ONESHOT_KICK);
                _breakKegTimer = 2000;
                break;
        }
    }

    void UpdateAI(uint32 diff) override
    {
        // Standard Ale Event Timers
        if (_breakKegTimer)
        {
            if (_breakKegTimer <= diff)
            {
                DoGo(DATA_GO_BAR_KEG, 0);
                _breakKegTimer = 0;
                _breakDoorTimer = 1000;
            }
            else _breakKegTimer -= diff;
        }

        if (_breakDoorTimer)
        {
            if (_breakDoorTimer <= diff)
            {
                DoGo(DATA_GO_BAR_DOOR, 2);
                DoGo(DATA_GO_BAR_KEG_TRAP, 0);               //doesn't work very well, leaving code here for future
                //spell by trap has effect61, this indicate the bar go hostile

                if (Unit* tmp = ObjectAccessor::GetUnit(*me, _instance->GetGuidData(DATA_PHALANX)))
                    tmp->SetFaction(FACTION_MONSTER);

                //for later, this event(s) has alot more to it.
                //optionally, DONE can trigger bar to go hostile.
                _instance->SetData(TYPE_BAR, DONE);
                _breakDoorTimer = 0;
            }
            else _breakDoorTimer -= diff;
        }

        npc_escortAI::UpdateAI(diff);
    }

private:
    bool CanStartLovePotionEvent() const
    {
        if (_lovePotionEvent || _aleEventStarted || !_instance || me->IsInCombat())
            return false;

        if (_instance->GetData(TYPE_BAR) != NOT_STARTED)
            return false;

        return _instance->instance->GetGameObject(_instance->GetGuidData(DATA_GO_BAR_DOOR));
    }

    void AbortLovePotionEvent()
    {
        if (_lovePotionComplete)
            return;

        _lovePotionEvent = false;
        _nagmaraGuid.Clear();
        me->setActive(false);
        me->GetMotionMaster()->Clear();
        me->GetMotionMaster()->MoveTargetedHome();
        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);

        if (Creature* nagmara = me->FindNearestCreature(NPC_MISTRESS_NAGMARA, 100.0f))
            if (nagmara->AI())
                nagmara->AI()->DoAction(ACTION_CANCEL_LOVE_POTION);
    }

    InstanceScript* _instance;
    ObjectGuid _nagmaraGuid;
    uint32 _breakKegTimer;
    uint32 _breakDoorTimer;
    bool _lovePotionEvent;
    bool _lovePotionComplete;
    bool _aleEventStarted;
};

void AddSC_blackrock_depths()
{
    RegisterBlackrockDepthsGameObjectAI(go_shadowforge_brazier);
    new at_ring_of_law();
    RegisterBlackrockDepthsCreatureAI(npc_grimstone);
    RegisterBlackrockDepthsCreatureAI(npc_phalanx);
    RegisterBlackrockDepthsCreatureAI(npc_mistress_nagmara);
    RegisterBlackrockDepthsCreatureAI(npc_rocknot);
    RegisterBlackrockDepthsCreatureAI(brd_ironhand_guardian);
}
