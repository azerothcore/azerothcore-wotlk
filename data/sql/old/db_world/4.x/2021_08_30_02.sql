-- DB update 2021_08_30_01 -> 2021_08_30_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_30_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_30_01 2021_08_30_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1629808025047678029'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629808025047678029');

-- Add the new spawns for the item Slagtree's Lost Tools
DELETE FROM `gameobject` WHERE (`id` = 179908) AND `guid` IN (46420, 100510, 100511, 100512, 100513);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(46420, 179908, 0, 0, 0, 1, 1, 374.858, -3784.89, 169.835, 2.96706, 0, 0, 0.996195, 0.087156, 2, 100, 1, '', 0), -- Skull rock
(100510, 179908, 0, 0, 0, 1, 1, 323.533, -4133.47, 119.93, 0, 0, 0, 0.996195, 0.087156, 2, 100, 1, '', 0), -- Base down below
(100511, 179908, 0, 0, 0, 1, 1, 217.35,-4318.79, 117.73, 0, 0, 0, 0.996195, 0.087156, 2, 100, 1, '', 0), -- 2 Base below
(100512, 179908, 0, 0, 0, 1, 1, 108.72, -4365.943, 120.63, 0, 0, 0, 0.996195, 0.087156, 2, 100, 1, '', 0), -- Lowest base
(100513, 179908, 0, 0, 0, 1, 1, 456.74, -3628.453, 120.03, 0, 0, 0, 0.996195, 0.087156, 2, 100, 1, '', 0); -- Top base

-- Add the new spawns to the same spawn pool so the item Slagtree's Lost Tools is spawned once at a time
DELETE FROM `pool_template` WHERE `entry` = 371;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)  VALUES (371, 1, "Slagtree's Lost Tools Spawns");

DELETE FROM `pool_gameobject` WHERE `guid` IN (46420, 100510, 100511, 100512, 100513);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(46420, 371, 0, "Slagtree's Lost Tools Spawn 1"),
(100510, 371, 0, "Slagtree's Lost Tools Spawn 2"),
(100511, 371, 0, "Slagtree's Lost Tools Spawn 3"),
(100512, 371, 0, "Slagtree's Lost Tools Spawn 4"),
(100513, 371, 0, "Slagtree's Lost Tools Spawn 5");

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_30_02' WHERE sql_rev = '1629808025047678029';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
