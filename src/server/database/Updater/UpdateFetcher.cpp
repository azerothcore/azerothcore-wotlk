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

#include "UpdateFetcher.h"
#include "CryptoHash.h"
#include "DBUpdater.h"
#include "Field.h"
#include "Log.h"
#include "Tokenize.h"
#include "Util.h"
#include <fstream>
#include <sstream>

#include "QueryResult.h"

using namespace std::filesystem;

struct UpdateFetcher::DirectoryEntry
{
    DirectoryEntry(Path const& path_, State state_) : path(path_), state(state_) { }

    Path const path;
    State const state;
};

UpdateFetcher::UpdateFetcher(Path const& sourceDirectory,
                             std::function<void(std::string const&)> const& apply,
                             std::function<void(Path const& path)> const& applyFile,
                             std::function<QueryResult(std::string const&)> const& retrieve, std::string const& dbModuleName, std::vector<std::string> const* setDirectories /*= nullptr*/) :
    _sourceDirectory(std::make_unique<Path>(sourceDirectory)), _apply(apply), _applyFile(applyFile),
    _retrieve(retrieve), _dbModuleName(dbModuleName), _setDirectories(setDirectories)
{
}

UpdateFetcher::UpdateFetcher(Path const& sourceDirectory,
    std::function<void(std::string const&)> const& apply,
    std::function<void(Path const& path)> const& applyFile,
    std::function<QueryResult(std::string const&)> const& retrieve,
    std::string const& dbModuleName,
    std::string_view modulesList /*= {}*/) :
    _sourceDirectory(std::make_unique<Path>(sourceDirectory)), _apply(apply), _applyFile(applyFile),
    _retrieve(retrieve), _dbModuleName(dbModuleName), _setDirectories(nullptr), _modulesList(modulesList)
{
}

UpdateFetcher::~UpdateFetcher()
{
}

UpdateFetcher::LocaleFileStorage UpdateFetcher::GetFileList() const
{
    LocaleFileStorage files;
    DirectoryStorage directories = ReceiveIncludedDirectories();
    for (auto const& entry : directories)
        FillFileListRecursively(entry.path, files, entry.state, 1);

    return files;
}

void UpdateFetcher::FillFileListRecursively(Path const& path, LocaleFileStorage& storage, State const state, uint32 const depth) const
{
    static uint32 const MAX_DEPTH = 10;
    static directory_iterator const end;

    for (directory_iterator itr(path); itr != end; ++itr)
    {
        if (is_directory(itr->path()))
        {
            if (depth < MAX_DEPTH)
                FillFileListRecursively(itr->path(), storage, state, depth + 1);
        }
        else if (itr->path().extension() == ".sql")
        {
            LOG_TRACE("sql.updates", "Added locale file \"{}\" state '{}'.", itr->path().filename().generic_string(), AppliedFileEntry::StateConvert(state));

            LocaleFileEntry const entry = { itr->path(), state };

            // Check for doubled filenames
            // Because elements are only compared by their filenames, this is ok
            if (storage.find(entry) != storage.end())
            {
                LOG_FATAL("sql.updates", "Duplicate filename \"{}\" occurred. Because updates are ordered " \
                          "by their filenames, every name needs to be unique!", itr->path().generic_string());

                throw UpdateException("Updating failed, see the log for details.");
            }

            storage.insert(entry);
        }
    }
}

UpdateFetcher::DirectoryStorage UpdateFetcher::ReceiveIncludedDirectories() const
{
    DirectoryStorage directories;

    if (_setDirectories)
    {
        for (auto const& itr : *_setDirectories)
        {
            std::string path = _sourceDirectory->generic_string() + itr;

            Path const p(path);
            if (!is_directory(p))
                continue;

            DirectoryEntry const entry = {p, AppliedFileEntry::StateConvert("MODULE")};
            directories.push_back(entry);

            LOG_TRACE("sql.updates", "Added applied extra file \"{}\" from remote.", p.filename().generic_string());
        }
    }
    else
    {
        QueryResult const result = _retrieve("SELECT `path`, `state` FROM `updates_include`");
        if (!result)
            return directories;

        do
        {
            Field* fields = result->Fetch();

            std::string path  = fields[0].Get<std::string>();
            std::string state = fields[1].Get<std::string>();
            if (path.substr(0, 1) == "$")
                path = _sourceDirectory->generic_string() + path.substr(1);

            Path const p(path);

            if (!is_directory(p))
            {
                LOG_WARN("sql.updates", "DBUpdater: Given update include directory \"{}\" does not exist, skipped!", p.generic_string());
                continue;
            }

            DirectoryEntry const entry = {p, AppliedFileEntry::StateConvert(state)};
            directories.push_back(entry);

            LOG_TRACE("sql.updates", "Added applied file \"{}\" '{}' state from remote.", p.filename().generic_string(), state);

        } while (result->NextRow());

        std::vector<std::string> moduleList;

        for (auto const& itr : Acore::Tokenize(_modulesList, ',', true))
        {
            moduleList.emplace_back(itr);
        }

        // data/sql
        for (auto const& itr : moduleList)
        {
            std::string path = _sourceDirectory->generic_string() + "/modules/" + itr + "/data/sql/" + _dbModuleName; // modules/mod-name/data/sql/db-world

            Path const p(path);
            if (!is_directory(p))
            {
                continue;
            }

            DirectoryEntry const entry = { p, AppliedFileEntry::StateConvert("MODULE") };
            directories.push_back(entry);

            LOG_TRACE("sql.updates", "Added applied modules file \"{}\" from remote.", p.filename().generic_string());
        }
    }

    return directories;
}

UpdateFetcher::AppliedFileStorage UpdateFetcher::ReceiveAppliedFiles() const
{
    AppliedFileStorage map;

    QueryResult result = _retrieve("SELECT `name`, `hash`, `state`, UNIX_TIMESTAMP(`timestamp`) FROM `updates` ORDER BY `name` ASC");
    if (!result)
        return map;

    do
    {
        Field* fields = result->Fetch();

        AppliedFileEntry const entry =
        {
            fields[0].Get<std::string>(), fields[1].Get<std::string>(), AppliedFileEntry::StateConvert(fields[2].Get<std::string>()), fields[3].Get<uint64>()
        };

        map.emplace(entry.name, entry);
    } while (result->NextRow());

    return map;
}

std::string UpdateFetcher::ReadSQLUpdate(Path const& file) const
{
    std::ifstream in(file.c_str());
    if (!in.is_open())
    {
        LOG_FATAL("sql.updates", "Failed to open the sql update \"{}\" for reading! "
                  "Stopping the server to keep the database integrity, "
                  "try to identify and solve the issue or disable the database updater.",
                  file.generic_string());

        throw UpdateException("Opening the sql update failed!");
    }

    auto update = [&in]
    {
        std::ostringstream ss;
        ss << in.rdbuf();
        return ss.str();
    }();

    in.close();
    return update;
}

UpdateResult UpdateFetcher::Update(bool const redundancyChecks,
                                   bool const allowRehash,
                                   bool const archivedRedundancy,
                                   int32 const cleanDeadReferencesMaxCount) const
{
    LocaleFileStorage const available = GetFileList();
    if (_setDirectories && available.empty())
    {
        return UpdateResult();
    }

    AppliedFileStorage applied = ReceiveAppliedFiles();

    std::size_t countRecentUpdates = 0;
    std::size_t countArchivedUpdates = 0;

    // Count updates
    for (auto const& entry : applied)
        if (entry.second.state == RELEASED)
            ++countRecentUpdates;
        else
            ++countArchivedUpdates;

    // Fill hash to name cache
    HashToFileNameStorage hashToName;
    for (auto& entry : applied)
        hashToName.insert(std::make_pair(entry.second.hash, entry.first));

    std::size_t importedUpdates = 0;

    auto ApplyUpdateFile = [&](LocaleFileEntry const& sqlFile)
    {
        auto filePath = sqlFile.first;
        auto fileState = sqlFile.second;

        LOG_DEBUG("sql.updates", "Checking update \"{}\"...", filePath.filename().generic_string());

        AppliedFileStorage::const_iterator iter = applied.find(filePath.filename().string());
        if (iter != applied.end())
        {
            // If redundancy is disabled, skip it, because the update is already applied.
            if (!redundancyChecks)
            {
                LOG_DEBUG("sql.updates", ">> Update is already applied, skipping redundancy checks.");
                applied.erase(iter);
                return;
            }

            // If the update is in an archived directory and is marked as archived in our database, skip redundancy checks (archived updates never change).
            if (!archivedRedundancy && (iter->second.state == ARCHIVED) && (sqlFile.second == ARCHIVED))
            {
                LOG_DEBUG("sql.updates", ">> Update is archived and marked as archived in database, skipping redundancy checks.");
                applied.erase(iter);
                return;
            }
        }

        std::string const hash = ByteArrayToHexStr(Acore::Crypto::SHA1::GetDigestOf(ReadSQLUpdate(filePath)));

        UpdateMode mode = MODE_APPLY;

        // Update is not in our applied list
        if (iter == applied.end())
        {
            // Catch renames (different filename, but same hash)
            HashToFileNameStorage::const_iterator const hashIter = hashToName.find(hash);
            if (hashIter != hashToName.end())
            {
                // Check if the original file was removed. If not, we've got a problem.
                LocaleFileStorage::const_iterator localeIter;

                // Push localeIter forward
                for (localeIter = available.begin(); (localeIter != available.end()) &&
                        (localeIter->first.filename().string() != hashIter->second); ++localeIter);

                // Conflict!
                if (localeIter != available.end())
                {
                    LOG_WARN("sql.updates", ">> It seems like the update \"{}\" \'{}\' was renamed, but the old file is still there! " \
                             "Treating it as a new file! (It is probably an unmodified copy of the file \"{}\")",
                             filePath.filename().string(), hash.substr(0, 7),
                             localeIter->first.filename().string());
                }
                else // It is safe to treat the file as renamed here
                {
                    LOG_INFO("sql.updates", ">> Renaming update \"{}\" to \"{}\" \'{}\'.",
                             hashIter->second, filePath.filename().string(), hash.substr(0, 7));

                    RenameEntry(hashIter->second, filePath.filename().string());
                    applied.erase(hashIter->second);
                    return;
                }
            }
            // Apply the update if it was never seen before.
            else
            {
                LOG_INFO("sql.updates", ">> Applying update \"{}\" \'{}\'...",
                    filePath.filename().string(), hash.substr(0, 7));
            }
        }
        // Rehash the update entry if it exists in our database with an empty hash.
        else if (allowRehash && iter->second.hash.empty())
        {
            mode = MODE_REHASH;

            LOG_INFO("sql.updates", ">> Re-hashing update \"{}\" \'{}\'...", filePath.filename().string(),
                hash.substr(0, 7));
        }
        else
        {
            // If the hash of the files differs from the one stored in our database, reapply the update (because it changed).
            if (iter->second.hash != hash)
            {
                LOG_INFO("sql.updates", ">> Reapplying update \"{}\" \'{}\' -> \'{}\' (it changed)...", filePath.filename().string(),
                    iter->second.hash.substr(0, 7), hash.substr(0, 7));
            }
            else
            {
                // If the file wasn't changed and just moved, update its state (if necessary).
                if (iter->second.state != fileState)
                {
                    LOG_DEBUG("sql.updates", ">> Updating the state of \"{}\" to \'{}\'...",
                              filePath.filename().string(), AppliedFileEntry::StateConvert(fileState));

                    UpdateState(filePath.filename().string(), fileState);
                }

                LOG_DEBUG("sql.updates", ">> Update is already applied and matches the hash \'{}\'.", hash.substr(0, 7));

                applied.erase(iter);
                return;
            }
        }

        uint32 speed = 0;
        AppliedFileEntry const file = { filePath.filename().string(), hash, fileState, 0 };

        switch (mode)
        {
            case MODE_APPLY:
                speed = Apply(filePath);
                [[fallthrough]];
            case MODE_REHASH:
                UpdateEntry(file, speed);
                break;
        }

        if (iter != applied.end())
            applied.erase(iter);

        if (mode == MODE_APPLY)
            ++importedUpdates;
    };

    // Apply default updates
    for (auto const& availableQuery : available)
    {
        if (availableQuery.second != CUSTOM && availableQuery.second != MODULE)
            ApplyUpdateFile(availableQuery);
    }

    // Apply only custom/module updates
    for (auto const& availableQuery : available)
    {
        if (availableQuery.second == CUSTOM || availableQuery.second == MODULE)
            ApplyUpdateFile(availableQuery);
    }

    // Cleanup up orphaned entries (if enabled)
    if (!applied.empty() && !_setDirectories)
    {
        bool const doCleanup = (cleanDeadReferencesMaxCount < 0) || (applied.size() <= static_cast<size_t>(cleanDeadReferencesMaxCount));

        AppliedFileStorage toCleanup;
        for (auto const& entry : applied)
        {
            if (entry.second.state != MODULE)
            {
                LOG_WARN("sql.updates",
                         ">> The file \'{}\' was applied to the database, but is missing in"
                         " your update directory now!",
                         entry.first);

                if (doCleanup)
                {
                    LOG_INFO("sql.updates", "Deleting orphaned entry \'{}\'...", entry.first);
                    toCleanup.insert(entry);
                }
            }
        }

        if (!toCleanup.empty())
        {
            if (doCleanup)
                CleanUp(toCleanup);
            else
            {
                LOG_ERROR("sql.updates",
                          "Cleanup is disabled! There were {} dirty files applied to your database, "
                          "but they are now missing in your source directory!",
                          toCleanup.size());
            }
        }
    }

    return UpdateResult(importedUpdates, countRecentUpdates, countArchivedUpdates);
}

uint32 UpdateFetcher::Apply(Path const& path) const
{
    using Time = std::chrono::high_resolution_clock;

    // Benchmark query speed
    auto const begin = Time::now();

    // Update database
    _applyFile(path);

    // Return the time it took the query to apply
    return uint32(std::chrono::duration_cast<std::chrono::milliseconds>(Time::now() - begin).count());
}

void UpdateFetcher::UpdateEntry(AppliedFileEntry const& entry, uint32 const speed) const
{
    std::string const update = "REPLACE INTO `updates` (`name`, `hash`, `state`, `speed`) VALUES (\"" +
                               entry.name + "\", \"" + entry.hash + "\", \'" + entry.GetStateAsString() + "\', " + std::to_string(speed) + ")";

    // Update database
    _apply(update);
}

void UpdateFetcher::RenameEntry(std::string const& from, std::string const& to) const
{
    // Delete the target if it exists
    {
        std::string const update = "DELETE FROM `updates` WHERE `name`=\"" + to + "\"";

        // Update database
        _apply(update);
    }

    // Rename
    {
        std::string const update = "UPDATE `updates` SET `name`=\"" + to + "\" WHERE `name`=\"" + from + "\"";

        // Update database
        _apply(update);
    }
}

void UpdateFetcher::CleanUp(AppliedFileStorage const& storage) const
{
    if (storage.empty())
        return;

    std::stringstream update;
    std::size_t remaining = storage.size();

    update << "DELETE FROM `updates` WHERE `name` IN(";

    for (auto const& entry : storage)
    {
        update << "\"" << entry.first << "\"";
        if ((--remaining) > 0)
            update << ", ";
    }

    update << ")";

    // Update database
    _apply(update.str());
}

void UpdateFetcher::UpdateState(std::string const& name, State const state) const
{
    std::string const update = "UPDATE `updates` SET `state`=\'" + AppliedFileEntry::StateConvert(state) + "\' WHERE `name`=\"" + name + "\"";

    // Update database
    _apply(update);
}

bool UpdateFetcher::PathCompare::operator()(LocaleFileEntry const& left, LocaleFileEntry const& right) const
{
    return left.first.filename().string() < right.first.filename().string();
}
