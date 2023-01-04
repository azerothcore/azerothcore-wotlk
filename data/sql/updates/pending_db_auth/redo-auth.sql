ALTER TABLE `account`
	RENAME COLUMN `id`					TO `ID`,
	RENAME COLUMN `username`			TO `Username`,
	RENAME COLUMN `salt`				TO `Salt`,
	RENAME COLUMN `verifier`			TO `Verifier`,
	RENAME COLUMN `session_key`			TO `SessionKey`,
	RENAME COLUMN `totp_secret`			TO `TOTPSecret`,
	RENAME COLUMN `email`				TO `Email`,
	RENAME COLUMN `reg_mail`			TO `RegMail`,
	RENAME COLUMN `joindate`			TO `JoinDate`,
	RENAME COLUMN `last_ip`				TO `LastIP`,
	RENAME COLUMN `last_attempt_ip`		TO `LastAttemptIP`,
	RENAME COLUMN `failed_logins`		TO `FailedLogins`,
	RENAME COLUMN `locked`				TO `Locked`,
	RENAME COLUMN `lock_country`		TO `LockCountry`,
	RENAME COLUMN `last_login`			TO `LastLogin`,
	RENAME COLUMN `online`				TO `Online`,
	RENAME COLUMN `expansion`			TO `Expansion`,
	RENAME COLUMN `mutetime`			TO `MuteTime`,
	RENAME COLUMN `mutereason`			TO `MuteReason`,
	RENAME COLUMN `muteby`				TO `MutedBy`,
	RENAME COLUMN `locale`				TO `Locale`,
	RENAME COLUMN `os`					TO `OS`,
	RENAME COLUMN `recruiter`			TO `Recruiter`,
	RENAME COLUMN `totaltime`			TO `TotalTime`;
ALTER TABLE `account_access`
	RENAME COLUMN `id`					TO `ID`,
	RENAME COLUMN `gmlevel`				TO `GMLevel`,
	RENAME COLUMN `RealmID`				TO `RealmID`,
	RENAME COLUMN `comment`				TO `Comment`;
ALTER TABLE `account_banned`
	RENAME COLUMN `id`					TO `ID`,
	RENAME COLUMN `bandate`				TO `BanDate`,
	RENAME COLUMN `unbandate`			TO `UnbanDate`,
	RENAME COLUMN `bannedby`			TO `BannedBy`,
	RENAME COLUMN `banreason`			TO `BanReason`,
	RENAME COLUMN `active`				TO `Active`;
ALTER TABLE `account_muted`
	RENAME COLUMN `guid`				TO `GUID`,
	RENAME COLUMN `mutedate`			TO `MuteDate`,
	RENAME COLUMN `mutetime`			TO `MuteTime`,
	RENAME COLUMN `mutedby`				TO `MutedBy`,
	RENAME COLUMN `mutereason`			TO `MuteReason`;
ALTER TABLE `autobroadcast`
	RENAME COLUMN `realmid`				TO `RealmID`,
	RENAME COLUMN `id`					TO `ID`,
	RENAME COLUMN `weight`				TO `Weight`,
	RENAME COLUMN `text`				TO `Text`,
	RENAME 							TO `auto_broadcast`;
ALTER TABLE `build_info`
	RENAME COLUMN `build`				TO `Build`,
	RENAME COLUMN `majorVersion`		TO `MajorVersion`,
	RENAME COLUMN `minorVersion`		TO `MinorVersion`,
	RENAME COLUMN `bugfixVersion`		TO `BugfixVersion`,
	RENAME COLUMN `hotfixVersion`		TO `HotfixVersion`,
	RENAME COLUMN `winAuthSeed`			TO `WinAuthSeed`,
	RENAME COLUMN `win64AuthSeed`		TO `Win64AuthSeed`,
	RENAME COLUMN `mac64AuthSeed`		TO `Mac64AuthSeed`,
	RENAME COLUMN `winChecksumSeed`		TO `WinChecksumSeed`,
	RENAME COLUMN `macChecksumSeed`		TO `MacChecksumSeed`;
ALTER TABLE `ip_banned`
	RENAME COLUMN `ip`					TO `IP`,
	RENAME COLUMN `bandate`				TO `BanDate`,
	RENAME COLUMN `unbandate`			TO `UnbanDate`,
	RENAME COLUMN `bannedby`			TO `BannedBy`,
	RENAME COLUMN `banreason`			TO `BanReason`;
ALTER TABLE `logs`
	RENAME COLUMN `time`				TO `Time`,
	RENAME COLUMN `realm`				TO `Realm`,
	RENAME COLUMN `type`				TO `Type`,
	RENAME COLUMN `level`				TO `Level`,
	RENAME COLUMN `string`				TO `String`;
ALTER TABLE `logs_ip_actions`
	RENAME COLUMN `id`					TO `ID`,
	RENAME COLUMN `account_id`			TO `AccountID`,
	RENAME COLUMN `character_guid`		TO `CharacterGUID`,
	RENAME COLUMN `type`				TO `Type`,
	RENAME COLUMN `ip`					TO `IP`,
	RENAME COLUMN `systemnote`			TO `SystemNote`,
	RENAME COLUMN `unixtime`			TO `UnixTime`,
	RENAME COLUMN `time`				TO `Time`,
	RENAME COLUMN `comment`				TO `Comment`;
ALTER TABLE `realmcharacters`
	RENAME COLUMN `realmid`				TO `RealmID`,
	RENAME COLUMN `acctid`				TO `AccountID`,
	RENAME COLUMN `numchars`			TO `NumChars`,
	RENAME 							TO `realm_characters`;
ALTER TABLE `realmlist`
	RENAME COLUMN `id`					TO `ID`,
	RENAME COLUMN `name`				TO `Name`,
	RENAME COLUMN `address`				TO `Address`,
	RENAME COLUMN `localAddress`		TO `LocalAddress`,
	RENAME COLUMN `localSubnetMask`		TO `LocalSubnetMask`,
	RENAME COLUMN `port`				TO `Port`,
	RENAME COLUMN `icon`				TO `Icon`,
	RENAME COLUMN `flag`				TO `Flags`,
	RENAME COLUMN `timezone`			TO `Timezone`,
	RENAME COLUMN `allowedSecurityLevel`TO `AllowedSecurityLevel`,
	RENAME COLUMN `population`			TO `Population`,
	RENAME COLUMN `gamebuild`			TO `Build`;
ALTER TABLE `secret_digest`
	RENAME COLUMN `id`					TO `ID`,
	RENAME COLUMN `digest`				TO `Digest`;
ALTER TABLE `updates`
	RENAME COLUMN `name`				TO `Name`,
	RENAME COLUMN `hash`				TO `Hash`,
	RENAME COLUMN `state`				TO `State`,
	RENAME COLUMN `timestamp`			TO `Timestamp`,
	RENAME COLUMN `speed`				TO `Duration`;
ALTER TABLE `updates_include`
	RENAME COLUMN `path`				TO `Path`,
	RENAME COLUMN `state`				TO `State`;
ALTER TABLE `uptime`
	RENAME COLUMN `realmid`				TO `RealmID`,
	RENAME COLUMN `starttime`			TO `StartTime`,
	RENAME COLUMN `uptime`				TO `Uptime`,
	RENAME COLUMN `maxplayers`			TO `MaxPlayers`,
	RENAME COLUMN `revision`			TO `Revision`;