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

#include "PreparedStatement.h"
#include "Errors.h"

PreparedStatementBase::PreparedStatementBase(uint32 index, uint8 capacity) :
    _index(index),
    _statementData(capacity)
{
    _paramsSet.assign(capacity, false);
}

//- Bind to buffer
template<typename T>
Acore::Types::is_non_string_view_v<T> PreparedStatementBase::SetValidData(const uint8 index, T const& value)
{
    ASSERT(index < _statementData.size());
    _statementData[index].data.emplace<T>(value);
    _paramsSet[index] = true;
}

// Non template functions
void PreparedStatementBase::SetValidData(const uint8 index)
{
    ASSERT(index < _statementData.size());
    _statementData[index].data.emplace<std::nullptr_t>(nullptr);
    _paramsSet[index] = true;
}

void PreparedStatementBase::SetValidData(const uint8 index, std::string_view value)
{
    ASSERT(index < _statementData.size(), "> Incorrect index ({}). Statement data size: {}", index, _statementData.size());
    _statementData[index].data.emplace<std::string>(value);
    _paramsSet[index] = true;
}

template AC_DATABASE_API void PreparedStatementBase::SetValidData(const uint8 index, uint8 const& value);
template AC_DATABASE_API void PreparedStatementBase::SetValidData(const uint8 index, int8 const& value);
template AC_DATABASE_API void PreparedStatementBase::SetValidData(const uint8 index, uint16 const& value);
template AC_DATABASE_API void PreparedStatementBase::SetValidData(const uint8 index, int16 const& value);
template AC_DATABASE_API void PreparedStatementBase::SetValidData(const uint8 index, uint32 const& value);
template AC_DATABASE_API void PreparedStatementBase::SetValidData(const uint8 index, int32 const& value);
template AC_DATABASE_API void PreparedStatementBase::SetValidData(const uint8 index, uint64 const& value);
template AC_DATABASE_API void PreparedStatementBase::SetValidData(const uint8 index, int64 const& value);
template AC_DATABASE_API void PreparedStatementBase::SetValidData(const uint8 index, bool const& value);
template AC_DATABASE_API void PreparedStatementBase::SetValidData(const uint8 index, float const& value);
template AC_DATABASE_API void PreparedStatementBase::SetValidData(const uint8 index, std::string const& value);
template AC_DATABASE_API void PreparedStatementBase::SetValidData(const uint8 index, std::vector<uint8> const& value);

std::pair<bool, uint8> PreparedStatementBase::IsAllParamsSet() const
{
    for (std::size_t index{}; index < _paramsSet.size(); index++)
        if (!_paramsSet[index])
            return { false, index };

    return { true, {} };
}

template<typename T>
std::string PreparedStatementData::ToString(T value)
{
    return Acore::StringFormatFmt("{}", value);
}

template<>
std::string PreparedStatementData::ToString(std::vector<uint8> /*value*/)
{
    return "BINARY";
}

std::string PreparedStatementData::ToString(std::nullptr_t /*value*/)
{
    return "NULL";
}

template AC_DATABASE_API std::string PreparedStatementData::ToString(uint8);
template AC_DATABASE_API std::string PreparedStatementData::ToString(uint16);
template AC_DATABASE_API std::string PreparedStatementData::ToString(uint32);
template AC_DATABASE_API std::string PreparedStatementData::ToString(uint64);
template AC_DATABASE_API std::string PreparedStatementData::ToString(int8);
template AC_DATABASE_API std::string PreparedStatementData::ToString(int16);
template AC_DATABASE_API std::string PreparedStatementData::ToString(int32);
template AC_DATABASE_API std::string PreparedStatementData::ToString(int64);
template AC_DATABASE_API std::string PreparedStatementData::ToString(std::string);
template AC_DATABASE_API std::string PreparedStatementData::ToString(float);
template AC_DATABASE_API std::string PreparedStatementData::ToString(double);
template AC_DATABASE_API std::string PreparedStatementData::ToString(bool);
