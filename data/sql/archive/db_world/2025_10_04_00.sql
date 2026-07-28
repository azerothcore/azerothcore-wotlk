-- DB update 2025_10_02_01 -> 2025_10_04_00
-- Update gameobject 'Big Rancid Meat' with sniffed values
-- updated spawns
DELETE FROM `gameobject` WHERE (`id` IN (177665)) AND (`guid` IN (45717));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(45717, 177665, 0, 0, 0, 1, 1, 1598.3446044921875, -3246.51708984375, 66.82944488525390625, 5.480334281921386718, 0, 0, -0.39073085784912109, 0.920504987239837646, 120, 255, 1, "", 46248, NULL);

-- new spawns
DELETE FROM `gameobject` WHERE (`id` IN (191789)) AND (`guid` IN (178, 179, 180));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(178, 191789, 571, 0, 0, 1, 1, 8322.1416015625, 2812.73779296875, 655.9156494140625, 2.042035102844238281, 0, 0, 0.852640151977539062, 0.522498607635498046, 120, 255, 1, "", 46368, NULL),
(179, 191789, 571, 0, 0, 1, 1, 8340.8603515625, 2739.64208984375, 655.246337890625, 4.97418975830078125, 0, 0, -0.60876083374023437, 0.793353796005249023, 120, 255, 1, "", 46368, NULL),
(180, 191789, 571, 0, 0, 1, 1, 8347.0751953125, 2816.0400390625, 655.16448974609375, 6.248279094696044921, 0, 0, -0.01745223999023437, 0.999847710132598876, 120, 255, 1, "", 46368, NULL);
