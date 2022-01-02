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

#ifndef DBC_FILE_LOADER_H
#define DBC_FILE_LOADER_H

#include "Define.h"
#include "Errors.h"
#include "Utilities/ByteConverter.h"

enum DbcFieldFormat
{
    FT_NA = 'x',                                              //not used or unknown, 4 byte size
    FT_NA_BYTE = 'X',                                         //not used or unknown, byte
    FT_STRING = 's',                                          //char*
    FT_FLOAT = 'f',                                           //float
    FT_INT = 'i',                                             //uint32
    FT_BYTE = 'b',                                            //uint8
    FT_SORT = 'd',                                            //sorted by this field, field is not included
    FT_IND = 'n',                                             //the same, but parsed to data
    FT_LOGIC = 'l'                                           //Logical (boolean)
};

class DBCFileLoader
{
public:
    DBCFileLoader();
    ~DBCFileLoader();

    auto Load(const char* filename, const char* fmt) -> bool;

    class Record
    {
    public:
        [[nodiscard]] auto getFloat(size_t field) const -> float
        {
            ASSERT(field < file.fieldCount);
            float val = *reinterpret_cast<float*>(offset + file.GetOffset(field));
            EndianConvert(val);
            return val;
        }

        [[nodiscard]] auto getUInt(size_t field) const -> uint32
        {
            ASSERT(field < file.fieldCount);
            uint32 val = *reinterpret_cast<uint32*>(offset + file.GetOffset(field));
            EndianConvert(val);
            return val;
        }

        [[nodiscard]] auto getUInt8(size_t field) const -> uint8
        {
            ASSERT(field < file.fieldCount);
            return *reinterpret_cast<uint8*>(offset + file.GetOffset(field));
        }

        [[nodiscard]] auto getString(size_t field) const -> const char*
        {
            ASSERT(field < file.fieldCount);
            size_t stringOffset = getUInt(field);
            ASSERT(stringOffset < file.stringSize);
            return reinterpret_cast<char*>(file.stringTable + stringOffset);
        }

    private:
        Record(DBCFileLoader& file_, unsigned char* offset_): offset(offset_), file(file_) { }
        unsigned char* offset;
        DBCFileLoader& file;

        friend class DBCFileLoader;
    };

    // Get record by id
    auto getRecord(size_t id) -> Record;

    [[nodiscard]] auto GetNumRows() const -> uint32 { return recordCount; }
    [[nodiscard]] auto GetRowSize() const -> uint32 { return recordSize; }
    [[nodiscard]] auto GetCols() const -> uint32 { return fieldCount; }
    [[nodiscard]] auto GetOffset(size_t id) const -> uint32 { return (fieldsOffset != nullptr && id < fieldCount) ? fieldsOffset[id] : 0; }
    [[nodiscard]] auto IsLoaded() const -> bool { return data != nullptr; }
    auto AutoProduceData(char const* fmt, uint32& count, char**& indexTable) -> char*;
    auto AutoProduceStrings(char const* fmt, char* dataTable) -> char*;
    static auto GetFormatRecordSize(const char* format, int32* index_pos = nullptr) -> uint32;

private:
    uint32 recordSize;
    uint32 recordCount;
    uint32 fieldCount;
    uint32 stringSize;
    uint32* fieldsOffset;
    unsigned char* data;
    unsigned char* stringTable;

    DBCFileLoader(DBCFileLoader const& right) = delete;
    auto operator=(DBCFileLoader const& right) -> DBCFileLoader& = delete;
};

#endif
