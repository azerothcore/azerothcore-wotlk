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

#include "DBCDatabaseLoader.h"
#include "DatabaseEnv.h"
#include "Errors.h"
#include "Log.h"
#include "QueryResult.h"
#include "StringFormat.h"
#include <cstring>
#include <limits>

namespace
{
    // Anything above this is a negative ID stored in a signed column
    constexpr uint32 MAX_DBC_INDEX = std::numeric_limits<int32>::max();
}

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
    if (indexPos >= 0)
        _sqlIndexPos = indexPos;

    ASSERT(_recordSize);
}

char* DBCDatabaseLoader::Load(uint32& records, char**& indexTable)
{
    std::string query = Acore::StringFormat("SELECT * FROM `{}` ORDER BY `ID` DESC", _sqlTableName);

    // no error if empty set
    QueryResult result = WorldDatabase.Query(query);
    if (!result)
        return nullptr;

    // Check if sql index pos is valid
    if (int32(result->GetFieldCount() - 1) < _sqlIndexPos)
    {
        ASSERT(false, "Invalid index pos for dbc: '{}'", _sqlTableName);
        return nullptr;
    }

    // Negative IDs sort last, so this only skips rows when every ID is invalid
    // database query *MUST* contain ORDER BY `index_field` DESC clause
    while ((*result)[_sqlIndexPos].Get<uint32>() > MAX_DBC_INDEX)
    {
        LOG_ERROR("server.loading", "Table `{}` has a row with invalid ID {}, skipped.",
            _sqlTableName, int32((*result)[_sqlIndexPos].Get<uint32>()));

        if (!result->NextRow())
            return nullptr;
    }

    // Resize index table
    uint32 indexTableSize = std::max(records, (*result)[_sqlIndexPos].Get<uint32>() + 1);
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
        uint32 indexValue = fields[_sqlIndexPos].Get<uint32>();
        if (indexValue > MAX_DBC_INDEX)
        {
            LOG_ERROR("server.loading", "Table `{}` has a row with invalid ID {}, skipped.",
                _sqlTableName, int32(indexValue));
            continue;
        }

        char* oldDataValue = indexTable[indexValue];

        // If exist in DBC file override from DB
        newIndexes[newRecords] = indexValue;
        char* dataValue = &dataTable[newRecords++ * _recordSize];

        uint32 dataOffset = 0;
        uint32 sqlColumnNumber = 0;
        uint32 nullWithoutDbcValue = 0;
        char const* dbcFormat = _dbcFormat;

        for (; (*dbcFormat); ++dbcFormat)
        {
            // a NULL column means "not overridden": keep the value loaded from the DBC file.
            // Without a DBC record to fall back on, NULL reads as 0.
            bool const keepDbcValue = oldDataValue && fields[sqlColumnNumber].IsNull();

            switch (*dbcFormat)
            {
                case FT_FLOAT:
                    if (keepDbcValue)
                        memcpy(&dataValue[dataOffset], &oldDataValue[dataOffset], sizeof(float));
                    else if (fields[sqlColumnNumber].IsNull()) // Field::Get<float>() returns 1.0f on NULL
                        *reinterpret_cast<float*>(&dataValue[dataOffset]) = 0.0f;
                    else
                        *reinterpret_cast<float*>(&dataValue[dataOffset]) = fields[sqlColumnNumber].Get<float>();

                    if (!oldDataValue && fields[sqlColumnNumber].IsNull())
                        ++nullWithoutDbcValue;

                    dataOffset += sizeof(float);
                    break;
                case FT_IND:
                case FT_INT:
                    if (keepDbcValue)
                        memcpy(&dataValue[dataOffset], &oldDataValue[dataOffset], sizeof(uint32));
                    else
                        *reinterpret_cast<uint32*>(&dataValue[dataOffset]) = fields[sqlColumnNumber].Get<uint32>();

                    if (!oldDataValue && fields[sqlColumnNumber].IsNull())
                        ++nullWithoutDbcValue;

                    dataOffset += sizeof(uint32);
                    break;
                case FT_BYTE:
                    if (keepDbcValue)
                        memcpy(&dataValue[dataOffset], &oldDataValue[dataOffset], sizeof(uint8));
                    else
                        *reinterpret_cast<uint8*>(&dataValue[dataOffset]) = fields[sqlColumnNumber].Get<uint8>();

                    if (!oldDataValue && fields[sqlColumnNumber].IsNull())
                        ++nullWithoutDbcValue;

                    dataOffset += sizeof(uint8);
                    break;
                case FT_STRING:
                    // NULL strings are expected in new records, do not count them
                    // an empty column means "not overridden", not "blank it"
                    if (fields[sqlColumnNumber].Get<std::string>().empty() && oldDataValue)
                        *reinterpret_cast<char**>(&dataValue[dataOffset]) = *reinterpret_cast<char**>(&oldDataValue[dataOffset]);
                    else
                        *reinterpret_cast<char**>(&dataValue[dataOffset]) = CloneStringToPool(fields[sqlColumnNumber].Get<std::string>());

                    dataOffset += sizeof(char*);
                    break;
                case FT_SORT:
                case FT_NA:
                case FT_NA_BYTE:
                    break;
                default:
                    ASSERT(false, "Unsupported data type '{}' in table '{}'", *dbcFormat, _sqlTableName);
                    return nullptr;
            }

            ++sqlColumnNumber;
        }

        ASSERT(sqlColumnNumber == result->GetFieldCount(), "SQL format string does not match database for table: '{}'", _sqlTableName);
        ASSERT(dataOffset == _recordSize);

        // valid for a new record, but also how a partial override with a wrong ID shows up
        if (nullWithoutDbcValue)
            LOG_DEBUG("server.loading", "Table `{}` ID {} has no DBC record, {} NULL column(s) loaded as 0.",
                _sqlTableName, indexValue, nullWithoutDbcValue);
    } while (result->NextRow());

    ASSERT(newRecords <= result->GetRowCount());

    // insert new records to index table
    for (uint32 i = 0; i < newRecords; ++i)
    {
        // cppcheck-suppress autoVariables
        indexTable[newIndexes[i]] = &dataTable[i * _recordSize];
    }

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
