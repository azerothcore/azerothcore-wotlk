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

#include "LoginDatabase.h"
#include "MySQLPreparedStatement.h"

void LoginDatabaseConnection::DoPrepareStatements()
{
    if (!m_reconnecting)
        m_stmts.resize(MAX_LOGINDATABASE_STATEMENTS);

    PrepareStatement(LOGIN_SEL_LOGONCHALLENGE,
        "SELECT a.ID, a.Username, a.Locked, a.LockCountry, a.LastIP, a.FailedLogins, "
        "ab.UnbanDate > UNIX_TIMESTAMP() OR ab.UnbanDate = ab.BanDate, ab.UnbanDate = ab.BanDate, "
        "ipb.UnbanDate > UNIX_TIMESTAMP() OR ipb.UnbanDate = ipb.BanDate, ipb.UnbanDate = ipb.BanDate, "
        "aa.GMLevel, a.TOTPSecret, a.Salt, a.Verifier "
        "FROM account a "
        "LEFT JOIN account_access aa ON a.ID = aa.ID "
        "LEFT JOIN account_banned ab ON ab.ID = a.ID AND ab.Active = 1 "
        "LEFT JOIN ip_banned ipb ON ipb.IP = ? "
        "WHERE a.Username = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_SEL_RECONNECTCHALLENGE,
        "SELECT a.ID, a.Username, a.Locked, a.LockCountry, a.LastIP, a.FailedLogins, "
        "ab.UnbanDate > UNIX_TIMESTAMP() OR ab.UnbanDate = ab.BanDate, ab.UnbanDate = ab.BanDate, "
        "ipb.UnbanDate > UNIX_TIMESTAMP() OR ipb.UnbanDate = ipb.BanDate, ipb.UnbanDate = ipb.BanDate, "
        "aa.GMLevel, a.SessionKey "
        "FROM account a "
        "LEFT JOIN account_access aa ON a.ID = aa.ID "
        "LEFT JOIN account_banned ab ON ab.ID = a.ID AND ab.Active = 1 "
        "LEFT JOIN ip_banned ipb ON ipb.IP = ? "
        "WHERE a.Username = ? AND a.SessionKey IS NOT NULL", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_SEL_ACCOUNT_INFO_BY_NAME, "SELECT a.ID, a.SessionKey, a.LastIP, a.Locked, a.LockCountry, a.Expansion, a.MuteTime, a.Locale, a.Recruiter, a.OS, a.TotalTime, "
        "aa.GMLevel, ab.UnbanDate > UNIX_TIMESTAMP() OR ab.UnbanDate = ab.BanDate, r.ID FROM account a LEFT JOIN account_access aa ON a.ID = aa.ID AND aa.RealmID IN (-1, ?) "
        "LEFT JOIN account_banned ab ON a.ID = ab.ID AND ab.Active = 1 LEFT JOIN account r ON a.ID = r.Recruiter WHERE a.Username = ? "
        "AND a.SessionKey IS NOT NULL ORDER BY aa.RealmID DESC LIMIT 1", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_SEL_IP_INFO, "SELECT UnbanDate > UNIX_TIMESTAMP() OR UnbanDate = BanDate AS banned, NULL as country FROM ip_banned WHERE IP = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_SEL_REALMLIST, "SELECT ID, Name, Address, LocalAddress, LocalSubnetMask, Port, Icon, Flags, Timezone, AllowedSecurityLevel, Population, Build FROM realmlist WHERE Flags <> 3 ORDER BY Name", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_DEL_EXPIRED_IP_BANS, "DELETE FROM ip_banned WHERE UnbanDate<>BanDate AND UnbanDate<=UNIX_TIMESTAMP()", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_EXPIRED_ACCOUNT_BANS, "UPDATE account_banned SET Active = 0 WHERE Active = 1 AND UnbanDate<>BanDate AND UnbanDate<=UNIX_TIMESTAMP()", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_SEL_IP_BANNED, "SELECT * FROM ip_banned WHERE IP = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_INS_IP_AUTO_BANNED, "INSERT INTO ip_banned (IP, BanDate, UnbanDate, BannedBy, BanReason) VALUES (?, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()+?, 'Acore realmd', 'Failed login autoban')", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_SEL_IP_BANNED_ALL, "SELECT IP, BanDate, UnbanDate, BannedBy, BanReason FROM ip_banned WHERE (BanDate = UnbanDate OR UnbanDate > UNIX_TIMESTAMP()) ORDER BY UnbanDate", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_IP_BANNED_BY_IP, "SELECT IP, BanDate, UnbanDate, BannedBy, BanReason FROM ip_banned WHERE (BanDate = UnbanDate OR UnbanDate > UNIX_TIMESTAMP()) AND IP LIKE CONCAT('%%', ?, '%%') ORDER BY UnbanDate", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_ACCOUNT_BANNED, "SELECT BanDate, UnbanDate FROM account_banned WHERE ID = ? AND Active = 1", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_ACCOUNT_BANNED_ALL, "SELECT account.ID, Username FROM account, account_banned WHERE account.ID = account_banned.ID AND Active = 1 GROUP BY account.ID", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_ACCOUNT_BANNED_BY_USERNAME, "SELECT account.ID, Username FROM account, account_banned WHERE account.ID = account_banned.ID AND Active = 1 AND Username LIKE CONCAT('%%', ?, '%%') GROUP BY account.ID", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_INS_ACCOUNT_AUTO_BANNED, "INSERT INTO account_banned VALUES (?, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()+?, 'Acore realmd', 'Failed login autoban', 1)", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_DEL_ACCOUNT_BANNED, "DELETE FROM account_banned WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_LOGON, "UPDATE account SET Salt = ?, Verifier = ? WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_LOGONPROOF, "UPDATE account SET SessionKey = ?, LastIP = ?, LastLogin = NOW(), Locale = ?, FailedLogins = 0, OS = ? WHERE Username = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_UPD_FAILEDLOGINS, "UPDATE account SET FailedLogins = FailedLogins + 1 WHERE Username = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_SEL_FAILEDLOGINS, "SELECT ID, FailedLogins FROM account WHERE Username = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_ACCOUNT_ID_BY_NAME, "SELECT ID FROM account WHERE Username = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_ACCOUNT_LIST_BY_NAME, "SELECT ID, Username FROM account WHERE Username = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_ACCOUNT_LIST_BY_EMAIL, "SELECT ID, Username FROM account WHERE Email = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_NUM_CHARS_ON_REALM, "SELECT NumChars FROM realm_characters WHERE RealmID = ? AND AccountID = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_REALM_CHARACTER_COUNTS, "SELECT RealmID, NumChars FROM realm_characters WHERE AccountID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_SEL_ACCOUNT_BY_IP, "SELECT ID, Username FROM account WHERE LastIP = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_ACCOUNT_BY_ID, "SELECT 1 FROM account WHERE ID = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_INS_IP_BANNED, "INSERT INTO ip_banned (IP, BanDate, UnbanDate, BannedBy, BanReason) VALUES (?, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()+?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_DEL_IP_NOT_BANNED, "DELETE FROM ip_banned WHERE IP = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_INS_ACCOUNT_BANNED, "INSERT INTO account_banned VALUES (?, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()+?, ?, ?, 1)", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_ACCOUNT_NOT_BANNED, "UPDATE account_banned SET Active = 0 WHERE ID = ? AND Active != 0", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_DEL_REALM_CHARACTERS, "DELETE FROM realm_characters WHERE AccountID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_REP_REALM_CHARACTERS, "REPLACE INTO realm_characters (NumChars, AccountID, RealmID) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_SEL_SUM_REALM_CHARACTERS, "SELECT SUM(NumChars) FROM realm_characters WHERE AccountID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_INS_ACCOUNT, "INSERT INTO account(Username, Salt, Verifier, Expansion, JoinDate) VALUES(?, ?, ?, ?, NOW())", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_INS_REALM_CHARACTERS_INIT, "INSERT INTO realm_characters (RealmID, AccountID, NumChars) SELECT realmlist.ID, account.ID, 0 FROM realmlist, account LEFT JOIN realm_characters ON AccountID=account.ID WHERE AccountID IS NULL", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_EXPANSION, "UPDATE account SET Expansion = ? WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_ACCOUNT_LOCK, "UPDATE account SET Locked = ? WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_ACCOUNT_LOCK_COUNTRY, "UPDATE account SET LockCountry = ? WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_USERNAME, "UPDATE account SET Username = ? WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_MUTE_TIME, "UPDATE account SET MuteTime = ? , MuteReason = ? , MutedBy = ? WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_MUTE_TIME_LOGIN, "UPDATE account SET MuteTime = ? WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_LAST_IP, "UPDATE account SET LastIP = ? WHERE Username = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_LAST_ATTEMPT_IP, "UPDATE account SET LastAttemptIP = ? WHERE Username = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_ACCOUNT_ONLINE, "UPDATE account SET Online = ? WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_UPD_UPTIME_PLAYERS, "UPDATE uptime SET Uptime = ?, MaxPlayers = ? WHERE RealmID = ? AND StartTime = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_DEL_OLD_LOGS, "DELETE FROM logs WHERE (Time + ?) < ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_DEL_ACCOUNT_ACCESS, "DELETE FROM account_access WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_DEL_ACCOUNT_ACCESS_BY_REALM, "DELETE FROM account_access WHERE ID = ? AND (RealmID = ? OR RealmID = -1)", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_INS_ACCOUNT_ACCESS, "INSERT INTO account_access (ID,GMLevel,RealmID) VALUES (?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_GET_ACCOUNT_ID_BY_USERNAME, "SELECT ID FROM account WHERE Username = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_GET_ACCOUNT_ACCESS_GMLEVEL, "SELECT GMLevel FROM account_access WHERE ID = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_GET_GMLEVEL_BY_REALMID, "SELECT GMLevel FROM account_access WHERE ID = ? AND (RealmID = ? OR RealmID = -1)", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_GET_USERNAME_BY_ID, "SELECT Username FROM account WHERE ID = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_CHECK_PASSWORD, "SELECT Salt, Verifier FROM account WHERE ID = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_CHECK_PASSWORD_BY_NAME, "SELECT Salt, Verifier FROM account WHERE Username = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_PINFO, "SELECT a.Username, aa.GMLevel, a.Email, a.RegMail, a.LastIP, DATE_FORMAT(a.LastLogin, '%Y-%m-%d %T'), a.MuteTime, a.MuteReason, a.MutedBy, a.FailedLogins, a.Locked, a.OS FROM account a LEFT JOIN account_access aa ON (a.ID = aa.ID AND (aa.RealmID = ? OR aa.RealmID = -1)) WHERE a.ID = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_PINFO_BANS, "SELECT UnbanDate, BanDate = UnbanDate, BannedBy, BanReason FROM account_banned WHERE ID = ? AND Active ORDER BY BanDate ASC LIMIT 1", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_GM_ACCOUNTS, "SELECT a.Username, aa.GMLevel FROM account a, account_access aa WHERE a.ID=aa.ID AND aa.GMLevel >= ? AND (aa.RealmID = -1 OR aa.RealmID = ?)", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_ACCOUNT_INFO, "SELECT a.Username, a.LastIP, aa.GMLevel, a.Expansion FROM account a LEFT JOIN account_access aa ON (a.ID = aa.ID) WHERE a.ID = ? ORDER BY a.LastIP", CONNECTION_SYNCH); // Only used in ".account onlinelist" command
    PrepareStatement(LOGIN_SEL_ACCOUNT_ACCESS_GMLEVEL_TEST, "SELECT 1 FROM account_access WHERE ID = ? AND GMLevel > ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_ACCOUNT_ACCESS, "SELECT a.ID, aa.GMLevel, aa.RealmID FROM account a LEFT JOIN account_access aa ON (a.ID = aa.ID) WHERE a.Username = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_ACCOUNT_RECRUITER, "SELECT 1 FROM account WHERE Recruiter = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_BANS, "SELECT 1 FROM account_banned WHERE ID = ? AND Active = 1 UNION SELECT 1 FROM ip_banned WHERE IP = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_ACCOUNT_WHOIS, "SELECT Username, Email, LastIP FROM account WHERE ID = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_LAST_ATTEMPT_IP, "SELECT LastAttemptIP FROM account WHERE ID = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_LAST_IP, "SELECT LastIP FROM account WHERE ID = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_SEL_REALMLIST_SECURITY_LEVEL, "SELECT AllowedSecurityLevel from realmlist WHERE ID = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_DEL_ACCOUNT, "DELETE FROM account WHERE ID = ?", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_SEL_AUTOBROADCAST, "SELECT ID, Weight, Text FROM auto_broadcast WHERE RealmID = ? OR RealmID = -1", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_INS_ACCOUNT_MUTE, "INSERT INTO account_muted VALUES (?, UNIX_TIMESTAMP(), ?, ?, ?)", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_SEL_ACCOUNT_MUTE_INFO, "SELECT MuteDate, MuteTime, MuteReason, MutedBy FROM account_muted WHERE GUID = ? ORDER BY MuteDate ASC", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_DEL_ACCOUNT_MUTED, "DELETE FROM account_muted WHERE GUID = ?", CONNECTION_ASYNC);
    // 0: uint32, 1: uint32, 2: uint8, 3: uint32, 4: string // Complete name: "Login_Insert_AccountLoginDeLete_IP_Logging"
    PrepareStatement(LOGIN_INS_ALDL_IP_LOGGING, "INSERT INTO logs_ip_actions (AccountID,CharacterGUID,Type,IP,SystemNote,UnixTime,Time) VALUES (?, ?, ?, (SELECT LastIP FROM account WHERE ID = ?), ?, unix_timestamp(NOW()), NOW())", CONNECTION_ASYNC);
    // 0: uint32, 1: uint32, 2: uint8, 3: uint32, 4: string // Complete name: "Login_Insert_FailedAccountLogin_IP_Logging"
    PrepareStatement(LOGIN_INS_FACL_IP_LOGGING, "INSERT INTO logs_ip_actions (AccountID,CharacterGUID,Type,IP,SystemNote,UnixTime,Time) VALUES (?, ?, ?, (SELECT LastAttemptIP FROM account WHERE ID = ?), ?, unix_timestamp(NOW()), NOW())", CONNECTION_ASYNC);
    // 0: uint32, 1: uint32, 2: uint8, 3: string, 4: string // Complete name: "Login_Insert_CharacterDelete_IP_Logging"
    PrepareStatement(LOGIN_INS_CHAR_IP_LOGGING, "INSERT INTO logs_ip_actions (AccountID,CharacterGUID,Type,IP,SystemNote,UnixTime,Time) VALUES (?, ?, ?, ?, ?, unix_timestamp(NOW()), NOW())", CONNECTION_ASYNC);
    // 0: string, 1: string, 2: string                      // Complete name: "Login_Insert_Failed_Account_Login_due_password_IP_Logging"
    PrepareStatement(LOGIN_INS_FALP_IP_LOGGING, "INSERT INTO logs_ip_actions (AccountID,CharacterGUID,Type,IP,SystemNote,UnixTime,Time) VALUES ((SELECT ID FROM account WHERE Username = ?), 0, 1, ?, ?, unix_timestamp(NOW()), NOW())", CONNECTION_ASYNC);

    // DB logging
    PrepareStatement(LOGIN_INS_LOG, "INSERT INTO logs (Time, Realm, Type, Level, String) VALUES (?, ?, ?, ?, ?)", CONNECTION_ASYNC);

    // TOTP
    PrepareStatement(LOGIN_SEL_SECRET_DIGEST, "SELECT Digest FROM secret_digest WHERE ID = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_INS_SECRET_DIGEST, "INSERT INTO secret_digest (ID, Digest) VALUES (?,?)", CONNECTION_ASYNC);
    PrepareStatement(LOGIN_DEL_SECRET_DIGEST, "DELETE FROM secret_digest WHERE ID = ?", CONNECTION_ASYNC);

    PrepareStatement(LOGIN_SEL_ACCOUNT_TOTP_SECRET, "SELECT TOTPSecret FROM account WHERE ID = ?", CONNECTION_SYNCH);
    PrepareStatement(LOGIN_UPD_ACCOUNT_TOTP_SECRET, "UPDATE account SET TOTPSecret = ? WHERE ID = ?", CONNECTION_ASYNC);
}

LoginDatabaseConnection::LoginDatabaseConnection(MySQLConnectionInfo& connInfo) : MySQLConnection(connInfo)
{
}

LoginDatabaseConnection::LoginDatabaseConnection(ProducerConsumerQueue<SQLOperation*>* q, MySQLConnectionInfo& connInfo) : MySQLConnection(q, connInfo)
{
}

LoginDatabaseConnection::~LoginDatabaseConnection()
{
}
