-- DB update 2022_03_06_11 -> 2022_03_06_12
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_06_11';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_06_11 2022_03_06_12 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646088431493180100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646088431493180100');

SET @NPC := 733;
SET @PATH := @NPC * 10;

UPDATE `creature_addon` SET `path_id` = @PATH WHERE `guid` = @NPC;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -11916.5, -1089.93, 77.2794, 100, 0),
(@PATH, 2, -11916.5, -1072.16, 77.2796, 100, 0),
(@PATH, 3, -11916.5, -1084.36, 77.2798, 100, 0),
(@PATH, 4, -11916.1, -1116.62, 77.2792, 100, 0),
(@PATH, 5, -11916, -1142.12, 77.2789, 100, 0),
(@PATH, 6, -11916.1, -1121.86, 77.282, 100, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_06_12' WHERE sql_rev = '1646088431493180100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
