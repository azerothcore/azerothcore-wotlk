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

#ifndef DBCFILE_H
#define DBCFILE_H
#include <cassert>
#include <string>

// cppcheck-suppress ctuOneDefinitionRuleViolation
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
    class Iterator; // cppcheck-suppress ctuOneDefinitionRuleViolation
    class Record // cppcheck-suppress ctuOneDefinitionRuleViolation
    {
    public:
        [[nodiscard]] float getFloat(std::size_t field) const
        {
            assert(field < file.fieldCount);
            return *reinterpret_cast<float*>(offset + field * 4);
        }
        [[nodiscard]] unsigned int getUInt(std::size_t field) const
        {
            assert(field < file.fieldCount);
            return *reinterpret_cast<unsigned int*>(offset + field * 4);
        }
        [[nodiscard]] int getInt(std::size_t field) const
        {
            assert(field < file.fieldCount);
            return *reinterpret_cast<int*>(offset + field * 4);
        }
        [[nodiscard]] const char* getString(std::size_t field) const
        {
            assert(field < file.fieldCount);
            std::size_t stringOffset = getUInt(field);
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
    Record getRecord(std::size_t id);
    /// Get begin iterator over records
    Iterator begin();
    /// Get begin iterator over records
    Iterator end();
    /// Trivial
    [[nodiscard]] std::size_t getRecordCount() const { return recordCount;}
    [[nodiscard]] std::size_t getFieldCount() const { return fieldCount; }
    std::size_t getMaxId();
private:
    std::string filename;
    std::size_t recordSize;
    std::size_t recordCount;
    std::size_t fieldCount;
    std::size_t stringSize;
    unsigned char* data;
    unsigned char* stringTable;
};

#endif
