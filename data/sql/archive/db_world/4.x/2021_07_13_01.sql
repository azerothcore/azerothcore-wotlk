-- DB update 2021_07_13_00 -> 2021_07_13_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_13_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_13_00 2021_07_13_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626007477539439387'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626007477539439387');

-- Delete Arathi PVP supplies from Warpwood Stomper, Desert Rumbler, Vekniss Soldier
DELETE FROM `creature_loot_template` WHERE `entry` IN (11465, 11746, 15229) AND `item` IN (20062, 20066);

-- Delete loot table for Field Marshal Oslight 
UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` = 14983;
DELETE FROM `creature_loot_template` WHERE `entry` = 14983;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_13_01' WHERE sql_rev = '1626007477539439387';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
