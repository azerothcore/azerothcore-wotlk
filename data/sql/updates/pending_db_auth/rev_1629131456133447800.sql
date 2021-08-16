INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1629131456133447800');

ALTER TABLE `account_muted`
CHANGE COLUMN `guid` `accountid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Global Unique Identifier' FIRST,
ADD COLUMN `id` int(10) NOT NULL AUTO_INCREMENT FIRST,
ADD COLUMN `active` tinyint(1) NOT NULL AFTER `mutereason`,
MODIFY COLUMN `mutetime` int(10) NOT NULL DEFAULT 0 AFTER `mutedate`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`) USING BTREE;

ALTER TABLE `account`
DROP COLUMN `mutetime`,
DROP COLUMN `mutereason`,
DROP COLUMN `muteby`;
