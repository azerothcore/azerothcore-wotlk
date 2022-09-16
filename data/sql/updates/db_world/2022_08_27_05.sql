-- DB update 2022_08_27_04 -> 2022_08_27_05
--
DELETE FROM `gameobject` WHERE `id`=180745 and `guid` IN (6660,6663,6665);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(6660,180745,531,0,0,1,1,-8660.63,2022.4,108.577,3.64774,0,0,-0.968147,0.250381,7200,255,1),
(6663,180745,531,0,0,1,1,-8652.2,2020.92,108.577,0.244346,0,0,0.121869,0.992546,7200,255,1),
(6665,180745,531,0,0,1,1,-8663.34,2029.9,108.577,4.45059,0,0,-0.793353,0.608762,7200,255,1);
