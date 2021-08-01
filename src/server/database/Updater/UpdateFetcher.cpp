/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "UpdateFetcher.h"
#include "CryptoHash.h"
#include "DBUpdater.h"
#include "Field.h"
#include "Log.h"
#include "QueryResult.h"
#include "Tokenize.h"
#include "Util.h"
#include <sstream>
#include <fstream>

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
                             std::function<QueryResult(std::string const&)> const& retrieve, std::string const& dbModuleName_) :
    _sourceDirectory(std::make_unique<Path>(sourceDirectory)), _apply(apply), _applyFile(applyFile),
    _retrieve(retrieve), _dbModuleName(dbModuleName_)
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
            LOG_TRACE("sql.updates", "Added locale file \"%s\" state '%s'.", itr->path().filename().generic_string().c_str(), AppliedFileEntry::StateConvert(state).c_str());

            LocaleFileEntry const entry = { itr->path(), state };

            // Check for doubled filenames
            // Because elements are only compared by their filenames, this is ok
            if (storage.find(entry) != storage.end())
            {
                LOG_FATAL("sql.updates", "Duplicate filename \"%s\" occurred. Because updates are ordered " \
                          "by their filenames, every name needs to be unique!", itr->path().generic_string().c_str());

                throw UpdateException("Updating failed, see the log for details.");
            }

            storage.insert(entry);
        }
    }
}

UpdateFetcher::DirectoryStorage UpdateFetcher::ReceiveIncludedDirectories() const
{
    DirectoryStorage directories;

    QueryResult const result = _retrieve("SELECT `path`, `state` FROM `updates_include`");
    if (!result)
        return directories;

    do
    {
        Field* fields = result->Fetch();

        std::string path = fields[0].GetString();
        std::string state = fields[1].GetString();
        if (path.substr(0, 1) == "$")
            path = _sourceDirectory->generic_string() + path.substr(1);

        Path const p(path);

        if (!is_directory(p))
        {
            LOG_WARN("sql.updates", "DBUpdater: Given update include directory \"%s\" does not exist, skipped!", p.generic_string().c_str());
            continue;
        }

        DirectoryEntry const entry = { p, AppliedFileEntry::StateConvert(state) };
        directories.push_back(entry);

        LOG_TRACE("sql.updates", "Added applied file \"%s\" '%s' state from remote.", p.filename().generic_string().c_str(), state.c_str());

    } while (result->NextRow());

    std::vector<std::string> moduleList;

    auto const& _modulesTokens = Acore::Tokenize(AC_MODULES_LIST, ',', true);
    for (auto const& itr : _modulesTokens)
        moduleList.emplace_back(itr);

    // data/sql
    for (auto const& itr : moduleList)
    {
        std::string path = _sourceDirectory->generic_string() + "/modules/" + itr + "/data/sql/" + _dbModuleName; // modules/mod-name/data/sql/db-world

        Path const p(path);
        if (!is_directory(p))
            continue;

        DirectoryEntry const entry = { p, AppliedFileEntry::StateConvert("CUSTOM") };
        directories.push_back(entry);

        LOG_TRACE("sql.updates", "Added applied modules file \"%s\" from remote.", p.filename().generic_string().c_str());
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
            fields[0].GetString(), fields[1].GetString(), AppliedFileEntry::StateConvert(fields[2].GetString()), fields[3].GetUInt64()
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
        LOG_FATAL("sql.updates", "Failed to open the sql update \"%s\" for reading! "
                  "Stopping the server to keep the database integrity, "
                  "try to identify and solve the issue or disable the database updater.",
                  file.generic_string().c_str());

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
    for (auto entry : applied)
        hashToName.insert(std::make_pair(entry.second.hash, entry.first));

    size_t importedUpdates = 0;

    auto ApplyUpdateFile = [&](LocaleFileEntry const& sqlFile)
    {
        auto filePath = sqlFile.first;
        auto fileState = sqlFile.second;

        LOG_DEBUG("sql.updates", "Checking update \"%s\"...", filePath.filename().generic_string().c_str());

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
                    LOG_WARN("sql.updates", ">> It seems like the update \"%s\" \'%s\' was renamed, but the old file is still there! " \
                             "Treating it as a new file! (It is probably an unmodified copy of the file \"%s\")",
                             filePath.filename().string().c_str(), hash.substr(0, 7).c_str(),
                             localeIter->first.filename().string().c_str());
                }
                else // It is safe to treat the file as renamed here
                {
                    LOG_INFO("sql.updates", ">> Renaming update \"%s\" to \"%s\" \'%s\'.",
                             hashIter->second.c_str(), filePath.filename().string().c_str(), hash.substr(0, 7).c_str());

                    RenameEntry(hashIter->second, filePath.filename().string());
                    applied.erase(hashIter->second);
                    return;
                }
            }
            // Apply the update if it was never seen before.
            else
            {
                LOG_INFO("sql.updates", ">> Applying update \"%s\" \'%s\'...",
                    filePath.filename().string().c_str(), hash.substr(0, 7).c_str());
            }
        }
        // Rehash the update entry if it exists in our database with an empty hash.
        else if (allowRehash && iter->second.hash.empty())
        {
            mode = MODE_REHASH;

            LOG_INFO("sql.updates", ">> Re-hashing update \"%s\" \'%s\'...", filePath.filename().string().c_str(),
                hash.substr(0, 7).c_str());
        }
        else
        {
            // If the hash of the files differs from the one stored in our database, reapply the update (because it changed).
            if (iter->second.hash != hash)
            {
                LOG_INFO("sql.updates", ">> Reapplying update \"%s\" \'%s\' -> \'%s\' (it changed)...", filePath.filename().string().c_str(),
                    iter->second.hash.substr(0, 7).c_str(), hash.substr(0, 7).c_str());
            }
            else
            {
                // If the file wasn't changed and just moved, update its state (if necessary).
                if (iter->second.state != fileState)
                {
                    LOG_DEBUG("sql.updates", ">> Updating the state of \"%s\" to \'%s\'...",
                              filePath.filename().string().c_str(), AppliedFileEntry::StateConvert(fileState).c_str());

                    UpdateState(filePath.filename().string(), fileState);
                }

                LOG_DEBUG("sql.updates", ">> Update is already applied and matches the hash \'%s\'.", hash.substr(0, 7).c_str());

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
            /* fallthrough */
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
        if (availableQuery.second != CUSTOM)
            ApplyUpdateFile(availableQuery);
    }

    // Apply only custom updates
    for (auto const& availableQuery : available)
    {
        if (availableQuery.second == CUSTOM)
            ApplyUpdateFile(availableQuery);
    }

    // Cleanup up orphaned entries (if enabled)
    if (!applied.empty())
    {
        bool const doCleanup = (cleanDeadReferencesMaxCount < 0) || (applied.size() <= static_cast<size_t>(cleanDeadReferencesMaxCount));

        for (auto const& entry : applied)
        {
            LOG_WARN("sql.updates", ">> The file \'%s\' was applied to the database, but is missing in" \
                     " your update directory now!", entry.first.c_str());

            if (doCleanup)
                LOG_INFO("sql.updates", "Deleting orphaned entry \'%s\'...", entry.first.c_str());
        }

        if (doCleanup)
            CleanUp(applied);
        else
        {
            LOG_ERROR("sql.updates", "Cleanup is disabled! There were  " SZFMTD " dirty files applied to your database, " \
                      "but they are now missing in your source directory!", applied.size());
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
    size_t remaining = storage.size();

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
