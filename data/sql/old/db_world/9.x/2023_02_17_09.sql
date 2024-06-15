-- DB update 2023_02_17_08 -> 2023_02_17_09
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22062);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22062, 0, 0, 0, 0, 0, 100, 0, 1500, 2500, 4000, 6000, 0, 11, 21067, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Dr. Whitherlimb - In Combat CMC - Cast \'Poison Bolt\''),
(22062, 0, 1, 0, 0, 0, 100, 0, 8000, 15000, 15000, 30000, 0, 11, 38864, 96, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Dr. Whitherlimb - In Combat CMC - Cast \'Withering Poison\''),
(22062, 0, 2, 0, 2, 0, 100, 0, 0, 50, 35000, 45000, 0, 11, 38871, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dr. Whitherlimb - Between 0-50% Health - Cast \'Monstrous Elixir\''),
(22062, 0, 3, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Dr. Whitherlimb - On Aggro - Say Line 0'),
(22062, 0, 4, 0, 5, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dr. Whitherlimb - On Killed Unit - Say Line 1');

DELETE FROM `creature` WHERE `id1`=22062;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `MovementType`) VALUES
(24911, 22062, 530, 1, 0, 6300.91, -6252.88, 77.8134, 4.92138, 5400, 2),
(24912, 22062, 530, 1, 0, 6305.22, -6475.4, 83.0121, 0.443913, 6300, 2),
(24913, 22062, 530, 1, 0, 7160.29, -6620.61, 60.6592, 5.59064, 7200, 2),
(24914, 22062, 530, 1, 0, 7227.19, -6406.61, 56.1656, 2.77106, 9000, 2);

DELETE FROM `creature_addon` WHERE (`guid` IN (24911, 24912, 24913, 24914));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(24911, 249110, 0, 0, 0, 0, 0, ''),
(24912, 249120, 0, 0, 0, 0, 0, ''),
(24913, 249130, 0, 0, 0, 0, 0, ''),
(24914, 249140, 0, 0, 0, 0, 0, '');

DELETE FROM `waypoint_data` WHERE `id` IN (249110, 249120, 249130, 249140);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`) VALUES
(249110, 1, 6305.4, -6258.75, 77.813),
(249110, 2, 6312.15, -6258.67, 80.813),
(249110, 3, 6319.65, -6250.08, 80.813),
(249110, 4, 6320.9, -6243.77, 77.942),
(249110, 5, 6314.05, -6237.9, 77.813),
(249110, 6, 6305.43, -6238.32, 77.813),
(249110, 7, 6299.6, -6244.36, 77.813),
(249110, 8, 6299.7, -6253.44, 77.813),
(249120, 1, 6294.18, -6468.08, 83.011),
(249120, 2, 6301.18, -6475.33, 83.011),
(249120, 3, 6309.72, -6475.18, 83.011),
(249120, 4, 6315.84, -6468.94, 83.197),
(249120, 5, 6315.23, -6462.81, 86.01),
(249120, 6, 6306.69, -6453.58, 86.01),
(249120, 7, 6300.74, -6453.97, 83.01),
(249120, 8, 6294.72, -6459.48, 83.01),
(249130, 1, 7160.11, -6607.73, 60.658),
(249130, 2, 7157.84, -6617.14, 60.658),
(249130, 3, 7162.99, -6624.5, 60.658),
(249130, 4, 7171.73, -6626.08, 60.864),
(249130, 5, 7176.71, -6622.44, 63.658),
(249130, 6, 7179.54, -6610.65, 63.658),
(249130, 7, 7175.27, -6604.53, 60.658),
(249130, 8, 7167.62, -6603.2, 60.658),
(249140, 1, 7224.31, -6404.75, 56.166),
(249140, 2, 7215.94, -6405.19, 56.166),
(249140, 3, 7211.89, -6409.29, 59.166),
(249140, 4, 7212.47, -6421.64, 59.166),
(249140, 5, 7216.75, -6426.26, 56.166),
(249140, 6, 7225.6, -6425.64, 56.166),
(249140, 7, 7231.39, -6419.25, 56.166),
(249140, 8, 7230.53, -6411.13, 56.166);

UPDATE `creature_text` SET `Probability`=100 WHERE `CreatureID`=22062 AND `GroupID`=1;

DELETE FROM `pool_template` WHERE `entry`=1114 AND `description`='Dr. Whitherlimb (22062)';
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (1114, 1, 'Dr. Whitherlimb (22062)');

DELETE FROM `pool_creature` WHERE `pool_entry`=1114 AND `description`='Dr. Whitherlimb (22062)';
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(24911, 1114, 0, 'Dr. Whitherlimb (22062)'),
(24912, 1114, 0, 'Dr. Whitherlimb (22062)'),
(24913, 1114, 0, 'Dr. Whitherlimb (22062)'),
(24914, 1114, 0, 'Dr. Whitherlimb (22062)');
