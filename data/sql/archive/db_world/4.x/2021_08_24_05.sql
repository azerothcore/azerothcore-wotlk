-- DB update 2021_08_24_04 -> 2021_08_24_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_24_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_24_04 2021_08_24_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629313785965120137'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629313785965120137');

-- Add movement to Marsh Inkspewer
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 750) AND (`guid` IN (42643, 43629, 42837, 43610));

-- Add movement to Marsh Murloc
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 747) AND (`guid` IN (43612, 43607));

-- Add movement to Jarquia
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 9916) AND (`guid` = 43774);

-- Remove movement to prevent clipping
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE (`id` = 752) AND (`guid` = 43658);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_24_05' WHERE sql_rev = '1629313785965120137';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
