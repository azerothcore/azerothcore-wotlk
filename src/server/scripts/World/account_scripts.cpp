/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 * Copyright (C) 2021+ WarheadCore <https://github.com/WarheadCore>
 */

#include "MuteMgr.h"
#include "ScriptMgr.h"

class LoginMuteTime : public AccountScript
{
public:
    LoginMuteTime() : AccountScript("LoginMuteTime") { }

    void OnAccountLogin(uint32 accountID) override
    {
        sMute->LoginAccount(accountID);
    }

    void OnAccountLogout(uint32 accountID) override
    {
        sMute->DeleteMuteTime(accountID, false);
    }
};

void AddSC_account_script()
{
    new LoginMuteTime();
}
