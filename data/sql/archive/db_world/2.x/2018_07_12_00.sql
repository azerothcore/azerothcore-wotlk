-- DB update 2018_07_04_00 -> 2018_07_12_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2018_07_04_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2018_07_04_00 2018_07_12_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1530734106945512205'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO version_db_world (`sql_rev`) VALUES ('1530734106945512205');

UPDATE `creature_template` SET `unit_flags` = 0 WHERE `entry` = 7856;
UPDATE `smart_scripts` SET `event_type` = 9, `event_param1` = 2, `event_param2` = 30, `comment` = 'Southsea Freebooter - Within 2-30 Range - Shoot' WHERE `entryorguid` = 7856 AND `id` = 0;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
