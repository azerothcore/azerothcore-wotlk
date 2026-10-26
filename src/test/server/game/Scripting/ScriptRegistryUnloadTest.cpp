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

#include "ScriptMgr.h"
#include "ScriptDefines/MiscScript.h"
#include "gtest/gtest.h"

namespace
{
class TestDestructGroupScript : public MiscScript
{
public:
    TestDestructGroupScript() : MiscScript("TestDestructGroupScript", { MISCHOOK_ON_DESTRUCT_GROUP }) { }

    void OnDestructGroup(Group* /*origin*/) override { ++CallCount; }

    inline static uint32 CallCount = 0;
};
}

// ScriptMgr::Unload() runs before the static destructors of GroupMgr and
// AuctionHouseMgr, which still call OnDestructGroup/OnDestructObject. After an
// unload those hooks must find no scripts instead of the deleted ones (#19635).
TEST(ScriptRegistryUnloadTest, UnloadEmptiesEnabledHooks)
{
    TestDestructGroupScript::CallCount = 0;
    new TestDestructGroupScript();

    sScriptMgr->OnDestructGroup(nullptr);
    ASSERT_EQ(TestDestructGroupScript::CallCount, 1u);

    ScriptRegistry<MiscScript>::Unload();

    EXPECT_TRUE(ScriptRegistry<MiscScript>::ScriptPointerList.empty());
    ASSERT_EQ(ScriptRegistry<MiscScript>::EnabledHooks.size(), std::size_t(MISCHOOK_END));
    for (auto const& hookScripts : ScriptRegistry<MiscScript>::EnabledHooks)
        EXPECT_TRUE(hookScripts.empty());

    sScriptMgr->OnDestructGroup(nullptr);
    EXPECT_EQ(TestDestructGroupScript::CallCount, 1u);
}
