DELETE FROM `gameobject` WHERE `id` = 176966;
INSERT INTO `gameobject` (`id`, `map`, `zoneId`, `areaId`,
    `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`,
    `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
    `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`)
VALUES (176966, 469, 0, 0, 1, 1, -7488.1, -1150.7, 476.535, 3.73064, -0.0,
    -0.0, -0.95694, 0.290285, 300, 0, 1, 'Nefarian\'s Gate', 0);
UPDATE `gameobject_template_addon` SET `flags` = `flags`|16 WHERE `entry` = 176966;
