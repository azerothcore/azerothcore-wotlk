#ifndef MODULE_DATABASE_POOL_H
#define MODULE_DATABASE_POOL_H

#include "Define.h"
#include "DatabaseUpdatePool.h"
#include "DatabaseEnvFwd.h"
#include "MySQLConnection.h"
#include <string_view>
#include <vector>
#include <memory>

class MySQLConnection;
class MySQLConnectionInfo;

class AC_DATABASE_API ModuleDatabasePool : public DatabaseUpdatePool
{
public:
    ModuleDatabasePool();
    virtual ~ModuleDatabasePool();

    void SetConnectionInfo(std::string_view infoString, uint8 asyncThreads, uint8 synchThreads);
    uint32 Open();
    void Close();

    void Execute(std::string const& sql) override;
    void DirectExecute(std::string const& sql) override;
    QueryResult Query(std::string const& sql) override;
    MySQLConnectionInfo const* GetConnectionInfo() const override;

protected:
    virtual MySQLConnection* CreateConnection(MySQLConnectionInfo& connInfo) = 0;

private:
    MySQLConnection* GetFreeConnection();
    MySQLConnectionInfo _connectionInfo;
    std::vector<std::unique_ptr<MySQLConnection>> _connections;
    uint8 _asyncThreads;
    uint8 _synchThreads;
};

#endif

