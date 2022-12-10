-- DB update 2021_08_07_02 -> 2021_08_07_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_07_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_07_02 2021_08_07_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627898569049526800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627898569049526800');

-- Spawn time changed to 38h, added movement to the spawn of Mongress (14344). Reduced her movement speed from 2.45 to 1
UPDATE `creature_template` SET `MovementType` = 1, `speed_walk` = 1 WHERE (`entry` = 14344);
UPDATE `creature` SET `spawntimesecs` = 136800, `wander_distance` = 10, `MovementType` = 1 WHERE (`id` = 14344) AND (`guid` IN (51895));

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_07_03' WHERE sql_rev = '1627898569049526800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
