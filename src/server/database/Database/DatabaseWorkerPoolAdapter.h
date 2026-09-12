/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef DATABASE_WORKER_POOL_ADAPTER_H
#define DATABASE_WORKER_POOL_ADAPTER_H

#include "DatabaseUpdatePool.h"
#include "DatabaseWorkerPool.h"

template <class T>
class DatabaseWorkerPoolAdapter : public DatabaseUpdatePool
{
public:
    DatabaseWorkerPoolAdapter(DatabaseWorkerPool<T>& pool) : _pool(pool) {}

    void DirectExecute(std::string_view query) override
    {
        _pool.DirectExecute(query);
    }

    QueryResult Query(std::string_view query) override
    {
        return _pool.Query(query);
    }

    MySQLConnectionInfo const* GetConnectionInfo() const override
    {
        return _pool.GetConnectionInfo();
    }

private:
    DatabaseWorkerPool<T>& _pool;
};

#endif
