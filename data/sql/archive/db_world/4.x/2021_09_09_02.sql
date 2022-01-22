-- DB update 2021_09_09_01 -> 2021_09_09_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_09_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_09_01 2021_09_09_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630953928818908826'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630953928818908826');

-- Added 2 new spawns and changed the coords according to sniff
DELETE FROM `creature` WHERE (`id` = 10644);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(32884, 10644, 1, 331, 0, 1, 1, 165, 0, 3528.78, 628.189, 9.04502, 5.20659, 36000, 10, 0, 573, 0, 1, 0, 0, 0, '', 0),
(51885, 10644, 1, 331, 0, 1, 1, 0, 0, 3330.55, 397.033, 3.7174, 0.0612236, 36000, 5, 0, 573, 0, 1, 0, 0, 0, '', 0),
(945802, 10644, 1, 331, 0, 1, 1, 0, 0, 3823.67, 52.756, 10.97, 5.73397, 36000, 5, 0, 1, 0, 1, 0, 0, 0, '', 0),
(945803, 10644, 1, 331, 0, 1, 1, 0, 0, 3498.51, 416.076, -0.199577, 0.926322, 36000, 10, 0, 1, 0, 1, 0, 0, 0, '', 0);

-- Add the new spawns to the same spawn pool so he can only be spawned once at a time
DELETE FROM `pool_template` WHERE `entry` = 375;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)  VALUES (375, 1, "Mist Howler Spawns");

DELETE FROM `pool_creature` WHERE `guid` IN (32884, 51885, 945802, 945803);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(32884, 375, 0, "Mist Howler Spawn 1"),
(51885, 375, 0, "Mist Howler Spawn 2"),
(945802, 375, 0, "Mist Howler Spawn 3"),
(945803, 375, 0, "Mist Howler Spawn 4");


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_09_02' WHERE sql_rev = '1630953928818908826';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
