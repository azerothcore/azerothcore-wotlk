/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "LoginDatabase.h"

void LoginDatabaseConnection::DoPrepareStatements()
{
    if (!m_reconnecting)
        m_stmts.resize(MAX_LOGINDATABASE_STATEMENTS);
    //Get Calls
    PrepareStatement(LOGIN_SEL_REALMLIST, "call sp_GetRealmListAll()", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_IP_BANNED, "call sp_GetIpBanByIp(?)", CONNECTION_SYNCH); //IP nvarchar(64)
    PrepareStatement(LOGIN_SEL_ACCOUNT_BANNED_ALL, "call sp_GetAccBanAll()", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_IP_BANNED_ALL, "call sp_GetIpBanAll()", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_IP_BANNED_BY_IP, "call sp_GetIpBanByIpByIpLike(?)", CONNECTION_SYNCH); //IP nvarchar(64)
    PrepareStatement(LOGIN_SEL_ACCOUNT_BANNED, "call sp_GetBanActiveById(?)", CONNECTION_SYNCH); //AccountID int
    PrepareStatement(LOGIN_SEL_ACCOUNT_BANNED_BY_USERNAME, "call sp_GetAccBanByUser(?)", CONNECTION_SYNCH); //UserName nvarchar(32)
    PrepareStatement(LOGIN_SEL_SESSIONKEY, "call sp_GetSeskeyByUser(?)", CONNECTION_SYNCH); //UserName nvarchar(32)
    PrepareStatement(LOGIN_SEL_LOGONCHALLENGE, "call sp_GetLogonChalByUser(?)", CONNECTION_SYNCH); //UserName nvarchar(32)
    PrepareStatement(LOGIN_SEL_LOGON_COUNTRY, "call sp_GetLogonCountryByIp(?)", CONNECTION_SYNCH); //IP nvarchar(64) //Calling process uses int32?
    PrepareStatement(LOGIN_SEL_FAILEDLOGINS, "call sp_GetFailedLogonsByUser(?)", CONNECTION_SYNCH); //UserName nvarchar(32)
    PrepareStatement(LOGIN_SEL_ACCOUNT_ID_BY_NAME, "call sp_GetAccIdByUser(?)", CONNECTION_SYNCH); //UserName nvarchar(32)
    PrepareStatement(LOGIN_SEL_ACCOUNT_LIST_BY_NAME, "call sp_GetAccByUser(?)", CONNECTION_SYNCH); //UserName nvarchar(32)
    PrepareStatement(LOGIN_SEL_ACCOUNT_INFO_BY_NAME, "call sp_GetAccInfoByUser(?)", CONNECTION_SYNCH); //UserName nvarchar(32)
    PrepareStatement(LOGIN_SEL_ACCOUNT_LIST_BY_EMAIL, "call sp_GetAccByEmail(?)", CONNECTION_SYNCH); //Email nvarchar(256)
    PrepareStatement(LOGIN_SEL_NUM_CHARS_ON_REALM, "call sp_GetNumCharsByRealmNAcc(?, ?)", CONNECTION_SYNCH); //RealmID int, AccountID int
    PrepareStatement(LOGIN_SEL_ACCOUNT_BY_IP, "call sp_GetAccByIp(?)", CONNECTION_SYNCH); //IP nvarchar(64)
    PrepareStatement(LOGIN_SEL_ACCOUNT_BY_ID, "call sp_GetAccExistById(?)", CONNECTION_SYNCH); //AccountID int
    PrepareStatement(LOGIN_SEL_SUM_REALM_CHARACTERS, "call sp_GetSumCharsByAcc(?)", CONNECTION_ASYNC); //AccountID int
    PrepareStatement(LOGIN_GET_ACCOUNT_ID_BY_USERNAME, "call sp_GetAccIdByUser(?)", CONNECTION_SYNCH); //UserName nvarchar(32)
    PrepareStatement(LOGIN_GET_ACCOUNT_ACCESS_GMLEVEL, "call sp_GetGMAccessByAcc(?)", CONNECTION_SYNCH); //AccountID int
    PrepareStatement(LOGIN_GET_GMLEVEL_BY_REALMID, "call sp_GetGMAccessByAccNRealm(?, ?)", CONNECTION_SYNCH); //AccountID int, RealmID int
    PrepareStatement(LOGIN_GET_USERNAME_BY_ID, "call sp_GetUserByAcc(?)", CONNECTION_SYNCH); //AccountID int
    PrepareStatement(LOGIN_SEL_CHECK_PASSWORD, "call sp_GetPassCheckByAcc(?, ?)", CONNECTION_SYNCH); //AccountID int, Password nvarchar(64)
    PrepareStatement(LOGIN_SEL_CHECK_PASSWORD_BY_NAME, "call sp_GetPassCheckByName(?, ?)", CONNECTION_SYNCH); //UserName nvarchar(32), Password nvarchar(64)
    PrepareStatement(LOGIN_SEL_PINFO, "call sp_GetPlayerByRealmNAcc(?, ?)", CONNECTION_SYNCH); //RealmID int, AccountID int
    PrepareStatement(LOGIN_SEL_PINFO_BANS, "call sp_GetPlayerBansByAcc(?)", CONNECTION_SYNCH); //AccountID int
    PrepareStatement(LOGIN_SEL_GM_ACCOUNTS, "call sp_GetGMAcctsByMinLvlNRealm(?, ?)", CONNECTION_SYNCH); //AccessLevel int, RealmID int
    PrepareStatement(LOGIN_SEL_ACCOUNT_INFO, "call sp_GetAccInfoGMExpByAcc(?)", CONNECTION_SYNCH); //AccountID int // Only used in ".account onlinelist" command
    PrepareStatement(LOGIN_SEL_ACCOUNT_ACCESS_GMLEVEL_TEST, "call sp_GetGMAccessByAccNGMlvl(?, ?)", CONNECTION_SYNCH); //AccountID int, AccessLevel int
    PrepareStatement(LOGIN_SEL_ACCOUNT_ACCESS, "call sp_GetGMAccessByUser(?)", CONNECTION_SYNCH); //UserName nvarchar(32)
    PrepareStatement(LOGIN_SEL_ACCOUNT_RECRUITER, "call sp_GetRecruiterCheckByRec(?)", CONNECTION_SYNCH); //RecruiterID int
    PrepareStatement(LOGIN_SEL_BANS, "call sp_GetBansByAccOrIp(?, ?)", CONNECTION_SYNCH); //AccountID int, IP nvarchar(64)
    PrepareStatement(LOGIN_SEL_ACCOUNT_WHOIS, "call sp_GetAccWhoByAcc(?)", CONNECTION_SYNCH); //AccountID int
    PrepareStatement(LOGIN_SEL_LAST_ATTEMPT_IP, "call sp_GetLastIpAttemptByAcc(?)", CONNECTION_SYNCH); //AccountID int //no references found? maybe old and not used anymore.
    PrepareStatement(LOGIN_SEL_LAST_IP, "call sp_GetLastIpByAcc(?)", CONNECTION_SYNCH); //AccountID int //no references found? maybe old and not used anymore.
    PrepareStatement(LOGIN_SEL_REALMLIST_SECURITY_LEVEL, "call sp_GetAllowSecByRealm(?)", CONNECTION_SYNCH); //RealmID int
    PrepareStatement(LOGIN_SEL_IP2NATION_COUNTRY, "call sp_GetIpCountryByIp(?)", CONNECTION_SYNCH); //IP nvarchar(64) //Calling process uses int32?
    PrepareStatement(LOGIN_SEL_AUTOBROADCAST, "call sp_GetAutoBroadcastByRealm(?)", CONNECTION_SYNCH); //RealmID int
    PrepareStatement(LOGIN_SEL_ACCOUNT_MUTE_INFO, "call sp_GetMutesByAcc(?)", CONNECTION_SYNCH); //AccountID int //Calling process uses int16 instead of int32, should probably fix.

    //Delete Calls
    PrepareStatement(LOGIN_DEL_EXPIRED_IP_BANS, "call sp_DelExpIpBansAll()", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_DEL_ACCOUNT_MUTEDEL, "call sp_DelAccMuteByAcc(?)", CONNECTION_ASYNC); //AccountID int
    PrepareStatement(LOGIN_DEL_ACCOUNT, "call sp_DelAccByAcc(?)", CONNECTION_ASYNC); //AccountID int
    PrepareStatement(LOGIN_DEL_OLD_LOGS, "call sp_DelLogsByAge(?, ?)", CONNECTION_ASYNC); //Age int, TimeNow int
    PrepareStatement(LOGIN_DEL_ACCOUNT_ACCESS, "call sp_DelAccAccessByAcc(?)", CONNECTION_ASYNC); //AccountID int
    PrepareStatement(LOGIN_DEL_ACCOUNT_ACCESS_BY_REALM, "call sp_DelAccAccessByAccNRealm(?, ?)", CONNECTION_ASYNC); //AccountID int, RealmID int
    PrepareStatement(LOGIN_DEL_IP_NOT_BANNED, "call sp_DelIpBanByIp(?)", CONNECTION_ASYNC); //IP nvarchar(64)
    PrepareStatement(LOGIN_DEL_REALM_CHARACTERS_BY_REALM, "call sp_DelRealmCharsByAccNRealm(?, ?)", CONNECTION_ASYNC); //AccountID int, RealmID int
    PrepareStatement(LOGIN_DEL_REALM_CHARACTERS, "call sp_DelRealmCharsByAcc(?)", CONNECTION_ASYNC); //AccountID int
    PrepareStatement(LOGIN_DEL_ACCOUNT_BANNED, "call sp_DelAccBanByAcc(?)", CONNECTION_ASYNC); //AccountID int

    //Insert Calls
    // 0: uint32, 1: uint32, 2: uint8, 3: uint32, 4: string // Complete name: "Login_Insert_AccountLoginDeLete_IP_Logging"
    PrepareStatement(LOGIN_INS_ALDL_IP_LOGGING, "call sp_InsLogIpActionsLookupIp(?, ?, ?, ?)", CONNECTION_ASYNC); //AccountID int, CharacterID int, LogType tinyint, Note text //adjusted calling procedure to remove second accountID reference.
    // 0: uint32, 1: uint32, 2: uint8, 3: uint32, 4: string // Complete name: "Login_Insert_FailedAccountLogin_IP_Logging"
    PrepareStatement(LOGIN_INS_FACL_IP_LOGGING, "call sp_InsLogIpActionsLookupIp(?, ?, ?, ?)", CONNECTION_ASYNC); //AccountID int, CharacterID int, LogType tinyint, Note text
    // 0: uint32, 1: uint32, 2: uint8, 3: string, 4: string // Complete name: "Login_Insert_CharacterDelete_IP_Logging"
    PrepareStatement(LOGIN_INS_CHAR_IP_LOGGING, "call sp_InsLogIpActions(?, ?, ? ,? ,?)", CONNECTION_ASYNC); //AccountID int, CharacterID int, LogType tinyint, Note text, IP nvarchar(64) //reversed note and IP in calling procedure.
    // 0: string, 1: string, 2: string                      // Complete name: "Login_Insert_Failed_Account_Login_due_password_IP_Logging"
    PrepareStatement(LOGIN_INS_FALP_IP_LOGGING, "call sp_InsLogIpActionsPassFail(?, ?, ?)", CONNECTION_ASYNC); //UserName nvarchar(32), IP nvarchar(64), Note text
    PrepareStatement(LOGIN_INS_ACCOUNT_MUTE, "call sp_InsAccMute(?, ?, ?, ?)", CONNECTION_ASYNC); //AccountID int, Age int, MuteBy nvarchar(64), MuteReason nvarchar(256)
    PrepareStatement(LOGIN_INS_ACCOUNT, "call sp_InsAcc(?, ?, ?)", CONNECTION_ASYNC); //UserName nvarchar(32), Password nvarchar(64), Expansions tinyint
    PrepareStatement(LOGIN_INS_REALM_CHARACTERS_INIT, "call sp_InsRealmCharsInit()", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_INS_ACCOUNT_ACCESS, "call sp_InsAccAccess(?, ? , ?)", CONNECTION_ASYNC); //AccountID int, AccessLevel tinyint, RealmID int
    PrepareStatement(LOGIN_INS_IP_BANNED, "call sp_InsIpBan(?, ?, ?, ?)", CONNECTION_ASYNC); //IP nvarchar(64), Age int, BanBy nvarchar(64), BanReason nvarchar(256)
    PrepareStatement(LOGIN_INS_ACCOUNT_BANNED, "call sp_InsAccBan(?, ?, ?, ?)", CONNECTION_ASYNC); //AccountID int, Age int, BannedBy nvarchar(64), BanReason nvarchar(256)
    PrepareStatement(LOGIN_INS_REALM_CHARACTERS, "call sp_InsRealmChars(?, ?, ?)", CONNECTION_ASYNC); //NumberOfCharacters int, AccountID int, RealmID int
    PrepareStatement(LOGIN_INS_ACCOUNT_AUTO_BANNED, "call sp_InsAutoAccBan(?, ?)", CONNECTION_ASYNC); //AccountID int, Age int
    PrepareStatement(LOGIN_INS_IP_AUTO_BANNED, "call sp_InsAutoIpBan(?, ?)", CONNECTION_ASYNC); //IP nvarchar(64), Age int

    //Update Calls
    PrepareStatement(LOGIN_UPD_EXPIRED_ACCOUNT_BANS, "call sp_UpdExpAccBansAll()", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_UPD_FAILEDLOGINS, "call sp_UpdAccFailedLoginByUser(?)", CONNECTION_ASYNC); //UserName nvarchar(32)
    PrepareStatement(LOGIN_UPD_VS, "call sp_UpdVSByUser(?, ?, ?)", CONNECTION_ASYNC); //UserName nvarchar(32), V nvarchar(64), S nvarchar(64) //adjusted order to put UserName first.
    PrepareStatement(LOGIN_UPD_LOGONPROOF, "call sp_UpdAccLogonProofByUser(?, ?, ?, ?, ?)", CONNECTION_SYNCH); //UserName nvarchar(32), SessionKey nvarchar(128), LastIP nvarchar(64), Locale tinyint, OS nvarchar(8) //adjusted order to put UserName first.
    PrepareStatement(LOGIN_UPD_ACCOUNT_NOT_BANNED, "call sp_UpdAccBanUnbanByAcc(?)", CONNECTION_ASYNC); //AccountID int
    PrepareStatement(LOGIN_UPD_EXPANSION, "call sp_UpdAccExpacByAcc(?, ?)", CONNECTION_ASYNC); //Expansions tinyint, AccountID int
    PrepareStatement(LOGIN_UPD_ACCOUNT_LOCK, "call sp_UpdAccLockByAcc(?, ?)", CONNECTION_ASYNC); //Locked tinyint, AccountID int
    PrepareStatement(LOGIN_UPD_ACCOUNT_LOCK_CONTRY, "call sp_UpdAccLockCountryByAcc(?, ?)", CONNECTION_ASYNC); //Country nvarchar(2), AccountID int
    PrepareStatement(LOGIN_UPD_USERNAME, "call sp_UpdAccUserByAcc(?, ?, ?)", CONNECTION_ASYNC); //AccountID int, UserName nvarchar(32), Password nvarchar(64) //adjusted order to put ID first.
    PrepareStatement(LOGIN_UPD_PASSWORD, "call sp_UpdAccPassByAcc(?, ?)", CONNECTION_ASYNC); //AccountID int, Password nvarchar(64) //adjusted order to put ID first.
    PrepareStatement(LOGIN_UPD_MUTE_TIME, "call sp_UpdAccMuteByAcc(?, ?, ?, ?)", CONNECTION_ASYNC); //AccountID int, Age bigint, MuteRason nvarchar(256), MuteBy nvarchar(64) //adjusted order to put ID first.
    PrepareStatement(LOGIN_UPD_MUTE_TIME_LOGIN, "call sp_UpdAccMuteTimeByAcc(?, ?)", CONNECTION_ASYNC); //AccountID int, Age bigint //adjusted order to put ID first.
    PrepareStatement(LOGIN_UPD_LAST_IP, "call sp_UpdAccLastIpByUser(?, ?)", CONNECTION_ASYNC); //UserName nvarchar(32), IP nvarchar(64) //adjusted order to put UserName first.
    PrepareStatement(LOGIN_UPD_LAST_ATTEMPT_IP, "call sp_UpdAccLastAttemptIpByUser(?, ?)", CONNECTION_ASYNC); //UserName nvarchar(32), IP nvarchar(64) //adjusted order to put UserName first.
    PrepareStatement(LOGIN_UPD_ACCOUNT_ONLINE, "call sp_UpdAccOnlineByAcc(?, ?)", CONNECTION_ASYNC); //AccountID int, Online int //adjusted order to put ID first.
    PrepareStatement(LOGIN_UPD_UPTIME_PLAYERS, "call sp_UpdUptimeByRealmNStart(?, ?, ?, ?)", CONNECTION_ASYNC); //RealmID int, Start int, Uptime int, MaxPlayers smallint //adjusted order in calling procedure.
}
