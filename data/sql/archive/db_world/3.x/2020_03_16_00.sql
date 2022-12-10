-- DB update 2020_03_15_00 -> 2020_03_16_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_03_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_03_15_00 2020_03_16_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1583690478008671900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1583690478008671900');

-- Set logic ID number
UPDATE `gameobject_template` SET `Data1` = '161495' WHERE `entry` = '161495';

-- Delete old entry and add new one with correct ID
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (11104,161495); -- Secret Safe
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `chance`, `questrequired`,  `groupid`, `mincount`, `maxcount`) VALUES
(161495, 22205, 0, 0, 1, 1, 1),
(161495, 22255, 0, 0, 1, 1, 1),
(161495, 22256, 0, 0, 1, 1, 1),
(161495, 22254, 0, 0, 1, 1, 1),
(161495, 11309, 100, 1, 0, 1, 1);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
