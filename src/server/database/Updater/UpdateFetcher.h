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

#ifndef UpdateFetcher_h__
#define UpdateFetcher_h__

#include "DatabaseEnv.h"
#include "Define.h"
#include <filesystem>
#include <set>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

struct AC_DATABASE_API UpdateResult
{
    UpdateResult() = default;
    UpdateResult(size_t const updated_, size_t const recent_, size_t const archived_)
        : updated(updated_), recent(recent_), archived(archived_) { }

    size_t updated{};
    size_t recent{};
    size_t archived{};
};

class AC_DATABASE_API UpdateFetcher
{
    typedef std::filesystem::path Path;

public:
    UpdateFetcher(Path const& updateDirectory,
                    std::function<void(std::string_view)> const& apply,
                    std::function<void(Path const& path)> const& applyFile,
                    std::function<QueryResult(std::string_view)> const& retrieve, std::string_view dbNameForModule, std::vector<std::string> const* setDirectories = nullptr);

    UpdateFetcher(Path const& updateDirectory,
                    std::function<void(std::string_view)> const& apply,
                    std::function<void(Path const& path)> const& applyFile,
                    std::function<QueryResult(std::string_view)> const& retrieve,
                    std::string_view dbNameForModule,
                    std::string_view modulesList = {});

    ~UpdateFetcher() = default;

    [[nodiscard]] UpdateResult Update() const;

private:
    enum UpdateMode
    {
        MODE_APPLY,
        MODE_REHASH
    };

    enum State
    {
        RELEASED,
        CUSTOM,
        MODULE,
        ARCHIVED
    };

    struct AppliedFileEntry
    {
        AppliedFileEntry(std::string_view name_, std::string_view hash_, State state_, uint64 timestamp_)
                : name(name_), hash(hash_), state(state_), timestamp(timestamp_) { }

        std::string const name;
        std::string const hash;
        State const state;
        uint64 const timestamp;

        static inline State StateConvert(std::string_view state)
        {
            if (state == "RELEASED")
                return RELEASED;
            else if (state == "CUSTOM")
                return CUSTOM;
            else if (state == "MODULE")
                return MODULE;

            return ARCHIVED;
        }

        static inline std::string StateConvert(State const state)
        {
            switch (state)
            {
                case RELEASED:
                    return "RELEASED";
                case CUSTOM:
                    return "CUSTOM";
                case MODULE:
                    return "MODULE";
                case ARCHIVED:
                    return "ARCHIVED";
                default:
                    return "";
            }
        }

        [[nodiscard]] std::string GetStateAsString() const
        {
            return StateConvert(state);
        }
    };

    struct DirectoryEntry;

    typedef std::pair<Path, State> LocaleFileEntry;

    struct PathCompare
    {
        bool operator()(LocaleFileEntry const& left, LocaleFileEntry const& right) const;
    };

    typedef std::set<LocaleFileEntry, PathCompare> LocaleFileStorage;
    typedef std::unordered_map<std::string, std::string> HashToFileNameStorage;
    typedef std::unordered_map<std::string, AppliedFileEntry> AppliedFileStorage;
    typedef std::vector<UpdateFetcher::DirectoryEntry> DirectoryStorage;

    [[nodiscard]] LocaleFileStorage GetFileList() const;
    static void FillFileListRecursively(Path const& path, LocaleFileStorage& storage,
                                    State state, uint32 depth) ;

    [[nodiscard]] DirectoryStorage ReceiveIncludedDirectories() const;
    [[nodiscard]] AppliedFileStorage ReceiveAppliedFiles() const;

    [[nodiscard]] static std::string ReadSQLUpdate(Path const& file) ;

    [[nodiscard]] Milliseconds Apply(Path const& path) const;

    void UpdateEntry(AppliedFileEntry const& entry, Milliseconds speed = 0ms) const;
    void RenameEntry(std::string const& from, std::string const& to) const;
    void CleanUp(AppliedFileStorage const& storage) const;

    void UpdateState(std::string const& name, State state) const;

    std::unique_ptr<Path> const _sourceDirectory;
    std::function<void(std::string_view)> const _apply;
    std::function<void(Path const& path)> const _applyFile;
    std::function<QueryResult(std::string_view)> const _retrieve;

    // modules
    std::string const _dbModuleName;
    std::vector<std::string> const* _setDirectories;
    std::string _modulesList;
};

#endif // UpdateFetcher_h__
