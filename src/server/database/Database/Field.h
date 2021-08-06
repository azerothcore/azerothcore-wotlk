/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
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

    bool GetBool() const // Wrapper, actually gets integer
    {
        return GetUInt8() == 1 ? true : false;
    }

    uint8 GetUInt8() const;
    int8 GetInt8() const;
    uint16 GetUInt16() const;
    int16 GetInt16() const;
    uint32 GetUInt32() const;
    int32 GetInt32() const;
    uint64 GetUInt64() const;
    int64 GetInt64() const;
    float GetFloat() const;
    double GetDouble() const;
    char const* GetCString() const;
    std::string GetString() const;
    std::string_view GetStringView() const;
    std::vector<uint8> GetBinary() const;

    template <size_t S>
    std::array<uint8, S> GetBinary() const
    {
        std::array<uint8, S> buf;
        GetBinarySizeChecked(buf.data(), S);
        return buf;
    }

    bool IsNull() const
    {
        return data.value == nullptr;
    }

    DatabaseFieldTypes GetType() { return meta->Type; }

protected:
    struct
    {
        char const* value;      // Actual data in memory
        uint32 length;          // Length
        bool raw;               // Raw bytes? (Prepared statement or ad hoc)
    } data;

    void SetByteValue(char const* newValue, uint32 length);
    void SetStructuredValue(char const* newValue, uint32 length);
    bool IsType(DatabaseFieldTypes type) const;
    bool IsNumeric() const;

private:
    QueryResultFieldMetadata const* meta;
    void LogWrongType(char const* getter) const;
    void SetMetadata(QueryResultFieldMetadata const* fieldMeta);
    void GetBinarySizeChecked(uint8* buf, size_t size) const;
};

#endif
