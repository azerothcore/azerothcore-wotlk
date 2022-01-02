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

#ifndef QUERYRESULT_H
#define QUERYRESULT_H

#include "DatabaseEnvFwd.h"
#include "Define.h"
#include <vector>

class AC_DATABASE_API ResultSet
{
public:
    ResultSet(MySQLResult* result, MySQLField* fields, uint64 rowCount, uint32 fieldCount);
    ~ResultSet();

    auto NextRow() -> bool;
    [[nodiscard]] auto GetRowCount() const -> uint64 { return _rowCount; }
    [[nodiscard]] auto GetFieldCount() const -> uint32 { return _fieldCount; }
    [[nodiscard]] auto GetFieldName(uint32 index) const -> std::string;

    [[nodiscard]] auto Fetch() const -> Field* { return _currentRow; }
    auto operator[](std::size_t index) const -> Field const&;

protected:
    std::vector<QueryResultFieldMetadata> _fieldMetadata;
    uint64 _rowCount;
    Field* _currentRow;
    uint32 _fieldCount;

private:
    void CleanUp();
    MySQLResult* _result;
    MySQLField* _fields;

    ResultSet(ResultSet const& right) = delete;
    auto operator=(ResultSet const& right) -> ResultSet& = delete;
};

class AC_DATABASE_API PreparedResultSet
{
public:
    PreparedResultSet(MySQLStmt* stmt, MySQLResult* result, uint64 rowCount, uint32 fieldCount);
    ~PreparedResultSet();

    auto NextRow() -> bool;
    [[nodiscard]] auto GetRowCount() const -> uint64 { return m_rowCount; }
    [[nodiscard]] auto GetFieldCount() const -> uint32 { return m_fieldCount; }

    [[nodiscard]] auto Fetch() const -> Field*;
    auto operator[](std::size_t index) const -> Field const&;

protected:
    std::vector<QueryResultFieldMetadata> m_fieldMetadata;
    std::vector<Field> m_rows;
    uint64 m_rowCount;
    uint64 m_rowPosition;
    uint32 m_fieldCount;

private:
    MySQLBind* m_rBind;
    MySQLStmt* m_stmt;
    MySQLResult* m_metadataResult;    ///< Field metadata, returned by mysql_stmt_result_metadata

    void CleanUp();
    auto _NextRow() -> bool;

    PreparedResultSet(PreparedResultSet const& right) = delete;
    auto operator=(PreparedResultSet const& right) -> PreparedResultSet& = delete;
};

#endif
