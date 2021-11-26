-- DB update 2021_07_10_02 -> 2021_07_11_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_10_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_10_02 2021_07_11_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625925059779148449'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625925059779148449');

-- Kregg Keelhaul
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 8203 AND `guid` = 51834;
-- Licillin
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 2191 AND `guid` = 52009;
-- Carnivous the Breaker
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5  WHERE `id` = 2186 AND `guid` = 51900;
-- Flagglemurk the Cruel
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 7015 AND `guid` = 51899;
-- Lord Sinslayer
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3  WHERE `id` = 7017 AND `guid` = 37089;

-- Correct speeds for Kregg and Licillin
UPDATE `creature_template` SET `speed_walk` = 1 WHERE `entry`IN (8203, 2191);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_11_00' WHERE sql_rev = '1625925059779148449';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
