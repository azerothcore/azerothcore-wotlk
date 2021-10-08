INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633459397421584200');

-- Currently 2 nodes are spawning always. According to the sniffs, from 1 to 3 ores should spawn, but the pool_template max_limit field seems to not work properly.
-- Source: https://youtu.be/b2bzQC2cvuU?t=919
DELETE FROM `pool_template` WHERE (`entry` = 11712);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (11712, 2, 'Rich Thorium Vein - Dire Maul East');

DELETE FROM `gameobject` WHERE (`id` = 175404) AND (`guid` IN (2135399, 2135400, 2135401, 2135402, 2135403));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(2135399, 175404, 429, 2557, 2557, 1, 1, 270.596, -286.689, -70.5572, 3.03684, 0, 0, 0.998629, 0.0523532, 604800, 100, 1, '', 0),
(2135400, 175404, 429, 2557, 2557, 1, 1, 246.195, -268.761, -52.933, 5.89921, 0, 0, -0.190808, 0.981627, 604800, 100, 1, '', 0),
(2135401, 175404, 429, 2557, 2557, 1, 1, 276.913, -323.602, -90.5699, 5.42798, 0, 0, -0.414693, 0.909962, 604800, 100, 1, '', 0),
(2135402, 175404, 429, 2557, 2557, 1, 1, 288.452, -309.522, -84.566, 4.83456, 0, 0, -0.66262, 0.748956, 604800, 100, 1, '', 0),
(2135403, 175404, 429, 2557, 2557, 1, 1, 263.743, -266.911, -59.9769, 2.94959, 0, 0, 0.995396, 0.0958512, 604800, 100, 1, '', 0);

DELETE FROM `pool_gameobject` WHERE (`guid` IN (2135399, 2135400, 2135401, 2135402, 2135403));
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(2135399, 11712, 0, 'Rich Thorium Vein - Dire Maul East node 1'),
(2135400, 11712, 0, 'Rich Thorium Vein - Dire Maul East node 2'),
(2135401, 11712, 0, 'Rich Thorium Vein - Dire Maul East node 3'),
(2135402, 11712, 0, 'Rich Thorium Vein - Dire Maul East node 4'),
(2135403, 11712, 0, 'Rich Thorium Vein - Dire Maul East node 5');
