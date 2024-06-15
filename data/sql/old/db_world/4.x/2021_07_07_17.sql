-- DB update 2021_07_07_16 -> 2021_07_07_17
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_07_16';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_07_16 2021_07_07_17 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625511611223853500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625511611223853500');

-- It was set to waypoint movement
UPDATE `creature_template` SET `MovementType` = 0 WHERE (`entry` = 16916);

-- It was set to random movement
UPDATE `creature` SET `MovementType` = 0 WHERE (`id` = 16916) AND (`guid` IN (58691));

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_07_17' WHERE sql_rev = '1625511611223853500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
