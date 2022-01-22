-- DB update 2021_07_30_01 -> 2021_07_30_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_30_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_30_01 2021_07_30_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627244221682670400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627244221682670400');

-- Updated his movement from 1 to 2
UPDATE `creature_template` SET `MovementType` = 2 WHERE (`entry` = 7045);

-- Updated some Z position on the ptrolling on the 1st spawn
UPDATE `waypoint_data` SET `position_z` = 146.012 WHERE `id` = 33000 AND `point` = 4;
UPDATE `waypoint_data` SET `position_z` = 145.851 WHERE `id` = 33000 AND `point` = 5;
UPDATE `waypoint_data` SET `position_z` = 147.232 WHERE `id` = 33000 AND `point` = 6;
UPDATE `waypoint_data` SET `position_z` = 147.143 WHERE `id` = 33000 AND `point` = 18;
UPDATE `waypoint_data` SET `position_z` = 145.674 WHERE `id` = 33000 AND `point` = 22;
UPDATE `waypoint_data` SET `position_z` = 145.236 WHERE `id` = 33000 AND `point` = 23;
UPDATE `waypoint_data` SET `position_z` = 147.245 WHERE `id` = 33000 AND `point` = 24;

-- Updated some Z position on the ptrolling on the 2nd spawn
UPDATE `waypoint_data` SET `position_z` = 136.235 WHERE `id` = 33020 AND `point` = 2;
UPDATE `waypoint_data` SET `position_z` = 134.413 WHERE `id` = 33020 AND `point` = 3;
UPDATE `waypoint_data` SET `position_z` = 133.234 WHERE `id` = 33020 AND `point` = 4;
UPDATE `waypoint_data` SET `position_z` = 133.913 WHERE `id` = 33020 AND `point` = 6;
UPDATE `waypoint_data` SET `position_z` = 134.101 WHERE `id` = 33020 AND `point` = 8;
UPDATE `waypoint_data` SET `position_z` = 134.512 WHERE `id` = 33020 AND `point` = 11;
UPDATE `waypoint_data` SET `position_z` = 133.584 WHERE `id` = 33020 AND `point` = 13;
UPDATE `waypoint_data` SET `position_z` = 132.754 WHERE `id` = 33020 AND `point` = 14;
UPDATE `waypoint_data` SET `position_z` = 130.811 WHERE `id` = 33020 AND `point` = 16;
UPDATE `waypoint_data` SET `position_z` = 130.332 WHERE `id` = 33020 AND `point` = 17;
UPDATE `waypoint_data` SET `position_z` = 132.321 WHERE `id` = 33020 AND `point` = 18;
UPDATE `waypoint_data` SET `position_z` = 134.327 WHERE `id` = 33020 AND `point` = 24;
UPDATE `waypoint_data` SET `position_z` = 135.192 WHERE `id` = 33020 AND `point` = 25;
UPDATE `waypoint_data` SET `position_z` = 134.327 WHERE `id` = 33020 AND `point` = 27;
UPDATE `waypoint_data` SET `position_z` = 135.192 WHERE `id` = 33020 AND `point` = 28;


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_30_02' WHERE sql_rev = '1627244221682670400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
