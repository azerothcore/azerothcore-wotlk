INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1612566366687490200');

-- Relocate Strange Lockbox and add Bubbly Fissure near it.

DELETE FROM `gameobject` WHERE (`id` = 177790) AND (`guid` IN (27813));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(27813, 177790, 0, 0, 0, 1, 1, 842.715, 2208.32, -136.765, 1.57, 0, 0, 0.994174, -0.107791, 50, 100, 1, '', 0);
INSERT INTO `gameobject` (`id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(177524, 0, 0, 0, 1, 1, 838.26, 2208.14, -136.906, 0, 0, 0, -0.753998, -0.656877, 300, 0, 1, '', 0);
