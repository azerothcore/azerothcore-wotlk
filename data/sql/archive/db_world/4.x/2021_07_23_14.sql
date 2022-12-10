-- DB update 2021_07_23_13 -> 2021_07_23_14
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_23_13';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_23_13 2021_07_23_14 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626875485474871100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626875485474871100');

-- Added movement to some Burning Blade Fanatic spawns
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 3197) AND (`guid` IN (6417, 6418, 6422, 6426, 6427, 6429, 7334, 7337, 7898, 7900, 7901));
  
--  Added movement to some Burning Blade Apprentice
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE (`id` = 3198) AND (`guid` IN (6420, 6423, 6430, 7339, 6431, 7880, 7883, 7885, 8429));


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_23_14' WHERE sql_rev = '1626875485474871100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
