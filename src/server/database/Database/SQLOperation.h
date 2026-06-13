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

#ifndef _SQLOPERATION_H
#define _SQLOPERATION_H

#include "DatabaseEnvFwd.h"
#include "Define.h"
#include <variant>

//- Type specifier of our element data
enum SQLElementDataType
{
    SQL_ELEMENT_RAW,
    SQL_ELEMENT_PREPARED
};

//- The element
struct SQLElementData
{
    std::variant<PreparedStatementBase*, std::string> element;
    SQLElementDataType type;
};

class MySQLConnection;

class AC_DATABASE_API SQLOperation
{
public:
    SQLOperation() = default;
    virtual ~SQLOperation() = default;

    virtual int call()
    {
        Execute();
        return 0;
    }

    virtual bool Execute() = 0;
    virtual void SetConnection(MySQLConnection* con) { m_conn = con; }

    MySQLConnection* m_conn{nullptr};

private:
    SQLOperation(SQLOperation const& right) = delete;
    SQLOperation& operator=(SQLOperation const& right) = delete;
};

#endif
