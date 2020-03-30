-- DB update 2020_03_29_01 -> 2020_03_30_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_03_29_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_03_29_01 2020_03_30_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1582823894137331500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1582823894137331500');

-- Set movement type for formation members
UPDATE `creature` SET `MovementType` = 0 WHERE `guid` IN (6886, 6883, 6880, 6877);

-- Deactivate paths for formation members
UPDATE `creature_addon` SET `path_id` = 0 WHERE `guid` IN (6886, 6883, 6880, 6877);

-- Create formation
DELETE FROM `creature_formations` WHERE `leaderGUID` = 6885;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(6885, 6885, 0, 0, 515, 0, 0),
(6885, 6886, 3, 0, 515, 0, 0),
(6885, 6883, 6, 0, 515, 0, 0),
(6885, 6880, 9, 0, 515, 0, 0),
(6885, 6877, 12, 0, 515, 0, 0);

-- Delete unused waypoints
DELETE FROM `waypoint_data` WHERE `id` IN (68860, 68830, 68800, 68770);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
