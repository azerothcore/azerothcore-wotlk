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

#ifndef SCRIPT_OBJECT_ACCOUNT_SCRIPT_H_
#define SCRIPT_OBJECT_ACCOUNT_SCRIPT_H_

#include "ScriptObject.h"
#include <vector>

enum AccountHook
{
    ACCOUNTHOOK_ON_ACCOUNT_LOGIN,
    ACCOUNTHOOK_ON_BEFORE_ACCOUNT_DELETE,
    ACCOUNTHOOK_ON_LAST_IP_UPDATE,
    ACCOUNTHOOK_ON_FAILED_ACCOUNT_LOGIN,
    ACCOUNTHOOK_ON_EMAIL_CHANGE,
    ACCOUNTHOOK_ON_FAILED_EMAIL_CHANGE,
    ACCOUNTHOOK_ON_PASSWORD_CHANGE,
    ACCOUNTHOOK_ON_FAILED_PASSWORD_CHANGE,
    ACCOUNTHOOK_CAN_ACCOUNT_CREATE_CHARACTER,
    ACCOUNTHOOK_END
};

class AccountScript : public ScriptObject
{
protected:
    AccountScript(const char* name, std::vector<uint16> enabledHooks = std::vector<uint16>());

public:
    // Called when an account logged in successfully
    virtual void OnAccountLogin(uint32 /*accountId*/) { }

    // Called when an account is about to be deleted
    virtual void OnBeforeAccountDelete(uint32 /*accountId*/) { }

    // Called when an ip logged in successfully
    virtual void OnLastIpUpdate(uint32 /*accountId*/, std::string /*ip*/) { }

    // Called when an account login failed
    virtual void OnFailedAccountLogin(uint32 /*accountId*/) { }

    // Called when Email is successfully changed for Account
    virtual void OnEmailChange(uint32 /*accountId*/) { }

    // Called when Email failed to change for Account
    virtual void OnFailedEmailChange(uint32 /*accountId*/) { }

    // Called when Password is successfully changed for Account
    virtual void OnPasswordChange(uint32 /*accountId*/) { }

    // Called when Password failed to change for Account
    virtual void OnFailedPasswordChange(uint32 /*accountId*/) { }

    // Called when creating a character on the Account
    [[nodiscard]] virtual bool CanAccountCreateCharacter(uint32 /*accountId*/, uint8 /*charRace*/, uint8 /*charClass*/) { return true;}
};

#endif
