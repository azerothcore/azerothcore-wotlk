-- DB update 2020_11_24_01 -> 2020_11_25_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_11_24_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_11_24_01 2020_11_25_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606162431492361200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606162431492361200');
DELETE `creature`, `creature_addon`, `waypoint_data`
FROM
    `creature`, `creature_addon`, `waypoint_data`
WHERE
    `creature`.`guid` = 203340 AND `creature`.`guid` = `creature_addon`.`guid` AND `creature_addon`.`path_id` = `waypoint_data`.`id`;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
