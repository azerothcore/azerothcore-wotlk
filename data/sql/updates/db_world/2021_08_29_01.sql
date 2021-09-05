-- DB update 2021_08_29_00 -> 2021_08_29_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_29_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_29_00 2021_08_29_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629751870485899862'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629751870485899862');

-- Added roaming movement to Arcane Devourer
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 16304) AND (`guid` IN (82405, 82411, 82417, 82424, 82434, 82466));
-- Added roaming movement to Mana Shifter
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 16310) AND (`guid` IN (82399, 82409, 82432, 82462, 82465, 82695));


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_29_01' WHERE sql_rev = '1629751870485899862';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
