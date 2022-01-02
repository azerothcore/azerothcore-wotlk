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

#ifndef _FIELD_H
#define _FIELD_H

#include "DatabaseEnvFwd.h"
#include "Define.h"
#include <array>
#include <string>
#include <string_view>
#include <vector>

enum class DatabaseFieldTypes : uint8
{
    Null,
    Int8,
    Int16,
    Int32,
    Int64,
    Float,
    Double,
    Decimal,
    Date,
    Binary
};

struct QueryResultFieldMetadata
{
    char const* TableName = nullptr;
    char const* TableAlias = nullptr;
    char const* Name = nullptr;
    char const* Alias = nullptr;
    char const* TypeName = nullptr;
    uint32 Index = 0;
    DatabaseFieldTypes Type = DatabaseFieldTypes::Null;
};

/**
    @class Field

    @brief Class used to access individual fields of database query result

    Guideline on field type matching:

    |   MySQL type           |  method to use                         |
    |------------------------|----------------------------------------|
    | TINYINT                | GetBool, GetInt8, GetUInt8             |
    | SMALLINT               | GetInt16, GetUInt16                    |
    | MEDIUMINT, INT         | GetInt32, GetUInt32                    |
    | BIGINT                 | GetInt64, GetUInt64                    |
    | FLOAT                  | GetFloat                               |
    | DOUBLE, DECIMAL        | GetDouble                              |
    | CHAR, VARCHAR,         | GetCString, GetString                  |
    | TINYTEXT, MEDIUMTEXT,  | GetCString, GetString                  |
    | TEXT, LONGTEXT         | GetCString, GetString                  |
    | TINYBLOB, MEDIUMBLOB,  | GetBinary, GetString                   |
    | BLOB, LONGBLOB         | GetBinary, GetString                   |
    | BINARY, VARBINARY      | GetBinary                              |

    Return types of aggregate functions:

    | Function |       Type        |
    |----------|-------------------|
    | MIN, MAX | Same as the field |
    | SUM, AVG | DECIMAL           |
    | COUNT    | BIGINT            |
*/
class AC_DATABASE_API Field
{
friend class ResultSet;
friend class PreparedResultSet;

public:
    Field();
    ~Field();

    [[nodiscard]] auto GetBool() const -> bool // Wrapper, actually gets integer
    {
        return GetUInt8() == 1 ? true : false;
    }

    [[nodiscard]] auto GetUInt8() const -> uint8;
    [[nodiscard]] auto GetInt8() const -> int8;
    [[nodiscard]] auto GetUInt16() const -> uint16;
    [[nodiscard]] auto GetInt16() const -> int16;
    [[nodiscard]] auto GetUInt32() const -> uint32;
    [[nodiscard]] auto GetInt32() const -> int32;
    [[nodiscard]] auto GetUInt64() const -> uint64;
    [[nodiscard]] auto GetInt64() const -> int64;
    [[nodiscard]] auto GetFloat() const -> float;
    [[nodiscard]] auto GetDouble() const -> double;
    [[nodiscard]] auto GetCString() const -> char const*;
    [[nodiscard]] auto GetString() const -> std::string;
    [[nodiscard]] auto GetStringView() const -> std::string_view;
    [[nodiscard]] auto GetBinary() const -> std::vector<uint8>;

    template <size_t S>
    auto GetBinary() const -> std::array<uint8, S>
    {
        std::array<uint8, S> buf;
        GetBinarySizeChecked(buf.data(), S);
        return buf;
    }

    [[nodiscard]] auto IsNull() const -> bool
    {
        return data.value == nullptr;
    }

    auto GetType() -> DatabaseFieldTypes { return meta->Type; }

protected:
    struct
    {
        char const* value;      // Actual data in memory
        uint32 length;          // Length
        bool raw;               // Raw bytes? (Prepared statement or ad hoc)
    } data;

    void SetByteValue(char const* newValue, uint32 length);
    void SetStructuredValue(char const* newValue, uint32 length);
    [[nodiscard]] auto IsType(DatabaseFieldTypes type) const -> bool;
    [[nodiscard]] auto IsNumeric() const -> bool;

private:
    QueryResultFieldMetadata const* meta;
    void LogWrongType(char const* getter) const;
    void SetMetadata(QueryResultFieldMetadata const* fieldMeta);
    void GetBinarySizeChecked(uint8* buf, size_t size) const;
};

#endif
