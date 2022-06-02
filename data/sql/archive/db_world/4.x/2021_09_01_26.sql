-- DB update 2021_09_01_25 -> 2021_09_01_26
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_01_25';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_01_25 2021_09_01_26 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1630335615911208914'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630335615911208914');

-- Fixed the Ash'ari Crystal (10415) dropping into the ground
UPDATE `creature_template` SET `InhabitType` = 4 WHERE (`entry` = 10415);

-- Added one spawn points to Masophet the Black (16249) in the left Ziggurat
DELETE FROM `creature` WHERE (`id` = 16249) AND (`guid` IN (152293));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(152293, 16249, 530, 0, 0, 1, 1, 0, 1, 6311.317, -6250.117, 80.81, 2, 300, 0, 0, 486, 1202, 0, 0, 0, 0, '', 0);

-- Add the new spawn to the same spawn pool so he can only be spawned once at a time
DELETE FROM `pool_template` WHERE `entry` = 373;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)  VALUES (373, 1, "Masophet the Black Spawns");

DELETE FROM `pool_creature` WHERE `guid` IN (82907, 152293);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(82907, 373, 0, "Masophet the Black Spawn 1"),
(152293, 373, 0, "Masophet the Black Spawn 2");

-- Add the 3 Deatholme Necromancer missing there
DELETE FROM `creature` WHERE (`id` = 16317) AND (`guid` IN (152294, 152295, 152296));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(152294, 16317, 530, 0, 0, 1, 1, 0, 1, 6306.93, -6257.11, 77.81, 1.20, 300, 0, 0, 377, 408, 0, 0, 0, 0, '', 0),
(152295, 16317, 530, 0, 0, 1, 1, 0, 1, 6301.00, -6240.72, 77.81, 5.49, 300, 0, 0, 377, 408, 0, 0, 0, 0, '', 0),
(152296, 16317, 530, 0, 0, 1, 1, 0, 1, 6315.15, -6236.77, 77.81, 4.35, 300, 0, 0, 377, 408, 0, 0, 0, 0, '', 0);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_09_01_26' WHERE sql_rev = '1630335615911208914';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
