/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2020 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "DatabaseEnv.h"
#include "DBCDatabaseLoader.h"
#include "Errors.h"
#include "StringFormat.h"

DBCDatabaseLoader::DBCDatabaseLoader(char const* tableName, char const* dbcFormatString, std::vector<char*>& stringPool)
    : _sqlTableName(tableName),
      _dbcFormat(dbcFormatString),
      _sqlIndexPos(0),
      _recordSize(0),
      _stringPool(stringPool)
{
    // Get sql index position
    int32 indexPos = -1;
    _recordSize = DBCFileLoader::GetFormatRecordSize(_dbcFormat, &indexPos);

    ASSERT(_recordSize);
}

char* DBCDatabaseLoader::Load(uint32& records, char**& indexTable)
{
    std::string query = Acore::StringFormat("SELECT * FROM `%s` ORDER BY `ID` DESC", _sqlTableName);

    // no error if empty set
    QueryResult result = WorldDatabase.Query(query.c_str());
    if (!result)
        return nullptr;

    // Check if sql index pos is valid
    if (int32(result->GetFieldCount() - 1) < _sqlIndexPos)
    {
        ASSERT(false, "Invalid index pos for dbc: '%s'", _sqlTableName);
        return nullptr;
    }

    // Resize index table
    // database query *MUST* contain ORDER BY `index_field` DESC clause
    uint32 indexTableSize = std::max(records, (*result)[_sqlIndexPos].GetUInt32() + 1);
    if (indexTableSize > records)
    {
        char** tmpIdxTable = new char* [indexTableSize];
        memset(tmpIdxTable, 0, indexTableSize * sizeof(char*));
        memcpy(tmpIdxTable, indexTable, records * sizeof(char*));
        delete[] indexTable;
        indexTable = tmpIdxTable;
    }

    std::unique_ptr<char[]> dataTable = std::make_unique<char[]>(result->GetRowCount() * _recordSize);
    std::unique_ptr<uint32[]> newIndexes = std::make_unique<uint32[]>(result->GetRowCount());
    uint32 newRecords = 0;

    // Insert sql data into the data array
    do
    {
        Field* fields = result->Fetch();
        uint32 indexValue = fields[_sqlIndexPos].GetUInt32();
        char* dataValue = indexTable[indexValue];

        // If exist in DBC file override from DB
        newIndexes[newRecords] = indexValue;
        dataValue = &dataTable[newRecords++ * _recordSize];

        uint32 dataOffset = 0;
        uint32 sqlColumnNumber = 0;
        char const* dbcFormat = _dbcFormat;

        for (; (*dbcFormat); ++dbcFormat)
        {
            switch (*dbcFormat)
            {
                case FT_FLOAT:
                    *reinterpret_cast<float*>(&dataValue[dataOffset]) = fields[sqlColumnNumber].GetFloat();
                    dataOffset += sizeof(float);
                    break;
                case FT_IND:
                case FT_INT:
                    *reinterpret_cast<uint32*>(&dataValue[dataOffset]) = fields[sqlColumnNumber].GetUInt32();
                    dataOffset += sizeof(uint32);
                    break;
                case FT_BYTE:
                    *reinterpret_cast<uint8*>(&dataValue[dataOffset]) = fields[sqlColumnNumber].GetUInt8();
                    dataOffset += sizeof(uint8);
                    break;
                case FT_STRING:
                    *reinterpret_cast<char**>(&dataValue[dataOffset]) = CloneStringToPool(fields[sqlColumnNumber].GetString());
                    dataOffset += sizeof(char*);
                    break;
                case FT_SORT:
                case FT_NA:
                    break;
                default:
                    ASSERT(false, "Unsupported data type '%c' in table '%s'", *dbcFormat, _sqlTableName);
                    return nullptr;
            }

            ++sqlColumnNumber;
        }

        ASSERT(sqlColumnNumber == result->GetFieldCount(), "SQL format string does not match database for table: '%s'", _sqlTableName);
        ASSERT(dataOffset == _recordSize);
    } while (result->NextRow());

    ASSERT(newRecords == result->GetRowCount());

    // insert new records to index table
    for (uint32 i = 0; i < newRecords; ++i)
        indexTable[newIndexes[i]] = &dataTable[i * _recordSize];

    records = indexTableSize;

    return dataTable.release();
}

char* DBCDatabaseLoader::CloneStringToPool(std::string const& str)
{
    char* buf = new char[str.size() + 1];
    memcpy(buf, str.c_str(), str.size() + 1);
    _stringPool.push_back(buf);
    return buf;
}
