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

#ifndef CharacterCache_h__
#define CharacterCache_h__

#include "ArenaTeam.h"
#include "Define.h"
#include "GUID.h"
#include "Optional.h"
#include <string>

struct CharacterCacheEntry
{
    WOWGUID Guid;
    std::string Name;
    uint32 AccountId;
    uint8 Class;
    uint8 Race;
    uint8 Sex;
    uint8 Level;
    uint8 MailCount;
    WOWGUID::LowType GuildId;
    std::array<uint32, MAX_ARENA_SLOT> ArenaTeamId;
    WOWGUID GroupGuid;
};

class AC_GAME_API CharacterCache
{
    public:
        CharacterCache() noexcept = default;
        ~CharacterCache() noexcept = default;
        static CharacterCache* instance();

        void LoadCharacterCacheStorage();
        void RefreshCacheEntry(uint32 lowGuid);

        void AddCharacterCacheEntry(WOWGUID const& guid, uint32 accountId, std::string const& name, uint8 gender, uint8 race, uint8 playerClass, uint8 level);
        void DeleteCharacterCacheEntry(WOWGUID const& guid, std::string const& name);

        void UpdateCharacterData(WOWGUID const& guid, std::string const& name, Optional<uint8> gender = {}, Optional<uint8> race = {});
        void UpdateCharacterLevel(WOWGUID const& guid, uint8 level);
        void UpdateCharacterAccountId(WOWGUID const& guid, uint32 accountId);
        void UpdateCharacterGuildId(WOWGUID const& guid, WOWGUID::LowType guildId);
        void UpdateCharacterArenaTeamId(WOWGUID const& guid, uint8 slot, uint32 arenaTeamId);

        void UpdateCharacterMailCount(WOWGUID const& guid, int8 count, bool update = false);
        void DecreaseCharacterMailCount(WOWGUID const& guid) { UpdateCharacterMailCount(guid, -1); };
        void IncreaseCharacterMailCount(WOWGUID const& guid) { UpdateCharacterMailCount(guid, 1); };

        [[nodiscard]] bool HasCharacterCacheEntry(WOWGUID const& guid) const;
        [[nodiscard]] CharacterCacheEntry const* GetCharacterCacheByGuid(WOWGUID const& guid) const;
        [[nodiscard]] CharacterCacheEntry const* GetCharacterCacheByName(std::string const& name) const;

        void UpdateCharacterGroup(WOWGUID const& guid, WOWGUID groupGUID);
        void ClearCharacterGroup(WOWGUID const& guid) { UpdateCharacterGroup(guid, WOWGUID::Empty); };

        [[nodiscard]] WOWGUID GetCharacterGuidByName(std::string const& name) const;
        bool GetCharacterNameByGuid(WOWGUID guid, std::string& name) const;
        [[nodiscard]] uint32 GetCharacterTeamByGuid(WOWGUID guid) const;
        [[nodiscard]] uint32 GetCharacterAccountIdByGuid(WOWGUID guid) const;
        [[nodiscard]] uint32 GetCharacterAccountIdByName(std::string const& name) const;
        [[nodiscard]] uint8 GetCharacterLevelByGuid(WOWGUID guid) const;
        [[nodiscard]] WOWGUID::LowType GetCharacterGuildIdByGuid(WOWGUID guid) const;
        [[nodiscard]] uint32 GetCharacterArenaTeamIdByGuid(WOWGUID guid, uint8 type) const;
        [[nodiscard]] WOWGUID GetCharacterGroupGuidByGuid(WOWGUID guid) const;
};

#define sCharacterCache CharacterCache::instance()

#endif // CharacterCache_h__
