/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "DatabaseEnv.h"
#include "Log.h"

static uint32 SizeForType(MYSQL_FIELD* field)
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
            sLog->outSQLDriver("SQL::SizeForType(): invalid field type %u", uint32(field->type));
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
            sLog->outSQLDriver("MysqlTypeToFieldType(): invalid field type %u", uint32(type));
            break;
    }

    return DatabaseFieldTypes::Null;
}

ResultSet::ResultSet(MySQLResult* result, MySQLField* fields, uint64 rowCount, uint32 fieldCount) :
_rowCount(rowCount),
_fieldCount(fieldCount),
_result(result),
_fields(fields)
{
    _currentRow = new Field[_fieldCount];
    ASSERT(_currentRow);
}

PreparedResultSet::PreparedResultSet(MySQLStmt* stmt, MySQLResult* result, uint64 rowCount, uint32 fieldCount) :
m_rowCount(rowCount),
m_rowPosition(0),
m_fieldCount(fieldCount),
m_rBind(nullptr),
m_stmt(stmt),
m_metadataResult(result)
{
    if (!m_metadataResult)
        return;

    if (m_stmt->bind_result_done)
    {
        delete[] m_stmt->bind->length;
        delete[] m_stmt->bind->is_null;
    }

    m_rBind = new MYSQL_BIND[m_fieldCount];
    MySQLBool* m_isNull = new MySQLBool[m_fieldCount];
    unsigned long* m_length = new unsigned long[m_fieldCount];

    memset(m_isNull, 0, sizeof(MySQLBool) * m_fieldCount);
    memset(m_rBind, 0, sizeof(MySQLBind) * m_fieldCount);
    memset(m_length, 0, sizeof(unsigned long) * m_fieldCount);

    //- This is where we store the (entire) resultset
    if (mysql_stmt_store_result(m_stmt))
    {
        sLog->outSQLDriver("%s:mysql_stmt_store_result, cannot bind result from MySQL server. Error: %s", __FUNCTION__, mysql_stmt_error(m_stmt));
        delete[] m_rBind;
        delete[] m_isNull;
        delete[] m_length;
        return;
    }

    m_rowCount = mysql_stmt_num_rows(m_stmt);

    //- This is where we prepare the buffer based on metadata
    MySQLField* field = reinterpret_cast<MySQLField*>(mysql_fetch_fields(m_metadataResult));
    std::size_t rowSize = 0;
    for (uint32 i = 0; i < m_fieldCount; ++i)
    {
        uint32 size = SizeForType(&field[i]);
        rowSize += size;

        m_rBind[i].buffer_type = field[i].type;
        m_rBind[i].buffer_length = size;
        m_rBind[i].length = &m_length[i];
        m_rBind[i].is_null = &m_isNull[i];
        m_rBind[i].error = nullptr;
        m_rBind[i].is_unsigned = field[i].flags & UNSIGNED_FLAG;
    }

    char* dataBuffer = new char[rowSize * m_rowCount];
    for (uint32 i = 0, offset = 0; i < m_fieldCount; ++i)
    {
        m_rBind[i].buffer = dataBuffer + offset;
        offset += m_rBind[i].buffer_length;
    }

    //- This is where we bind the bind the buffer to the statement
    if (mysql_stmt_bind_result(m_stmt, m_rBind))
    {
        sLog->outSQLDriver("%s:mysql_stmt_bind_result, cannot bind result from MySQL server. Error: %s", __FUNCTION__, mysql_stmt_error(m_stmt));
        mysql_stmt_free_result(m_stmt);
        CleanUp();
        delete[] m_isNull;
        delete[] m_length;
        return;
    }

    m_rows.resize(uint32(m_rowCount) * m_fieldCount);
    while (_NextRow())
    {
        for (uint32 fIndex = 0; fIndex < m_fieldCount; ++fIndex)
        {
            unsigned long buffer_length = m_rBind[fIndex].buffer_length;
            unsigned long fetched_length = *m_rBind[fIndex].length;
            if (!*m_rBind[fIndex].is_null)
            {
                void* buffer = m_stmt->bind[fIndex].buffer;
                switch (m_rBind[fIndex].buffer_type)
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
                        // TODO: remove Field::GetCString and use boost::string_ref (currently proposed for TS as string_view, maybe in C++17)
                        if (fetched_length < buffer_length)
                            *((char*)buffer + fetched_length) = '\0';
                        break;
                    default:
                        break;
                }

                m_rows[uint32(m_rowPosition) * m_fieldCount + fIndex].SetByteValue(
                    buffer,
                    MysqlTypeToFieldType(m_rBind[fIndex].buffer_type),
                    fetched_length);

                // move buffer pointer to next part
                m_stmt->bind[fIndex].buffer = (char*)buffer + rowSize;
            }
            else
            {
                m_rows[uint32(m_rowPosition) * m_fieldCount + fIndex].SetByteValue(
                    nullptr,
                    MysqlTypeToFieldType(m_rBind[fIndex].buffer_type),
                    *m_rBind[fIndex].length);
            }
        }
        m_rowPosition++;
    }
    m_rowPosition = 0;

    /// All data is buffered, let go of mysql c api structures
    mysql_stmt_free_result(m_stmt);
}

ResultSet::~ResultSet()
{
    CleanUp();
}

PreparedResultSet::~PreparedResultSet()
{
    CleanUp();
}

bool ResultSet::NextRow()
{
    MYSQL_ROW row;

    if (!_result)
        return false;

    row = mysql_fetch_row(_result);
    if (!row)
    {
        CleanUp();
        return false;
    }

    for (uint32 i = 0; i < _fieldCount; i++)
        _currentRow[i].SetStructuredValue(row[i], _fields[i].type);

    return true;
}

bool PreparedResultSet::NextRow()
{
    /// Only updates the m_rowPosition so upper level code knows in which element
    /// of the rows vector to look
    if (++m_rowPosition >= m_rowCount)
        return false;

    return true;
}

bool PreparedResultSet::_NextRow()
{
    /// Only called in low-level code, namely the constructor
    /// Will iterate over every row of data and buffer it
    if (m_rowPosition >= m_rowCount)
        return false;

    int retval = mysql_stmt_fetch( m_stmt );

    if (!retval || retval == MYSQL_DATA_TRUNCATED)
        retval = true;

    if (retval == MYSQL_NO_DATA)
        retval = false;

    return retval;
}

#ifdef ELUNA
char* ResultSet::GetFieldName(uint32 index) const
{
    ASSERT(index < _fieldCount);
    return _fields[index].name;
}
#endif

void ResultSet::CleanUp()
{
    if (_currentRow)
    {
        delete [] _currentRow;
        _currentRow = NULL;
    }

    if (_result)
    {
        mysql_free_result(_result);
        _result = NULL;
    }
}

void PreparedResultSet::CleanUp()
{
    /// More of the in our code allocated sources are deallocated by the poorly documented mysql c api
    if (m_res)
        mysql_free_result(m_res);

    FreeBindBuffer();
    mysql_stmt_free_result(m_stmt);

    delete[] m_rBind;
}

void PreparedResultSet::FreeBindBuffer()
{
    for (uint32 i = 0; i < m_fieldCount; ++i)
        free (m_rBind[i].buffer);
}
