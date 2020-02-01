/*
* Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
* Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
* Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
*/

#include "Field.h"
#include "Log.h"

Field::Field()
{
    data.value = nullptr;
    data.type = DatabaseFieldTypes::Null;
    data.length = 0;
    data.raw = false;
}

Field::~Field()
{
    CleanUp();
}

uint8 Field::GetUInt8() const
{
    if (!data.value)
        return 0;

    if (data.raw)
        return *reinterpret_cast<uint8*>(data.value);
    return static_cast<uint8>(strtoul((char*)data.value, nullptr, 10));
}

int8 Field::GetInt8() const
{
    if (!data.value)
        return 0;

    if (data.raw)
        return *reinterpret_cast<int8*>(data.value);
    return static_cast<int8>(strtol((char*)data.value, nullptr, 10));
}

uint16 Field::GetUInt16() const
{
    if (!data.value)
        return 0;

    if (data.raw)
        return *reinterpret_cast<uint16*>(data.value);
    return static_cast<uint16>(strtoul((char*)data.value, nullptr, 10));
}

int16 Field::GetInt16() const
{
    if (!data.value)
        return 0;

    if (data.raw)
        return *reinterpret_cast<int16*>(data.value);
    return static_cast<int16>(strtol((char*)data.value, nullptr, 10));
}

uint32 Field::GetUInt32() const
{
    if (!data.value)
        return 0;

    if (data.raw)
        return *reinterpret_cast<uint32*>(data.value);
    return static_cast<uint32>(strtoul((char*)data.value, nullptr, 10));
}

int32 Field::GetInt32() const
{
    if (!data.value)
        return 0;

    if (data.raw)
        return *reinterpret_cast<int32*>(data.value);
    return static_cast<int32>(strtol((char*)data.value, nullptr, 10));
}

uint64 Field::GetUInt64() const
{
    if (!data.value)
        return 0;

    if (data.raw)
        return *reinterpret_cast<uint64*>(data.value);
    return static_cast<uint64>(strtoull((char*)data.value, nullptr, 10));
}

int64 Field::GetInt64() const
{
    if (!data.value)
        return 0;

    if (data.raw)
        return *reinterpret_cast<int64*>(data.value);
    return static_cast<int64>(strtoll((char*)data.value, nullptr, 10));
}

float Field::GetFloat() const
{
    if (!data.value)
        return 0.0f;

    if (data.raw)
        return *reinterpret_cast<float*>(data.value);
    return static_cast<float>(atof((char*)data.value));
}

double Field::GetDouble() const
{
    if (!data.value)
        return 0.0f;

    if (data.raw && !IsType(DatabaseFieldTypes::Decimal))
        return *reinterpret_cast<double*>(data.value);
    return static_cast<double>(atof((char*)data.value));
}

char const* Field::GetCString() const
{
    if (!data.value)
        return nullptr;

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

std::vector<uint8> Field::GetBinary() const
{
    std::vector<uint8> result;
    if (!data.value || !data.length)
        return result;

    result.resize(data.length);
    memcpy(result.data(), data.value, data.length);
    return result;
}

void Field::SetByteValue(void* newValue, DatabaseFieldTypes newType, uint32 length)
{
    // This value stores raw bytes that have to be explicitly cast later
    data.value = newValue;
    data.length = length;
    data.type = newType;
    data.raw = true;
}

void Field::SetStructuredValue(char* newValue, DatabaseFieldTypes newType, uint32 length)
{
    if (data.value)
        CleanUp();

    // This value stores somewhat structured data that needs function style casting
    if (newValue)
    {
        data.value = new char[length + 1];
        memcpy(data.value, newValue, length);
        *(reinterpret_cast<char*>(data.value) + length) = '\0';
        data.length = length;
    }

    data.type = newType;
    data.raw = false;
}

bool Field::IsType(DatabaseFieldTypes type) const
{
    return data.type == type;
}

bool Field::IsNumeric() const
{
    return (data.type == DatabaseFieldTypes::Int8 ||
        data.type == DatabaseFieldTypes::Int16 ||
        data.type == DatabaseFieldTypes::Int32 ||
        data.type == DatabaseFieldTypes::Int64 ||
        data.type == DatabaseFieldTypes::Float ||
        data.type == DatabaseFieldTypes::Double);
}

