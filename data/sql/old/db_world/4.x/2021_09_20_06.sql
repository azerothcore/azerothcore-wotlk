-- DB update 2021_09_20_05 -> 2021_09_20_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_20_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_20_05 2021_09_20_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631712749389773841'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631712749389773841');

-- Adds movement to Spindleweb Lurker's
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 16351 AND `guid` IN (82364, 82374, 82377, 82592, 82597, 82604, 82616, 82617, 82382, 82386, 82480, 82691);

-- Repositioning of one Spindleweb Lurker that spawned in a tree
UPDATE `creature` SET `position_x` = 7110.5, `position_y` = -6149.9, `position_z` = 22.72 WHERE `id` = 16351 AND `guid` = 82604;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_20_06' WHERE sql_rev = '1631712749389773841';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
