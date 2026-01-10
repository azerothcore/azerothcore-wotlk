-- DB update 2024_12_10_01 -> 2024_12_10_02

-- Delete/Cleaning Npcs

DELETE FROM `creature` WHERE (`id1` = 28607) AND (`guid` IN (129247));
DELETE FROM `creature_addon` WHERE (`guid` IN (129247));


-- Havenshire Stallion spawn point

UPDATE `creature` SET `position_x` = 2195.9116, `position_y` = -5858.604, `position_z` = 101.32708, `orientation` = 3.7085388 WHERE `guid` = 129215 AND `id1` = 28605;
UPDATE `creature` SET `position_x` = 2199.2192, `position_y` = -5850.0396, `position_z` = 101.36801, `orientation` = 4.9723105 WHERE `guid` = 129214 AND `id1` = 28605;


-- Havenshire Mare spawn point

UPDATE `creature` SET `position_x` = 2204.0552, `position_y` = -5854.607, `position_z` = 101.6112, `orientation` = 4.917175 WHERE `guid` = 129236 AND `id1` = 28606;
UPDATE `creature` SET `position_x` = 2206.8572, `position_y` = -5848.667, `position_z` = 101.39461, `orientation` = 4.941651 WHERE `guid` = 129235 AND `id1` = 28606;


-- Havenshire Colts spawn point

UPDATE `creature` SET `position_x` = 2207.5293, `position_y` = -5852.516, `position_z` = 101.384766, `orientation` = 4.913268 WHERE `guid` = 129246 AND `id1` = 28607;
UPDATE `creature` SET `position_x` = 2200.4082, `position_y` = -5853.1797, `position_z` = 101.39033, `orientation` = 5.2745533 WHERE `guid` = 129249 AND `id1` = 28607;
UPDATE `creature` SET `position_x` = 2203.335, `position_y` = -5849.832, `position_z` = 101.40138, `orientation` = 4.9533725 WHERE `guid` = 129251 AND `id1` = 28607;
UPDATE `creature` SET `position_x` = 2205.8127, `position_y` = -5844.881, `position_z` = 101.527245, `orientation` = 4.8709197 WHERE `guid` = 129248 AND `id1` = 28607;
UPDATE `creature` SET `position_x` = 2198.61, `position_y` = -5846.52, `position_z` = 101.70071, `orientation` = 5.0044303 WHERE `guid` = 129245 AND `id1` = 28607;


-- Waypoints (Sniffed)

DELETE FROM `waypoint_data` WHERE `id` IN (12921500);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12921500, 1, 2181.8208, -5866.014, 101.38311, NULL, 0, 1, 0, 100, 0),
(12921500, 2, 2163.5708, -5871.264, 101.38311, NULL, 0, 1, 0, 100, 0),
(12921500, 3, 2156.404, -5873.486, 101.35129, NULL, 0, 1, 0, 100, 0),
(12921500, 4, 2140.0742, -5877.82, 101.841995, NULL, 0, 1, 0, 100, 0),	
(12921500, 5, 2118.6294, -5903.7754, 104.6409, NULL, 0, 1, 0, 100, 0),	 
(12921500, 6, 2080.034, -5913.223, 106.414085, NULL, 0, 1, 0, 100, 0),	
(12921500, 7, 2009.6409, -5923.7266, 105.32761, NULL, 0, 1, 0, 100, 0), 
(12921500, 8, 1970.5721, -5935.1025, 102.947174, NULL, 0, 1, 0, 100, 0), 
(12921500, 9, 1895.7273, -5921.091, 103.54128, NULL, 0, 1, 0, 100, 0), 
(12921500, 10, 1842.2395, -5917.941, 107.21487, NULL, 0, 1, 0, 100, 0),	
(12921500, 11, 1781.0726, -5925.415, 116.29511, NULL, 0, 1, 0, 100, 0), 
(12921500, 12, 1742.219, -5908.065, 116.12137, NULL, 0, 1, 0, 100, 0); 


-- Creature Formation

DELETE FROM `creature_formations` WHERE `leaderGUID` = 129215;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(129215, 129215, 0, 0, 512, 0, 0),
(129215, 129214, 4, 140, 512, 0, 0),
(129215, 129236, 5, 160, 512, 0, 0),
(129215, 129235, 6, 180, 512, 0, 0),
(129215, 129246, 7, 200, 512, 0, 0),
(129215, 129249, 8, 180, 512, 0, 0),
(129215, 129251, 7, 160, 512, 0, 0),
(129215, 129248, 6, 140, 512, 0, 0),
(129215, 129245, 5, 120, 512, 0, 0);


-- Spawn Groups

DELETE FROM `pool_template` WHERE (`entry` IN (22383));
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES 
(22383, 6, 'Havenshire Stallions/Mares/Colts (1 out 1)');

DELETE FROM `pool_creature` WHERE (`pool_entry` IN (22383));
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES 
(129214, 22383, 0, 'Havenshire Stallion (28605)'),
(129236, 22383, 0, 'Havenshire Mare (28606)'),
(129235, 22383, 0, 'Havenshire Mare (28606)'),
(129251, 22383, 0, 'Havenshire Colt (28607)'),
(129246, 22383, 0, 'Havenshire Colt (28607)'),
(129249, 22383, 0, 'Havenshire Colt (28607)'),
(129248, 22383, 0, 'Havenshire Colt (28607)'),
(129245, 22383, 0, 'Havenshire Colt (28607)');


-- Set SmartAI for Havenshire Stallion

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 28605);


-- Comment

UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`id1` = 28605) AND (`guid` IN (129215));


-- DBGuid SmartAI

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -129215);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129215, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12921500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Respawn - Start Path 12921500'),
(-129215, 0, 1, 2, 109, 0, 100, 0, 0, 12921500, 0, 0, 0, 0, 41, 2000, 60, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129236, 28606, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129246, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129249, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129251, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129248, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129245, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129214, 28605, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 62, 0, 0, 0, 0, 10, 129235, 28606, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms');
