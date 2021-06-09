/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#ifndef DBUpdater_h__
#define DBUpdater_h__

#include "DatabaseEnv.h"
#include "Define.h"
#include <string>

template <class T>
class DatabaseWorkerPool;

namespace boost
{
    namespace filesystem
    {
        class path;
    }
}

class AC_DATABASE_API UpdateException : public std::exception
{
public:
    UpdateException(std::string const& msg) : _msg(msg) { }
    ~UpdateException() throw() { }

    char const* what() const throw() override { return _msg.c_str(); }

private:
    std::string const _msg;
};

enum BaseLocation
{
    LOCATION_REPOSITORY,
    LOCATION_DOWNLOAD
};

class AC_DATABASE_API DBUpdaterUtil
{
public:
    static std::string GetCorrectedMySQLExecutable();

    static bool CheckExecutable();

private:
    static std::string& corrected_path();
};

template <class T>
class AC_DATABASE_API DBUpdater
{
public:
    using Path = boost::filesystem::path;

    static inline std::string GetConfigEntry();
    static inline std::string GetTableName();
    static std::string GetBaseFilesDirectory();
    static bool IsEnabled(uint32 const updateMask);
    static BaseLocation GetBaseLocationType();
    static bool Create(DatabaseWorkerPool<T>& pool);
    static bool Update(DatabaseWorkerPool<T>& pool);
    static bool Populate(DatabaseWorkerPool<T>& pool);

    // module
    static std::string GetDBModuleName();

private:
    static QueryResult Retrieve(DatabaseWorkerPool<T>& pool, std::string const& query);
    static void Apply(DatabaseWorkerPool<T>& pool, std::string const& query);
    static void ApplyFile(DatabaseWorkerPool<T>& pool, Path const& path);
    static void ApplyFile(DatabaseWorkerPool<T>& pool, std::string const& host, std::string const& user,
                          std::string const& password, std::string const& port_or_socket, std::string const& database, std::string const& ssl, Path const& path);
};

#endif // DBUpdater_h__
