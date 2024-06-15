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

#include "AccountScript.h"
#include "ScriptMgr.h"
#include "ScriptMgrMacros.h"

void ScriptMgr::OnAccountLogin(uint32 accountId)
{
    CALL_ENABLED_HOOKS(AccountScript, ACCOUNTHOOK_ON_ACCOUNT_LOGIN, script->OnAccountLogin(accountId));
}

void ScriptMgr::OnBeforeAccountDelete(uint32 accountId)
{
    CALL_ENABLED_HOOKS(AccountScript, ACCOUNTHOOK_ON_BEFORE_ACCOUNT_DELETE, script->OnBeforeAccountDelete(accountId));
}

void ScriptMgr::OnLastIpUpdate(uint32 accountId, std::string ip)
{
    CALL_ENABLED_HOOKS(AccountScript, ACCOUNTHOOK_ON_LAST_IP_UPDATE, script->OnLastIpUpdate(accountId, ip));
}

void ScriptMgr::OnFailedAccountLogin(uint32 accountId)
{
    CALL_ENABLED_HOOKS(AccountScript, ACCOUNTHOOK_ON_FAILED_ACCOUNT_LOGIN, script->OnFailedAccountLogin(accountId));
}

void ScriptMgr::OnEmailChange(uint32 accountId)
{
    CALL_ENABLED_HOOKS(AccountScript, ACCOUNTHOOK_ON_EMAIL_CHANGE, script->OnEmailChange(accountId));
}

void ScriptMgr::OnFailedEmailChange(uint32 accountId)
{
    CALL_ENABLED_HOOKS(AccountScript, ACCOUNTHOOK_ON_FAILED_EMAIL_CHANGE, script->OnFailedEmailChange(accountId));
}

void ScriptMgr::OnPasswordChange(uint32 accountId)
{
    CALL_ENABLED_HOOKS(AccountScript, ACCOUNTHOOK_ON_PASSWORD_CHANGE, script->OnPasswordChange(accountId));
}

void ScriptMgr::OnFailedPasswordChange(uint32 accountId)
{
    CALL_ENABLED_HOOKS(AccountScript, ACCOUNTHOOK_ON_FAILED_PASSWORD_CHANGE, script->OnFailedPasswordChange(accountId));
}

bool ScriptMgr::CanAccountCreateCharacter(uint32 accountId, uint8 charRace, uint8 charClass)
{
    CALL_ENABLED_BOOLEAN_HOOKS(AccountScript, ACCOUNTHOOK_CAN_ACCOUNT_CREATE_CHARACTER, !script->CanAccountCreateCharacter(accountId, charRace, charClass));
}

AccountScript::AccountScript(char const* name, std::vector<uint16> enabledHooks) :
    ScriptObject(name, ACCOUNTHOOK_END)
{
    // If empty - enable all available hooks.
    if (enabledHooks.empty())
        for (uint16 i = 0; i < ACCOUNTHOOK_END; ++i)
            enabledHooks.emplace_back(i);

    ScriptRegistry<AccountScript>::AddScript(this, std::move(enabledHooks));
}

template class AC_GAME_API ScriptRegistry<AccountScript>;
