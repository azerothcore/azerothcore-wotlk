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

#ifndef MySQLPreparedStatement_h__
#define MySQLPreparedStatement_h__

#include "DatabaseEnvFwd.h"
#include "MySQLWorkaround.h"
#include <string>
#include <vector>

class MySQLConnection;
class PreparedStatementBase;

//- Class of which the instances are unique per MySQLConnection
//- access to these class objects is only done when a prepared statement task
//- is executed.
class AC_DATABASE_API MySQLPreparedStatement
{
    friend class MySQLConnection;

public:
    MySQLPreparedStatement(MySQLStmt* stmt, std::string_view queryString);
    ~MySQLPreparedStatement();

    void BindParameters(PreparedStatement stmt);

    [[nodiscard]] uint32 GetParameterCount() const { return _paramCount; }

protected:
    void SetParameter(uint8 index, bool value);
    void SetParameter(uint8 index, std::nullptr_t /*value*/);
    void SetParameter(uint8 index, std::string const& value);
    void SetParameter(uint8 index, std::vector<uint8> const& value);

    template<typename T>
    void SetParameter(uint8 index, T value);

    MySQLStmt* GetSTMT() { return _mysqlStmt; }
    MySQLBind* GetBind() { return _bind; }
    PreparedStatement _stmt;
    void ClearParameters();
    void AssertValidIndex(uint8 index);
    [[nodiscard]] std::string getQueryString() const;

private:
    MySQLStmt* _mysqlStmt{ nullptr };
    uint32 _paramCount{};
    std::vector<bool> _paramsSet;
    MySQLBind* _bind{ nullptr };
    std::string _queryString;

    MySQLPreparedStatement(MySQLPreparedStatement const& right) = delete;
    MySQLPreparedStatement& operator=(MySQLPreparedStatement const& right) = delete;
};

#endif // MySQLPreparedStatement_h__
