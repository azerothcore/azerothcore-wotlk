/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef DBCFILE_H
#define DBCFILE_H
#include <cassert>
#include <string>
#include <utility>

class DBCFile
{
public:
    DBCFile(std::string  filename);
    ~DBCFile();

    // Open database. It must be openened before it can be used.
    bool open();

    // Database exceptions
    class Exception
    {
    public:
        Exception(std::string  message): message(std::move(message))
        { }
        virtual ~Exception() = default;
        const std::string& getMessage() {return message;}
    private:
        std::string message;
    };
    class NotFound: public Exception
    {
    public:
        NotFound(): Exception("Key was not found")
        { }
    };
    // Iteration over database
    class Iterator;
    class Record
    {
    public:
        [[nodiscard]] float getFloat(size_t field) const
        {
            assert(field < file.fieldCount);
            return *reinterpret_cast<float*>(offset + field * 4);
        }
        [[nodiscard]] unsigned int getUInt(size_t field) const
        {
            assert(field < file.fieldCount);
            return *reinterpret_cast<unsigned int*>(offset + field * 4);
        }
        [[nodiscard]] int getInt(size_t field) const
        {
            assert(field < file.fieldCount);
            return *reinterpret_cast<int*>(offset + field * 4);
        }
        [[nodiscard]] const char* getString(size_t field) const
        {
            assert(field < file.fieldCount);
            size_t stringOffset = getUInt(field);
            assert(stringOffset < file.stringSize);
            return reinterpret_cast<char*>(file.stringTable + stringOffset);
        }
    private:
        Record(DBCFile& file, unsigned char* offset): file(file), offset(offset) {}
        DBCFile& file;
        unsigned char* offset;

        friend class DBCFile;
        friend class DBCFile::Iterator;
    };
    /** Iterator that iterates over records
    */
    class Iterator
    {
    public:
        Iterator(DBCFile& file, unsigned char* offset):
            record(file, offset) {}
        /// Advance (prefix only)
        Iterator& operator++()
        {
            record.offset += record.file.recordSize;
            return *this;
        }
        /// Return address of current instance
        Record const& operator*() const { return record; }
        const Record* operator->() const
        {
            return &record;
        }
        /// Comparison
        bool operator==(const Iterator& b) const
        {
            return record.offset == b.record.offset;
        }
        bool operator!=(const Iterator& b) const
        {
            return record.offset != b.record.offset;
        }
    private:
        Record record;
    };

    // Get record by id
    Record getRecord(size_t id);
    /// Get begin iterator over records
    Iterator begin();
    /// Get begin iterator over records
    Iterator end();
    /// Trivial
    [[nodiscard]] size_t getRecordCount() const { return recordCount;}
    [[nodiscard]] size_t getFieldCount() const { return fieldCount; }
    size_t getMaxId();
private:
    std::string filename;
    size_t recordSize;
    size_t recordCount;
    size_t fieldCount;
    size_t stringSize;
    unsigned char* data;
    unsigned char* stringTable;
};

#endif
