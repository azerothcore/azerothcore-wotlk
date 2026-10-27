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
#include "WaypointMgr.h"

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
// Cala's CMaNGOS Grim Guzzler rework established the corner/door staging:
// https://github.com/cmangos/mangos-wotlk/commit/563770518af7
// The route and spell IDs below are checked against Anniversary build 69546.
enum PhalanxSpells
{
    SPELL_THUNDERCLAP = 15588,
    SPELL_FIREBALLVOLLEY = 15285,
    SPELL_MIGHTYBLOW = 14099
};

enum PhalanxTexts
{
    SAY_PHALANX_AGGRO = 0
};

enum PhalanxActions
{
    ACTION_PHALANX_START_ACTIVATION = 1
};

enum PhalanxEvents
{
    EVENT_PHALANX_YELL = 1,
    EVENT_PHALANX_FINISH_MOVEMENT,
    EVENT_PHALANX_THUNDERCLAP,
    EVENT_PHALANX_MIGHTY_BLOW,
    EVENT_PHALANX_FIREBALL_VOLLEY
};

enum PhalanxStates
{
    PHALANX_STATE_DORMANT,
    PHALANX_STATE_MOVING_TO_DOOR,
    PHALANX_STATE_ACTIVE
};

enum PhalanxData
{
    PATH_PHALANX_DOOR = 95020,
    FACTION_PHALANX_HOSTILE = 54
};

struct npc_phalanx : public ScriptedAI
{
    npc_phalanx(Creature* creature) : ScriptedAI(creature),
        _instance(creature->GetInstanceScript()), _state(PHALANX_STATE_DORMANT), _volleyStarted(false) { }

    void Reset() override
    {
        _combatEvents.Reset();
        _stagingEvents.Reset();
        _volleyStarted = false;

        bool const restoring = _state == PHALANX_STATE_DORMANT && _instance &&
            _instance->GetData(DATA_PHALANX_ACTIVATED) == DONE;
        if (_state != PHALANX_STATE_DORMANT || restoring)
        {
            Activate();
            // An evade already has a home movement. A newly loaded creature needs one,
            // but must not replay the announcement or become friendly again.
            if (restoring)
                me->GetMotionMaster()->MoveTargetedHome();
        }
        else
        {
            me->RestoreFaction();
            me->SetReactState(REACT_AGGRESSIVE);
        }
    }

    void EnterEvadeMode(EvadeReason why = EVADE_REASON_OTHER) override
    {
        // Waypoint movement updates home at each node. Evading during the run
        // must still return to the final guard position.
        if (_state != PHALANX_STATE_DORMANT)
            SetDoorHome();

        ScriptedAI::EnterEvadeMode(why);
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _combatEvents.ScheduleEvent(EVENT_PHALANX_THUNDERCLAP, 12s);
        _combatEvents.ScheduleEvent(EVENT_PHALANX_MIGHTY_BLOW, 15s);
    }

    void PathEndReached(uint32 pathId) override
    {
        if (pathId == PATH_PHALANX_DOOR && _state == PHALANX_STATE_MOVING_TO_DOOR)
        {
            Activate();
            // Zero-delay waypoints do not apply their facing; the sniff turns him after arrival.
            me->SetFacingTo(me->GetHomePosition().GetOrientation());
        }
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_PHALANX_START_ACTIVATION && _state == PHALANX_STATE_DORMANT)
            StartActivation();
    }

    void UpdateAI(uint32 diff) override
    {
        // Preserve the existing Plugger activation hook.
        if (_state == PHALANX_STATE_DORMANT && me->GetFaction() == FACTION_MONSTER)
            StartActivation();

        _stagingEvents.Update(diff);
        while (uint32 eventId = _stagingEvents.ExecuteEvent())
        {
            if (eventId == EVENT_PHALANX_YELL)
                Talk(SAY_PHALANX_AGGRO);
            else if (eventId == EVENT_PHALANX_FINISH_MOVEMENT)
            {
                // A blocked route must not leave him permanently passive or teleport him.
                Activate();
            }
        }

        if (_state != PHALANX_STATE_ACTIVE || !UpdateVictim())
            return;

        _combatEvents.Update(diff);
        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        if (!_volleyStarted && HealthBelowPct(51))
        {
            _volleyStarted = true;
            _combatEvents.ScheduleEvent(EVENT_PHALANX_FIREBALL_VOLLEY, 1ms);
        }

        while (uint32 eventId = _combatEvents.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_PHALANX_THUNDERCLAP:
                    _combatEvents.ScheduleEvent(eventId,
                        DoCastSelf(SPELL_THUNDERCLAP) == SPELL_CAST_OK ? 10s : 500ms);
                    break;
                case EVENT_PHALANX_MIGHTY_BLOW:
                    _combatEvents.ScheduleEvent(eventId,
                        DoCastVictim(SPELL_MIGHTYBLOW) == SPELL_CAST_OK ? 10s : 500ms);
                    break;
                case EVENT_PHALANX_FIREBALL_VOLLEY:
                    _combatEvents.ScheduleEvent(eventId,
                        HealthBelowPct(51) && DoCastSelf(SPELL_FIREBALLVOLLEY) == SPELL_CAST_OK ? 10s : 500ms);
                    break;
            }
        }
        DoMeleeAttackIfReady();
    }

private:
    void SetDoorHome()
    {
        if (WaypointPath const* path = sWaypointMgr->GetPath(PATH_PHALANX_DOOR); path && !path->Nodes.empty())
        {
            WaypointNode const& node = path->Nodes.back();
            me->SetHomePosition(node.X, node.Y, node.Z, node.Orientation.value_or(me->GetOrientation()));
        }
    }

    void StartActivation()
    {
        _state = PHALANX_STATE_MOVING_TO_DOOR;
        SetDoorHome();
        if (_instance)
            _instance->SetData(DATA_PHALANX_ACTIVATED, DONE);

        // The sniff retains interaction during staging, changes faction on arrival,
        // and announces the event shortly after starting the run.
        me->SetReactState(REACT_PASSIVE);
        me->SetWalk(false);
        me->GetMotionMaster()->MoveWaypoint(PATH_PHALANX_DOOR, false);
        _stagingEvents.ScheduleEvent(EVENT_PHALANX_YELL, 200ms);
        _stagingEvents.ScheduleEvent(EVENT_PHALANX_FINISH_MOVEMENT, 15s);
    }

    void Activate()
    {
        _state = PHALANX_STATE_ACTIVE;
        _stagingEvents.CancelEvent(EVENT_PHALANX_FINISH_MOVEMENT);
        SetDoorHome();
        me->SetFaction(FACTION_PHALANX_HOSTILE);
        me->SetReactState(REACT_AGGRESSIVE);
    }

    InstanceScript* _instance;
    PhalanxStates _state;
    EventMap _stagingEvents;
    EventMap _combatEvents;
    bool _volleyStarted;
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
    EMOTE_NAGMARA = 3
};

enum RocknotSays
{
    SAY_GOT_BEER = 0,
    SAY_MORE_ALE = 1,
    SAY_FIRST_EMPTY = 2,
    SAY_SECOND_EMPTY = 3,
    SAY_ALE = 4,
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

enum NagmaraTaskGroups
{
    GROUP_NAGMARA_LOVE_SEQUENCE = 1,
    GROUP_NAGMARA_MOVEMENT_TIMEOUT,
    GROUP_NAGMARA_AMBIENT_REPLY,
    GROUP_NAGMARA_KISS
};

enum NagmaraGossip
{
    GOSSIP_MENU_NAGMARA = 2076
};

enum NagmaraPoints
{
    POINT_APPROACH   = 100,
    POINT_APPROACH_GREETING = 108,
    POINT_ROCKNOT_FINAL     = 300
};

enum NagmaraWaypoints
{
    PATH_NAGMARA_LOVERS = 95001,
    POINT_NAGMARA_DOOR_WAIT = 4
};

// WotLK Classic 3.4.1.49345 sniff, identical waypoints in two runs:
// https://github.com/azerothcore/azerothcore-wotlk/pull/27287#issuecomment-5786575146
Position const NagmaraApproachPosition = { 874.3762f, -187.63274f, -43.70371f };
Position const NagmaraGreetingPosition = { 889.49426f, -196.88141f, -43.713f };

Position const NagmaraFinalPosition = { 878.1779f, -222.06618f, -49.967144f, 0.25003412f };
Position const RocknotFinalPosition = { 880.1218f, -221.5959f, -49.95902f, 3.3916268f };

struct npc_mistress_nagmara : public CreatureAI
{
    npc_mistress_nagmara(Creature* creature) : CreatureAI(creature), _instance(creature->GetInstanceScript()),
        _doorOpenAttempts(0), _lovePotionEvent(false),
        _lovePotionComplete(false), _doorOpenedByEvent(false) { }

    void Reset() override
    {
        if (_lovePotionComplete)
        {
            me->setActive(false);
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            me->GetMotionMaster()->MoveIdle();
            return;
        }

        if (_instance && _instance->GetData(DATA_LOVE_POTION_EVENT) == DONE)
        {
            scheduler.CancelAll();
            _ambientScheduler.CancelAll();
            _rocknotGuid.Clear();
            _doorOpenAttempts = 0;
            _lovePotionEvent = false;
            _lovePotionComplete = true;
            _doorOpenedByEvent = false;
            me->GetMotionMaster()->Clear();
            Position const& finalPosition = NagmaraFinalPosition;
            me->NearTeleportTo(finalPosition.GetPositionX(), finalPosition.GetPositionY(),
                finalPosition.GetPositionZ(), finalPosition.GetOrientation());
            me->SetHomePosition(finalPosition);
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            ScheduleKiss();
            me->GetMotionMaster()->MoveIdle();
            me->setActive(false);
            return;
        }

        if (_lovePotionEvent)
        {
            AbortLovePotionEvent(true);
            return;
        }

        CancelLovePotionTasks();
        _rocknotGuid.Clear();
        _doorOpenAttempts = 0;
        _doorOpenedByEvent = false;
    }

    void sGossipSelect(Player* player, uint32 menuId, uint32 gossipListId) override
    {
        if (menuId != GOSSIP_MENU_NAGMARA || gossipListId != 0 || !player->GetQuestRewardStatus(QUEST_POTION_LOVE))
            return;

        CloseGossipMenuFor(player);

        if (!_instance)
            return;

        uint32 const barState = _instance->GetData(TYPE_BAR);
        if (barState != NOT_STARTED && barState != IN_PROGRESS)
            return;

        Creature* rocknot = me->FindNearestCreature(NPC_PRIVATE_ROCKNOT, 100.0f);
        if (!rocknot || !rocknot->AI() || !rocknot->AI()->GetData(DATA_CAN_START_LOVE_POTION))
            return;

        rocknot->AI()->DoAction(ACTION_START_LOVE_POTION);
        if (!rocknot->AI()->GetData(DATA_LOVE_POTION_ACTIVE))
            return;

        me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_NONE);
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        _lovePotionEvent = true;
        _rocknotGuid = rocknot->GetGUID();
        me->setActive(true);

        me->SetWalk(false);
        me->GetMotionMaster()->Clear();
        Talk(SAY_NAGMARA_1);
        MoveToApproachPoint();
        scheduler.Schedule(45s, GROUP_NAGMARA_MOVEMENT_TIMEOUT, [this](TaskContext context)
        {
            AbortLovePotionEvent(true, context);
        });
    }

    void SetData(uint32 id, uint32 value) override
    {
        if (!_lovePotionComplete && id == DATA_AMBIENT_ORDER && value == 1 &&
            !_ambientScheduler.IsGroupScheduled(GROUP_NAGMARA_AMBIENT_REPLY))
        {
            _ambientScheduler.Schedule(4s, GROUP_NAGMARA_AMBIENT_REPLY, [this](TaskContext /*context*/)
            {
                if (Creature* patron = FindNearestPatron())
                    Talk(SAY_NAGMARA_AMBIENT, patron);
            });
        }
    }

    void DoAction(int32 action) override
    {
        if (action == ACTION_CANCEL_LOVE_POTION)
            AbortLovePotionEvent(false);
        else if (action == ACTION_ROCKNOT_AT_LOVERS_STOP && _lovePotionEvent)
        {
            Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid);
            if (!rocknot || !rocknot->AI())
            {
                AbortLovePotionEvent(false);
                return;
            }

            me->SetFacingToObject(rocknot);
            rocknot->SetFacingToObject(me);
            scheduler.CancelGroupsOf({ GROUP_NAGMARA_LOVE_SEQUENCE, GROUP_NAGMARA_MOVEMENT_TIMEOUT });
            _lovePotionEvent = false;
            _lovePotionComplete = true;
            _doorOpenedByEvent = false;
            _ambientScheduler.CancelAll();
            me->SetHomePosition(me->GetPosition());
            rocknot->AI()->DoAction(ACTION_COMPLETE_LOVE_POTION);
            if (_instance)
                _instance->SetData(DATA_LOVE_POTION_EVENT, DONE);
            me->setActive(false);
        }
    }

    void MovementInform(uint32 type, uint32 pointId) override
    {
        if (type != POINT_MOTION_TYPE || !_lovePotionEvent)
            return;

        scheduler.RescheduleGroup(GROUP_NAGMARA_MOVEMENT_TIMEOUT, 45s);

        if (pointId == POINT_APPROACH_GREETING)
        {
            scheduler.Schedule(1ms, GROUP_NAGMARA_LOVE_SEQUENCE, [this](TaskContext context)
            {
                GreetRocknot(context);
            });
        }
        else if (pointId == POINT_APPROACH)
        {
            scheduler.Schedule(1ms, GROUP_NAGMARA_LOVE_SEQUENCE, [this](TaskContext /*context*/)
            {
                MoveToGreetingPosition();
            });
        }
    }

    void WaypointReached(uint32 pointId, uint32 pathId) override
    {
        if (!_lovePotionEvent || pathId != PATH_NAGMARA_LOVERS)
            return;

        scheduler.RescheduleGroup(GROUP_NAGMARA_MOVEMENT_TIMEOUT, 45s);
        if (pointId != POINT_NAGMARA_DOOR_WAIT)
            return;

        me->PauseMovement();
        _doorOpenAttempts = 0;
        if (Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid))
            if (rocknot->AI())
                rocknot->AI()->DoAction(ACTION_PAUSE_AT_BAR_DOOR);

        scheduler.Schedule(500ms, GROUP_NAGMARA_LOVE_SEQUENCE, [this](TaskContext context)
        {
            TryOpenBarDoor(context);
        });
    }

    void PathEndReached(uint32 pathId) override
    {
        if (_lovePotionEvent && pathId == PATH_NAGMARA_LOVERS)
            scheduler.Schedule(1ms, GROUP_NAGMARA_LOVE_SEQUENCE, [this](TaskContext context)
            {
                ReachLoversStop(context);
            });
    }

    void UpdateAI(uint32 diff) override
    {
        if (!_lovePotionEvent && !_lovePotionComplete)
            _ambientScheduler.Update(diff);

        scheduler.Update(diff);
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

    void MoveToApproachPoint()
    {
        me->GetMotionMaster()->MovePoint(POINT_APPROACH, NagmaraApproachPosition,
            FORCED_MOVEMENT_NONE, 0.0f, false);
    }

    void MoveToGreetingPosition()
    {
        me->GetMotionMaster()->MovePoint(POINT_APPROACH_GREETING, NagmaraGreetingPosition, FORCED_MOVEMENT_NONE, 0.0f, false);
    }

    void GreetRocknot(TaskContext& context)
    {
        Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid);
        if (!rocknot || !me->IsWithinDistInMap(rocknot, 6.0f))
        {
            AbortLovePotionEvent(true, context);
            return;
        }

        me->GetMotionMaster()->MoveIdle();
        me->SetFacingToObject(rocknot);
        rocknot->SetFacingToObject(me);
        context.Schedule(300ms, GROUP_NAGMARA_LOVE_SEQUENCE, [this](TaskContext context)
        {
            CastLovePotion(context);
        });
    }

    void CastLovePotion(TaskContext& context)
    {
        DoCast(me, SPELL_POTION_LOVE);

        // The potion casts for 1 second, then she waits 2.2 seconds before leaving.
        if (ObjectAccessor::GetCreature(*me, _rocknotGuid))
        {
            context.Schedule(3200ms, GROUP_NAGMARA_LOVE_SEQUENCE, [this](TaskContext context)
            {
                StartLoversRoute(context);
            });
        }
        else
            AbortLovePotionEvent(false, context);
    }

    void StartLoversRoute(TaskContext& context)
    {
        Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid);
        if (!rocknot || !rocknot->AI())
        {
            AbortLovePotionEvent(false, context);
            return;
        }

        rocknot->AI()->DoAction(ACTION_BEGIN_LOVERS_FOLLOW);
        if (!rocknot->AI()->GetData(DATA_LOVE_POTION_ACTIVE))
        {
            AbortLovePotionEvent(false, context);
            return;
        }

        me->GetMotionMaster()->MoveWaypoint(PATH_NAGMARA_LOVERS, false);
    }

    bool OpenBarDoor()
    {
        if (!_instance)
            return false;

        GameObject* door = _instance->instance->GetGameObject(_instance->GetGuidData(DATA_GO_BAR_DOOR));
        if (!door)
            return false;

        // players can open this door with the Grim Guzzler Key, so only close it again if we opened it
        _doorOpenedByEvent = door->GetGoState() == GO_STATE_READY;
        door->SetGoState(GO_STATE_ACTIVE);
        return true;
    }

    void TryOpenBarDoor(TaskContext& context)
    {
        if (OpenBarDoor())
        {
            context.Schedule(3200ms, GROUP_NAGMARA_LOVE_SEQUENCE, [this](TaskContext /*context*/)
            {
                ContinueAfterDoor();
            });
        }
        else if (++_doorOpenAttempts < 30)
            context.Repeat(1s);
        else
            AbortLovePotionEvent(true, context);
    }

    void ContinueAfterDoor()
    {
        if (Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid))
            if (rocknot->AI())
                rocknot->AI()->DoAction(ACTION_RESUME_AFTER_BAR_DOOR);

        me->ResumeMovement();
    }

    void ReachLoversStop(TaskContext& context)
    {
        me->GetMotionMaster()->MoveIdle();

        if (Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid))
            if (rocknot->AI())
            {
                me->SetFacingTo(me->GetAngle(&RocknotFinalPosition));
                context.Schedule(1ms, GROUP_NAGMARA_KISS, [this](TaskContext context)
                {
                    KissRocknot(context);
                });
                rocknot->AI()->DoAction(ACTION_MOVE_TO_LOVERS_STOP);
                return;
            }

        AbortLovePotionEvent(false, context);
    }

    void KissRocknot(TaskContext& context)
    {
        Talk(EMOTE_NAGMARA);
        DoCastSelf(SPELL_NAGMARA_ROCKNOT, true);
        context.Repeat(11s, 21s);
    }

    void ScheduleKiss()
    {
        scheduler.Schedule(1ms, GROUP_NAGMARA_KISS, [this](TaskContext context)
        {
            KissRocknot(context);
        });
    }

    void CancelLovePotionTasks()
    {
        scheduler.CancelGroupsOf({ GROUP_NAGMARA_LOVE_SEQUENCE, GROUP_NAGMARA_MOVEMENT_TIMEOUT,
            GROUP_NAGMARA_KISS });
    }

    void AbortLovePotionEvent(bool notifyRocknot)
    {
        if (_lovePotionComplete || !_lovePotionEvent)
            return;

        CancelLovePotionTasks();
        ResetLovePotionEvent(notifyRocknot);
    }

    void AbortLovePotionEvent(bool notifyRocknot, TaskContext& context)
    {
        if (_lovePotionComplete || !_lovePotionEvent)
            return;

        context.CancelGroupsOf({ GROUP_NAGMARA_LOVE_SEQUENCE, GROUP_NAGMARA_MOVEMENT_TIMEOUT,
            GROUP_NAGMARA_KISS });
        ResetLovePotionEvent(notifyRocknot);
    }

    void ResetLovePotionEvent(bool notifyRocknot)
    {
        Creature* rocknot = ObjectAccessor::GetCreature(*me, _rocknotGuid);
        if (_doorOpenedByEvent && _instance)
            if (GameObject* door = _instance->instance->GetGameObject(_instance->GetGuidData(DATA_GO_BAR_DOOR)))
                door->SetGoState(GO_STATE_READY);

        _rocknotGuid.Clear();
        _lovePotionEvent = false;
        _doorOpenAttempts = 0;
        _doorOpenedByEvent = false;
        me->setActive(false);
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->RemoveAurasDueToSpell(SPELL_NAGMARA_ROCKNOT);
        me->GetMotionMaster()->Clear();
        me->GetMotionMaster()->InitDefault();
        me->GetMotionMaster()->MoveTargetedHome();
        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);

        if (notifyRocknot && rocknot && rocknot->AI())
            rocknot->AI()->DoAction(ACTION_CANCEL_LOVE_POTION);
    }

    InstanceScript* _instance;
    TaskScheduler _ambientScheduler;
    ObjectGuid _rocknotGuid;
    uint8 _doorOpenAttempts;
    bool _lovePotionEvent;
    bool _lovePotionComplete;
    bool _doorOpenedByEvent;
};

enum RocknotQuests
{
    QUEST_ALE = 4295
};

enum RocknotEvents
{
    EVENT_ROCKNOT_MORE_ALE = 1,
    EVENT_ROCKNOT_PUNCH,
    EVENT_ROCKNOT_SECOND_KEG,
    EVENT_ROCKNOT_FINAL_KEG,
    EVENT_ROCKNOT_ALE,
    EVENT_ROCKNOT_BREAK_KEG,
    EVENT_ROCKNOT_BAR_REACTION,
    EVENT_ROCKNOT_RECOVER
};

enum RocknotPaths
{
    PATH_ROCKNOT_ALE = 95030
};

enum RocknotPoints
{
    POINT_ROCKNOT_FIRST_KEG = 3,
    POINT_ROCKNOT_LEAVE_FIRST_KEG = 4,
    POINT_ROCKNOT_SECOND_KEG = 5,
    POINT_ROCKNOT_LEAVE_SECOND_KEG = 6,
    POINT_ROCKNOT_FINAL_KEG = 8
};

enum RocknotTaskGroups
{
    GROUP_ROCKNOT_KISS = 1
};

struct npc_rocknot : public npc_escortAI
{
    npc_rocknot(Creature* creature) : npc_escortAI(creature), _instance(creature->GetInstanceScript()),
        _aleComplete(false), _lovePotionEvent(false), _lovePotionComplete(false)
    {
        if (WaypointPath const* path = sWaypointMgr->GetPath(PATH_ROCKNOT_ALE))
            for (WaypointNode const& node : path->Nodes)
                AddWaypoint(node.Id, node.X, node.Y, node.Z, node.Delay);
    }

    void Reset() override
    {
        if (_instance && _instance->GetData(DATA_LOVE_POTION_EVENT) == DONE)
        {
            _nagmaraGuid.Clear();
            _lovePotionEvent = false;
            _lovePotionComplete = true;
            _events.Reset();
            me->GetMotionMaster()->Clear();
            me->NearTeleportTo(RocknotFinalPosition.GetPositionX(), RocknotFinalPosition.GetPositionY(),
                RocknotFinalPosition.GetPositionZ(), RocknotFinalPosition.GetOrientation());
            me->SetHomePosition(RocknotFinalPosition);
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_QUESTGIVER);
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            ScheduleKiss();
            me->GetMotionMaster()->MoveIdle();
            me->setActive(false);
            return;
        }

        if (_lovePotionEvent && !_lovePotionComplete)
        {
            AbortLovePotionEvent();
            return;
        }

        if (HasEscortState(STATE_ESCORT_ESCORTING) || _aleEventActive)
            return;

        _events.Reset();
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->SetEmoteState(EMOTE_STATE_NONE);
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
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_QUESTGIVER);
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
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
            me->ReplaceAllNpcFlags(UNIT_NPC_FLAG_QUESTGIVER);
            me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
            ScheduleKiss();
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

    void JustRespawned() override
    {
        bool const restartAleEvent = _aleEventActive && !_aleComplete;
        if (_aleEventActive)
        {
            me->SetHomePosition(_originalPosition);
            me->SetImmuneToNPC(_originalImmuneToNPC);
            me->ReplaceAllNpcFlags(_originalNpcFlags);
        }
        _aleEventActive = false;
        _recovering = false;
        npc_escortAI::JustRespawned();

        // The three ales were already handed in; restart without charging for them again.
        if (restartAleEvent)
            StartAleEvent();
    }

    void JustReachedHome() override
    {
        if (!_recovering || _events.HasTimeUntilEvent(EVENT_ROCKNOT_RECOVER))
            return;

        _recovering = false;
        _aleEventActive = false;
        me->SetEmoteState(EMOTE_STATE_NONE);
        me->SetFacingTo(_originalPosition.GetOrientation());
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        me->SetImmuneToNPC(_originalImmuneToNPC);
        me->ReplaceAllNpcFlags(_originalNpcFlags);
    }

    void sQuestReward(Player* player, Quest const* quest, uint32 /*opt*/) override
    {
        if (!_instance || _lovePotionEvent || _lovePotionComplete || quest->GetQuestId() != QUEST_ALE)
            return;

        if (HasEscortState(STATE_ESCORT_ESCORTING) || _aleEventActive)
            return;

        // Both captured hand-ins have the drinking emote and acknowledgement.
        me->HandleEmoteCommand(EMOTE_ONESHOT_EAT_NO_SHEATHE);
        Talk(SAY_GOT_BEER);
        // Further quest rewards are allowed after recovery, but cannot restart the completed event.
        if (_aleComplete || _instance->GetData(TYPE_BAR) == DONE || _instance->GetData(TYPE_BAR) == SPECIAL)
            return;

        if (_instance->GetData(TYPE_BAR) != IN_PROGRESS)
            _instance->SetData(TYPE_BAR, IN_PROGRESS);

        _instance->SetData(TYPE_BAR, SPECIAL);
        if (_instance->GetData(TYPE_BAR) != SPECIAL)
            return;

        StartAleEvent();
        // Keep the escort's NPC flags cleared so WotLK rejects further quest interactions.
        CloseGossipMenuFor(player);
    }

    void WaypointStart(uint32 pointId) override
    {
        if (pointId == POINT_ROCKNOT_LEAVE_FIRST_KEG)
        {
            me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
            Talk(SAY_FIRST_EMPTY);
        }
        else if (pointId == POINT_ROCKNOT_LEAVE_SECOND_KEG)
        {
            me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
            Talk(SAY_SECOND_EMPTY);
        }
    }

    using CreatureAI::WaypointReached;
    void WaypointReached(uint32 pointId) override
    {
        switch (pointId)
        {
            case POINT_ROCKNOT_FIRST_KEG:
                _events.ScheduleEvent(EVENT_ROCKNOT_PUNCH, 1500ms);
                _events.ScheduleEvent(EVENT_ROCKNOT_PUNCH, 3100ms);
                break;
            case POINT_ROCKNOT_SECOND_KEG:
                _events.ScheduleEvent(EVENT_ROCKNOT_SECOND_KEG, 1500ms);
                break;
            case POINT_ROCKNOT_FINAL_KEG:
                // Evade must return to the keg while the final sequence is still running.
                me->SetHomePosition(me->GetPosition());
                SetEscortPaused(true);
                _events.ScheduleEvent(EVENT_ROCKNOT_FINAL_KEG, 300ms);
                _events.ScheduleEvent(EVENT_ROCKNOT_PUNCH, 1900ms);
                _events.ScheduleEvent(EVENT_ROCKNOT_PUNCH, 3500ms);
                _events.ScheduleEvent(EVENT_ROCKNOT_ALE, 3700ms);
                _events.ScheduleEvent(EVENT_ROCKNOT_BREAK_KEG, 5100ms);
                break;
        }
    }

    void UpdateEscortAI(uint32 diff) override
    {
        scheduler.Update(diff);
        if (_lovePotionEvent || _lovePotionComplete)
            return;

        _events.Update(diff);
        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_ROCKNOT_MORE_ALE:
                    Talk(SAY_MORE_ALE);
                    break;
                case EVENT_ROCKNOT_PUNCH:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK_UNARMED);
                    break;
                case EVENT_ROCKNOT_SECOND_KEG:
                    me->SetFacingTo(2.0769417f);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK_UNARMED);
                    break;
                case EVENT_ROCKNOT_FINAL_KEG:
                    me->SetFacingTo(2.443461f);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK_UNARMED);
                    break;
                case EVENT_ROCKNOT_ALE:
                    Talk(SAY_ALE);
                    break;
                case EVENT_ROCKNOT_BREAK_KEG:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK_UNARMED);
                    me->SetEmoteState(EMOTE_STATE_WORK_SHEATHED);
                    if (GameObject* keg = GetBarObject(DATA_GO_BAR_KEG))
                        keg->SetGoState(GO_STATE_ACTIVE);

                    // Start both animations together; the trap and Phalanx react after the cork hits.
                    if (GameObject* door = GetBarObject(DATA_GO_BAR_DOOR))
                        door->SetGoState(GO_STATE_ACTIVE_ALTERNATIVE);

                    _events.ScheduleEvent(EVENT_ROCKNOT_BAR_REACTION, 7s);
                    break;
                case EVENT_ROCKNOT_BAR_REACTION:
                    if (GameObject* trap = GetBarObject(DATA_GO_BAR_KEG_TRAP))
                        trap->Use(me);

                    me->SetEmoteState(EMOTE_STATE_STUN);
                    me->SetHomePosition(me->GetPosition());
                    _aleComplete = true;
                    _recovering = true;
                    // Requested recovery delay; not a timing established by the Anniversary sniff.
                    _events.ScheduleEvent(EVENT_ROCKNOT_RECOVER, 15s);
                    if (_instance)
                    {
                        if (Creature* phalanx = ObjectAccessor::GetCreature(*me, _instance->GetGuidData(DATA_PHALANX)))
                            phalanx->AI()->DoAction(ACTION_PHALANX_START_ACTIVATION);

                        _instance->SetData(TYPE_BAR, DONE);
                    }
                    break;
                case EVENT_ROCKNOT_RECOVER:
                    RemoveEscortState(STATE_ESCORT_ESCORTING | STATE_ESCORT_RETURNING | STATE_ESCORT_PAUSED);
                    me->SetEmoteState(EMOTE_STATE_NONE);
                    me->SetHomePosition(_originalPosition);
                    // Keep interactions disabled until the home movement restores his position and facing.
                    me->GetMotionMaster()->MoveTargetedHome(true);
                    break;
            }
        }
    }

private:
    void ScheduleKiss()
    {
        scheduler.CancelGroup(GROUP_ROCKNOT_KISS);
        scheduler.Schedule(1ms, GROUP_ROCKNOT_KISS, [this](TaskContext context)
        {
            me->HandleEmoteCommand(EMOTE_ONESHOT_KISS);
            Talk(EMOTE_ROCKNOT);
            DoCastSelf(SPELL_NAGMARA_ROCKNOT, true);
            context.Repeat(11s, 21s);
        });
    }

    bool CanStartLovePotionEvent() const
    {
        if (_lovePotionEvent || _lovePotionComplete || _aleEventActive || _aleComplete ||
            !_instance || me->IsInCombat())
            return false;

        // Partial ale hand-ins do not commit to the escort route; SPECIAL means it has started.
        uint32 const barState = _instance->GetData(TYPE_BAR);
        if (barState != NOT_STARTED && barState != IN_PROGRESS)
            return false;

        return _instance->instance->GetGameObject(_instance->GetGuidData(DATA_GO_BAR_DOOR));
    }

    void AbortLovePotionEvent()
    {
        if (_lovePotionComplete || !_lovePotionEvent)
            return;

        _lovePotionEvent = false;
        scheduler.CancelGroup(GROUP_ROCKNOT_KISS);
        me->RemoveUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        _nagmaraGuid.Clear();
        me->setActive(false);
        me->GetMotionMaster()->Clear();
        me->GetMotionMaster()->MoveTargetedHome();
        me->SetNpcFlag(UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_QUESTGIVER);

        if (Creature* nagmara = me->FindNearestCreature(NPC_MISTRESS_NAGMARA, 100.0f))
            if (nagmara->AI())
                nagmara->AI()->DoAction(ACTION_CANCEL_LOVE_POTION);
    }

    void StartAleEvent()
    {
        _events.Reset();
        _aleEventActive = true;
        SetDespawnAtEnd(false);
        SetDespawnAtFar(false);
        me->GetRespawnPosition(_originalPosition.m_positionX, _originalPosition.m_positionY,
            _originalPosition.m_positionZ, &_originalPosition.m_orientation);
        _originalNpcFlags = me->GetNpcFlags();
        _originalImmuneToNPC = me->IsImmuneToNPC();
        me->SetWalk(true);
        Start(false);
        // Anniversary 69546 sends Uninteractible when the ale route begins.
        me->SetUnitFlag(UNIT_FLAG_NOT_SELECTABLE);
        _events.ScheduleEvent(EVENT_ROCKNOT_MORE_ALE, 1500ms);
    }

    GameObject* GetBarObject(uint32 data) const
    {
        return _instance ? _instance->instance->GetGameObject(_instance->GetGuidData(data)) : nullptr;
    }

    InstanceScript* _instance;
    ObjectGuid _nagmaraGuid;
    EventMap _events;
    bool _aleComplete;
    bool _aleEventActive = false;
    bool _recovering = false;
    bool _lovePotionEvent;
    bool _lovePotionComplete;
    Position _originalPosition;
    NPCFlags _originalNpcFlags = UNIT_NPC_FLAG_NONE;
    bool _originalImmuneToNPC = false;
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
