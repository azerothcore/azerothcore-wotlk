
-- Delete/Cleaning Npcs

DELETE FROM `creature` WHERE (`id1` = 28606) AND (`guid` IN (129235));
DELETE FROM `creature_addon` WHERE (`guid` IN (129235));
DELETE FROM `creature` WHERE (`id1` = 28607) AND (`guid` IN (129247));
DELETE FROM `creature_addon` WHERE (`guid` IN (129247));


-- Creature Formation

DELETE FROM `creature_formations` WHERE `leaderGUID` = 129215;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(129215, 129215, 0, 0, 512, 0, 0),
(129215, 129236, 4, 220, 512, 0, 0),
(129215, 129246, 5, 200, 512, 0, 0),
(129215, 129249, 6, 180, 512, 0, 0),
(129215, 129251, 5, 160, 512, 0, 0),
(129215, 129248, 4, 140, 512, 0, 0),
(129215, 129245, 3, 120, 512, 0, 0);


-- Havenshire Stallion spawn point

UPDATE `creature` SET `position_x` = 2195.9116, `position_y` = -5858.604, `position_z` = 101.32708, `orientation` = 3.7085388 WHERE `guid` = 129215 AND `id1` = 28605;


-- Havenshire Mare spawn point

UPDATE `creature` SET `position_x` = 2204.0552, `position_y` = -5854.607, `position_z` = 101.6112, `orientation` = 4.917175 WHERE `guid` = 129236 AND `id1` = 28606;


-- Havenshire Colts spawn point

UPDATE `creature` SET `position_x` = 2207.5293, `position_y` = -5852.516, `position_z` = 101.384766, `orientation` = 4.913268 WHERE `guid` = 129246 AND `id1` = 28607;
UPDATE `creature` SET `position_x` = 2200.4082, `position_y` = -5853.1797, `position_z` = 101.39033, `orientation` = 5.2745533 WHERE `guid` = 129249 AND `id1` = 28607;
UPDATE `creature` SET `position_x` = 2203.335, `position_y` = -5849.832, `position_z` = 101.40138, `orientation` = 4.9533725 WHERE `guid` = 129251 AND `id1` = 28607;
UPDATE `creature` SET `position_x` = 2205.8127, `position_y` = -5844.881, `position_z` = 101.527245, `orientation` = 4.8709197 WHERE `guid` = 129248 AND `id1` = 28607;
UPDATE `creature` SET `position_x` = 2198.61, `position_y` = -5846.52, `position_z` = 101.70071, `orientation` = 5.0044303 WHERE `guid` = 129245 AND `id1` = 28607;


-- Havenshire Stallion spawn point (it should be the horse that jump on the fence. Spawn Point Sniffed).

UPDATE `creature` SET `position_x` = 2231.44, `position_y` = -5828.90, `position_z` = 101.37, `orientation` = 3.04377 WHERE `guid` = 129214 AND `id1` = 28605;


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


-- Set SmartAI for Havenshire Stallion

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 28605);


-- Comment

UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`id1` = 28605) AND (`guid` IN (129215));


-- DBGuid SmartAI

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -129215);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129215, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 12921500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Respawn - Start Path 12921500'),
(-129215, 0, 1, 2, 109, 0, 100, 0, 0, 12921500, 0, 0, 0, 0, 41, 2000, 10, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 12, 0, 0, 0, 0, 10, 129236, 28606, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 12, 0, 0, 0, 0, 10, 129246, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 12, 0, 0, 0, 0, 10, 129249, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 12, 0, 0, 0, 0, 10, 129251, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 12, 0, 0, 0, 0, 10, 129248, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms'),
(-129215, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 12, 0, 0, 0, 0, 10, 129245, 28607, 0, 0, 0, 0, 0, 0, 'Havenshire Stallion - On Path 12921500 Finished - Despawn In 2000 ms');
