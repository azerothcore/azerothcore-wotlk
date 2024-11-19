-- DB update 2021_07_13_01 -> 2021_07_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_13_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_13_01 2021_07_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626100751770962700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626100751770962700');

-- Add wandering to the NPCs 373, 612, 756, 921 and 1062
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 2 WHERE `id` = 1551 AND `guid` = 373;
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 2 WHERE `id` = 1551 AND `guid` = 612;
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 1551 AND `guid` = 756;
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 1551 AND `guid` = 981;
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 1551 AND `guid` = 1062;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_14_00' WHERE sql_rev = '1626100751770962700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
