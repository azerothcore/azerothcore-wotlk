INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1557238733487498900');

UPDATE `auctionhouse`
SET `time` = 0, `auctioneerguid` = 7;

ALTER TABLE `auctionhouse` CHANGE COLUMN `auctioneerguid` `houseid` TINYINT(3) UNSIGNED NOT NULL DEFAULT '7' AFTER `id`;
