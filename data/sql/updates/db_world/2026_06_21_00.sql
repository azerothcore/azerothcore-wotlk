-- DB update 2026_06_20_00 -> 2026_06_21_00

-- Set Extra Flag NO_MOVE_FLAGS_UPDATE.
UPDATE `creature_template` SET `flags_extra` = `flags_extra` |512 WHERE (`entry` = 28465);

-- Remove Movement Flags.
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 28465);

-- Remove MT and waypoint ids.
UPDATE `creature` SET `MovementType` = 0 WHERE (`id` = 28465) AND (`guid` IN (100536, 100540));
UPDATE `creature_addon` SET `path_id` = 0 WHERE (`guid` IN (100536, 100540));

-- Move Heb Drakkar Striker paths on waypoints table.
DELETE FROM `waypoint_data` WHERE (`id` IN (1005360, 1005400));
DELETE FROM `waypoints` WHERE `entry` IN (10053600, 10054000);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(10053600, 1, 5997.71, -3803.25, 384.444, NULL, 'Heb Drakkar Striker 1'),
(10053600, 2, 5971.09, -3866.25, 390.999, NULL, 'Heb Drakkar Striker 1'),
(10053600, 3, 5896.79, -3922, 387, NULL, 'Heb Drakkar Striker 1'),
(10053600, 4, 5846.83, -3912.56, 378.944, NULL, 'Heb Drakkar Striker 1'),
(10053600, 5, 5803.36, -3868.98, 376.389, NULL, 'Heb Drakkar Striker 1'),
(10053600, 6, 5803.01, -3817.95, 376.055, NULL, 'Heb Drakkar Striker 1'),
(10053600, 7, 5839.45, -3767.71, 375.888, NULL, 'Heb Drakkar Striker 1'),
(10053600, 8, 5879.84, -3723.38, 375.222, NULL, 'Heb Drakkar Striker 1'),
(10053600, 9, 5906.52, -3689.99, 375.222, NULL, 'Heb Drakkar Striker 1'),
(10053600, 10, 5948.16, -3694.75, 375.222, NULL, 'Heb Drakkar Striker 1'),
(10053600, 11, 5986.21, -3743.16, 378.722, NULL, 'Heb Drakkar Striker 1'),
(10054000, 1, 5921.5, -3765.99, 374.932, NULL, 'Heb Drakkar Striker 2'),
(10054000, 2, 5892.01, -3795.87, 373.182, NULL, 'Heb Drakkar Striker 2'),
(10054000, 3, 5894.13, -3870.95, 381.932, NULL, 'Heb Drakkar Striker 2'),
(10054000, 4, 5936.05, -3933.15, 399.932, NULL, 'Heb Drakkar Striker 2'),
(10054000, 5, 5992.46, -3987.92, 399.932, NULL, 'Heb Drakkar Striker 2'),
(10054000, 6, 6035.39, -3982.35, 382.682, NULL, 'Heb Drakkar Striker 2'),
(10054000, 7, 6084.95, -3923.61, 382.682, NULL, 'Heb Drakkar Striker 2'),
(10054000, 8, 6090.31, -3870.81, 401.877, NULL, 'Heb Drakkar Striker 2'),
(10054000, 9, 6015.04, -3792.97, 401.877, NULL, 'Heb Drakkar Striker 2'),
(10054000, 10, 5975.41, -3758.67, 379.627, NULL, 'Heb Drakkar Striker 2');

-- Add Heb Drakkar Striker Specific GUID.
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` IN (-100536, -100540));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-100536, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Respawn - Set Disable Gravity On'),
(-100536, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 10053600, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Respawn - Start Patrol Path 10053600'),
(-100536, 0, 2, 3, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Aggro - Set Disable Gravity Off'),
(-100536, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Aggro - Dismount'),
(-100536, 0, 4, 5, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Evade - Set Disable Gravity On'),
(-100536, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 43, 0, 9074, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Evade - Mount To Model 9074'),
(-100536, 0, 6, 0, 0, 0, 100, 0, 5000, 5000, 16000, 16000, 0, 0, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - In Combat - Cast \'Strike\''),
(-100536, 0, 7, 0, 0, 0, 100, 0, 4000, 14000, 50000, 60000, 0, 0, 11, 51951, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - In Combat - Cast \'Rabies\''),
(-100540, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Respawn - Set Disable Gravity On'),
(-100540, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 10054000, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Respawn - Start Patrol Path 10054000'),
(-100540, 0, 2, 3, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Aggro - Set Disable Gravity Off'),
(-100540, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Aggro - Dismount'),
(-100540, 0, 4, 5, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Evade - Set Disable Gravity On'),
(-100540, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 43, 0, 9074, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - On Evade - Mount To Model 9074'),
(-100540, 0, 6, 0, 0, 0, 100, 0, 5000, 5000, 16000, 16000, 0, 0, 11, 11976, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - In Combat - Cast \'Strike\''),
(-100540, 0, 7, 0, 0, 0, 100, 0, 4000, 14000, 50000, 60000, 0, 0, 11, 51951, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Heb\'Drakkar Striker - In Combat - Cast \'Rabies\'');
