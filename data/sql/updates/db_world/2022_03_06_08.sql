-- DB update 2022_03_06_07 -> 2022_03_06_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_06_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_06_07 2022_03_06_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1646081535601402400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1646081535601402400');

SET @NPC := 225;
SET @PATH := @NPC * 10;

DELETE FROM `creature_addon` WHERE `guid` = @NPC;
INSERT INTO `creature_addon` (`guid`, `path_id`) VALUES (@NPC, @PATH);
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = @NPC;

DELETE FROM `waypoint_data` WHERE `id` = @PATH;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`) VALUES
(@PATH, 1, -5711.44, -553.78, 398.49, 0, 0),
(@PATH, 2, -5701.5, -556.94, 399.42, 0, 0),
(@PATH, 3, -5690.68, -562.23, 399.75, 0, 0),
(@PATH, 4, -5686.02, -576.38, 401.57, 0, 0),
(@PATH, 5, -5703.14, -576.05, 401.19, 0, 0),
(@PATH, 6, -5712.95, -566.86, 399.93, 0, 0),
(@PATH, 7, -5719.97, -550.44, 398.7, 0, 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_06_08' WHERE sql_rev = '1646081535601402400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
