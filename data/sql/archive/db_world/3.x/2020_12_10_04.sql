-- DB update 2020_12_10_03 -> 2020_12_10_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_10_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_10_03 2020_12_10_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1606604290694357400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1606604290694357400');

-- Update position, facing and ready emote for Lightning Charged Iron Dwarf (10 & 25 Ulduar)

DELETE FROM `creature` WHERE (`id` = 34199) AND (`guid` IN (136610));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(136610, 34199, 603, 0, 0, 3, 1, 26239, 1, 1544.11, -27.754, 420.967, 3.01593, 604800, 0, 0, 471835, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `creature` WHERE (`id` = 34199) AND (`guid` IN (136771));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(136771, 34199, 603, 0, 0, 2, 1, 26239, 1, 1544.37, -20.3519, 420.967, 3.10938, 604800, 0, 0, 471835, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `creature_addon` WHERE (`guid` IN (136771));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(136771, 0, 0, 0, 1, 333, 0, NULL);

DELETE FROM `creature_addon` WHERE (`guid` IN (136610));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`) VALUES
(136610, 0, 0, 0, 1, 333, 0, NULL);

-- Update position, facing, and add item 'NPC Equip 39750' (lightning staff) for Iron Mender (10 & 25 Ulduar)

DELETE FROM `creature` WHERE (`id` = 34198) AND (`guid` IN (136603));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(136603, 34198, 603, 0, 0, 3, 1, 26218, 1, 1551.155273, -31.939562, 420.966705, 4.622076, 604800, 0, 0, 337025, 62535, 0, 0, 0, 0, '', 0);

DELETE FROM `creature` WHERE (`id` = 34198) AND (`guid` IN (136772));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(136772, 34198, 603, 0, 0, 2, 1, 26218, 1, 1551.93571, -16.073572, 420.66736, 1.945428, 604800, 0, 0, 337025, 62535, 0, 0, 0, 0, '', 0);

UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE (`entry` = 34198);
UPDATE `creature_equip_template` SET `ItemID1` = 39750 WHERE (`CreatureID` = 34198);
UPDATE `creature_template_addon` SET `bytes2` = 1 WHERE (`entry` = 34236);
DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 34236);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(34236, 1, 39750, 0, 0, 0);

-- Update position, facing for Hardened Iron Golem (10 & 25 Ulduar)

DELETE FROM `creature` WHERE (`id` = 34190) AND (`guid` IN (136557));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(136557, 34190, 603, 0, 0, 3, 1, 26155, 0, 1550.437744, -37.141003, 420.966705, 1.668972, 604800, 0, 0, 404430, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `creature` WHERE (`id` = 34190) AND (`guid` IN (136770));
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(136770, 34190, 603, 0, 0, 2, 1, 26155, 0, 1550.216064, -10.390898, 420.966736, 4.776779, 604800, 0, 0, 404430, 0, 0, 0, 0, 0, '', 0);


--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
