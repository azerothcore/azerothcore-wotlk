-- DB update 2021_10_07_02 -> 2021_10_07_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_07_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_07_02 2021_10_07_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1632749142653310150'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1632749142653310150');

-- adds another spawn and adds random movement for Lady Sathrah
DELETE FROM `creature` WHERE `id` = 7319 AND `guid` IN (12596, 12605);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(12596, 7319, 1, 141, 0, 1, 1, 0, 0, 10979.6, 1366.13, 1328.87, 1.75107, 120, 5, 0, 230, 249, 1, 0, 0, 0, '', 0),
(12605, 7319, 1, 141, 0, 1, 1, 0, 0, 10993.6, 1686.8, 1291.2, 2.1, 120, 5, 0, 230, 249, 1, 0, 0, 0, '', 0);

-- links both guids to one pool
DELETE FROM `pool_creature` WHERE `guid` IN (12596, 12605);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(12596, 1107, 0, 'Lady Sathrah (7319) Spawn 1'),
(12605, 1107, 0, 'Lady Sathrah (7319) Spawn 2');

-- creates a new pool for Lady Sathrah with a spawn limit of 1
DELETE FROM `pool_template` WHERE `entry` = 1107;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES 
(1107, 1, 'Lady Sathrah (7319) 2 Spawns');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_07_03' WHERE sql_rev = '1632749142653310150';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
