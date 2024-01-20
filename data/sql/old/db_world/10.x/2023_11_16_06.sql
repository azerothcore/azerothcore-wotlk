-- DB update 2023_11_16_05 -> 2023_11_16_06
-- Bloodsail Charts
DELETE FROM `gameobject` WHERE (`id` = 2086);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`, `Comment`) VALUES
(12154, 2086, 0, 33, 43, 1, 1, -14678.3, 500.529, 2.43489, 1.65806, 0, 0, 0.737277, 0.675591, 180, 100, 1, '', 0, NULL),
(12165, 2086, 0, 33, 43, 1, 1, -14686.3, 488.541, 4.28859, 5.61996, 0, 0, -0.325567, 0.945519, 180, 100, 1, '', 0, NULL),
(12167, 2086, 0, 33, 43, 1, 1, -14703.8, 451.066, 0.649918, 2.77507, 0, 0, 0.983254, 0.182238, 180, 100, 1, '', 0, NULL),
(12174, 2086, 0, 33, 43, 1, 1, -14607.7, 332.715, 3.69033, 1.83259, 0, 0, 0.793353, 0.608762, 180, 100, 1, '', 0, NULL);

DELETE FROM `pool_template` WHERE `entry`=136;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(136, 1, 'Bloodsail Charts - Stranglethorn Vale');

DELETE FROM `pool_gameobject` WHERE `guid` IN (12154,12165,12167,12174);
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(12154, 136, 0, 'Bloodsail Charts'),
(12165, 136, 0, 'Bloodsail Charts'),
(12167, 136, 0, 'Bloodsail Charts'),
(12174, 136, 0, 'Bloodsail Charts');
