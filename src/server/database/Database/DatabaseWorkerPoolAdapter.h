#ifndef DATABASE_WORKER_POOL_ADAPTER_H
#define DATABASE_WORKER_POOL_ADAPTER_H

#include "DatabaseWorkerPool.h"
#include "DatabaseUpdatePool.h"

template<class T>
class DatabaseWorkerPoolAdapter : public DatabaseUpdatePool
{
public:
    DatabaseWorkerPoolAdapter(DatabaseWorkerPool<T>& pool) : _pool(pool) {}

    void Execute(std::string const& query) override
    {
        _pool.DirectExecute(query.c_str());
    }

    void DirectExecute(std::string const& query) override
    {
        _pool.DirectExecute(query.c_str());
    }

    QueryResult Query(std::string const& query) override
    {
        return _pool.Query(query.c_str());
    }

    MySQLConnectionInfo const* GetConnectionInfo() const override
    {
        return _pool.GetConnectionInfo();
    }

private:
    DatabaseWorkerPool<T>& _pool;
};

#endif
