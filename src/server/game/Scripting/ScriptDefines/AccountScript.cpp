/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
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
#include "ScriptMgrMacros.h"

void ScriptMgr::OnAccountLogin(uint32 accountId)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnAccountLogin(accountId);
    });
}

//void ScriptMgr::OnAccountLogout(uint32 accountId)
//{
//    ExecuteScript<AccountScript>([&](AccountScript* script)
//    {
//        script->OnAccountLogout(accountId);
//    });
//}

void ScriptMgr::OnLastIpUpdate(uint32 accountId, std::string ip)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnLastIpUpdate(accountId, ip);
    });
}

void ScriptMgr::OnFailedAccountLogin(uint32 accountId)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnFailedAccountLogin(accountId);
    });
}

void ScriptMgr::OnEmailChange(uint32 accountId)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnEmailChange(accountId);
    });
}

void ScriptMgr::OnFailedEmailChange(uint32 accountId)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnFailedEmailChange(accountId);
    });
}

void ScriptMgr::OnPasswordChange(uint32 accountId)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnPasswordChange(accountId);
    });
}

void ScriptMgr::OnFailedPasswordChange(uint32 accountId)
{
    ExecuteScript<AccountScript>([&](AccountScript* script)
    {
        script->OnFailedPasswordChange(accountId);
    });
}
