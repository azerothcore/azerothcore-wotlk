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

#include "QueryResult.h"
#include "Errors.h"
#include "Log.h"
#include "MySQLHacks.h"

namespace
{
    uint32 SizeForType(MYSQL_FIELD* field)
    {
        switch (field->type)
        {
            case MYSQL_TYPE_NULL:
                return 0;
            case MYSQL_TYPE_TINY:
                return 1;
            case MYSQL_TYPE_YEAR:
            case MYSQL_TYPE_SHORT:
                return 2;
            case MYSQL_TYPE_INT24:
            case MYSQL_TYPE_LONG:
            case MYSQL_TYPE_FLOAT:
                return 4;
            case MYSQL_TYPE_DOUBLE:
            case MYSQL_TYPE_LONGLONG:
            case MYSQL_TYPE_BIT:
                return 8;

            case MYSQL_TYPE_TIMESTAMP:
            case MYSQL_TYPE_DATE:
            case MYSQL_TYPE_TIME:
            case MYSQL_TYPE_DATETIME:
                return sizeof(MYSQL_TIME);

            case MYSQL_TYPE_TINY_BLOB:
            case MYSQL_TYPE_MEDIUM_BLOB:
            case MYSQL_TYPE_LONG_BLOB:
            case MYSQL_TYPE_BLOB:
            case MYSQL_TYPE_STRING:
            case MYSQL_TYPE_VAR_STRING:
                return field->max_length + 1;

            case MYSQL_TYPE_DECIMAL:
            case MYSQL_TYPE_NEWDECIMAL:
                return 64;

            case MYSQL_TYPE_GEOMETRY:
                /*
                Following types are not sent over the wire:
                MYSQL_TYPE_ENUM:
                MYSQL_TYPE_SET:
                */
            default:
                LOG_WARN("db.query", "SQL::SizeForType(): invalid field type {}", uint32(field->type));
                return 0;
        }
    }

    DatabaseFieldTypes MysqlTypeToFieldType(enum_field_types type)
    {
        switch (type)
        {
            case MYSQL_TYPE_NULL:
                return DatabaseFieldTypes::Null;
            case MYSQL_TYPE_TINY:
                return DatabaseFieldTypes::Int8;
            case MYSQL_TYPE_YEAR:
            case MYSQL_TYPE_SHORT:
                return DatabaseFieldTypes::Int16;
            case MYSQL_TYPE_INT24:
            case MYSQL_TYPE_LONG:
                return DatabaseFieldTypes::Int32;
            case MYSQL_TYPE_LONGLONG:
            case MYSQL_TYPE_BIT:
                return DatabaseFieldTypes::Int64;
            case MYSQL_TYPE_FLOAT:
                return DatabaseFieldTypes::Float;
            case MYSQL_TYPE_DOUBLE:
                return DatabaseFieldTypes::Double;
            case MYSQL_TYPE_DECIMAL:
            case MYSQL_TYPE_NEWDECIMAL:
                return DatabaseFieldTypes::Decimal;
            case MYSQL_TYPE_TIMESTAMP:
            case MYSQL_TYPE_DATE:
            case MYSQL_TYPE_TIME:
            case MYSQL_TYPE_DATETIME:
                return DatabaseFieldTypes::Date;
            case MYSQL_TYPE_TINY_BLOB:
            case MYSQL_TYPE_MEDIUM_BLOB:
            case MYSQL_TYPE_LONG_BLOB:
            case MYSQL_TYPE_BLOB:
            case MYSQL_TYPE_STRING:
            case MYSQL_TYPE_VAR_STRING:
                return DatabaseFieldTypes::Binary;
            default:
                LOG_WARN("db.query", "MysqlTypeToFieldType(): invalid field type {}", uint32(type));
                break;
        }

        return DatabaseFieldTypes::Null;
    }

    std::string FieldTypeToString(enum_field_types type)
    {
        switch (type)
        {
            case MYSQL_TYPE_BIT:         return "BIT";
            case MYSQL_TYPE_BLOB:        return "BLOB";
            case MYSQL_TYPE_DATE:        return "DATE";
            case MYSQL_TYPE_DATETIME:    return "DATETIME";
            case MYSQL_TYPE_NEWDECIMAL:  return "NEWDECIMAL";
            case MYSQL_TYPE_DECIMAL:     return "DECIMAL";
            case MYSQL_TYPE_DOUBLE:      return "DOUBLE";
            case MYSQL_TYPE_ENUM:        return "ENUM";
            case MYSQL_TYPE_FLOAT:       return "FLOAT";
            case MYSQL_TYPE_GEOMETRY:    return "GEOMETRY";
            case MYSQL_TYPE_INT24:       return "INT24";
            case MYSQL_TYPE_LONG:        return "LONG";
            case MYSQL_TYPE_LONGLONG:    return "LONGLONG";
            case MYSQL_TYPE_LONG_BLOB:   return "LONG_BLOB";
            case MYSQL_TYPE_MEDIUM_BLOB: return "MEDIUM_BLOB";
            case MYSQL_TYPE_NEWDATE:     return "NEWDATE";
            case MYSQL_TYPE_NULL:        return "NULL";
            case MYSQL_TYPE_SET:         return "SET";
            case MYSQL_TYPE_SHORT:       return "SHORT";
            case MYSQL_TYPE_STRING:      return "STRING";
            case MYSQL_TYPE_TIME:        return "TIME";
            case MYSQL_TYPE_TIMESTAMP:   return "TIMESTAMP";
            case MYSQL_TYPE_TINY:        return "TINY";
            case MYSQL_TYPE_TINY_BLOB:   return "TINY_BLOB";
            case MYSQL_TYPE_VAR_STRING:  return "VAR_STRING";
            case MYSQL_TYPE_YEAR:        return "YEAR";
            default:                     return "-Unknown-";
        }
    }

    void InitializeDatabaseFieldMetadata(QueryResultFieldMetadata* meta, MySQLField const* field, uint32 fieldIndex)
    {
        meta->TableName = field->org_table;
        meta->TableAlias = field->table;
        meta->Name = field->org_name;
        meta->Alias = field->name;
        meta->TypeName = FieldTypeToString(field->type);
        meta->Index = fieldIndex;
        meta->Type = MysqlTypeToFieldType(field->type);
    }
}

ResultSet::ResultSet(MySQLResult* result, MySQLField* fields, uint64 rowCount, uint32 fieldCount) :
    _rowCount(rowCount),
    _fieldCount(fieldCount),
    _result(result),
    _fields(fields)
{
    _fieldMetadata.resize(_fieldCount);
    _currRow = std::make_unique<Field[]>(_fieldCount);

    for (uint32 i = 0; i < _fieldCount; i++)
    {
        InitializeDatabaseFieldMetadata(&_fieldMetadata[i], &_fields[i], i);
        _currRow[i].SetMetadata(&_fieldMetadata[i]);
    }
}

ResultSet::~ResultSet()
{
    CleanUp();
}

bool ResultSet::NextRow()
{
    if (!_result)
        return false;

    auto row = mysql_fetch_row(_result);
    if (!row)
    {
        CleanUp();
        return false;
    }

    unsigned long* lengths = mysql_fetch_lengths(_result);
    if (!lengths)
    {
        LOG_WARN("db.query", "{}:mysql_fetch_lengths, cannot retrieve value lengths. Error {}.", __FUNCTION__, mysql_error(_result->handle));
        CleanUp();
        return false;
    }

    for (uint32 i = 0; i < _fieldCount; i++)
        _currRow[i].SetStructuredValue(row[i], lengths[i]);

    return true;
}

std::string ResultSet::GetFieldName(uint32 index) const
{
    ASSERT(index < _fieldCount);
    return _fields[index].name;
}

void ResultSet::CleanUp()
{
    if (_result)
    {
        mysql_free_result(_result);
        _result = nullptr;
    }
}

Field const& ResultSet::operator[](std::size_t index) const
{
    ASSERT(index < _fieldCount);
    return _currRow[index];
}

void ResultSet::AssertRows(std::size_t sizeRows) const
{
    ASSERT(sizeRows == _fieldCount);
}

PreparedResultSet::PreparedResultSet(MySQLStmt* stmt, MySQLResult* result, uint64 rowCount, uint32 fieldCount) :
    _rowCount(rowCount),
    _fieldCount(fieldCount),
    _stmt(stmt),
    _metadataResult(result)
{
    if (!_metadataResult)
        return;

    if (_stmt->bind_result_done)
    {
        delete[] _stmt->bind->length;
        delete[] _stmt->bind->is_null;
    }

    _rBind = new MySQLBind[_fieldCount];

    //- for future readers wondering where this is freed - mysql_stmt_bind_result moves pointers to these
    // from m_rBind to m_stmt->bind and it is later freed by the `if (m_stmt->bind_result_done)` block just above here
    // MYSQL_STMT lifetime is equal to connection lifetime
    auto* isNull = new MySQLBool[_fieldCount];
    auto* length = new unsigned long[_fieldCount];

    memset(isNull, 0, sizeof(MySQLBool) * _fieldCount);
    memset(_rBind, 0, sizeof(MySQLBind) * _fieldCount);
    memset(length, 0, sizeof(unsigned long) * _fieldCount);

    //- This is where we store the (entire) resultset
    if (mysql_stmt_store_result(_stmt))
    {
        LOG_WARN("db.query", "{}:mysql_stmt_store_result, cannot bind result from MySQL server. Error: {}", __FUNCTION__, mysql_stmt_error(_stmt));
        delete[] _rBind;
        delete[] isNull;
        delete[] length;
        return;
    }

    _rowCount = mysql_stmt_num_rows(_stmt);

    //- This is where we prepare the buffer based on metadata
    auto* field = reinterpret_cast<MySQLField*>(mysql_fetch_fields(_metadataResult));
    _fieldMetadata.resize(_fieldCount);
    std::size_t rowSize = 0;

    for (uint32 i = 0; i < _fieldCount; ++i)
    {
        uint32 size = SizeForType(&field[i]);
        rowSize += size;

        InitializeDatabaseFieldMetadata(&_fieldMetadata[i], &field[i], i);

        _rBind[i].buffer_type = field[i].type;
        _rBind[i].buffer_length = size;
        _rBind[i].length = &length[i];
        _rBind[i].is_null = &isNull[i];
        _rBind[i].error = nullptr;
        _rBind[i].is_unsigned = field[i].flags & UNSIGNED_FLAG;
    }

    char* dataBuffer = new char[rowSize * _rowCount];
    for (uint32 i = 0, offset = 0; i < _fieldCount; ++i)
    {
        _rBind[i].buffer = dataBuffer + offset;
        offset += _rBind[i].buffer_length;
    }

    //- This is where we bind the bind the buffer to the statement
    if (mysql_stmt_bind_result(_stmt, _rBind))
    {
        LOG_WARN("db.query", "{}:mysql_stmt_bind_result, cannot bind result from MySQL server. Error: {}", __FUNCTION__, mysql_stmt_error(_stmt));
        mysql_stmt_free_result(_stmt);
        CleanUp();
        delete[] isNull;
        delete[] length;
        return;
    }

    _rows.resize(uint32(_rowCount) * _fieldCount);

    while (_NextRow())
    {
        for (uint32 fIndex = 0; fIndex < _fieldCount; ++fIndex)
        {
            _rows[uint32(_rowPosition) * _fieldCount + fIndex].SetMetadata(&_fieldMetadata[fIndex]);

            unsigned long buffer_length = _rBind[fIndex].buffer_length;
            unsigned long fetched_length = *_rBind[fIndex].length;
            if (!*_rBind[fIndex].is_null)
            {
                void* buffer = _stmt->bind[fIndex].buffer;
                switch (_rBind[fIndex].buffer_type)
                {
                    case MYSQL_TYPE_TINY_BLOB:
                    case MYSQL_TYPE_MEDIUM_BLOB:
                    case MYSQL_TYPE_LONG_BLOB:
                    case MYSQL_TYPE_BLOB:
                    case MYSQL_TYPE_STRING:
                    case MYSQL_TYPE_VAR_STRING:
                        // warning - the string will not be null-terminated if there is no space for it in the buffer
                        // when mysql_stmt_fetch returned MYSQL_DATA_TRUNCATED
                        // we cannot blindly null-terminate the data either as it may be retrieved as binary blob and not specifically a string
                        // in this case using Field::GetCString will result in garbage
                        // TODO: remove Field::GetCString and use std::string_view in C++17
                        if (fetched_length < buffer_length)
                            *((char*)buffer + fetched_length) = '\0';
                        break;
                    default:
                        break;
                }

                _rows[uint32(_rowPosition) * _fieldCount + fIndex].SetByteValue((char const*)buffer, fetched_length);

                // move buffer pointer to next part
                _stmt->bind[fIndex].buffer = (char*)buffer + rowSize;
            }
            else
            {
                _rows[uint32(_rowPosition) * _fieldCount + fIndex].SetByteValue(nullptr, *_rBind[fIndex].length);
            }
        }

        _rowPosition++;
    }

    _rowPosition = 0;

    /// All data is buffered, let go of mysql c api structures
    mysql_stmt_free_result(_stmt);
}

PreparedResultSet::~PreparedResultSet()
{
    CleanUp();
}

bool PreparedResultSet::NextRow()
{
    /// Only updates the m_rowPosition so upper level code knows in which element
    /// of the rows vector to look
    if (++_rowPosition >= _rowCount)
        return false;

    return true;
}

bool PreparedResultSet::_NextRow()
{
    /// Only called in low-level code, namely the constructor
    /// Will iterate over every row of data and buffer it
    if (_rowPosition >= _rowCount)
        return false;

    int mysqlStmtFetch = mysql_stmt_fetch(_stmt);
    return mysqlStmtFetch == 0 || mysqlStmtFetch == MYSQL_DATA_TRUNCATED;
}

Field* PreparedResultSet::Fetch() const
{
    ASSERT(_rowPosition < _rowCount);
    return const_cast<Field*>(&_rows[uint32(_rowPosition) * _fieldCount]);
}

Field const& PreparedResultSet::operator[](std::size_t index) const
{
    ASSERT(_rowPosition < _rowCount);
    ASSERT(index < _fieldCount);
    return _rows[uint32(_rowPosition) * _fieldCount + index];
}

void PreparedResultSet::CleanUp()
{
    if (_metadataResult)
        mysql_free_result(_metadataResult);

    if (_rBind)
    {
        delete[] (char*)_rBind->buffer;
        delete[] _rBind;
        _rBind = nullptr;
    }
}

void PreparedResultSet::AssertRows(std::size_t sizeRows) const
{
    ASSERT(_rowPosition < _rowCount);
    ASSERT(sizeRows == _fieldCount, "> Tuple size != count fields");
}
