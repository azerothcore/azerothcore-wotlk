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

#ifndef WORLD_STATE_H
#define WORLD_STATE_H

#include "Player.h"
#include <atomic>

enum WorldStateCondition
{
    WORLD_STATE_CONDITION_TROLLBANES_COMMAND  = 39911,
    WORLD_STATE_CONDITION_NAZGRELS_FAVOR      = 39913,
    // Zeppelins
    WORLD_STATE_CONDITION_THE_THUNDERCALLER   = 164871,
    WORLD_STATE_CONDITION_THE_IRON_EAGLE      = 175080,
    WORLD_STATE_CONDITION_THE_PURPLE_PRINCESS = 176495,
};

enum WorldStateConditionState
{
    WORLD_STATE_CONDITION_STATE_NONE = 0,
};

enum WorldStateEvent
{
    WORLD_STATE_CUSTOM_EVENT_ON_ADALS_SONG_OF_BATTLE     = 39953,
    WORLD_STATE_CUSTOM_EVENT_ON_MAGTHERIDON_HEAD_SPAWN   = 184640,
    WORLD_STATE_CUSTOM_EVENT_ON_MAGTHERIDON_HEAD_DESPAWN = 184641,
};

enum WorldStateZoneId
{
    ZONEID_SHATTRATH    = 3703,
    ZONEID_BOTANICA     = 3847,
    ZONEID_ARCATRAZ     = 3848,
    ZONEID_MECHANAR     = 3849,

    ZONEID_HELLFIRE_PENINSULA   = 3483,
    ZONEID_HELLFIRE_RAMPARTS    = 3562,
    ZONEID_HELLFIRE_CITADEL     = 3563,
    ZONEID_BLOOD_FURNACE        = 3713,
    ZONEID_SHATTERED_HALLS      = 3714,
    ZONEID_MAGTHERIDON_LAIR     = 3836,
};

enum WorldStateSpells
{
    SPELL_ADAL_SONG_OF_BATTLE   = 39953,

    SPELL_TROLLBANES_COMMAND    = 39911,
    SPELL_NAZGRELS_FAVOR        = 39913,
};

// Intended for implementing server wide scripts, note: all behaviour must be safeguarded towards multithreading
class WorldState
{
    public:
        WorldState();
        virtual ~WorldState();
        static WorldState* instance();
        void HandlePlayerEnterZone(Player* player, WorldStateZoneId zoneId);
        void HandlePlayerLeaveZone(Player* player, WorldStateZoneId zoneId);
        bool IsConditionFulfilled(WorldStateCondition conditionId, WorldStateConditionState state = WORLD_STATE_CONDITION_STATE_NONE) const;
        void HandleConditionStateChange(WorldStateCondition conditionId, WorldStateConditionState state);
        void HandleExternalEvent(WorldStateEvent eventId, uint32 param);
        void Update(uint32 diff);
    private:
        void BuffAdalsSongOfBattle();
        void DispelAdalsSongOfBattle();
        uint32 _adalSongOfBattleTimer;
        void BuffMagtheridonTeam(TeamId team);
        void DispelMagtheridonTeam(TeamId team);
        bool _isMagtheridonHeadSpawnedHorde;
        bool _isMagtheridonHeadSpawnedAlliance;
        std::map<WorldStateCondition, std::atomic<WorldStateConditionState>> _transportStates; // atomic to avoid having to lock
        std::mutex _mutex; // all World State operations are threat unsafe
};

#define sWorldState WorldState::instance()
#endif
