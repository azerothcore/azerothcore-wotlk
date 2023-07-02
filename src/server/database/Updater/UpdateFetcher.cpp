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
#include "Config.h"
#include "CryptoHash.h"
#include "DBUpdater.h"
#include "Log.h"
#include "StopWatch.h"
#include "Tokenize.h"
#include "Util.h"
#include <filesystem>
#include <fstream>
#include <sstream>
#include <utility>

namespace fs = std::filesystem;

struct UpdateFetcher::DirectoryEntry
{
    DirectoryEntry(Path path_, State state_) : path(std::move(path_)), state(state_) { }

    Path const path;
    State const state;
};

UpdateFetcher::UpdateFetcher(Path const& sourceDirectory,
    std::function<void(std::string_view)> const& apply,
    std::function<void(Path const& path)> const& applyFile,
    std::function<QueryResult(std::string_view)> const& retrieve, std::string_view dbNameForModule, std::vector<std::string> const* setDirectories /*= nullptr*/) :
    _sourceDirectory(std::make_unique<Path>(sourceDirectory)), _apply(apply), _applyFile(applyFile),
    _retrieve(retrieve), _dbModuleName(dbNameForModule), _setDirectories(setDirectories)
{
}

UpdateFetcher::UpdateFetcher(Path const& sourceDirectory,
    std::function<void(std::string_view)> const& apply,
    std::function<void(Path const& path)> const& applyFile,
    std::function<QueryResult(std::string_view)> const& retrieve,
    std::string_view dbNameForModule,
    std::string_view modulesList /*= {}*/) :
    _sourceDirectory(std::make_unique<Path>(sourceDirectory)), _apply(apply), _applyFile(applyFile),
    _retrieve(retrieve), _dbModuleName(dbNameForModule), _setDirectories(nullptr), _modulesList(modulesList)
{
}

UpdateFetcher::LocaleFileStorage UpdateFetcher::GetFileList() const
{
    DirectoryStorage directories = ReceiveIncludedDirectories();
    if (directories.empty())
    {
        LOG_ERROR("db.update", "> Not found all includes directory. Try reapply `updates_include`");

        fs::path updateFile = *_sourceDirectory;
        updateFile /= "data";
        updateFile /= "sql";
        updateFile /= "base";
        updateFile /= _dbModuleName;
        updateFile /= "updates_include.sql";

        _applyFile(updateFile);

        directories = ReceiveIncludedDirectories();
        if (directories.empty())
            ABORT("Can't find all includes directory");
        else
            LOG_INFO("db.update", "> Successful restored includes directory");
    }

    LocaleFileStorage files;

    for (auto const& entry : directories)
        FillFileListRecursively(entry.path, files, entry.state, 1);

    return files;
}

void UpdateFetcher::FillFileListRecursively(Path const& path, LocaleFileStorage& storage, State const state, uint32 const /*depth*/)
{
    for (auto const& dirEntry : fs::recursive_directory_iterator(path))
    {
        auto const& dirPath = dirEntry.path();
        if (!dirPath.has_extension() || dirPath.extension() != ".sql")
            continue;

        LOG_TRACE("db.update", "Added locale file \"{}\" state '{}'.", dirPath.filename().generic_string(), AppliedFileEntry::StateConvert(state));

        LocaleFileEntry const entry = {dirPath, state };

        // Check for doubled filenames
        // Because elements are only compared by their filenames, this is ok
        if (storage.find(entry) != storage.end())
        {
            LOG_FATAL("db.update", "Duplicate filename \"{}\" occurred. Because updates are ordered " \
                "by their filenames, every name needs to be unique!", dirPath.generic_string());

            throw UpdateException("Updating failed, see the log for details.");
        }

        storage.emplace(entry);
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
            if (!fs::is_directory(p))
                continue;

            DirectoryEntry const entry = {p, AppliedFileEntry::StateConvert("MODULE")};
            directories.push_back(entry);

            LOG_TRACE("db.update", "Added applied extra file \"{}\" from remote.", p.filename().generic_string());
        }

        return directories;
    }

    QueryResult const result = _retrieve("SELECT `path`, `state` FROM `updates_include`");
    if (!result)
        return directories;

    for (auto& resultSet : *result)
    {
        auto [path, state] = resultSet.FetchTuple<std::string, std::string>();

        if (path.substr(0, 1) == "$")
            path = _sourceDirectory->generic_string() + path.substr(1);

        Path const p(path);
        if (!fs::is_directory(p))
        {
            LOG_WARN("db.update", "DBUpdater: Given update include directory \"{}\" does not exist, skipped!", p.generic_string());
            continue;
        }

        DirectoryEntry const entry = { p, AppliedFileEntry::StateConvert(state) };
        directories.push_back(entry);

        LOG_TRACE("db.update", "Added applied file \"{}\" '{}' state from remote.", p.filename().generic_string(), state);
    }

    if (directories.empty() || _modulesList.empty())
        return directories;

    std::vector<std::string> moduleList;

    for (auto const& itr : Acore::Tokenize(_modulesList, ',', true))
        moduleList.emplace_back(itr);

    // data/sql
    for (auto const& name : moduleList)
    {
        Path moduleDir{ *_sourceDirectory };
        moduleDir /= "modules";
        moduleDir /= name;
        moduleDir /= "sql";

        // Skip check if not exist sql dir in module
        if (!is_directory(moduleDir))
            continue;

        moduleDir /= _dbModuleName; // modules/mod-name/sql/db-world

        if (!fs::is_directory(moduleDir))
            continue;

        DirectoryEntry const entry = { moduleDir, MODULE };
        directories.emplace_back(entry);

        LOG_TRACE("db.update", "Added applied modules file \"{}\" from remote.", moduleDir.filename().generic_string());
    }

    return directories;
}

UpdateFetcher::AppliedFileStorage UpdateFetcher::ReceiveAppliedFiles() const
{
    AppliedFileStorage map;

    QueryResult result = _retrieve("SELECT `name`, `hash`, `state`, UNIX_TIMESTAMP(`timestamp`) FROM `updates` ORDER BY `name` ASC");
    if (!result)
        return map;

    for (auto& resultSet : *result)
    {
        auto const& [name, hash, state, timestamp] = resultSet.FetchTuple<std::string_view, std::string_view, std::string_view, uint64>();
        AppliedFileEntry entry{ name, hash, AppliedFileEntry::StateConvert(state), timestamp };
        map.emplace(entry.name, entry);
    }

    return map;
}

std::string UpdateFetcher::ReadSQLUpdate(Path const& file)
{
    std::ifstream in(file.c_str());
    if (!in.is_open())
    {
        LOG_FATAL("db.update", "Failed to open the sql update \"{}\" for reading! "
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

UpdateResult UpdateFetcher::Update() const
{
    auto const cleanDeadReferencesMaxCount = sConfigMgr->GetOption<int32>("Updates.CleanDeadRefMaxCount", 3);

    LocaleFileStorage const available = GetFileList();
    if (_setDirectories && available.empty())
        return {};

    AppliedFileStorage applied = ReceiveAppliedFiles();

    size_t countRecentUpdates = 0;
    size_t countArchivedUpdates = 0;

    // Count updates
    for (auto const& entry : applied)
        if (entry.second.state == RELEASED)
            ++countRecentUpdates;
        else
            ++countArchivedUpdates;

    // Fill hash to name cache
    HashToFileNameStorage hashToName;
    for (const auto& entry : applied)
        hashToName.emplace(entry.second.hash, entry.first);

    size_t importedUpdates = 0;

    auto ApplyUpdateFile = [this, &applied, &hashToName, &available, &importedUpdates](Path const& filePath, State const fileState)
    {
        bool const redundancyChecks = sConfigMgr->GetOption<bool>("Updates.Redundancy", true);
        bool const allowRehash = sConfigMgr->GetOption<bool>("Updates.AllowRehash", true);
        bool const archivedRedundancy = sConfigMgr->GetOption<bool>("Updates.ArchivedRedundancy", false);

        auto const& iter = applied.find(filePath.filename().string());
        if (iter != applied.end())
        {
            // If redundancy is disabled, skip it, because the update is already applied.
            if (!redundancyChecks)
            {
                applied.erase(iter);
                return;
            }

            // If the update is in an archived directory and is marked as archived in our database, skip redundancy checks (archived updates never change).
            if (!archivedRedundancy && (iter->second.state == ARCHIVED) && (fileState == ARCHIVED))
            {
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
            auto const& hashIter = hashToName.find(hash);
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
                    LOG_WARN("db.update", ">> It seems like the update \"{}\" \'{}\' was renamed, but the old file is still there! " \
                             "Treating it as a new file! (It is probably an unmodified copy of the file \"{}\")",
                             filePath.filename().string(), hash.substr(0, 7), localeIter->first.filename().string());
                }
                else // It is safe to treat the file as renamed here
                {
                    LOG_INFO("db.update", ">> Renaming update \"{}\" to \"{}\" \'{}\'.",
                             hashIter->second, filePath.filename().string(), hash.substr(0, 7));

                    RenameEntry(hashIter->second, filePath.filename().string());
                    applied.erase(hashIter->second);
                    return;
                }
            }
            else
            {
                LOG_INFO("db.update", ">> Applying update \"{}\" \'{}\'...", filePath.filename().string(), hash.substr(0, 7));
            }

        }
        // Rehash the update entry if it exists in our database with an empty hash.
        else if (allowRehash && iter->second.hash.empty())
        {
            mode = MODE_REHASH;
            LOG_INFO("db.update", ">> Re-hashing update \"{}\" \'{}\'...", filePath.filename().string(), hash.substr(0, 7));
        }
        else
        {
            // If the hash of the files differs from the one stored in our database, reapply the update (because it changed).
            if (iter->second.hash != hash)
            {
                LOG_INFO("db.update", ">> Reapplying update \"{}\" \'{}\' -> \'{}\' (it changed)...",
                    filePath.filename().string(), iter->second.hash.substr(0, 7), hash.substr(0, 7));
            }
            else
            {
                // If the file wasn't changed and just moved, update its state (if necessary).
                if (iter->second.state != fileState)
                    UpdateState(filePath.filename().string(), fileState);

                applied.erase(iter);
                return;
            }
        }

        Milliseconds speed{};
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
    for (auto const& [path, state] : available)
    {
        if (state == RELEASED || state == ARCHIVED)
        {
            ApplyUpdateFile(path, state);
        }
    }

    // Apply only custom updates
    for (auto const& [path, state] : available)
    {
        if (state == CUSTOM)
        {
            ApplyUpdateFile(path, state);
        }
    }

    // Apply only module updates
    for (auto const& [path, state] : available)
    {
        if (state == MODULE)
        {
            ApplyUpdateFile(path, state);
        }
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
                LOG_WARN("db.update", ">> The file \'{}\' was applied to the database, but is missing in your update directory now!",
                    entry.first);

                if (doCleanup)
                {
                    LOG_INFO("db.update", "Deleting orphaned entry \'{}\'...", entry.first);
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
                LOG_ERROR("db.update", "Cleanup is disabled! There were {} dirty files applied to your database, "
                    "but they are now missing in your source directory!", toCleanup.size());
            }
        }
    }

    return UpdateResult{ importedUpdates, countRecentUpdates, countArchivedUpdates };
}

Milliseconds UpdateFetcher::Apply(Path const& path) const
{
    StopWatch sw;

    // Update database
    _applyFile(path);

    // Return the time it took the query to apply
    return Milliseconds{ sw.Elapsed().count() / 1000 };
}

void UpdateFetcher::UpdateEntry(AppliedFileEntry const& entry, Milliseconds speed) const
{
    auto update = Acore::StringFormatFmt("REPLACE INTO `updates` (`name`, `hash`, `state`, `speed`) VALUES ('{}', '{}', '{}', '{}')",
        entry.name, entry.hash, entry.GetStateAsString(), speed.count());

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
