-- DB update 2021_03_28_00 -> 2021_04_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_characters' AND COLUMN_NAME = '2021_03_28_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_characters CHANGE COLUMN 2021_03_28_00 2021_04_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_characters WHERE sql_rev = '1617907126348389400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_characters` (`sql_rev`) VALUES ('1617907126348389400');

-- Keep only the highest guid PvE or PvP (not bones) corpse per player guid
DELETE c FROM `corpse` c LEFT JOIN
(
    SELECT MAX(`corpseGuid`) AS id
    FROM `corpse`
    WHERE `corpseType` IN (1,2)
    GROUP BY `guid`
) corpsetemp
ON c.`corpseGuid` = corpsetemp.`id`
WHERE corpsetemp.`id` IS NULL;

-- Remove corpseGUID and set key to player guid
ALTER TABLE `corpse` DROP `corpseGuid`, DROP INDEX `idx_player`, ADD PRIMARY KEY (`guid`);

UPDATE `auctionhouse` SET `time` = 0, `auctioneerguid` = 7;
ALTER TABLE `auctionhouse` CHANGE `auctioneerguid` `houseid` TINYINT(3)  UNSIGNED NOT NULL DEFAULT '7' AFTER `id`;

ALTER TABLE `characters` CHANGE `transguid` `transguid` MEDIUMINT DEFAULT 0 NOT NULL;

ALTER TABLE `groups` CHANGE `icon1` `icon1` BIGINT UNSIGNED NOT NULL;
ALTER TABLE `groups` CHANGE `icon2` `icon2` BIGINT UNSIGNED NOT NULL;
ALTER TABLE `groups` CHANGE `icon3` `icon3` BIGINT UNSIGNED NOT NULL;
ALTER TABLE `groups` CHANGE `icon4` `icon4` BIGINT UNSIGNED NOT NULL;
ALTER TABLE `groups` CHANGE `icon5` `icon5` BIGINT UNSIGNED NOT NULL;
ALTER TABLE `groups` CHANGE `icon6` `icon6` BIGINT UNSIGNED NOT NULL;
ALTER TABLE `groups` CHANGE `icon7` `icon7` BIGINT UNSIGNED NOT NULL;
ALTER TABLE `groups` CHANGE `icon8` `icon8` BIGINT UNSIGNED NOT NULL;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
