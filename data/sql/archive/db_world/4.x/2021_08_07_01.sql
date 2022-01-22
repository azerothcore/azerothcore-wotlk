-- DB update 2021_08_07_00 -> 2021_08_07_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_07_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_07_00 2021_08_07_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627896958983750100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627896958983750100');

-- Change the spawn to 1 second from 15 minutes
UPDATE `gameobject` SET `spawntimesecs` = 1 WHERE `guid` IN (9986, 10135, 10030);
UPDATE `gameobject_template` SET `size` = 1 WHERE `entry` IN (2891, 2892, 2893);

 -- Add 3 piles of bones generic so when they despawn is not noticed
DELETE FROM `gameobject` WHERE (`id` = 177604) AND (`guid` IN (100507, 100508, 100509));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(100507, 177604, 0, 0, 0, 1, 1,-12544.0, -723.063, 40.4432, 3.14159, 0, 0, 0, 0, 0, 0, 0, '', 0), -- Balia'mah Trophy Skulls
(100508, 177604, 0, 0, 0, 1, 1,-12705.1, -472.833, 30.2692, 3.14159, 0, 0, 0, 0, 0, 0, 0, '', 0), -- Ziata'jai Trophy Skulls
(100509, 177604, 0, 0, 0, 1, 1,-12850.8, -819.736, 54.8824, 3.14159, 0, 0, 0, 0, 0, 0, 0, '', 0); -- Zul'Mamwe Trophy Skulls


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_07_01' WHERE sql_rev = '1627896958983750100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
