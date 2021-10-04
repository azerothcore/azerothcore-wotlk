-- DB update 2021_08_26_02 -> 2021_08_26_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_26_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_26_02 2021_08_26_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629435906739087287'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629435906739087287');

-- Add movement to Withered Green Keepers
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 15637 AND `guid` IN (55527, 55528, 55529, 55532, 55533, 55534, 55535, 55569, 55570);

-- Shift one spawn slightly to avoid overlapping
UPDATE `creature` SET `position_x` = 8258, `position_y` = -6136.1, `position_z` = 34.2 WHERE `id` = 15637 AND `guid` = 55534;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_26_03' WHERE sql_rev = '1629435906739087287';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
