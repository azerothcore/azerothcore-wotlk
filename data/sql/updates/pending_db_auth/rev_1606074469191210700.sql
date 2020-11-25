INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1606074469191210700');

delimiter // 
create procedure sp_DelRealmCharsByAccNRealm(vAcctId int, vRealm int)
begin
    DELETE FROM realmcharacters 
    WHERE acctid = vAcctId
    AND realmid = vRealm;
end//

create procedure sp_DelAccAccessByAcc(vAcctId int)
begin
    DELETE FROM account_access 
    WHERE id = vAcctId;
end//

create procedure sp_DelAccAccessByAccNRealm(vAcctId int, vRealm int)
begin
    DELETE FROM account_access 
    WHERE id = vAcctId
    and realmid = IFNULL(nullif(vRealm, ''), -1);
end//

create procedure sp_DelAccBanByAcc(vAcctId int)
begin
    DELETE FROM account_banned 
    WHERE id = vAcctId;
end//

create procedure sp_DelAccByAcc(vAcctId int)
begin
    DELETE FROM account
    WHERE id = vAcctId;
end//

create procedure sp_DelAccMuteByAcc(vAcctId int)
begin
    DELETE FROM account_muted
    WHERE guid = vAcctId;
end//

create procedure sp_DelExpIpBansAll()
begin
    DELETE FROM ip_banned 
    WHERE unbandate <> bandate 
    AND unbandate <= UNIX_TIMESTAMP();
end//

create procedure sp_DelIpBanByIp(vIp nvarchar(64))
begin
    DELETE FROM ip_banned 
    WHERE ip = vIp;
end//

create procedure sp_DelLogsByAge(vAge int, vNow int)
begin
    DELETE FROM logs 
    WHERE (time + vAge) < vNow;
end//

create procedure sp_DelRealmCharsByAcc(vAcctId int)
begin
    DELETE FROM realmcharacters 
    WHERE acctid = vAcctId;
end//

create procedure sp_GetPassCheckByAcc(vAcctId int, vPass nvarchar(64))
begin
    SELECT 1 
    FROM account 
    WHERE id = vAcctId
    AND sha_pass_hash = vPass;
end//

create procedure sp_GetPassCheckByName(vUName nvarchar(32), vPass nvarchar(64))
begin
    SELECT 1 
    FROM account 
    WHERE username = vUName
    AND sha_pass_hash = vPass;
end//

create procedure sp_GetPlayerBansByAcc(vAcctId int)
begin
    SELECT unbandate
        , bandate = unbandate
        , bannedby
        , banreason 
    FROM account_banned 
    WHERE id = vAcctId
    AND active 
    ORDER BY bandate ASC 
    LIMIT 1;
end//

create procedure sp_GetPlayerByRealmNAcc(vRealm int, vAcctId int)
begin
    SELECT a.username
        , aa.gmlevel
        , a.email
        , a.reg_mail
        , a.last_ip
        , DATE_FORMAT(a.last_login, '%Y-%m-%d %T')
        , a.mutetime
        , a.mutereason
        , a.muteby
        , a.failed_logins
        , a.locked
        , a.OS 
    FROM account a 
    LEFT JOIN account_access aa 
        ON a.id = aa.id 
        AND aa.RealmID = ifnull(nullif(vRealm, ''), -1)
    WHERE a.id = vAcctId;
end//

create procedure sp_GetRealmlistAll() 
begin
    SELECT id,
        name
        , address
        , localAddress
        , localSubnetMask
        , port
        , icon
        , flag
        , timezone
        , allowedSecurityLevel
        , population
        , gamebuild
    FROM realmlist
    WHERE flag <> 3
    ORDER BY name;
end//

create procedure sp_GetRecruiterCheckByRec(vRec int)
begin
    SELECT 1 
    FROM account 
    WHERE recruiter = vRec;
end//

create procedure sp_GetSeskeyByUser(vUName nvarchar(32))
begin
    SELECT a.sessionkey
        , a.id
        , aa.gmlevel  
    FROM account a 
    LEFT JOIN account_access aa 
        ON (a.id = aa.id)
    WHERE username = vUName;
end//

create procedure sp_GetSumCharsByAcc(vAcctId int)
begin
    SELECT SUM(numchars) 
    FROM realmcharacters 
    WHERE acctid = vAcctId;
end//

create procedure sp_GetUserByAcc(vAcctId int)
begin
    SELECT username
    FROM account 
    WHERE id = vAcctId;
end//

create procedure sp_GetAccBanAll()
begin
    SELECT a.id
		, a.username 
    FROM account a 
    join account_banned b
        on a.id = b.id 
    where b.active = 1 
    GROUP BY a.id;
end//

create procedure sp_GetAccBanByUser(vUName nvarchar(32))
begin
    SELECT a.account.id, a.username 
    FROM account a
    join account_banned b
        on a.account.id = b.account_banned.id 
    where b.active = 1 
    AND a.username LIKE CONCAT('%', vUName, '%') 
    GROUP BY a.account.id;
end//

create procedure sp_GetAccByEmail(vEmail nvarchar(256))
begin
    SELECT id
        , username
    FROM account 
    WHERE email = vEmail;
end//

create procedure sp_GetAccByIp(vIp nvarchar(64))
begin
    SELECT id 
        , username
    FROM account 
    WHERE last_ip = vIp;
end//

create procedure sp_GetAccByUser(vUName nvarchar(32))
begin
    SELECT id 
        , username
    FROM account 
    WHERE username = vUName;
end//

create procedure sp_GetAccExistById(vAcctId int)
begin
    SELECT 1 
    FROM account 
    WHERE id = vAcctId;
end//

create procedure sp_GetAccIdByUser(vUName nvarchar(32))
begin
    SELECT id 
    FROM account 
    WHERE username = vUName;
end//

create procedure sp_GetAccInfoByUser(vUName nvarchar(32))
begin
    SELECT id
        , sessionkey
        , last_ip
        , locked
        , lock_country
        , expansion
        , mutetime
        , locale
        , recruiter
        , os
        , totaltime
    FROM account 
    WHERE username = vUName;
end//

create procedure sp_GetAccInfoGMExpByAcc(vAcctId int)
begin
    SELECT a.username
        , a.last_ip
        , aa.gmlevel
        , a.expansion 
    FROM account a 
    LEFT JOIN account_access aa 
        ON (a.id = aa.id) 
    WHERE a.id = vAcctId
    ORDER BY a.last_ip;
end//

create procedure sp_GetAccWhoByAcc(vAcctId int)
begin
    SELECT username
        , email
        , last_ip 
    FROM account 
    WHERE id = vAcctId;
end//

create procedure sp_GetAllowSecByRealm(vRealm int)
begin
    SELECT allowedSecurityLevel 
    from realmlist 
    WHERE id = vRealm;
end//

create procedure sp_GetAutoBroadcastByRealm(vRealm int)
begin
    SELECT id
        , weight
        , text 
    FROM autobroadcast 
    WHERE realmid = ifnull(nullif(vRealm, ''), -1);
end//

create procedure sp_GetBanActiveById(vAcctId int)
begin
    SELECT bandate
        , unbandate 
    FROM account_banned 
    WHERE id = vAcctId 
    AND active = 1;
end//

create procedure sp_GetBansByAccOrIp(vAcctId int, vIp nvarchar(64))
begin
    SELECT 1 
    FROM account_banned 
    WHERE id = vAcctId
        AND active = 1
		
    UNION 
	
    SELECT 1 
    FROM ip_banned 
    WHERE ip = vIp;
end//

create procedure sp_GetFailedLogonsByUser(vUName nvarchar(64))
begin
    SELECT id
        , failed_logins 
    FROM account 
    WHERE username = vUName;
end//

create procedure sp_GetGMAccessByAcc(vAcctId int)
begin
    SELECT  aa.gmlevel 
    FROM account_access aa 
    WHERE aa.username = vAcctId;
end//

create procedure sp_GetGMAccessByAccNGMlvl(vAcctId int, vGMLvl int)
begin
    SELECT 1 
    FROM account_access 
    WHERE id = vAcctId
    AND gmlevel > vGMLvl;
end//

create procedure sp_GetGMAccessByAccNRealm(vAcctId int, vRealm int)
begin
    SELECT aa.gmlevel 
    FROM account_access aa 
    where aa.id = vAcctId
    AND aa.realmid = IFNULL(nullif(vRealm, ''), -1);
end//

create procedure sp_GetGMAccessByUser(vUName nvarchar(32))
begin
    SELECT a.id
        , aa.gmlevel
        , aa.RealmID 
    FROM account a 
    LEFT JOIN account_access aa 
        ON (a.id = aa.id) 
    WHERE a.username = vUName;
end//

create procedure sp_GetGMAcctsByMinLvlNRealm(vGMLvl int, vRealm int)
begin
    SELECT a.username
        , aa.gmlevel 
    FROM account a
    join account_access aa 
        on a.id=aa.id 
    where aa.gmlevel >= vGMLvl
    AND aa.realmid = IFNULL(nullif(vRealm, ''), -1);
end//

create procedure sp_GetIpBanAll()
begin
    SELECT ip
        , bandate
        , unbandate
        , bannedby
        , banreason 
    FROM ip_banned 
    WHERE bandate = unbandate

    union

    SELECT ip
        , bandate
        , unbandate
        , bannedby
        , banreason 
    FROM ip_banned 
    WHERE unbandate > UNIX_TIMESTAMP()
    ORDER BY unbandate;
end//

create procedure sp_GetIpBanByIp(vIp nvarchar(64))
begin
    SELECT ip
        , bandate
        , unbandate
        , bannedby
        , banreason
    FROM ip_banned 
    WHERE ip = vIp;
end//

create procedure sp_GetIpBanByIpByIpLike(vIp nvarchar(64))
begin
    SELECT ip
        , bandate
        , unbandate
        , bannedby
        , banreason 
    FROM ip_banned 
    WHERE bandate = unbandate
    AND ip LIKE CONCAT('%%', vIp, '%%') 

    union

    SELECT ip
        , bandate
        , unbandate
        , bannedby
        , banreason 
    FROM ip_banned 
    WHERE unbandate > UNIX_TIMESTAMP()
    AND ip LIKE CONCAT('%%', vIp, '%%') 
    ORDER BY unbandate;
end//

create procedure sp_GetIpCountryByIp(vIp int)
begin
    SELECT c.country 
    FROM ip2nationCountries c
    join ip2nation i 
        on i.ip < vIp 
    where c.code = i.country 
    ORDER BY i.ip DESC 
    LIMIT 0,1;
end//

create procedure sp_GetLastIpAttemptByAcc(vAcctId int)
begin
    select last_attempt_ip
    from account
    where id = vAcctId;
end//

create procedure sp_GetLastIpByAcc(vAcctId int)
begin
    select last_ip
    from account
    where id = vAcctId;
end//

create procedure sp_GetLogonChalByUser(vUName nvarchar(32))
begin
    SELECT a.sha_pass_hash
        , a.id
        , a.locked
        , a.lock_country
        , a.last_ip
        , aa.gmlevel
        , a.v, a.s
        , a.token_key 
    FROM account a 
    LEFT JOIN account_access aa 
        ON (a.id = aa.id) 
    WHERE a.username = vUName;
end//

create procedure sp_GetLogonCountryByIp(vIp int)
begin
    SELECT country 
    FROM ip2nation 
    WHERE ip < vIp
    ORDER BY ip DESC 
    LIMIT 0,1;
end//

create procedure sp_GetMutesByAcc(vAcctId int)
begin
    SELECT mutedate
        , mutetime
        , mutereason
        , mutedby 
    FROM account_muted 
    WHERE guid = vAcctId
    ORDER BY mutedate ASC;
end//

create procedure sp_GetNumCharsByRealmNAcc(vRealmid int, vAcctId int)
begin
    SELECT numchars 
    FROM realmcharacters 
    WHERE realmid = vRealmid
    AND acctid = vAcctId;
end//

create procedure sp_InsRealmCharsInit()
begin
    INSERT INTO realmcharacters 
    (realmid, acctid, numchars)    
    SELECT rl.id
		, a.id
		, 0 
    FROM realmlist rl
	join account a
    LEFT JOIN realmcharacters rlc
        ON rlc.acctid=a.id 
    WHERE rlc.acctid IS NULL;
END//

create procedure sp_InsAcc(vUName nvarchar(32), vPass nvarchar(64), vExpac tinyint)
begin
    INSERT INTO account
    (username, sha_pass_hash, expansion, joindate) 
    VALUES
    (vUName, vPass, vExpac, NOW());
end//

create procedure sp_InsAccAccess(vAcctId int, vGMLvl tinyint, vRealm int)
begin
    INSERT INTO account_access 
    (id, gmlevel, RealmID) 
    VALUES 
    (vAcctId, vGMLvl, vRealm);
end//

create procedure sp_InsAccBan(vAcctId int, vAge int, vBanBy nvarchar(64), vBanReason nvarchar(256))
begin
    INSERT INTO account_banned 
    VALUES 
    (vAcctId, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()+vAge, vBanBy, vBanReason, 1);
end//

create procedure sp_InsAccMute(vAcctId INT, vAge int, vMuteBy nvarchar(64), vMuteReason nvarchar(256))
begin
    INSERT INTO account_muted 
    VALUES 
    (vAcctId, UNIX_TIMESTAMP(), vAge, vMuteBy, vMuteReason);
end//

create procedure sp_InsAutoAccBan(vAcctId int, vAge int)
begin
    INSERT INTO account_banned 
    (id, bandate, unbandate, bannedby, banreason, active)
    VALUES 
    (vAcctId, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()+vAge, 'Trinity realmd', 'Failed login autoban', 1);
end//

create procedure sp_InsAutoIpBan(vIp nvarchar(64), vAge int)
begin
    INSERT INTO ip_banned 
    (ip, bandate, unbandate, bannedby, banreason) 
    VALUES 
    (vIp, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()+vAge, 'Trinity realmd', 'Failed login autoban');
end//

create procedure sp_InsIpBan(vIp nvarchar(64), vAge int, vBanBy nvarchar(64), vBanReason nvarchar(256))
begin
    INSERT INTO ip_banned 
    (ip, bandate, unbandate, bannedby, banreason)
    VALUES 
    (vIp, UNIX_TIMESTAMP(), UNIX_TIMESTAMP()+vAge, vBanBy, vBanReason);
end//

create procedure sp_InsLogIpActions(vAcctId int, vCharId int, vLogType tinyint, vNote text, vIp nvarchar(64))
begin
    INSERT INTO logs_ip_actions 
    (account_id,character_guid,type,ip,systemnote,unixtime,time) 
    VALUES 
    (vAcctId, vCharId, vLogType, vIp, vNote, unix_timestamp(NOW()), NOW());
end//

create procedure sp_InsLogIpActionsLookupIp(vAcctId int, vCharId int, vLogType tinyint, vNote text)
begin
    INSERT INTO logs_ip_actions 
    (account_id,character_guid,type,ip,systemnote,unixtime,time) 
    VALUES 
    (vAcctId, vCharId, vLogType, (SELECT last_ip FROM account WHERE id = vAcctId), vNote, unix_timestamp(NOW()), NOW());
end//

create procedure sp_InsLogIpActionsPassFail(vUName nvarchar(32), vIp nvarchar(64), vNote text)
begin
    INSERT INTO logs_ip_actions 
    (account_id,character_guid,type,ip,systemnote,unixtime,time) 
    VALUES 
    ((SELECT id FROM account WHERE username = vUName), 0, 1, vIp, vNote, unix_timestamp(NOW()), NOW());
end//

create procedure sp_InsRealmChars(vNumChars int, vAcctId int, vRealm int)
begin
    INSERT INTO realmcharacters 
    (numchars, acctid, realmid) 
    VALUES 
    (vNumChars, vAcctId, vRealm);
end//

create procedure sp_UpdVSByUser(vUName nvarchar(32), vV nvarchar(64), vS nvarchar(64))
begin
    UPDATE account 
    SET v = vV
        , s = vS
    WHERE username = vUName;
end//

create procedure sp_UpdAccBanUnbanByAcc(vAcctId int)
begin
    UPDATE account_banned 
    SET active = 0 
    WHERE id = vAcctId
    AND active != 0;
end//

create procedure sp_UpdAccExpacByAcc(vExpac tinyint, vAcctId int)
begin
    UPDATE account 
    SET expansion = vExpac
    WHERE id = vAcctId;
end//

create procedure sp_UpdAccFailedLoginByUser(vUName nvarchar(32))
begin
    UPDATE account 
    SET failed_logins = failed_logins + 1
    WHERE username = vUName;
end//

create procedure sp_UpdAccLastAttemptIpByUser(vUName nvarchar(32), vIp nvarchar(64))
begin
    UPDATE account 
    SET last_attempt_ip = vIp
    WHERE username = vUName;
end//

create procedure sp_UpdAccLastIpByUser(vUName nvarchar(32), vIp nvarchar(64))
begin
    UPDATE account 
    SET last_ip = vIp
    WHERE username = vUName;
end//

create procedure sp_UpdAccLockByAcc(vLock tinyint, vAcctId int)
begin
    UPDATE account 
    SET locked = vLock
    WHERE id = vAcctId;
end//

create procedure sp_UpdAccLockCountryByAcc(vCountry nvarchar(2), vAcctId int)
begin
    UPDATE account 
    SET lock_country = vCountry
    WHERE id = vAcctId;
end//

create procedure sp_UpdAccLogonProofByUser(vUName nvarchar(32), vSKey nvarchar(128), vLastIp nvarchar(64), vLocale tinyint, vOS nvarchar(8))
begin
    UPDATE account 
    SET sessionkey = vSKey
        , last_ip = vLastIp
        , last_login = NOW()
        , locale = vLocale
        , failed_logins = 0
        , os = vOS
    WHERE username = vUName;
end//

create procedure sp_UpdAccMuteByAcc(vAcctId int, vAge bigint, vReason nvarchar(256), vMuteBy nvarchar(64))
begin
    UPDATE account 
    SET mutetime = vAge
        , mutereason = vReason
        , muteby = vMuteBy
    WHERE id = vAcctId;
end//

create procedure sp_UpdAccMuteTimeByAcc(vAcctId int, vAge bigint)
begin
    UPDATE account 
    SET mutetime = vAge
    WHERE id = vAcctId;
end//

create procedure sp_UpdAccOnlineByAcc(vAcctId int, vOnline int)
begin
    UPDATE account 
    SET online = vOnline
    WHERE id = vAcctId;
end//

create procedure sp_UpdAccPassByAcc(vAcctId int, vPass nvarchar(64))
begin
    UPDATE account 
    SET v = 0
        , s = 0
        , sha_pass_hash = vPass
    WHERE id = vAcctId;
end//

create procedure sp_UpdAccUserByAcc(vAcctId int, vUName nvarchar(32), vPass nvarchar(64))
begin
    UPDATE account 
    SET v = 0
        , s = 0
        , username = vUName
        , sha_pass_hash = vPass
    WHERE id = vAcctId;
end//

create procedure sp_UpdExpAccBansAll()
begin
    UPDATE account_banned 
    SET active = 0 
    WHERE active = 1 
    AND unbandate <> bandate 
    AND unbandate <= UNIX_TIMESTAMP();
end//

create procedure sp_UpdUptimeByRealmNStart(vRealm int, vStart int, vUptime int, vMaxP smallint)
begin
    UPDATE uptime 
    SET uptime = vUptime
        , maxplayers = vMaxP
    WHERE realmid = vRealm
    and starttime = vStart;
end//

