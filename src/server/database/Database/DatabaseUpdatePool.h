#ifndef DATABASE_UPDATE_POOL_H
#define DATABASE_UPDATE_POOL_H

#include "Define.h"
#include "MySQLConnection.h"
#include "QueryResult.h"

struct AC_DATABASE_API DatabaseUpdatePool
{
    virtual ~DatabaseUpdatePool() = default;

    virtual void Execute(std::string const& query) = 0;
    virtual void DirectExecute(std::string const& query) = 0;
    virtual QueryResult Query(std::string const& query) = 0;
    virtual MySQLConnectionInfo const* GetConnectionInfo() const = 0;
};

#endif
