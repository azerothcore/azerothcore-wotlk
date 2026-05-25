-- DB update 2024_03_04_03 -> 2024_03_04_04
-- Add some missing gameobject 'Anvil, Forge, Alchemy Lab' based on sniffed values
DELETE FROM `gameobject` WHERE (`id` IN (194466, 194467, 194468))
AND (`guid` IN (465, 466, 467));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(465, 194466, 530, 0, 0, 1, 1, -1737.48095703125, 5632.6103515625, 128.9701995849609375, 0, 0, 0, 0, 1, 120, 255, 1, "", 49345, NULL),
(466, 194467, 530, 0, 0, 1, 1, -1745.2545166015625, 5646.84228515625, 128.023193359375, 5.567600727081298828, 0, 0, -0.35020732879638671, 0.936672210693359375, 120, 255, 1, "", 49345, NULL),
(467, 194468, 530, 0, 0, 1, 1, -1747.6688232421875, 5648.66162109375, 128.023193359375, 4.049167633056640625, 0, 0, -0.89879322052001953, 0.438372820615768432, 120, 255, 1, "", 49345, NULL);
