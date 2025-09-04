-- Update gameobject 'Doodad_FrostGiantIceShard01' with sniffed values
-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (192186)) AND (`guid` IN (40));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(40, 192186, 571, 0, 0, 1, 1, 7299.98193359375, -2056.776123046875, 760.91754150390625, 3.129810810089111328, 0.336331367492675781, 0.04759979248046875, -0.9404611587524414, 0.012177699245512485, 120, 255, 1, "", 46158, NULL);
