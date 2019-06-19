INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1560960241358803400');

-- Change table `logs`
ALTER TABLE `logs` 
DROP COLUMN `type`,
CHANGE COLUMN `time` `Time` int(10) UNSIGNED NOT NULL FIRST,
CHANGE COLUMN `realm` `RealmID` int(10) UNSIGNED NOT NULL AFTER `Time`,
CHANGE COLUMN `level` `LogLevel` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 AFTER `RealmID`,
CHANGE COLUMN `string` `Message` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `LogLevel`,
ADD COLUMN `Filter` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL AFTER `Time`;
