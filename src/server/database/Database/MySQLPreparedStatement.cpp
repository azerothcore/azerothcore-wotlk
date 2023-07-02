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

#include "MySQLPreparedStatement.h"
#include "Errors.h"
#include "Log.h"
#include "MySQLHacks.h"
#include "PreparedStatement.h"

template<typename T>
struct MySQLType { };

template<> struct MySQLType<uint8> : std::integral_constant<enum_field_types, MYSQL_TYPE_TINY> { };
template<> struct MySQLType<uint16> : std::integral_constant<enum_field_types, MYSQL_TYPE_SHORT> { };
template<> struct MySQLType<uint32> : std::integral_constant<enum_field_types, MYSQL_TYPE_LONG> { };
template<> struct MySQLType<uint64> : std::integral_constant<enum_field_types, MYSQL_TYPE_LONGLONG> { };
template<> struct MySQLType<int8> : std::integral_constant<enum_field_types, MYSQL_TYPE_TINY> { };
template<> struct MySQLType<int16> : std::integral_constant<enum_field_types, MYSQL_TYPE_SHORT> { };
template<> struct MySQLType<int32> : std::integral_constant<enum_field_types, MYSQL_TYPE_LONG> { };
template<> struct MySQLType<int64> : std::integral_constant<enum_field_types, MYSQL_TYPE_LONGLONG> { };
template<> struct MySQLType<float> : std::integral_constant<enum_field_types, MYSQL_TYPE_FLOAT> { };
template<> struct MySQLType<double> : std::integral_constant<enum_field_types, MYSQL_TYPE_DOUBLE> { };

MySQLPreparedStatement::MySQLPreparedStatement(MySQLStmt* stmt, std::string_view queryString) :
    _mysqlStmt(stmt),
    _queryString(queryString)
{
    /// Initialize variable parameters
    _paramCount = mysql_stmt_param_count(stmt);
    _paramsSet.assign(_paramCount, false);

    _bind = new MySQLBind[_paramCount];
    memset(_bind, 0, sizeof(MySQLBind) * _paramCount);

    /// "If set to 1, causes mysql_stmt_store_result() to update the metadata MYSQL_FIELD->max_length value."
    auto bool_tmp = MySQLBool(1);
    mysql_stmt_attr_set(stmt, STMT_ATTR_UPDATE_MAX_LENGTH, &bool_tmp);
}

MySQLPreparedStatement::~MySQLPreparedStatement()
{
    ClearParameters();
    if (_mysqlStmt->bind_result_done)
    {
        delete[] _mysqlStmt->bind->length;
        delete[] _mysqlStmt->bind->is_null;
    }

    mysql_stmt_close(_mysqlStmt);
    delete[] _bind;
}

void MySQLPreparedStatement::BindParameters(PreparedStatement stmt)
{
    _stmt = stmt; // Cross-reference them for debug output

    uint8 pos = 0;
    for (PreparedStatementData const& data : stmt->GetParameters())
    {
        std::visit([&](auto&& param)
        {
            SetParameter(pos, param);
        }, data.data);

        ++pos;
    }

#ifdef _DEBUG
    if (pos < m_paramCount)
        LOG_WARN("db.query", "BindParameters() for statement {} did not bind all allocated parameters", stmt->GetIndex());
#endif
}

void MySQLPreparedStatement::ClearParameters()
{
    for (uint32 i = 0; i < _paramCount; ++i)
    {
        delete _bind[i].length;
        _bind[i].length = nullptr;
        delete[] (char*)_bind[i].buffer;
        _bind[i].buffer = nullptr;
        _paramsSet[i] = false;
    }
}

static bool ParamenterIndexAssertFail(uint32 stmtIndex, uint8 index, uint32 paramCount)
{
    LOG_ERROR("db.query", "Attempted to bind parameter {}{} on a PreparedStatementBase {} (statement has only {} parameters)",
        uint32(index) + 1, (index == 1 ? "st" : (index == 2 ? "nd" : (index == 3 ? "rd" : "nd"))), stmtIndex, paramCount);

    return false;
}

//- Bind on mysql level
void MySQLPreparedStatement::AssertValidIndex(uint8 index)
{
    ASSERT(index < _paramCount || ParamenterIndexAssertFail(_stmt->GetIndex(), index, _paramCount));

    if (_paramsSet[index])
        LOG_ERROR("db.query", "Prepared Statement (id: {}) trying to bind value on already bound index ({}).", _stmt->GetIndex(), index);
}

template<typename T>
void MySQLPreparedStatement::SetParameter(const uint8 index, T value)
{
    AssertValidIndex(index);
    _paramsSet[index] = true;
    MYSQL_BIND* param = &_bind[index];
    auto len = uint32(sizeof(T));
    param->buffer_type = MySQLType<T>::value;
    delete[] static_cast<char*>(param->buffer);
    param->buffer = new char[len];
    param->buffer_length = 0;
    param->is_null_value = 0;
    param->length = nullptr; // Only != NULL for strings
    param->is_unsigned = std::is_unsigned_v<T>;

    memcpy(param->buffer, &value, len);
}

void MySQLPreparedStatement::SetParameter(uint8 index, bool value)
{
    SetParameter(index, uint8(value ? 1 : 0));
}

void MySQLPreparedStatement::SetParameter(uint8 index, std::nullptr_t /*value*/)
{
    AssertValidIndex(index);
    _paramsSet[index] = true;
    MYSQL_BIND* param = &_bind[index];
    param->buffer_type = MYSQL_TYPE_NULL;
    delete[] static_cast<char*>(param->buffer);
    param->buffer = nullptr;
    param->buffer_length = 0;
    param->is_null_value = 1;
    delete param->length;
    param->length = nullptr;
}

void MySQLPreparedStatement::SetParameter(uint8 index, std::string const& value)
{
    AssertValidIndex(index);
    _paramsSet[index] = true;
    MYSQL_BIND* param = &_bind[index];
    auto len = uint32(value.size());
    param->buffer_type = MYSQL_TYPE_VAR_STRING;
    delete[] static_cast<char*>(param->buffer);
    param->buffer = new char[len];
    param->buffer_length = len;
    param->is_null_value = 0;
    delete param->length;
    param->length = new unsigned long(len);

    memcpy(param->buffer, value.c_str(), len);
}

void MySQLPreparedStatement::SetParameter(uint8 index, std::vector<uint8> const& value)
{
    AssertValidIndex(index);
    _paramsSet[index] = true;
    MYSQL_BIND* param = &_bind[index];
    auto len = uint32(value.size());
    param->buffer_type = MYSQL_TYPE_BLOB;
    delete[] static_cast<char*>(param->buffer);
    param->buffer = new char[len];
    param->buffer_length = len;
    param->is_null_value = 0;
    delete param->length;
    param->length = new unsigned long(len);

    memcpy(param->buffer, value.data(), len);
}

std::string MySQLPreparedStatement::getQueryString() const
{
    std::string queryString(_queryString);
    std::size_t pos{};

    for (PreparedStatementData const& data : _stmt->GetParameters())
    {
        pos = queryString.find('?', pos);

        std::string replaceStr = std::visit([&](auto&& data)
        {
            return PreparedStatementData::ToString(data);
        }, data.data);

        queryString.replace(pos, 1, replaceStr);
        pos += replaceStr.length();
    }

    return queryString;
}
