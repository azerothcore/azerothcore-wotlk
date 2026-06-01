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

#include "StringLiteralView.h"
#include "gtest/gtest.h"

#include <string_view>
#include <type_traits>
#include <utility>

namespace
{
    constexpr bool CopyAndAssignWorks()
    {
        StringLiteralView source = "source";
        char const* sourceData = source.data();
        StringLiteralView copy(source);
        StringLiteralView assigned = "initial";

        assigned = copy;

        return static_cast<std::string_view>(assigned) == "source" &&
            assigned.data() == sourceData &&
            copy.data() == sourceData;
    }

    static_assert(std::is_copy_constructible_v<StringLiteralView>);
    static_assert(std::is_copy_assignable_v<StringLiteralView>);
    static_assert(std::is_move_constructible_v<StringLiteralView>);
    static_assert(std::is_move_assignable_v<StringLiteralView>);
    static_assert(CopyAndAssignWorks());
}

TEST(StringLiteralViewTest, CopiesAndAssigns)
{
    StringLiteralView source = "source";
    char const* sourceData = source.data();
    StringLiteralView copy(source);
    StringLiteralView assigned = "initial";

    assigned = copy;

    EXPECT_EQ(static_cast<std::string_view>(copy), "source");
    EXPECT_EQ(static_cast<std::string_view>(assigned), "source");
    EXPECT_EQ(copy.data(), sourceData);
    EXPECT_EQ(assigned.data(), sourceData);
}

TEST(StringLiteralViewTest, MovesAndMoveAssigns)
{
    StringLiteralView source = "moved";
    char const* movedData = source.data();
    StringLiteralView moved(std::move(source));

    StringLiteralView assignSource = "move assigned";
    char const* assignedData = assignSource.data();
    StringLiteralView assigned = "initial";

    assigned = std::move(assignSource);

    EXPECT_EQ(static_cast<std::string_view>(moved), "moved");
    EXPECT_EQ(static_cast<std::string_view>(assigned), "move assigned");
    EXPECT_EQ(moved.data(), movedData);
    EXPECT_EQ(assigned.data(), assignedData);
}
