-- DB update 2021_06_13_04 -> 2021_06_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_13_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_13_04 2021_06_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1622966158177775526'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622966158177775526');

-- Removes lvl 27 Cuirboulli Boots from lvl 21 Blackfathom Tide Priestess
DELETE FROM `creature_loot_template` WHERE `Entry` = 4802 AND `Item` = 2143;

-- Removes lvl 27 Cuirboulli Boots from lvl 21 Blackfathom Oracle
DELETE FROM `creature_loot_template` WHERE `Entry` = 4803 AND `Item` = 2143;

-- Removes lvl 65 Idol of Brutality from lvl 59 Hive'Zora Tunneler
DELETE FROM `creature_loot_template` WHERE `Entry` = 11726 AND `Item` = 23198;

-- Removes lvl 65 Idol of Brutality from lvl 60 Twilight Stonecaller
DELETE FROM `creature_loot_template` WHERE `Entry` = 11882 AND `Item` = 23198;

-- Removes lvl 17 Stonesplinter Rags from lvl 12 Stonesplinter Scout
DELETE FROM `creature_loot_template` WHERE `Entry` = 1162 AND `Item` = 5109;

-- Removes lvl 17 Stonesplinter Rags from lvl 12 Stonesplinter Trogg
DELETE FROM `creature_loot_template` WHERE `Entry` = 1161 AND `Item` = 5109;

-- Removes lvl 23 Scouting Spaulders from lvl 18 Foreman Thistlenettle
DELETE FROM `creature_loot_template` WHERE `Entry` = 626 AND `Item` = 6588;

-- Removes lvl 65 Idol of Brutality from lvl 60 Scourge Champion
DELETE FROM `creature_loot_template` WHERE `Entry` = 8529 AND `Item` = 23198;

-- Removes lvl 65 Idol of Brutality from lvl 60 Hive'Zora Hive Sister
DELETE FROM `creature_loot_template` WHERE `Entry` = 11729 AND `Item` = 23198;

-- Removes lvl 65 Idol of Brutality from lvl 60 Hive'Regal Ambusher
DELETE FROM `creature_loot_template` WHERE `Entry` = 11730 AND `Item` = 23198;

-- Removes lvl 65 Idol of Brutality from lvl 60 Hive'Regal Spitfire
DELETE FROM `creature_loot_template` WHERE `Entry` = 11732 AND `Item` = 23198;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_14_00' WHERE sql_rev = '1622966158177775526';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
