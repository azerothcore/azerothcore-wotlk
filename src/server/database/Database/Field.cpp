/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "Field.h"
#include "Errors.h"
#include "Log.h"
#include "MySQLHacks.h"

Field::Field()
{
    data.value = nullptr;
    data.length = 0;
    data.raw = false;
    meta = nullptr;
}

Field::~Field() = default;

uint8 Field::GetUInt8() const
{
    if (!data.value)
        return 0;

#ifdef ACORE_STRICT_DATABASE_TYPE_CHECKS
    if (!IsType(DatabaseFieldTypes::Int8))
    {
        LogWrongType(__FUNCTION__);
        return 0;
    }
#endif

    if (data.raw)
        return *reinterpret_cast<uint8 const*>(data.value);
    return static_cast<uint8>(strtoul(data.value, nullptr, 10));
}

int8 Field::GetInt8() const
{
    if (!data.value)
        return 0;

#ifdef ACORE_STRICT_DATABASE_TYPE_CHECKS
    if (!IsType(DatabaseFieldTypes::Int8))
    {
        LogWrongType(__FUNCTION__);
        return 0;
    }
#endif

    if (data.raw)
        return *reinterpret_cast<int8 const*>(data.value);
    return static_cast<int8>(strtol(data.value, nullptr, 10));
}

uint16 Field::GetUInt16() const
{
    if (!data.value)
        return 0;

#ifdef ACORE_STRICT_DATABASE_TYPE_CHECKS
    if (!IsType(DatabaseFieldTypes::Int16))
    {
        LogWrongType(__FUNCTION__);
        return 0;
    }
#endif

    if (data.raw)
        return *reinterpret_cast<uint16 const*>(data.value);
    return static_cast<uint16>(strtoul(data.value, nullptr, 10));
}

int16 Field::GetInt16() const
{
    if (!data.value)
        return 0;

#ifdef ACORE_STRICT_DATABASE_TYPE_CHECKS
    if (!IsType(DatabaseFieldTypes::Int16))
    {
        LogWrongType(__FUNCTION__);
        return 0;
    }
#endif

    if (data.raw)
        return *reinterpret_cast<int16 const*>(data.value);
    return static_cast<int16>(strtol(data.value, nullptr, 10));
}

uint32 Field::GetUInt32() const
{
    if (!data.value)
        return 0;

#ifdef ACORE_STRICT_DATABASE_TYPE_CHECKS
    if (!IsType(DatabaseFieldTypes::Int32))
    {
        LogWrongType(__FUNCTION__);
        return 0;
    }
#endif

    if (data.raw)
        return *reinterpret_cast<uint32 const*>(data.value);
    return static_cast<uint32>(strtoul(data.value, nullptr, 10));
}

int32 Field::GetInt32() const
{
    if (!data.value)
        return 0;

#ifdef ACORE_STRICT_DATABASE_TYPE_CHECKS
    if (!IsType(DatabaseFieldTypes::Int32))
    {
        LogWrongType(__FUNCTION__);
        return 0;
    }
#endif

    if (data.raw)
        return *reinterpret_cast<int32 const*>(data.value);
    return static_cast<int32>(strtol(data.value, nullptr, 10));
}

uint64 Field::GetUInt64() const
{
    if (!data.value)
        return 0;

#ifdef ACORE_STRICT_DATABASE_TYPE_CHECKS
    if (!IsType(DatabaseFieldTypes::Int64))
    {
        LogWrongType(__FUNCTION__);
        return 0;
    }
#endif

    if (data.raw)
        return *reinterpret_cast<uint64 const*>(data.value);
    return static_cast<uint64>(strtoull(data.value, nullptr, 10));
}

int64 Field::GetInt64() const
{
    if (!data.value)
        return 0;

#ifdef ACORE_STRICT_DATABASE_TYPE_CHECKS
    if (!IsType(DatabaseFieldTypes::Int64))
    {
        LogWrongType(__FUNCTION__);
        return 0;
    }
#endif

    if (data.raw)
        return *reinterpret_cast<int64 const*>(data.value);
    return static_cast<int64>(strtoll(data.value, nullptr, 10));
}

float Field::GetFloat() const
{
    if (!data.value)
        return 0.0f;

#ifdef ACORE_STRICT_DATABASE_TYPE_CHECKS
    if (!IsType(DatabaseFieldTypes::Float))
    {
        LogWrongType(__FUNCTION__);
        return 0.0f;
    }
#endif

    if (data.raw)
        return *reinterpret_cast<float const*>(data.value);
    return static_cast<float>(atof(data.value));
}

double Field::GetDouble() const
{
    if (!data.value)
        return 0.0f;

#ifdef ACORE_STRICT_DATABASE_TYPE_CHECKS
    if (!IsType(DatabaseFieldTypes::Double) && !IsType(DatabaseFieldTypes::Decimal))
    {
        LogWrongType(__FUNCTION__);
        return 0.0f;
    }
#endif

    if (data.raw && !IsType(DatabaseFieldTypes::Decimal))
        return *reinterpret_cast<double const*>(data.value);
    return static_cast<double>(atof(data.value));
}

char const* Field::GetCString() const
{
    if (!data.value)
        return nullptr;

#ifdef ACORE_STRICT_DATABASE_TYPE_CHECKS
    if (IsNumeric() && data.raw)
    {
        LogWrongType(__FUNCTION__);
        return nullptr;
    }
#endif
    return static_cast<char const*>(data.value);
}

std::string Field::GetString() const
{
    if (!data.value)
        return "";

    char const* string = GetCString();
    if (!string)
        return "";

    return std::string(string, data.length);
}

std::string_view Field::GetStringView() const
{
    if (!data.value)
        return {};

    char const* const string = GetCString();
    if (!string)
        return {};

    return { string, data.length };
}

std::vector<uint8> Field::GetBinary() const
{
    std::vector<uint8> result;
    if (!data.value || !data.length)
        return result;

    result.resize(data.length);
    memcpy(result.data(), data.value, data.length);
    return result;
}

void Field::GetBinarySizeChecked(uint8* buf, size_t length) const
{
    ASSERT(data.value && (data.length == length), "Expected %zu-byte binary blob, got %sdata (%u bytes) instead", length, data.value ? "" : "no ", data.length);
    memcpy(buf, data.value, length);
}

void Field::SetByteValue(char const* newValue, uint32 length)
{
    // This value stores raw bytes that have to be explicitly cast later
    data.value = newValue;
    data.length = length;
    data.raw = true;
}

void Field::SetStructuredValue(char const* newValue, uint32 length)
{
    // This value stores somewhat structured data that needs function style casting
    data.value = newValue;
    data.length = length;
    data.raw = false;
}

bool Field::IsType(DatabaseFieldTypes type) const
{
    return meta->Type == type;
}

bool Field::IsNumeric() const
{
    return (meta->Type == DatabaseFieldTypes::Int8 ||
        meta->Type == DatabaseFieldTypes::Int16 ||
        meta->Type == DatabaseFieldTypes::Int32 ||
        meta->Type == DatabaseFieldTypes::Int64 ||
        meta->Type == DatabaseFieldTypes::Float ||
        meta->Type == DatabaseFieldTypes::Double);
}

void Field::LogWrongType(char const* getter) const
{
    LOG_WARN("sql.sql", "Warning: %s on %s field %s.%s (%s.%s) at index %u.",
        getter, meta->TypeName, meta->TableAlias, meta->Alias, meta->TableName, meta->Name, meta->Index);
}

void Field::SetMetadata(QueryResultFieldMetadata const* fieldMeta)
{
    meta = fieldMeta;
}
