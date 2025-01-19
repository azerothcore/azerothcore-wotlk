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

#ifndef ACORE_SMARTSCRIPTMGR_H
#define ACORE_SMARTSCRIPTMGR_H

#include "Common.h"
#include "Creature.h"
#include "DBCStores.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Optional.h"
#include "SpellMgr.h"
#include <limits>

typedef uint32 SAIBool;

struct WayPoint
{
    WayPoint(uint32 _id, float _x, float _y, float _z, Optional<float> _o, uint32 _delay)
    {
        id = _id;
        x = _x;
        y = _y;
        z = _z;
        o = _o;
        delay = _delay;
    }

    uint32 id;
    float x;
    float y;
    float z;
    std::optional<float> o;
    uint32 delay;
};

enum eSmartAI
{
    SMART_EVENT_PARAM_COUNT = 4,
    SMART_ACTION_PARAM_COUNT = 6,
    SMART_SUMMON_COUNTER = 0xFFFFFF,
    SMART_ESCORT_LAST_OOC_POINT = 0xFFFFFF,
    SMART_RANDOM_POINT = 0xFFFFFE,
    SMART_ESCORT_TARGETS = 0xFFFFFF
};

enum SMART_EVENT_PHASE
{
    SMART_EVENT_PHASE_ALWAYS  = 0,
    SMART_EVENT_PHASE_1       = 1,
    SMART_EVENT_PHASE_2       = 2,
    SMART_EVENT_PHASE_3       = 3,
    SMART_EVENT_PHASE_4       = 4,
    SMART_EVENT_PHASE_5       = 5,
    SMART_EVENT_PHASE_6       = 6,
    SMART_EVENT_PHASE_7       = 7,
    SMART_EVENT_PHASE_8       = 8,
    SMART_EVENT_PHASE_9       = 9,
    SMART_EVENT_PHASE_10      = 10,
    SMART_EVENT_PHASE_11      = 11,
    SMART_EVENT_PHASE_12      = 12,
    SMART_EVENT_PHASE_MAX     = 13,

    SMART_EVENT_PHASE_COUNT   = 12
};

enum SMART_EVENT_PHASE_BITS
{
    SMART_EVENT_PHASE_ALWAYS_BIT   = 0,
    SMART_EVENT_PHASE_1_BIT        = 1,
    SMART_EVENT_PHASE_2_BIT        = 2,
    SMART_EVENT_PHASE_3_BIT        = 4,
    SMART_EVENT_PHASE_4_BIT        = 8,
    SMART_EVENT_PHASE_5_BIT        = 16,
    SMART_EVENT_PHASE_6_BIT        = 32,
    SMART_EVENT_PHASE_7_BIT        = 64,
    SMART_EVENT_PHASE_8_BIT        = 128,
    SMART_EVENT_PHASE_9_BIT        = 256,
    SMART_EVENT_PHASE_10_BIT       = 512,
    SMART_EVENT_PHASE_11_BIT       = 1024,
    SMART_EVENT_PHASE_12_BIT       = 2048,
    SMART_EVENT_PHASE_ALL          = SMART_EVENT_PHASE_1_BIT + SMART_EVENT_PHASE_2_BIT + SMART_EVENT_PHASE_3_BIT + SMART_EVENT_PHASE_4_BIT + SMART_EVENT_PHASE_5_BIT + SMART_EVENT_PHASE_6_BIT + SMART_EVENT_PHASE_7_BIT + SMART_EVENT_PHASE_8_BIT + SMART_EVENT_PHASE_9_BIT + SMART_EVENT_PHASE_10_BIT + SMART_EVENT_PHASE_11_BIT + SMART_EVENT_PHASE_12_BIT
};

const uint32 SmartPhaseMask[SMART_EVENT_PHASE_COUNT][2] =
{
    {SMART_EVENT_PHASE_1, SMART_EVENT_PHASE_1_BIT },
    {SMART_EVENT_PHASE_2, SMART_EVENT_PHASE_2_BIT },
    {SMART_EVENT_PHASE_3, SMART_EVENT_PHASE_3_BIT },
    {SMART_EVENT_PHASE_4, SMART_EVENT_PHASE_4_BIT },
    {SMART_EVENT_PHASE_5, SMART_EVENT_PHASE_5_BIT },
    {SMART_EVENT_PHASE_6, SMART_EVENT_PHASE_6_BIT },
    {SMART_EVENT_PHASE_7, SMART_EVENT_PHASE_7_BIT },
    {SMART_EVENT_PHASE_8, SMART_EVENT_PHASE_8_BIT },
    {SMART_EVENT_PHASE_9, SMART_EVENT_PHASE_9_BIT },
    {SMART_EVENT_PHASE_10, SMART_EVENT_PHASE_10_BIT },
    {SMART_EVENT_PHASE_11, SMART_EVENT_PHASE_11_BIT },
    {SMART_EVENT_PHASE_12, SMART_EVENT_PHASE_12_BIT }
};

enum SMART_EVENT
{
    SMART_EVENT_UPDATE_IC                = 0,       // InitialMin, InitialMax, RepeatMin, RepeatMax
    SMART_EVENT_UPDATE_OOC               = 1,       // InitialMin, InitialMax, RepeatMin, RepeatMax
    SMART_EVENT_HEALTH_PCT               = 2,       // HPMin%, HPMax%,  RepeatMin, RepeatMax
    SMART_EVENT_MANA_PCT                 = 3,       // ManaMin%, ManaMax%, RepeatMin, RepeatMax
    SMART_EVENT_AGGRO                    = 4,       // NONE
    SMART_EVENT_KILL                     = 5,       // CooldownMin0, CooldownMax1, playerOnly2, else creature entry3
    SMART_EVENT_DEATH                    = 6,       // NONE
    SMART_EVENT_EVADE                    = 7,       // NONE
    SMART_EVENT_SPELLHIT                 = 8,       // SpellID, School, CooldownMin, CooldownMax
    SMART_EVENT_RANGE                    = 9,       // min, max, repeatMin, repeatMax, rangeMin, rangeMax
    SMART_EVENT_OOC_LOS                  = 10,      // HostilityMode, MaxRnage, CooldownMin, CooldownMax, PlayerOnly
    SMART_EVENT_RESPAWN                  = 11,      // type, MapId, ZoneId
    SMART_EVENT_TARGET_HEALTH_PCT        = 12,      // HPMin%, HPMax%, RepeatMin, RepeatMax
    SMART_EVENT_VICTIM_CASTING           = 13,      // RepeatMin, RepeatMax, spellid
    SMART_EVENT_FRIENDLY_HEALTH          = 14,      // HPDeficit, Radius, RepeatMin, RepeatMax
    SMART_EVENT_FRIENDLY_IS_CC           = 15,      // Radius, RepeatMin, RepeatMax
    SMART_EVENT_FRIENDLY_MISSING_BUFF    = 16,      // SpellId, Radius, RepeatMin, RepeatMax, onlyInCombat
    SMART_EVENT_SUMMONED_UNIT            = 17,      // CreatureId(0 all), CooldownMin, CooldownMax
    SMART_EVENT_TARGET_MANA_PCT          = 18,      // ManaMin%, ManaMax%, RepeatMin, RepeatMax
    SMART_EVENT_ACCEPTED_QUEST           = 19,      // QuestID (0 = any), CooldownMin, CooldownMax
    SMART_EVENT_REWARD_QUEST             = 20,      // QuestID (0 = any), CooldownMin, CooldownMax
    SMART_EVENT_REACHED_HOME             = 21,      // NONE
    SMART_EVENT_RECEIVE_EMOTE            = 22,      // EmoteId, CooldownMin, CooldownMax, condition, val1, val2, val3
    SMART_EVENT_HAS_AURA                 = 23,      // Param1 = SpellID, Param2 = Stack amount, Param3/4 RepeatMin, RepeatMax
    SMART_EVENT_TARGET_BUFFED            = 24,      // Param1 = SpellID, Param2 = Stack amount, Param3/4 RepeatMin, RepeatMax
    SMART_EVENT_RESET                    = 25,      // Called after combat, when the creature respawn and spawn.
    SMART_EVENT_IC_LOS                   = 26,      // HostilityMode, MaxRnage, CooldownMin, CooldownMax, PlayerOnly
    SMART_EVENT_PASSENGER_BOARDED        = 27,      // CooldownMin, CooldownMax
    SMART_EVENT_PASSENGER_REMOVED        = 28,      // CooldownMin, CooldownMax
    SMART_EVENT_CHARMED                  = 29,      // onRemove (0 - on apply, 1 - on remove)
    SMART_EVENT_CHARMED_TARGET           = 30,      // NONE
    SMART_EVENT_SPELLHIT_TARGET          = 31,      // SpellID, School, CooldownMin, CooldownMax
    SMART_EVENT_DAMAGED                  = 32,      // MinDmg, MaxDmg, CooldownMin, CooldownMax
    SMART_EVENT_DAMAGED_TARGET           = 33,      // MinDmg, MaxDmg, CooldownMin, CooldownMax
    SMART_EVENT_MOVEMENTINFORM           = 34,      // MovementType(any), PointID
    SMART_EVENT_SUMMON_DESPAWNED         = 35,      // Entry, CooldownMin, CooldownMax
    SMART_EVENT_CORPSE_REMOVED           = 36,      // NONE
    SMART_EVENT_AI_INIT                  = 37,      // NONE
    SMART_EVENT_DATA_SET                 = 38,      // Id, Value, CooldownMin, CooldownMax
    SMART_EVENT_WAYPOINT_START           = 39,      // PointId(0any), pathID(0any)
    SMART_EVENT_WAYPOINT_REACHED         = 40,      // PointId(0any), pathID(0any)
    SMART_EVENT_TRANSPORT_ADDPLAYER      = 41,      // NONE
    SMART_EVENT_TRANSPORT_ADDCREATURE    = 42,      // Entry (0 any)
    SMART_EVENT_TRANSPORT_REMOVE_PLAYER  = 43,      // NONE
    SMART_EVENT_TRANSPORT_RELOCATE       = 44,      // PointId
    SMART_EVENT_INSTANCE_PLAYER_ENTER    = 45,      // Team (0 any), CooldownMin, CooldownMax
    SMART_EVENT_AREATRIGGER_ONTRIGGER    = 46,      // TriggerId(0 any)
    SMART_EVENT_QUEST_ACCEPTED           = 47,      // none
    SMART_EVENT_QUEST_OBJ_COMPLETION     = 48,      // none
    SMART_EVENT_QUEST_COMPLETION         = 49,      // none
    SMART_EVENT_QUEST_REWARDED           = 50,      // none
    SMART_EVENT_QUEST_FAIL               = 51,      // none
    SMART_EVENT_TEXT_OVER                = 52,      // GroupId from creature_text,  creature entry who talks (0 any)
    SMART_EVENT_RECEIVE_HEAL             = 53,      // MinHeal, MaxHeal, CooldownMin, CooldownMax
    SMART_EVENT_JUST_SUMMONED            = 54,      // none
    SMART_EVENT_WAYPOINT_PAUSED          = 55,      // PointId(0any), pathID(0any)
    SMART_EVENT_WAYPOINT_RESUMED         = 56,      // PointId(0any), pathID(0any)
    SMART_EVENT_WAYPOINT_STOPPED         = 57,      // PointId(0any), pathID(0any)
    SMART_EVENT_WAYPOINT_ENDED           = 58,      // PointId(0any), pathID(0any)
    SMART_EVENT_TIMED_EVENT_TRIGGERED    = 59,      // id
    SMART_EVENT_UPDATE                   = 60,      // InitialMin, InitialMax, RepeatMin, RepeatMax
    SMART_EVENT_LINK                     = 61,      // INTERNAL USAGE, no params, used to link together multiple events, does not use any extra resources to iterate event lists needlessly
    SMART_EVENT_GOSSIP_SELECT            = 62,      // menuID, actionID
    SMART_EVENT_JUST_CREATED             = 63,      // none
    SMART_EVENT_GOSSIP_HELLO             = 64,      // event_para_1 (only) 0 = no filter set, always execute action, 1 = GossipHello only filter set, skip action if reportUse, 2 = reportUse only filter set, skip action if GossipHello
    SMART_EVENT_FOLLOW_COMPLETED         = 65,      // none
    SMART_EVENT_EVENT_PHASE_CHANGE       = 66,      // event phase mask (<= SMART_EVENT_PHASE_ALL)
    SMART_EVENT_IS_BEHIND_TARGET         = 67,      // min, max, repeatMin, repeatMax, rangeMin, rangeMax
    SMART_EVENT_GAME_EVENT_START         = 68,      // game_event.Entry
    SMART_EVENT_GAME_EVENT_END           = 69,      // game_event.Entry
    SMART_EVENT_GO_STATE_CHANGED         = 70,      // go state
    SMART_EVENT_GO_EVENT_INFORM          = 71,      // eventId
    SMART_EVENT_ACTION_DONE              = 72,      // eventId (SharedDefines.EventId)
    SMART_EVENT_ON_SPELLCLICK            = 73,      // clicker (unit)
    SMART_EVENT_FRIENDLY_HEALTH_PCT      = 74,      // min, max, repeatMin, repeatMax, hpPct, range
    SMART_EVENT_DISTANCE_CREATURE        = 75,      // guid, entry, distance, repeat
    SMART_EVENT_DISTANCE_GAMEOBJECT      = 76,      // guid, entry, distance, repeat
    SMART_EVENT_COUNTER_SET              = 77,      // id, value, cooldownMin, cooldownMax

    SMART_EVENT_SCENE_START              = 78,      // don't use on 3.3.5a
    SMART_EVENT_SCENE_TRIGGER            = 79,      // don't use on 3.3.5a
    SMART_EVENT_SCENE_CANCEL             = 80,      // don't use on 3.3.5a
    SMART_EVENT_SCENE_COMPLETE           = 81,      // don't use on 3.3.5a

    SMART_EVENT_SUMMONED_UNIT_DIES       = 82,      // CreatureId(0 all), CooldownMin, CooldownMax

    SMART_EVENT_TC_END                   = 83,

    /* AC Custom Events */
    SMART_EVENT_AC_START                 = 100,

    SMART_EVENT_NEAR_PLAYERS             = 101,      // min, radius, first timer, repeatMin, repeatMax
    SMART_EVENT_NEAR_PLAYERS_NEGATION    = 102,      // max, radius, first timer, repeatMin, repeatMax
    SMART_EVENT_NEAR_UNIT                = 103,      // type (0: creature 1: gob), entry, count, range, timer
    SMART_EVENT_NEAR_UNIT_NEGATION       = 104,      // type (0: creature 1: gob), entry, count, range, timer
    SMART_EVENT_AREA_CASTING             = 105,      // min, max, repeatMin, repeatMax, rangeMin, rangeMax
    SMART_EVENT_AREA_RANGE               = 106,      // min, max, repeatMin, repeatMax, rangeMin, rangeMax
    SMART_EVENT_SUMMONED_UNIT_EVADE      = 107,      // CreatureId(0 all), CooldownMin, CooldownMax
    SMART_EVENT_WAYPOINT_DATA_REACHED    = 108,      // PointId (0: any), pathId (0: any)
    SMART_EVENT_WAYPOINT_DATA_ENDED      = 109,      // PointId (0: any), pathId (0: any)
    SMART_EVENT_IS_IN_MELEE_RANGE        = 110,      // min, max, repeatMin, repeatMax, dist, invert (0: false, 1: true)

    SMART_EVENT_AC_END                   = 111
};

struct SmartEvent
{
    SMART_EVENT type;
    uint32 event_phase_mask;
    uint32 event_chance;
    uint32 event_flags;
    union
    {
        struct
        {
            uint32 min;
            uint32 max;
            uint32 repeatMin;
            uint32 repeatMax;
            uint32 rangeMin;
            uint32 rangeMax;
        } minMaxRepeat;

        struct
        {
            uint32 cooldownMin;
            uint32 cooldownMax;
            SAIBool playerOnly;
            uint32 creature;
        } kill;

        struct
        {
            uint32 spell;
            uint32 school;
            uint32 cooldownMin;
            uint32 cooldownMax;
        } spellHit;

        struct
        {
            /// <summary>
            /// Hostility mode of the event. 0: hostile, 1: not hostile, 2: any
            /// </summary>
            uint32 hostilityMode;
            uint32 maxDist;
            uint32 cooldownMin;
            uint32 cooldownMax;
            SAIBool playerOnly;
        } los;

        struct
        {
            uint32 type;
            uint32 map;
            uint32 area;
        } respawn;

        struct
        {
            uint32 repeatMin;
            uint32 repeatMax;
        } minMax;

        struct
        {
            uint32 repeatMin;
            uint32 repeatMax;
            uint32 spellId;
        } targetCasting;

        struct
        {
            uint32 hpDeficit;
            uint32 radius;
            uint32 repeatMin;
            uint32 repeatMax;
        } friendlyHealth;

        struct
        {
            uint32 radius;
            uint32 repeatMin;
            uint32 repeatMax;
        } friendlyCC;

        struct
        {
            uint32 spell;
            uint32 radius;
            uint32 repeatMin;
            uint32 repeatMax;
            uint32 onlyInCombat;
        } missingBuff;

        struct
        {
            uint32 creature;
            uint32 cooldownMin;
            uint32 cooldownMax;
        } summoned;

        struct
        {
            uint32 quest;
            uint32 cooldownMin;
            uint32 cooldownMax;
        } quest;

        struct
        {
            uint32 emote;
            uint32 cooldownMin;
            uint32 cooldownMax;
        } emote;

        struct
        {
            uint32 spell;
            uint32 count;
            uint32 repeatMin;
            uint32 repeatMax;
        } aura;

        struct
        {
            uint32 onRemove;
        } charm;

        struct
        {
            uint32 spell;
            uint32 count;
            uint32 repeatMin;
            uint32 repeatMax;
        } targetAura;

        struct
        {
            uint32 type;
            uint32 id;
        } movementInform;

        struct
        {
            uint32 id;
            uint32 value;
            uint32 cooldownMin;
            uint32 cooldownMax;
        } dataSet;

        struct
        {
            uint32 pointID;
            uint32 pathID;
        } waypoint;

        struct
        {
            uint32 creature;
        } transportAddCreature;

        struct
        {
            uint32 pointID;
        } transportRelocate;

        struct
        {
            uint32 team;
            uint32 cooldownMin;
            uint32 cooldownMax;
        } instancePlayerEnter;

        struct
        {
            uint32 id;
        } areatrigger;

        struct
        {
            uint32 textGroupID;
            uint32 creatureEntry;
        } textOver;

        struct
        {
            uint32 id;
        } timedEvent;

        struct
        {
            uint32 filter;
        } gossipHello;

        struct
        {
            uint32 sender;
            uint32 action;
        } gossip;

        struct
        {
            uint32 spell;
            uint32 effIndex;
        } dummy;

        struct
        {
            uint32 phasemask;
        } eventPhaseChange;

        struct
        {
            uint32 gameEventId;
        } gameEvent;

        struct
        {
            uint32 state;
        } goStateChanged;

        struct
        {
            uint32 eventId;
        } eventInform;

        struct
        {
            uint32 eventId;
        } doAction;

        struct
        {
            uint32 min;
            uint32 max;
            uint32 repeatMin;
            uint32 repeatMax;
            uint32 hpPct;
            uint32 radius;
        } friendlyHealthPct;

        struct
        {
            uint32 guid;
            uint32 entry;
            uint32 dist;
            uint32 repeat;
        } distance;

        struct
        {
            uint32 id;
            uint32 value;
            uint32 cooldownMin;
            uint32 cooldownMax;
        } counter;

        struct
        {
            uint32 minCount;
            uint32 radius;
            uint32 firstTimer;
            uint32 repeatMin;
            uint32 repeatMax;
        } nearPlayer;

        struct
        {
            uint32 maxCount;
            uint32 radius;
            uint32 firstTimer;
            uint32 repeatMin;
            uint32 repeatMax;
        } nearPlayerNegation;

        struct
        {
            uint32 type;
            uint32 entry;
            uint32 count;
            uint32 range;
            uint32 timer;
        } nearUnit;

        struct
        {
            uint32 min;
            uint32 max;
            uint32 repeatMin;
            uint32 repeatMax;
            uint32 dist;
            uint32 invert;
        } meleeRange;

        struct
        {
            uint32 type;
            uint32 entry;
            uint32 count;
            uint32 range;
            uint32 timer;
        } nearUnitNegation;

        struct
        {
            uint32 pointId;
            uint32 pathId;
        } wpData;

        struct
        {
            uint32 param1;
            uint32 param2;
            uint32 param3;
            uint32 param4;
            uint32 param5;
            uint32 param6;
        } raw;
    };

    enum class LOSHostilityMode : uint32
    {
        Hostile = 0,
        NotHostile = 1,
        Any = 2,
        End
    };
};

enum SMART_SCRIPT_RESPAWN_CONDITION
{
    SMART_SCRIPT_RESPAWN_CONDITION_NONE = 0,
    SMART_SCRIPT_RESPAWN_CONDITION_MAP = 1,
    SMART_SCRIPT_RESPAWN_CONDITION_AREA = 2,
    SMART_SCRIPT_RESPAWN_CONDITION_END = 3,
};

enum SMART_ACTION
{
    SMART_ACTION_NONE                               = 0,      // No action
    SMART_ACTION_TALK                               = 1,      // groupID from creature_text, duration to wait before TEXT_OVER event is triggered, use first target from targetlist as invoker, useTalkTarget (0/1) - use target as talk target
    SMART_ACTION_SET_FACTION                        = 2,      // FactionId (or 0 for default)
    SMART_ACTION_MORPH_TO_ENTRY_OR_MODEL            = 3,      // Creature_template entry(param1) OR ModelId (param2) (or 0 for both to demorph)
    SMART_ACTION_SOUND                              = 4,      // SoundId, onlySelf, distance
    SMART_ACTION_PLAY_EMOTE                         = 5,      // EmoteId
    SMART_ACTION_FAIL_QUEST                         = 6,      // QuestID
    SMART_ACTION_OFFER_QUEST                        = 7,      // QuestID, directAdd
    SMART_ACTION_SET_REACT_STATE                    = 8,      // state
    SMART_ACTION_ACTIVATE_GOBJECT                   = 9,      //
    SMART_ACTION_RANDOM_EMOTE                       = 10,     // EmoteId1, EmoteId2, EmoteId3...
    SMART_ACTION_CAST                               = 11,     // spellID, castFlags, triggerFlags, targetsLimit
    SMART_ACTION_SUMMON_CREATURE                    = 12,     // CreatureID, summonType, duration in ms, attackInvoker, attackScriptOwner, flags(SmartActionSummonCreatureFlags)
    SMART_ACTION_THREAT_SINGLE_PCT                  = 13,     // Threat%
    SMART_ACTION_THREAT_ALL_PCT                     = 14,     // Threat%
    SMART_ACTION_CALL_AREAEXPLOREDOREVENTHAPPENS    = 15,     // QuestID
    SMART_ACTION_RESERVED_16                        = 16,     // used on 4.3.4 and higher scripts
    SMART_ACTION_SET_EMOTE_STATE                    = 17,     // emoteID
    SMART_ACTION_SET_UNIT_FLAG                      = 18,     // Flags (may be more than one field OR'd together), Target
    SMART_ACTION_REMOVE_UNIT_FLAG                   = 19,     // Flags (may be more than one field OR'd together), Target
    SMART_ACTION_AUTO_ATTACK                        = 20,     // AllowAttackState (0 = stop attack, anything else means continue attacking)
    SMART_ACTION_ALLOW_COMBAT_MOVEMENT              = 21,     // AllowCombatMovement (0 = stop combat based movement, anything else continue attacking)
    SMART_ACTION_SET_EVENT_PHASE                    = 22,     // Phase
    SMART_ACTION_INC_EVENT_PHASE                    = 23,     // Value (may be negative to decrement phase, should not be 0)
    SMART_ACTION_EVADE                              = 24,     // No Params
    SMART_ACTION_FLEE_FOR_ASSIST                    = 25,     // With Emote
    SMART_ACTION_CALL_GROUPEVENTHAPPENS             = 26,     // QuestID
    SMART_ACTION_COMBAT_STOP                        = 27,     // No Params
    SMART_ACTION_REMOVEAURASFROMSPELL               = 28,     // Spellid (0 removes all auras), charges (0 removes aura)
    SMART_ACTION_FOLLOW                             = 29,     // Distance (0 = default), Angle (0 = default), EndCreatureEntry, credit, creditType (0monsterkill, 1event)
    SMART_ACTION_RANDOM_PHASE                       = 30,     // PhaseId1, PhaseId2, PhaseId3...
    SMART_ACTION_RANDOM_PHASE_RANGE                 = 31,     // PhaseMin, PhaseMax
    SMART_ACTION_RESET_GOBJECT                      = 32,     //
    SMART_ACTION_CALL_KILLEDMONSTER                 = 33,     // CreatureId,
    SMART_ACTION_SET_INST_DATA                      = 34,     // Field, Data
    SMART_ACTION_SET_INST_DATA64                    = 35,     // Field,
    SMART_ACTION_UPDATE_TEMPLATE                    = 36,     // Entry, UpdateLevel
    SMART_ACTION_DIE                                = 37,     // Milliseconds
    SMART_ACTION_SET_IN_COMBAT_WITH_ZONE            = 38,     // Range (if outside of dungeon)
    SMART_ACTION_CALL_FOR_HELP                      = 39,     // Radius, With Emote
    SMART_ACTION_SET_SHEATH                         = 40,     // Sheath (0-unarmed, 1-melee, 2-ranged)
    SMART_ACTION_FORCE_DESPAWN                      = 41,     // timer
    SMART_ACTION_SET_INVINCIBILITY_HP_LEVEL         = 42,     // MinHpValue(+pct, -flat)
    SMART_ACTION_MOUNT_TO_ENTRY_OR_MODEL            = 43,     // Creature_template entry(param1) OR ModelId (param2) (or 0 for both to dismount)
    SMART_ACTION_SET_INGAME_PHASE_MASK              = 44,     // mask
    SMART_ACTION_SET_DATA                           = 45,     // Field, Data (only creature TODO)
    SMART_ACTION_MOVE_FORWARD                       = 46,     // distance
    SMART_ACTION_SET_VISIBILITY                     = 47,     // on/off
    SMART_ACTION_SET_ACTIVE                         = 48,     // on/off
    SMART_ACTION_ATTACK_START                       = 49,     //
    SMART_ACTION_SUMMON_GO                          = 50,     // GameObjectID, DespawnTime, targetSummon, summonType (0 time or summoner dies/1 time)
    SMART_ACTION_KILL_UNIT                          = 51,     //
    SMART_ACTION_ACTIVATE_TAXI                      = 52,     // TaxiID
    SMART_ACTION_WP_START                           = 53,     // run/walk, pathID, canRepeat, quest, despawntime, reactState
    SMART_ACTION_WP_PAUSE                           = 54,     // time
    SMART_ACTION_WP_STOP                            = 55,     // despawnTime, quest, fail?
    SMART_ACTION_ADD_ITEM                           = 56,     // itemID, count
    SMART_ACTION_REMOVE_ITEM                        = 57,     // itemID, count
    SMART_ACTION_INSTALL_AI_TEMPLATE                = 58,     // AITemplateID
    SMART_ACTION_SET_RUN                            = 59,     // 0/1
    SMART_ACTION_SET_FLY                            = 60,     // 0/1
    SMART_ACTION_SET_SWIM                           = 61,     // 0/1
    SMART_ACTION_TELEPORT                           = 62,     // mapID,
    SMART_ACTION_SET_COUNTER                        = 63,     // id, value, reset (0/1)
    SMART_ACTION_STORE_TARGET_LIST                  = 64,     // varID,
    SMART_ACTION_WP_RESUME                          = 65,     // none
    SMART_ACTION_SET_ORIENTATION                    = 66,     // quick change, random orientation? (0/1), turnAngle
    SMART_ACTION_CREATE_TIMED_EVENT                 = 67,     // id, InitialMin, InitialMax, RepeatMin(only if it repeats), RepeatMax(only if it repeats), chance
    SMART_ACTION_PLAYMOVIE                          = 68,     // entry
    SMART_ACTION_MOVE_TO_POS                        = 69,     // PointId (optional x,y,z offset), transport, controlled, ContactDistance
    SMART_ACTION_RESPAWN_TARGET                     = 70,     // force / goRespawnTime
    SMART_ACTION_EQUIP                              = 71,     // entry, slotmask slot1, slot2, slot3   , only slots with mask set will be sent to client, bits are 1, 2, 4, leaving mask 0 is defaulted to mask 7 (send all), slots1-3 are only used if no entry is set
    SMART_ACTION_CLOSE_GOSSIP                       = 72,     // none
    SMART_ACTION_TRIGGER_TIMED_EVENT                = 73,     // id(>1)
    SMART_ACTION_REMOVE_TIMED_EVENT                 = 74,     // id(>1)
    SMART_ACTION_ADD_AURA                           = 75,     // spellid,  targets
    SMART_ACTION_OVERRIDE_SCRIPT_BASE_OBJECT        = 76,     // WARNING: CAN CRASH CORE, do not use if you dont know what you are doing
    SMART_ACTION_RESET_SCRIPT_BASE_OBJECT           = 77,     // none
    SMART_ACTION_CALL_SCRIPT_RESET                  = 78,     // none
    SMART_ACTION_SET_RANGED_MOVEMENT                = 79,     // Distance, angle
    SMART_ACTION_CALL_TIMED_ACTIONLIST              = 80,     // ID (overwrites already running actionlist), stop after combat?(0/1), timer update type(0-OOC, 1-IC, 2-ALWAYS)
    SMART_ACTION_SET_NPC_FLAG                       = 81,     // Flags
    SMART_ACTION_ADD_NPC_FLAG                       = 82,     // Flags
    SMART_ACTION_REMOVE_NPC_FLAG                    = 83,     // Flags
    SMART_ACTION_SIMPLE_TALK                        = 84,     // groupID, can be used to make players say groupID, Text_over event is not triggered, whisper can not be used (Target units will say the text)
    SMART_ACTION_SELF_CAST                          = 85,     // spellID, castFlags, triggerFlags, targetsLimit
    SMART_ACTION_CROSS_CAST                         = 86,     // spellID, castFlags, CasterTargetType, CasterTarget param1, CasterTarget param2, CasterTarget param3, ( + the origonal target fields as Destination target),   CasterTargets will cast spellID on all Targets (use with caution if targeting multiple * multiple units)
    SMART_ACTION_CALL_RANDOM_TIMED_ACTIONLIST       = 87,     // script9 ids 1-9
    SMART_ACTION_CALL_RANDOM_RANGE_TIMED_ACTIONLIST = 88,     // script9 id min, max
    SMART_ACTION_RANDOM_MOVE                        = 89,     // maxDist
    SMART_ACTION_SET_UNIT_FIELD_BYTES_1             = 90,     // bytes, target
    SMART_ACTION_REMOVE_UNIT_FIELD_BYTES_1          = 91,     // bytes, target
    SMART_ACTION_INTERRUPT_SPELL                    = 92,
    SMART_ACTION_SEND_GO_CUSTOM_ANIM                = 93,     // anim id
    SMART_ACTION_SET_DYNAMIC_FLAG                   = 94,     // Flags
    SMART_ACTION_ADD_DYNAMIC_FLAG                   = 95,     // Flags
    SMART_ACTION_REMOVE_DYNAMIC_FLAG                = 96,     // Flags
    SMART_ACTION_JUMP_TO_POS                        = 97,     // speedXY, speedZ, selfJump
    SMART_ACTION_SEND_GOSSIP_MENU                   = 98,     // menuId, optionId
    SMART_ACTION_GO_SET_LOOT_STATE                  = 99,     // state
    SMART_ACTION_SEND_TARGET_TO_TARGET              = 100,    // id
    SMART_ACTION_SET_HOME_POS                       = 101,    // SpawnPos
    SMART_ACTION_SET_HEALTH_REGEN                   = 102,    // 0/1
    SMART_ACTION_SET_ROOT                           = 103,    // off/on
    SMART_ACTION_SET_GO_FLAG                        = 104,    // Flags
    SMART_ACTION_ADD_GO_FLAG                        = 105,    // Flags
    SMART_ACTION_REMOVE_GO_FLAG                     = 106,    // Flags
    SMART_ACTION_SUMMON_CREATURE_GROUP              = 107,    // Group, attackInvoker, attackScriptOwner
    SMART_ACTION_SET_POWER                          = 108,    // PowerType, newPower
    SMART_ACTION_ADD_POWER                          = 109,    // PowerType, newPower
    SMART_ACTION_REMOVE_POWER                       = 110,    // PowerType, newPower
    SMART_ACTION_GAME_EVENT_STOP                    = 111,    // GameEventId
    SMART_ACTION_GAME_EVENT_START                   = 112,    // GameEventId
    SMART_ACTION_START_CLOSEST_WAYPOINT             = 113,    // wp1, wp2, wp3, wp4, wp5, wp6, wp7
    SMART_ACTION_RISE_UP                            = 114,    // distance
    SMART_ACTION_RANDOM_SOUND                       = 115,    // SoundId1, SoundId2, SoundId3, SoundId4, onlySelf, distance
    SMART_ACTION_SET_CORPSE_DELAY                   = 116,    // timer
    SMART_ACTION_DISABLE_EVADE                      = 117,    // 0/1 (1 = disabled, 0 = enabled)
    SMART_ACTION_GO_SET_GO_STATE                    = 118,    // state
    SMART_ACTION_SET_CAN_FLY                        = 119,    /// @todo: NOT SUPPORTED YET
    SMART_ACTION_REMOVE_AURAS_BY_TYPE               = 120,    /// @todo: NOT SUPPORTED YET
    SMART_ACTION_SET_SIGHT_DIST                     = 121,    // sightDistance
    SMART_ACTION_FLEE                               = 122,    // fleeTime
    SMART_ACTION_ADD_THREAT                         = 123,    // +threat, -threat
    SMART_ACTION_LOAD_EQUIPMENT                     = 124,    // id
    SMART_ACTION_TRIGGER_RANDOM_TIMED_EVENT         = 125,    // id min range, id max range
    SMART_ACTION_REMOVE_ALL_GAMEOBJECTS             = 126,
    SMART_ACTION_REMOVE_MOVEMENT                    = 127,    /// @todo: NOT SUPPORTED YET
    SMART_ACTION_PLAY_ANIMKIT                       = 128,    // don't use on 3.3.5a
    SMART_ACTION_SCENE_PLAY                         = 129,    // don't use on 3.3.5a
    SMART_ACTION_SCENE_CANCEL                       = 130,    // don't use on 3.3.5a
    SMART_ACTION_SPAWN_SPAWNGROUP                   = 131,    /// @todo: NOT SUPPORTED YET
    SMART_ACTION_DESPAWN_SPAWNGROUP                 = 132,    /// @todo: NOT SUPPORTED YET
    SMART_ACTION_RESPAWN_BY_SPAWNID                 = 133,    /// @todo: NOT SUPPORTED YET
    SMART_ACTION_INVOKER_CAST                       = 134,    // spellID, castFlags, triggerFlags, targetsLimit
    SMART_ACTION_PLAY_CINEMATIC                     = 135,    // entry
    SMART_ACTION_SET_MOVEMENT_SPEED                 = 136,    // movementType, speedInteger, speedFraction

    SMART_ACTION_SET_HEALTH_PCT                     = 142,    // percent

    SMART_ACTION_TC_END                             = 199,    // placeholder

    // AC-only SmartActions:
    SMART_ACTION_AC_START                           = 200,    // placeholder

    SMART_ACTION_MOVE_TO_POS_TARGET                 = 201,    // pointId
    // SMART_ACTION_SET_GO_STATE                    = 202,    // state // Replaced by SMART_ACTION_GO_SET_GO_STATE
    SMART_ACTION_EXIT_VEHICLE                       = 203,    // none
    SMART_ACTION_SET_UNIT_MOVEMENT_FLAGS            = 204,    // flags
    SMART_ACTION_SET_COMBAT_DISTANCE                = 205,    // combatDistance
    SMART_ACTION_DISMOUNT                           = 206,
    SMART_ACTION_SET_HOVER                          = 207,    // 0/1
    SMART_ACTION_ADD_IMMUNITY                       = 208,    // type, id, value
    SMART_ACTION_REMOVE_IMMUNITY                    = 209,    // type, id, value
    SMART_ACTION_FALL                               = 210,    //
    SMART_ACTION_SET_EVENT_FLAG_RESET               = 211,    // 0/1
    SMART_ACTION_STOP_MOTION                        = 212,    // stopMoving, movementExpired
    SMART_ACTION_NO_ENVIRONMENT_UPDATE              = 213,
    SMART_ACTION_ZONE_UNDER_ATTACK                  = 214,
    SMART_ACTION_LOAD_GRID                          = 215,
    SMART_ACTION_MUSIC                              = 216,    // SoundId, onlySelf, type
    SMART_ACTION_RANDOM_MUSIC                       = 217,    // SoundId1, SoundId2, SoundId3, SoundId4, onlySelf, type

    SMART_ACTION_CUSTOM_CAST                        = 218,    // spellId, castflag, bp0, bp1, bp2
    SMART_ACTION_CONE_SUMMON                        = 219,    // entry, duration (0 = perm), dist between rings, dist between earch summon in a row, length of cone, width of cone (angle)
    SMART_ACTION_PLAYER_TALK                        = 220,    // acore_string.entry, yell? (0/1)
    SMART_ACTION_VORTEX_SUMMON                      = 221,    // entry, duration (0 = perm), spiral scaling, spiral appearance, range max, phi_delta     <-- yes confusing math, try it ingame and see, my lovely AC boys!
    SMART_ACTION_CU_ENCOUNTER_START                 = 222,    // Resets cooldowns on all targets and removes Heroism debuff(s)
    SMART_ACTION_DO_ACTION                          = 223,    // ActionId
    SMART_ACTION_ATTACK_STOP                        = 224,    //
    SMART_ACTION_SET_GUID                           = 225,    // Sends the invoker's or the base object's own ObjectGuid to target
    SMART_ACTION_SCRIPTED_SPAWN                     = 226,    // state, spawnTimerMin, spawnTimerMax, respawnDelay, corpseDelay, dontDespawn
    SMART_ACTION_SET_SCALE                          = 227,    // scale
    SMART_ACTION_SUMMON_RADIAL                      = 228,    // summonEntry, summonDuration, repetitions, startAngle, stepAngle, dist
    SMART_ACTION_PLAY_SPELL_VISUAL                  = 229,    // visualId, visualIdImpact
    SMART_ACTION_FOLLOW_GROUP                       = 230,    // followState, followType, dist
    SMART_ACTION_SET_ORIENTATION_TARGET             = 231,    // type, target_type, target_param1, target_param2, target_param3, target_param4
    SMART_ACTION_WAYPOINT_DATA_START                = 232,    // pathId, repeat
    SMART_ACTION_WAYPOINT_DATA_RANDOM               = 233,    // pathId1, pathId2, repeat
    SMART_ACTION_MOVEMENT_STOP                      = 234,    //
    SMART_ACTION_MOVEMENT_PAUSE                     = 235,    // timer
    SMART_ACTION_MOVEMENT_RESUME                    = 236,    // timerOverride
    SMART_ACTION_WORLD_SCRIPT                       = 237,    // eventId, param
    SMART_ACTION_DISABLE_REWARD                     = 238,    // reputation 0/1, loot 0/1

    SMART_ACTION_AC_END                             = 239,    // placeholder
};

enum class SmartActionSummonCreatureFlags
{
    None            = 0,
    PersonalSpawn   = 1,
    PreferUnit      = 2,

    All = PersonalSpawn | PreferUnit
};

DEFINE_ENUM_FLAG(SmartActionSummonCreatureFlags);

struct SmartAction
{
    SMART_ACTION type;

    union
    {
        struct
        {
            uint32 textGroupID;
            uint32 duration;
            SAIBool useTalkTarget;
        } talk;

        struct
        {
            uint32 textGroupID;
            uint32 duration;
        } simpleTalk;

        struct
        {
            uint32 factionID;
        } faction;

        struct
        {
            uint32 creature;
            uint32 model;
        } morphOrMount;

        struct
        {
            uint32 sound;
            SAIBool onlySelf;
            uint32 distance;
        } sound;

        struct
        {
            uint32 sound1;
            uint32 sound2;
            uint32 sound3;
            uint32 sound4;
            SAIBool onlySelf;
            uint32 distance;
        } randomSound;

        struct
        {
            uint32 sound;
            uint32 onlySelf;
            uint32 type;
        } music;

        struct
        {
            uint32 sound1;
            uint32 sound2;
            uint32 sound3;
            uint32 sound4;
            uint32 onlySelf;
            uint32 type;
        } randomMusic;

        struct
        {
            uint32 emote;
        } emote;

        struct
        {
            uint32 quest;
        } quest;

        struct
        {
            uint32 questID;
            SAIBool directAdd;
        } questOffer;

        struct
        {
            uint32 state;
        } react;

        struct
        {
            std::array<uint32, SMART_ACTION_PARAM_COUNT> emotes;
        } randomEmote;

        struct
        {
            uint32 spell;
            uint32 castFlags;
            uint32 triggerFlags;
            uint32 targetsLimit;
        } cast;

        struct
        {
            uint32 spell;
            uint32 flags;
            uint32 targetType;
            uint32 targetParam1;
            uint32 targetParam2;
            uint32 targetParam3;
        } crossCast;

        struct
        {
            uint32 alternative;
        } activateObject;

        struct
        {
            uint32 range;
        } combatZone;

        struct
        {
            uint32 creature;
            uint32 type;
            uint32 duration;
            SAIBool attackInvoker;
            uint32 attackScriptOwner;
            uint32 flags; // SmartActionSummonCreatureFlags
        } summonCreature;

        struct
        {
            uint32 threatINC;
            uint32 threatDEC;
        } threatPCT;

        struct
        {
            uint32 threatINC;
            uint32 threatDEC;
        } threat;

        struct
        {
            SAIBool attack;
        } autoAttack;

        struct
        {
            SAIBool move;
        } combatMove;

        struct
        {
            uint32 phase;
        } setEventPhase;

        struct
        {
            uint32 inc;
            uint32 dec;
        } incEventPhase;

        struct
        {
            uint32 spell;
        } addAura;

        struct
        {
            uint32 spell;
            uint32 charges;
        } removeAura;

        struct
        {
            uint32 dist;
            uint32 angle;
            uint32 entry;
            uint32 credit;
            uint32 creditType;
            uint32 aliveState;
        } follow;

        struct
        {
            std::array<uint32, SMART_ACTION_PARAM_COUNT> phases;
        } randomPhase;

        struct
        {
            uint32 phaseMin;
            uint32 phaseMax;
        } randomPhaseRange;

        struct
        {
            uint32 creature;
        } killedMonster;

        struct
        {
            uint32 field;
            uint32 data;
            uint32 type;
        } setInstanceData;

        struct
        {
            uint32 field;
        } setInstanceData64;

        struct
        {
            uint32 creature;
            SAIBool updateLevel;
        } updateTemplate;

        struct
        {
            uint32 milliseconds;
        } die;

        struct
        {
            uint32 range;
            SAIBool withEmote;
        } callHelp;

        struct
        {
            uint32 sheath;
        } setSheath;

        struct
        {
            uint32 delay;
            uint32 forceRespawnTimer;
            SAIBool removeObjectFromWorld;
        } forceDespawn;

        struct
        {
            uint32 minHP;
            uint32 percent;
        } invincHP;

        struct
        {
            uint32 mask;
        } ingamePhaseMask;

        struct
        {
            uint32 field;
            uint32 data;
        } setData;

        struct
        {
            uint32 distance;
        } moveRandom;

        struct
        {
            SAIBool state;
        } visibility;

        struct
        {
            uint32 state;
        } setActive;

        struct
        {
            uint32 entry;
            uint32 despawnTime;
            uint32 targetsummon;
            uint32 summonType;
        } summonGO;

        struct
        {
            uint32 id;
        } taxi;

        struct
        {
            SAIBool run;
            uint32 pathID;
            SAIBool repeat;
            uint32 quest;
            uint32 despawnTime;
            uint32 reactState;
        } wpStart;

        struct
        {
            uint32 delay;
        } wpPause;

        struct
        {
            uint32 despawnTime;
            uint32 quest;
            SAIBool fail;
        } wpStop;

        struct
        {
            uint32 entry;
            uint32 count;
        } item;

        struct
        {
            uint32 id;
            uint32 param1;
            uint32 param2;
            uint32 param3;
            uint32 param4;
            uint32 param5;
        } installTtemplate;

        struct
        {
            SAIBool run;
        } setRun;

        struct
        {
            SAIBool fly;
            uint32 speed;
            uint32 disableGravity;
        } setFly;

        struct
        {
            SAIBool swim;
        } setSwim;

        struct
        {
            uint32 mapID;
        } teleport;

        struct
        {
            uint32 counterId;
            uint32 value;
            SAIBool reset;
            uint32 subtract;
        } setCounter;

        struct
        {
            uint32 id;
        } storeTargets;

        struct
        {
            uint32 id;
            uint32 min;
            uint32 max;
            uint32 repeatMin;
            uint32 repeatMax;
            uint32 chance;
        } timeEvent;

        struct
        {
            uint32 entry;
        } movie;

        struct
        {
            uint32 entry;
            uint32 mask;
            std::array<uint32, MAX_EQUIPMENT_ITEMS> slots;
        } equip;

        struct
        {
            uint32 flag;
            uint32 type;
        } unitFlag;

        struct
        {
            uint32 flag;
        } flag;

        struct
        {
            uint32 byte1;
            uint32 type;
        } setunitByte;

        struct
        {
            uint32 byte1;
            uint32 type;
        } delunitByte;

        struct
        {
            uint32 id;
            uint32 timerType;
            SAIBool allowOverride;
        } timedActionList;

        struct
        {
            std::array<uint32, SMART_ACTION_PARAM_COUNT> actionLists;
        } randTimedActionList;

        struct
        {
            uint32 idMin;
            uint32 idMax;
        } randRangeTimedActionList;

        struct
        {
            SAIBool withDelayed;
            uint32 spell_id;
            SAIBool withInstant;
        } interruptSpellCasting;

        struct
        {
            uint32 anim;
        } sendGoCustomAnim;

        struct
        {
            uint32 speedxy;
            uint32 speedz;
            uint32 selfJump;
        } jump;

        struct
        {
            uint32 flag;
        } movementFlag;

        struct
        {
            uint32 withEmote;
        } flee;

        struct
        {
            uint32 goRespawnTime;
        } RespawnTarget;

        struct
        {
            uint32 pointId;
            SAIBool transport;
            uint32 controlled;
            uint32 ContactDistance;
            uint32 combatReach;
        } moveToPos;

        struct
        {
            uint32 gossipMenuId;
            uint32 gossipNpcTextId;
        } sendGossipMenu;

        struct
        {
            uint32 state;
        } setGoLootState;

        struct
        {
            uint32 id;
        } sendTargetToTarget;

        struct
        {
            uint32 distance;
            uint32 angle;
        } setRangedMovement;

        struct
        {
            SAIBool regenHealth;
        } setHealthRegen;

        struct
        {
            SAIBool root;
        } setRoot;

        struct
        {
            uint32 flag;
        } goFlag;

        struct
        {
            uint32 state;
        } goState;

        struct
        {
            uint32 group;
            uint32 attackInvoker;
            uint32 attackScriptOwner;
        } creatureGroup;

        struct
        {
            uint32 powerType;
            uint32 newPower;
        } power;

        struct
        {
            uint32 id;
        } gameEventStop;

        struct
        {
            uint32 id;
        } gameEventStart;

        struct
        {
            std::array<uint32, SMART_ACTION_PARAM_COUNT> wps;
        } closestWaypointFromList;

        struct
        {
            uint32 dist;
        } combatDistance;

        struct
        {
            uint32 dist;
        } sightDistance;

        struct
        {
            uint32 dist;
            uint32 reset;
        } casterDistance;

        struct
        {
            uint32 spawnPos;
        } setHomePos;

        struct
        {
            uint32 id;
            SAIBool force;
        } loadEquipment;

        struct
        {
            uint32 minId;
            uint32 maxId;
        } randomTimedEvent;

        struct
        {
            uint32 state;
        } setHover;

        struct
        {
            uint32 type;
            uint32 id;
            uint32 value;
        } immunity;

        struct
        {
            uint32 quickChange;
            uint32 random;
            uint32 turnAngle;
        } orientation;

        struct
        {
            uint32 stopMovement;
            uint32 movementExpired;
        } stopMotion;

        struct
        {
            uint32 summonEntry;
            uint32 summonDuration;
            uint32 distanceBetweenRings;
            uint32 distanceBetweenSummons;
            uint32 coneLength;
            uint32 coneAngle;
        } coneSummon;

        struct
        {
            uint32 textId;
            uint32 flag;
        } playerTalk;

        struct
        {
            uint32 spell;
            uint32 flags;
            uint32 bp1;
            uint32 bp2;
            uint32 bp3;
        } castCustom;

        struct
        {
            uint32 summonEntry;
            uint32 summonDuration;
            uint32 a;
            uint32 k;
            uint32 r_max;
            uint32 phi_delta;
        } summonVortex;

        struct
        {
            uint32 actionId;
            uint32 isNegative;
            uint32 instanceTarget;
        } doAction;

        struct
        {
            SAIBool disable;
        } disableEvade;

        struct
        {
            uint32 timer;
        } corpseDelay;

        struct
        {
            uint32 movementType;
            uint32 speedInteger;
            uint32 speedFraction;
        } movementSpeed;

        struct
        {
            uint32 percent;
        } setHealthPct;

        struct
        {
            uint32 entry;
        } cinematic;

        struct
        {
            SAIBool invokerGUID;
            uint32 index;
        } setGuid;

        struct
        {
            SAIBool state;
            uint32 spawnTimerMin;
            uint32 spawnTimerMax;
            uint32 respawnDelay;
            uint32 corpseDelay;
            SAIBool dontDespawn;
        } scriptSpawn;

        struct
        {
            uint32 scale;
        } setScale;

        struct
        {
            uint32 summonEntry;
            uint32 summonDuration;
            uint32 repetitions;
            uint32 startAngle;
            uint32 stepAngle;
            uint32 dist;
        } radialSummon;

        struct
        {
            uint32 visualId;
        } spellVisual;

        struct
        {
            uint32 followState;
            uint32 followType;
            uint32 dist;
        } followGroup;

        struct
        {
            uint32 type;
            uint32 targetType;
            uint32 targetParam1;
            uint32 targetParam2;
            uint32 targetParam3;
            uint32 targetParam4;
        } orientationTarget;

        struct
        {
            uint32 pathId;
            SAIBool repeat;
        } wpData;

        struct
        {
            uint32 pathId1;
            uint32 pathId2;
            SAIBool repeat;
        } wpDataRandom;

        struct
        {
            uint32 timer;
        } move;

        struct
        {
            uint32 eventId;
            uint32 param;
        } worldStateScript;
        //! Note for any new future actions
        //! All parameters must have type uint32

        struct
        {
            uint32 param1;
            uint32 param2;
            uint32 param3;
            uint32 param4;
            uint32 param5;
            uint32 param6;
        } raw;

        struct
        {
            SAIBool reputation;
            SAIBool loot;
        } reward;
    };
};

enum SMARTAI_TEMPLATE
{
    SMARTAI_TEMPLATE_BASIC          = 0, //nothing is preset
    SMARTAI_TEMPLATE_CASTER         = 1, //spellid, repeatMin, repeatMax, range, manaPCT +JOIN: target_param1 as castFlag
    SMARTAI_TEMPLATE_TURRET         = 2, //spellid, repeatMin, repeatMax +JOIN: target_param1 as castFlag
    SMARTAI_TEMPLATE_PASSIVE        = 3,
    SMARTAI_TEMPLATE_CAGED_GO_PART  = 4, //creatureID, give credit at point end?,
    SMARTAI_TEMPLATE_CAGED_NPC_PART = 5, //gameObjectID, despawntime, run?, dist, TextGroupID
    SMARTAI_TEMPLATE_END            = 6,
};

enum SMARTAI_TARGETS
{
    SMART_TARGET_NONE                           = 0,    // NONE
    SMART_TARGET_SELF                           = 1,    // Self cast
    SMART_TARGET_VICTIM                         = 2,    // Our current target (ie: highest aggro)
    SMART_TARGET_HOSTILE_SECOND_AGGRO           = 3,    // Second highest aggro, maxdist, playerOnly, powerType + 1, missing aura
    SMART_TARGET_HOSTILE_LAST_AGGRO             = 4,    // Dead last on aggro, maxdist, playerOnly, powerType + 1, missing aura
    SMART_TARGET_HOSTILE_RANDOM                 = 5,    // Just any random target on our threat list, maxdist, playerOnly, powerType + 1, missing aura
    SMART_TARGET_HOSTILE_RANDOM_NOT_TOP         = 6,    // Any random target except top threat, maxdist, playerOnly, powerType + 1, missing aura
    SMART_TARGET_ACTION_INVOKER                 = 7,    // Unit who caused this Event to occur
    SMART_TARGET_POSITION                       = 8,    // use xyz from event params
    SMART_TARGET_CREATURE_RANGE                 = 9,    // CreatureEntry(0any), minDist, maxDist, alive(0 - both, 1 - alive, 2 - dead)
    SMART_TARGET_CREATURE_GUID                  = 10,   // guid, entry
    SMART_TARGET_CREATURE_DISTANCE              = 11,   // CreatureEntry(0any), maxDist, alive(0 - both, 1 - alive, 2 - dead)
    SMART_TARGET_STORED                         = 12,   // id, uses pre-stored target(list)
    SMART_TARGET_GAMEOBJECT_RANGE               = 13,   // entry(0any), min, max
    SMART_TARGET_GAMEOBJECT_GUID                = 14,   // guid, entry
    SMART_TARGET_GAMEOBJECT_DISTANCE            = 15,   // entry(0any), maxDist
    SMART_TARGET_INVOKER_PARTY                  = 16,   // includePets(0 - false, 1 - true)
    SMART_TARGET_PLAYER_RANGE                   = 17,   // min, max, maxCount (maxCount by pussywizard), set target.o to 1 if u want to search for all in range if min, max fails
    SMART_TARGET_PLAYER_DISTANCE                = 18,   // maxDist
    SMART_TARGET_CLOSEST_CREATURE               = 19,   // CreatureEntry(0any), maxDist, dead?
    SMART_TARGET_CLOSEST_GAMEOBJECT             = 20,   // entry(0any), maxDist
    SMART_TARGET_CLOSEST_PLAYER                 = 21,   // maxDist
    SMART_TARGET_ACTION_INVOKER_VEHICLE         = 22,   // Unit's vehicle who caused this Event to occur
    SMART_TARGET_OWNER_OR_SUMMONER              = 23,   // Unit's owner or summoner, Use Owner/Charmer of this unit
    SMART_TARGET_THREAT_LIST                    = 24,   // All units on creature's threat list, maxdist, playerOnly
    SMART_TARGET_CLOSEST_ENEMY                  = 25,   // maxDist, playerOnly
    SMART_TARGET_CLOSEST_FRIENDLY               = 26,   // maxDist, playerOnly
    SMART_TARGET_LOOT_RECIPIENTS                = 27,   // all players that have tagged this creature (for kill credit)
    SMART_TARGET_FARTHEST                       = 28,   // maxDist, playerOnly, isInLos, minDist
    SMART_TARGET_VEHICLE_PASSENGER              = 29,   // seat number (vehicle can target it's own accessory)

    SMART_TARGET_TC_END                         = 30,   // placeholder

    // AC-only SmartTargets:

    SMART_TARGET_AC_START                       = 200,  // placeholder

    SMART_TARGET_PLAYER_WITH_AURA               = 201,  // spellId, negation, MaxDist, MinDist, set target.o to a number to random resize the list
    SMART_TARGET_RANDOM_POINT                   = 202,  // range, amount (for summoning creature), self als middle (0/1) else use xyz
    SMART_TARGET_ROLE_SELECTION                 = 203,  // Range Max, TargetMask (Tanks (1), Healer (2) Damage (4)), resize list
    SMART_TARGET_SUMMONED_CREATURES             = 204,  // Entry
    SMART_TARGET_INSTANCE_STORAGE               = 205,  // Instance data index, Type (creature (1), gameobject (2))

    SMART_TARGET_AC_END                         = 206   // placeholder
};

struct SmartTarget
{
    SmartTarget (SMARTAI_TARGETS t = SMART_TARGET_NONE, uint32 p1 = 0, uint32 p2 = 0, uint32 p3 = 0, uint32 p4 = 0)
    {
        type = t;
        raw.param1 = p1;
        raw.param2 = p2;
        raw.param3 = p3;
        raw.param4 = p4;
        x = 0.0f;
        y = 0.0f;
        z = 0.0f;
        o = 0.0f;
    }
    SMARTAI_TARGETS type;
    float x, y, z, o;
    union
    {
        // Xinef: allow random selectors to limit distance
        struct
        {
            uint32 maxDist;
            SAIBool playerOnly;
            uint32 powerType;
            uint32 aura;
        } hostileRandom;

        struct
        {
            uint32 maxDist;
            SAIBool playerOnly;
            SAIBool isInLos;
            uint32 minDist;
        } farthest;

        struct
        {
            uint32 creature;
            uint32 minDist;
            uint32 maxDist;
            uint32 livingState;
        } unitRange;

        struct
        {
            uint32 dbGuid;
            uint32 entry;
        } unitGUID;

        struct
        {
            uint32 maxDist;
            uint32 roleMask;
            uint32 resize;
        } roleSelection;

        struct
        {
            uint32 creature;
            uint32 dist;
            uint32 livingState;
        } unitDistance;

        struct
        {
            uint32 dist;
        } playerDistance;

        struct
        {
            uint32 minDist;
            uint32 maxDist;
            uint32 maxCount;
        } playerRange;

        struct
        {
            uint32 id;
        } stored;

        struct
        {
            uint32 entry;
            uint32 minDist;
            uint32 maxDist;
        } goRange;

        struct
        {
            uint32 dbGuid;
            uint32 entry;
        } goGUID;

        struct
        {
            uint32 entry;
            uint32 dist;
        } goDistance;

        struct
        {
            uint32 entry;
            uint32 dist;
            SAIBool dead;
        } unitClosest;

        struct
        {
            SAIBool useCharmerOrOwner;
        } owner;

        struct
        {
            uint32 seatMask;
        } vehicle;

        struct
        {
            uint32 maxDist;
        } threatList;

        struct
        {
            uint32 entry;
            uint32 dist;
            uint32 onlySpawned;
        } goClosest;

        struct
        {
            uint32 maxDist;
            SAIBool playerOnly;
        } closestAttackable;

        struct
        {
            uint32 maxDist;
            SAIBool playerOnly;
        } closestFriendly;

        struct
        {
            uint32 range;
            uint32 amount;
            uint32 self;
        } randomPoint;

        struct
        {
            uint32 spellId;
            uint32 negation;
            uint32 distMax;
            uint32 distMin;
        } playerWithAura;

        struct
        {
            uint32 entry;
        } summonedCreatures;

        struct
        {
            uint32 param1;
            uint32 param2;
            uint32 param3;
            uint32 param4;
        } raw;

        struct
        {
            uint32 index;
            uint32 type;
        } instanceStorage;

        struct
        {
            SAIBool includePets;
        } invokerParty;
    };
};

enum SmartTargetRoleFlags
{
    SMART_TARGET_ROLE_FLAG_TANKS        = 0x001,
    SMART_TARGET_ROLE_FLAG_HEALERS      = 0x002,
    SMART_TARGET_ROLE_FLAG_DAMAGERS     = 0x004
};

enum SmartScriptType
{
    SMART_SCRIPT_TYPE_CREATURE = 0, //done
    SMART_SCRIPT_TYPE_GAMEOBJECT = 1, //done
    SMART_SCRIPT_TYPE_AREATRIGGER = 2, //done
    SMART_SCRIPT_TYPE_EVENT = 3, //
    SMART_SCRIPT_TYPE_GOSSIP = 4, //
    SMART_SCRIPT_TYPE_QUEST = 5, //
    SMART_SCRIPT_TYPE_SPELL = 6, //
    SMART_SCRIPT_TYPE_TRANSPORT = 7, //
    SMART_SCRIPT_TYPE_INSTANCE = 8, //
    SMART_SCRIPT_TYPE_TIMED_ACTIONLIST = 9, //
    SMART_SCRIPT_TYPE_MAX = 10
};

enum SmartAITypeMaskId
{
    SMART_SCRIPT_TYPE_MASK_CREATURE = 1,
    SMART_SCRIPT_TYPE_MASK_GAMEOBJECT = 2,
    SMART_SCRIPT_TYPE_MASK_AREATRIGGER = 4,
    SMART_SCRIPT_TYPE_MASK_EVENT = 8,
    SMART_SCRIPT_TYPE_MASK_GOSSIP = 16,
    SMART_SCRIPT_TYPE_MASK_QUEST = 32,
    SMART_SCRIPT_TYPE_MASK_SPELL = 64,
    SMART_SCRIPT_TYPE_MASK_TRANSPORT = 128,
    SMART_SCRIPT_TYPE_MASK_INSTANCE = 256,
    SMART_SCRIPT_TYPE_MASK_TIMED_ACTIONLIST = 512,
};

const uint32 SmartAITypeMask[SMART_SCRIPT_TYPE_MAX][2] =
{
    {SMART_SCRIPT_TYPE_CREATURE,            SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_SCRIPT_TYPE_GAMEOBJECT,          SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_SCRIPT_TYPE_AREATRIGGER,         SMART_SCRIPT_TYPE_MASK_AREATRIGGER },
    {SMART_SCRIPT_TYPE_EVENT,               SMART_SCRIPT_TYPE_MASK_EVENT },
    {SMART_SCRIPT_TYPE_GOSSIP,              SMART_SCRIPT_TYPE_MASK_GOSSIP },
    {SMART_SCRIPT_TYPE_QUEST,               SMART_SCRIPT_TYPE_MASK_QUEST },
    {SMART_SCRIPT_TYPE_SPELL,               SMART_SCRIPT_TYPE_MASK_SPELL },
    {SMART_SCRIPT_TYPE_TRANSPORT,           SMART_SCRIPT_TYPE_MASK_TRANSPORT },
    {SMART_SCRIPT_TYPE_INSTANCE,            SMART_SCRIPT_TYPE_MASK_INSTANCE },
    {SMART_SCRIPT_TYPE_TIMED_ACTIONLIST,    SMART_SCRIPT_TYPE_MASK_TIMED_ACTIONLIST }
};

const uint32 SmartAIEventMask[SMART_EVENT_AC_END][2] =
{
    {SMART_EVENT_UPDATE_IC,                 SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_TIMED_ACTIONLIST},
    {SMART_EVENT_UPDATE_OOC,                SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT + SMART_SCRIPT_TYPE_MASK_INSTANCE },
    {SMART_EVENT_HEALTH_PCT,                SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_MANA_PCT,                  SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_AGGRO,                     SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_KILL,                      SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_DEATH,                     SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_EVADE,                     SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_SPELLHIT,                  SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_RANGE,                     SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_OOC_LOS,                   SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_RESPAWN,                   SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_TARGET_HEALTH_PCT,         SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_VICTIM_CASTING,            SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_FRIENDLY_HEALTH,           SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_FRIENDLY_IS_CC,            SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_FRIENDLY_MISSING_BUFF,     SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_SUMMONED_UNIT,             SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_TARGET_MANA_PCT,           SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_ACCEPTED_QUEST,            SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_REWARD_QUEST,              SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_REACHED_HOME,              SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_RECEIVE_EMOTE,             SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_HAS_AURA,                  SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_TARGET_BUFFED,             SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_RESET,                     SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_IC_LOS,                    SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_PASSENGER_BOARDED,         SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_PASSENGER_REMOVED,         SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_CHARMED,                   SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_CHARMED_TARGET,            SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_SPELLHIT_TARGET,           SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_DAMAGED,                   SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_DAMAGED_TARGET,            SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_MOVEMENTINFORM,            SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_SUMMON_DESPAWNED,          SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_CORPSE_REMOVED,            SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_AI_INIT,                   SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_DATA_SET,                  SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_WAYPOINT_START,            SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_WAYPOINT_REACHED,          SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_TRANSPORT_ADDPLAYER,       SMART_SCRIPT_TYPE_MASK_TRANSPORT },
    {SMART_EVENT_TRANSPORT_ADDCREATURE,     SMART_SCRIPT_TYPE_MASK_TRANSPORT },
    {SMART_EVENT_TRANSPORT_REMOVE_PLAYER,   SMART_SCRIPT_TYPE_MASK_TRANSPORT },
    {SMART_EVENT_TRANSPORT_RELOCATE,        SMART_SCRIPT_TYPE_MASK_TRANSPORT },
    {SMART_EVENT_INSTANCE_PLAYER_ENTER,     SMART_SCRIPT_TYPE_MASK_INSTANCE },
    {SMART_EVENT_AREATRIGGER_ONTRIGGER,     SMART_SCRIPT_TYPE_MASK_AREATRIGGER },
    {SMART_EVENT_QUEST_ACCEPTED,            SMART_SCRIPT_TYPE_MASK_QUEST },
    {SMART_EVENT_QUEST_OBJ_COMPLETION,      SMART_SCRIPT_TYPE_MASK_QUEST },
    {SMART_EVENT_QUEST_REWARDED,            SMART_SCRIPT_TYPE_MASK_QUEST },
    {SMART_EVENT_QUEST_COMPLETION,          SMART_SCRIPT_TYPE_MASK_QUEST },
    {SMART_EVENT_QUEST_FAIL,                SMART_SCRIPT_TYPE_MASK_QUEST },
    {SMART_EVENT_TEXT_OVER,                 SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_RECEIVE_HEAL,              SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_JUST_SUMMONED,             SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_WAYPOINT_PAUSED,           SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_WAYPOINT_RESUMED,          SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_WAYPOINT_STOPPED,          SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_WAYPOINT_ENDED,            SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_TIMED_EVENT_TRIGGERED,     SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_UPDATE,                    SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_LINK,                      SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT + SMART_SCRIPT_TYPE_MASK_AREATRIGGER + SMART_SCRIPT_TYPE_MASK_EVENT + SMART_SCRIPT_TYPE_MASK_GOSSIP + SMART_SCRIPT_TYPE_MASK_QUEST + SMART_SCRIPT_TYPE_MASK_SPELL + SMART_SCRIPT_TYPE_MASK_TRANSPORT + SMART_SCRIPT_TYPE_MASK_INSTANCE },
    {SMART_EVENT_GOSSIP_SELECT,             SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_JUST_CREATED,              SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_GOSSIP_HELLO,              SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_FOLLOW_COMPLETED,          SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_EVENT_PHASE_CHANGE,        SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_IS_BEHIND_TARGET,          SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_GAME_EVENT_START,          SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_GAME_EVENT_END,            SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_GO_STATE_CHANGED,          SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_GO_EVENT_INFORM,           SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_ACTION_DONE,               SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_ON_SPELLCLICK,             SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_FRIENDLY_HEALTH_PCT,       SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_DISTANCE_CREATURE,         SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_DISTANCE_GAMEOBJECT,       SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_COUNTER_SET,               SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    { 0, 0 }, // 78
    { 0, 0 }, // 79
    { 0, 0 }, // 80
    { 0, 0 }, // 81
    {SMART_EVENT_SUMMONED_UNIT_DIES,        SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    { 0, 0 }, // 83
    { 0, 0 }, // 84
    { 0, 0 }, // 85
    { 0, 0 }, // 86
    { 0, 0 }, // 87
    { 0, 0 }, // 88
    { 0, 0 }, // 89
    { 0, 0 }, // 90
    { 0, 0 }, // 91
    { 0, 0 }, // 92
    { 0, 0 }, // 93
    { 0, 0 }, // 94
    { 0, 0 }, // 95
    { 0, 0 }, // 96
    { 0, 0 }, // 97
    { 0, 0 }, // 98
    { 0, 0 }, // 99
    { 0, 0 }, // 100
    {SMART_EVENT_NEAR_PLAYERS,              SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_NEAR_PLAYERS_NEGATION,     SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_NEAR_UNIT,                 SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_NEAR_UNIT_NEGATION,        SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_AREA_CASTING,              SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_AREA_RANGE,                SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_SUMMONED_UNIT_EVADE,       SMART_SCRIPT_TYPE_MASK_CREATURE + SMART_SCRIPT_TYPE_MASK_GAMEOBJECT },
    {SMART_EVENT_WAYPOINT_DATA_REACHED,     SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_WAYPOINT_DATA_ENDED,       SMART_SCRIPT_TYPE_MASK_CREATURE },
    {SMART_EVENT_IS_IN_MELEE_RANGE,         SMART_SCRIPT_TYPE_MASK_CREATURE },
};

enum SmartEventFlags
{
    SMART_EVENT_FLAG_NOT_REPEATABLE        = 0x001,                     // Event can not repeat
    SMART_EVENT_FLAG_DIFFICULTY_0          = 0x002,                     // Event only occurs in instance difficulty 0
    SMART_EVENT_FLAG_DIFFICULTY_1          = 0x004,                     // Event only occurs in instance difficulty 1
    SMART_EVENT_FLAG_DIFFICULTY_2          = 0x008,                     // Event only occurs in instance difficulty 2
    SMART_EVENT_FLAG_DIFFICULTY_3          = 0x010,                     // Event only occurs in instance difficulty 3
    SMART_EVENT_FLAG_RESERVED_5            = 0x020,
    SMART_EVENT_FLAG_RESERVED_6            = 0x040,
    SMART_EVENT_FLAG_DEBUG_ONLY            = 0x080,                     // Event only occurs in debug build
    SMART_EVENT_FLAG_DONT_RESET            = 0x100,                     // Event will not reset in SmartScript::OnReset()
    SMART_EVENT_FLAG_WHILE_CHARMED         = 0x200,                     // Event occurs even if AI owner is charmed

    SMART_EVENT_FLAG_DIFFICULTY_ALL        = (SMART_EVENT_FLAG_DIFFICULTY_0 | SMART_EVENT_FLAG_DIFFICULTY_1 | SMART_EVENT_FLAG_DIFFICULTY_2 | SMART_EVENT_FLAG_DIFFICULTY_3),
    SMART_EVENT_FLAGS_ALL                  = (SMART_EVENT_FLAG_NOT_REPEATABLE | SMART_EVENT_FLAG_DIFFICULTY_ALL | SMART_EVENT_FLAG_RESERVED_5 | SMART_EVENT_FLAG_RESERVED_6 | SMART_EVENT_FLAG_DEBUG_ONLY | SMART_EVENT_FLAG_DONT_RESET | SMART_EVENT_FLAG_WHILE_CHARMED),

    // Temp flags, used only at runtime, never stored in DB
    SMART_EVENT_FLAG_TEMP_IGNORE_CHANCE_ROLL = 0x40000000,              //Event occurs no matter what roll_chance_i(e.event.event_chance) returns.
};

enum SmartCastFlags
{
    SMARTCAST_INTERRUPT_PREVIOUS     = 0x001,                     // Interrupt any spell casting
    SMARTCAST_TRIGGERED              = 0x002,                     // Triggered (this makes spell cost zero mana and have no cast time)
    //CAST_FORCE_CAST                  = 0x004,                     // Forces cast even if creature is out of mana or out of range
    //CAST_NO_MELEE_IF_OOM             = 0x008,                     // Prevents creature from entering melee if out of mana or out of range
    //CAST_FORCE_TARGET_SELF           = 0x010,                     // Forces the target to cast this spell on itself
    SMARTCAST_AURA_NOT_PRESENT       = 0x020,                     // Only casts the spell if the target does not have an aura from the spell
    SMARTCAST_COMBAT_MOVE            = 0x040,                     // Prevents combat movement if cast successful. Allows movement on range, OOM, LOS
    SMARTCAST_THREATLIST_NOT_SINGLE  = 0x080,                     // Only cast if the source's threatlist is higher than one. This includes pets (see Skeram's True Fulfillment)
    SMARTCAST_TARGET_POWER_MANA      = 0x100                      // Only cast if the target has power type mana (e.g. Mana Drain)
};

enum SmartFollowType
{
    FOLLOW_TYPE_CIRCLE                     = 1,                  // 360 degrees around leader, 90 degrees is the maximum angle
    FOLLOW_TYPE_SEMI_CIRCLE_BEHIND         = 2,                  // 180 degrees behind leader
    FOLLOW_TYPE_SEMI_CIRCLE_FRONT          = 3,                  // 180 degrees in front of leader
    FOLLOW_TYPE_LINE                       = 4,                  // front -> back -> front -> back
    FOLLOW_TYPE_COLUMN                     = 5,                  // left -> right -> left -> right
    FOLLOW_TYPE_ANGULAR                    = 6                   // geese-like formation 135 and 225 degrees behind leader
};

// one line in DB is one event
struct SmartScriptHolder
{
    SmartScriptHolder() : entryOrGuid(0), source_type(SMART_SCRIPT_TYPE_CREATURE)
        , event_id(0), link(0), event(), action(), target(), timer(0), priority(DEFAULT_PRIORITY), active(false), runOnce(false)
        , enableTimed(false) {}

    int32 entryOrGuid;
    SmartScriptType source_type;
    uint32 event_id;
    uint32 link;

    SmartEvent event;
    SmartAction action;
    SmartTarget target;

public:
    uint32 GetScriptType() const { return (uint32)source_type; }
    uint32 GetEventType() const { return (uint32)event.type; }
    uint32 GetActionType() const { return (uint32)action.type; }
    uint32 GetTargetType() const { return (uint32)target.type; }

    uint32 timer;
    uint32 priority;
    bool active;
    bool runOnce;
    bool enableTimed;

    // Default comparision operator using priority field as first ordering field
    bool operator<(SmartScriptHolder const& other) const
    {
        return std::tie(priority, entryOrGuid, source_type, event_id, link) < std::tie(other.priority, other.entryOrGuid, other.source_type, other.event_id, other.link);
    }

    static constexpr uint32 DEFAULT_PRIORITY = std::numeric_limits<uint32>::max();
};

typedef std::unordered_map<uint32, WayPoint*> WPPath;

typedef std::vector<WorldObject*> ObjectVector;

class ObjectGuidVector
{
public:
    explicit ObjectGuidVector(ObjectVector const& objectVector) : _objectVector(objectVector)
    {
        _guidVector.reserve(_objectVector.size());
        for (WorldObject* obj : _objectVector)
            _guidVector.push_back(obj->GetGUID());
    }

    ObjectVector const* GetObjectVector(WorldObject const& ref) const
    {
        UpdateObjects(ref);
        return &_objectVector;
    }

    ~ObjectGuidVector() { }

private:
    mutable ObjectVector _objectVector;

    GuidVector _guidVector;

    //sanitize vector using _guidVector
    void UpdateObjects(WorldObject const& ref) const
    {
        _objectVector.clear();

        for (ObjectGuid const& guid : _guidVector)
            if (WorldObject* obj = ObjectAccessor::GetWorldObject(ref, guid))
                _objectVector.push_back(obj);
    }
};
typedef std::unordered_map<uint32, ObjectGuidVector> ObjectVectorMap;

class SmartWaypointMgr
{
    SmartWaypointMgr() {}
public:
    ~SmartWaypointMgr();

    static SmartWaypointMgr* instance();

    void LoadFromDB();

    WPPath* GetPath(uint32 id)
    {
        if (waypoint_map.find(id) != waypoint_map.end())
            return waypoint_map[id];
        else return 0;
    }

private:
    std::unordered_map<uint32, WPPath*> waypoint_map;
};

// all events for a single entry
typedef std::vector<SmartScriptHolder> SmartAIEventList;
typedef std::list<SmartScriptHolder> SmartAIEventStoredList;

// all events for all entries / guids
typedef std::unordered_map<int32, SmartAIEventList> SmartAIEventMap;

class SmartAIMgr
{
    SmartAIMgr() {};
public:
    ~SmartAIMgr() {};

    static SmartAIMgr* instance();

    void LoadSmartAIFromDB();
    void CheckIfSmartAIInDatabaseExists();

    SmartAIEventList GetScript(int32 entry, SmartScriptType type)
    {
        SmartAIEventList temp;
        if (mEventMap[uint32(type)].find(entry) != mEventMap[uint32(type)].end())
            return mEventMap[uint32(type)][entry];
        else
        {
            if (entry > 0) //first search is for guid (negative), do not drop error if not found
                LOG_DEBUG("sql.sql", "SmartAIMgr::GetScript: Could not load Script for Entry {} ScriptType {}.", entry, uint32(type));
            return temp;
        }
    }

private:
    //event stores
    SmartAIEventMap mEventMap[SMART_SCRIPT_TYPE_MAX];

    static bool EventHasInvoker(SMART_EVENT event);

    bool IsEventValid(SmartScriptHolder& e);
    bool IsTargetValid(SmartScriptHolder const& e);

    /*inline bool IsTargetValid(SmartScriptHolder e, int32 target)
    {
        if (target < SMART_TARGET_NONE || target >= SMART_TARGET_END)
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses invalid Target type {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), target);
            return false;
        }
        return true;
    }*/

    bool IsMinMaxValid(SmartScriptHolder const& e, uint32 min, uint32 max)
    {
        if (max < min)
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses min/max params wrong ({}/{}), skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), min, max);
            return false;
        }
        return true;
    }

    /*inline bool IsPercentValid(SmartScriptHolder e, int32 pct)
    {
        if (pct < -100 || pct > 100)
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} has invalid Percent set ({}), skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), pct);
            return false;
        }
        return true;
    }*/

    bool NotNULL(SmartScriptHolder const& e, uint32 data)
    {
        if (!data)
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} Parameter can not be nullptr, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType());
            return false;
        }
        return true;
    }

    bool IsCreatureValid(SmartScriptHolder const& e, uint32 entry)
    {
        if (!sObjectMgr->GetCreatureTemplate(entry))
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Creature entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), entry);
            return false;
        }
        return true;
    }

    bool IsQuestValid(SmartScriptHolder const& e, uint32 entry)
    {
        if (!sObjectMgr->GetQuestTemplate(entry))
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Quest entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), entry);
            return false;
        }
        return true;
    }

    bool IsGameObjectValid(SmartScriptHolder const& e, uint32 entry)
    {
        if (!sObjectMgr->GetGameObjectTemplate(entry))
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent GameObject entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), entry);
            return false;
        }
        return true;
    }

    bool IsSpellValid(SmartScriptHolder const& e, uint32 entry)
    {
        if (!sSpellMgr->GetSpellInfo(entry))
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Spell entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), entry);
            return false;
        }
        return true;
    }

    bool IsItemValid(SmartScriptHolder const& e, uint32 entry)
    {
        if (!sItemStore.LookupEntry(entry))
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Item entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), entry);
            return false;
        }
        return true;
    }

    bool IsTextEmoteValid(SmartScriptHolder const& e, uint32 entry)
    {
        if (!sEmotesTextStore.LookupEntry(entry))
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Text Emote entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), entry);
            return false;
        }
        return true;
    }

    bool IsEmoteValid(SmartScriptHolder const& e, uint32 entry)
    {
        if (!sEmotesStore.LookupEntry(entry))
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Emote entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), entry);
            return false;
        }
        return true;
    }

    bool IsAreaTriggerValid(SmartScriptHolder const& e, uint32 entry)
    {
        if (!sObjectMgr->GetAreaTrigger(entry))
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent AreaTrigger entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), entry);
            return false;
        }
        return true;
    }

    bool IsSoundValid(SmartScriptHolder const& e, uint32 entry)
    {
        if (!sSoundEntriesStore.LookupEntry(entry))
        {
            LOG_ERROR("sql.sql", "SmartAIMgr: Entry {} SourceType {} Event {} Action {} uses non-existent Sound entry {}, skipped.", e.entryOrGuid, e.GetScriptType(), e.event_id, e.GetActionType(), entry);
            return false;
        }
        return true;
    }

    static bool IsSAIBoolValid(SmartScriptHolder const& e, SAIBool value);
    static bool IsTextValid(SmartScriptHolder const& e, uint32 id);
    static bool CheckUnusedEventParams(SmartScriptHolder const& e);
    static bool CheckUnusedActionParams(SmartScriptHolder const& e);
    static bool CheckUnusedTargetParams(SmartScriptHolder const& e);
};

#define sSmartScriptMgr SmartAIMgr::instance()
#define sSmartWaypointMgr SmartWaypointMgr::instance()

#endif
