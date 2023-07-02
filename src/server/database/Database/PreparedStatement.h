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

#ifndef _PREPAREDSTATEMENT_H
#define _PREPAREDSTATEMENT_H

#include "Define.h"
#include "Duration.h"
#include <string>
#include <string_view>
#include <tuple>
#include <variant>
#include <vector>

namespace Acore::Types
{
    template <typename T>
    using is_default = std::enable_if_t<std::is_arithmetic_v<T> || std::is_same_v<std::vector<uint8>, T>>;

    template <typename T>
    using is_enum_v = std::enable_if_t<std::is_enum_v<T>>;

    template <typename T>
    using is_non_string_view_v = std::enable_if_t<!std::is_base_of_v<std::string_view, T>>;
}

struct PreparedStatementData
{
    std::variant<
        bool,
        uint8,
        uint16,
        uint32,
        uint64,
        int8,
        int16,
        int32,
        int64,
        float,
        double,
        std::string,
        std::vector<uint8>,
        std::nullptr_t
    > data;

    template<typename T>
    static std::string ToString(T value);

    static std::string ToString(std::nullptr_t /*value*/);
};

//- Upper-level class that is used in code
class AC_DATABASE_API PreparedStatementBase
{
public:
    explicit PreparedStatementBase(uint32 index, uint8 capacity);
    virtual ~PreparedStatementBase() = default;

    // Set numeric and default binary
    template<typename T>
    inline Acore::Types::is_default<T> SetData(const uint8 index, T value)
    {
        SetValidData(index, value);
    }

    // Set enums
    template<typename T>
    inline Acore::Types::is_enum_v<T> SetData(const uint8 index, T value)
    {
        SetValidData(index, std::underlying_type_t<T>(value));
    }

    // Set string_view
    inline void SetData(const uint8 index, std::string_view value)
    {
        SetValidData(index, value);
    }

    // Set nullptr
    inline void SetData(const uint8 index, std::nullptr_t = nullptr)
    {
        SetValidData(index);
    }

    // Set non default binary
    template<std::size_t Size>
    inline void SetData(const uint8 index, std::array<uint8, Size> const& value)
    {
        std::vector<uint8> vec(value.begin(), value.end());
        SetValidData(index, vec);
    }

    // Set duration
    template<class Rep, class Period>
    inline void SetData(const uint8 index, std::chrono::duration<Rep, Period> const& value, bool convertToUin32 = true)
    {
        SetValidData(index, convertToUin32 ? static_cast<uint32>(value.count()) : value.count());
    }

    // Set all
    template <typename... Args>
    inline void SetArguments(Args&&... args)
    {
        SetDataTuple(std::make_tuple(std::forward<Args>(args)...));
    }

    [[nodiscard]] uint32 GetIndex() const { return _index; }
    [[nodiscard]] std::vector<PreparedStatementData> const& GetParameters() const { return _statementData; }
    [[nodiscard]] std::pair<bool, uint8> IsAllParamsSet() const;

protected:
    template<typename T>
    Acore::Types::is_non_string_view_v<T> SetValidData(uint8 index, T const& value);

    void SetValidData(uint8 index);
    void SetValidData(uint8 index, std::string_view value);

    template<typename... Ts>
    void SetDataTuple(std::tuple<Ts...> const& argsList)
    {
        std::apply
        (
            [this](Ts const&... arguments)
            {
                uint8 index{ 0 };
                ((SetData(index, arguments), index++), ...);
            }, argsList
        );
    }

    uint32 _index;
    std::vector<bool> _paramsSet;

    //- Buffer of parameters, not tied to MySQL in any way yet
    std::vector<PreparedStatementData> _statementData;

    PreparedStatementBase(PreparedStatementBase const& right) = delete;
    PreparedStatementBase& operator=(PreparedStatementBase const& right) = delete;
};

#endif
