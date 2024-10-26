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

#include "Config.h"
#include "Define.h"
#include "gtest/gtest.h"

#include <boost/filesystem.hpp>
#include <cstdlib>
#include <fstream>
#include <string>

std::string CreateConfigWithMap(std::map<std::string, std::string> const& map)
{
    auto mTempFileRel = boost::filesystem::unique_path("deleteme.ini");
    auto mTempFileAbs = boost::filesystem::temp_directory_path() / mTempFileRel;
    std::ofstream iniStream;
    iniStream.open(mTempFileAbs.c_str());

    iniStream << "[test]\n";
    for (auto const& itr : map)
        iniStream << itr.first << " = " << itr.second << "\n";

    iniStream.close();

    return mTempFileAbs.native();
}

class ConfigEnvTest : public testing::Test {
protected:
    void SetUp() override {
        std::map<std::string, std::string> config;
        config["Int.Nested"] = "4242";
        config["lower"] = "simpleString";
        config["UPPER"] = "simpleString";
        config["SomeLong.NestedNameWithNumber.Like1"] = "1";
        config["GM.InGMList.Level"] = "50";

        confFilePath = CreateConfigWithMap(config);

        sConfigMgr->Configure(confFilePath, std::vector<std::string>());
        sConfigMgr->LoadAppConfigs();
    }

    void TearDown() override {
        std::remove(confFilePath.c_str());
    }

    std::string confFilePath;
};

TEST_F(ConfigEnvTest, NestedInt)
{
    EXPECT_EQ(sConfigMgr->GetOption<int32>("Int.Nested", 10), 4242);
    setenv("AC_INT_NESTED", "8080", 1);
    EXPECT_EQ(sConfigMgr->OverrideWithEnvVariablesIfAny().empty(), false);
    EXPECT_EQ(sConfigMgr->GetOption<int32>("Int.Nested", 10), 8080);
}

TEST_F(ConfigEnvTest, SimpleLowerString)
{
    EXPECT_EQ(sConfigMgr->GetOption<std::string>("lower", ""), "simpleString");
    setenv("AC_LOWER", "envstring", 1);
    EXPECT_EQ(sConfigMgr->OverrideWithEnvVariablesIfAny().empty(), false);
    EXPECT_EQ(sConfigMgr->GetOption<std::string>("lower", ""), "envstring");
}

TEST_F(ConfigEnvTest, SimpleUpperString)
{
    EXPECT_EQ(sConfigMgr->GetOption<std::string>("UPPER", ""), "simpleString");
    setenv("AC_UPPER", "envupperstring", 1);
    EXPECT_EQ(sConfigMgr->OverrideWithEnvVariablesIfAny().empty(), false);
    EXPECT_EQ(sConfigMgr->GetOption<std::string>("UPPER", ""), "envupperstring");
}

TEST_F(ConfigEnvTest, LongNestedNameWithNumber)
{
    EXPECT_EQ(sConfigMgr->GetOption<float>("SomeLong.NestedNameWithNumber.Like1", 0), 1);
    setenv("AC_SOME_LONG_NESTED_NAME_WITH_NUMBER_LIKE_1", "42", 1);
    EXPECT_EQ(sConfigMgr->OverrideWithEnvVariablesIfAny().empty(), false);
    EXPECT_EQ(sConfigMgr->GetOption<float>("SomeLong.NestedNameWithNumber.Like1", 0), 42);
}

TEST_F(ConfigEnvTest, ValueWithSeveralUpperlLaters)
{
    EXPECT_EQ(sConfigMgr->GetOption<int>("GM.InGMList.Level", 1), 50);
    setenv("AC_GM_IN_GMLIST_LEVEL", "42", 1);
    EXPECT_EQ(sConfigMgr->OverrideWithEnvVariablesIfAny().empty(), false);
    EXPECT_EQ(sConfigMgr->GetOption<int>("GM.InGMList.Level", 0), 42);
}

TEST_F(ConfigEnvTest, StringThatNotExistInConfig)
{
    setenv("AC_UNIQUE_STRING", "somevalue", 1);
    EXPECT_EQ(sConfigMgr->GetOption<std::string>("Unique.String", ""), "somevalue");
}

TEST_F(ConfigEnvTest, IntThatNotExistInConfig)
{
    setenv("AC_UNIQUE_INT", "100", 1);
    EXPECT_EQ(sConfigMgr->GetOption<int>("Unique.Int", 1), 100);
}

TEST_F(ConfigEnvTest, NotExistingString)
{
    EXPECT_EQ(sConfigMgr->GetOption<std::string>("NotFound.String", "none"), "none");
}

TEST_F(ConfigEnvTest, NotExistingInt)
{
    EXPECT_EQ(sConfigMgr->GetOption<int>("NotFound.Int", 1), 1);
}
