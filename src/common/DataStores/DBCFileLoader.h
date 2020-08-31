/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2020 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
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

    bool Load(const char *filename, const char *fmt);

    class Record
    {
    public:
        float getFloat(size_t field) const
        {
            ASSERT(field < file.fieldCount);
            float val = *reinterpret_cast<float*>(offset+file.GetOffset(field));
            EndianConvert(val);
            return val;
        }

        uint32 getUInt(size_t field) const
        {
            ASSERT(field < file.fieldCount);
            uint32 val = *reinterpret_cast<uint32*>(offset+file.GetOffset(field));
            EndianConvert(val);
            return val;
        }

        uint8 getUInt8(size_t field) const
        {
            ASSERT(field < file.fieldCount);
            return *reinterpret_cast<uint8*>(offset+file.GetOffset(field));
        }

        const char *getString(size_t field) const
        {
            ASSERT(field < file.fieldCount);
            size_t stringOffset = getUInt(field);
            ASSERT(stringOffset < file.stringSize);
            return reinterpret_cast<char*>(file.stringTable + stringOffset);
        }

    private:
        Record(DBCFileLoader &file_, unsigned char *offset_): offset(offset_), file(file_) { }
        unsigned char *offset;
        DBCFileLoader &file;

        friend class DBCFileLoader;

    };

    // Get record by id
    Record getRecord(size_t id);

    uint32 GetNumRows() const { return recordCount; }
    uint32 GetRowSize() const { return recordSize; }
    uint32 GetCols() const { return fieldCount; }
    uint32 GetOffset(size_t id) const { return (fieldsOffset != nullptr && id < fieldCount) ? fieldsOffset[id] : 0; }
    bool IsLoaded() const { return data != nullptr; }
    char* AutoProduceData(char const* fmt, uint32& count, char**& indexTable);
    char* AutoProduceStrings(char const* fmt, char* dataTable);
    static uint32 GetFormatRecordSize(const char * format, int32 * index_pos = nullptr);

private:
    uint32 recordSize;
    uint32 recordCount;
    uint32 fieldCount;
    uint32 stringSize;
    uint32 *fieldsOffset;
    unsigned char *data;
    unsigned char *stringTable;

    DBCFileLoader(DBCFileLoader const& right) = delete;
    DBCFileLoader& operator=(DBCFileLoader const& right) = delete;
};

#endif
