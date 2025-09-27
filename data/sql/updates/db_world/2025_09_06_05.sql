-- DB update 2025_09_06_04 -> 2025_09_06_05
-- Update gameobject 'Doodad_FrostGiantIceShard' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (192193, 192194, 192195)) AND (`guid` IN (20924, 20925, 20926));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(20924, 192193, 571, 0, 0, 1, 4, 7325.5732421875, -2044.4727783203125, 760.7373046875, 5.478795528411865234, 0.056999683380126953, 0.307971954345703125, -0.35146713256835937, 0.882255733013153076, 120, 255, 1, "", 46158, NULL),
(20925, 192194, 571, 0, 0, 1, 4, 7320.685546875, -2053.649169921875, 761.33929443359375, 5.478795528411865234, 0.056999683380126953, 0.307971954345703125, -0.35146713256835937, 0.882255733013153076, 120, 255, 1, "", 46158, NULL),
(20926, 192195, 571, 0, 0, 1, 4, 7321.001953125, -2054.294677734375, 760.8995361328125, 4.88195037841796875, 0.128789901733398437, -0.01092052459716796, -0.64533519744873046, 0.752885341644287109, 120, 255, 1, "", 46158, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (192186)) AND (`guid` IN (40));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(40, 192186, 571, 0, 0, 1, 4, 7299.98193359375, -2056.776123046875, 760.91754150390625, 3.129810810089111328, 0.336331367492675781, 0.04759979248046875, -0.9404611587524414, 0.012177699245512485, 120, 255, 1, "", 46158, NULL);
