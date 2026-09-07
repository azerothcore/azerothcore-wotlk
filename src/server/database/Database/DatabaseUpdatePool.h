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

#ifndef DATABASE_UPDATE_POOL_H
#define DATABASE_UPDATE_POOL_H

#include "Define.h"
#include "MySQLConnection.h"
#include "QueryResult.h"
#include <string_view>

// Minimal pool interface the DB updater operates on. Core pools reach it through
// DatabaseWorkerPoolAdapter; modules can implement it directly (see ModuleDatabasePool).
struct AC_DATABASE_API DatabaseUpdatePool
{
    virtual ~DatabaseUpdatePool() = default;

    virtual void Execute(std::string_view query) = 0;
    virtual void DirectExecute(std::string_view query) = 0;
    virtual QueryResult Query(std::string_view query) = 0;
    virtual MySQLConnectionInfo const* GetConnectionInfo() const = 0;
};

#endif
