-- DB update 2022_01_31_02 -> 2022_02_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_31_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_31_02 2022_02_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1642953762715459200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642953762715459200');

UPDATE `smart_scripts` SET `id`=19 WHERE `entryorguid`=12818 AND `source_type`=0 AND `id`=18 AND `event_type`=11;
UPDATE `smart_scripts` SET `link`=18 WHERE `entryorguid`=12818 AND `source_type`=0 AND `id`=17;
DELETE FROM `smart_scripts` WHERE `entryorguid`=12818 AND `source_type`=0 AND `id`=18;
INSERT INTO `smart_scripts` VALUES
(12818,0,18,0,61,0,100,0,0,0,0,0,0,26,6482,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Ruul Snowhoof - On Waypoint Finished - Quest Complete');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_01_00' WHERE sql_rev = '1642953762715459200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
