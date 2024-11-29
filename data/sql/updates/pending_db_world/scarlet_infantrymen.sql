
-- Delete Wrong npc (not found on official servers)

DELETE FROM `creature` WHERE (`id1` = 28609) AND (`guid` IN (129280));
DELETE FROM `creature_addon` WHERE (`guid` IN (129280));


-- Update spawn points

UPDATE `creature` SET `position_x` = 2143.90, `position_y` = -5675.58, `position_z` = 109.95, `orientation` = 0.3333 WHERE `guid` = 129270 AND `id1` = 28609;
UPDATE `creature` SET `position_x` = 2154.62, `position_y` = -5689.39, `position_z` = 105.75, `orientation` = 0.6432 WHERE `guid` = 129271 AND `id1` = 28609;
UPDATE `creature` SET `position_x` = 2221.08, `position_y` = -5885.01, `position_z` = 100.68, `orientation` = 3.1306 WHERE `guid` = 129282 AND `id1` = 28609;
UPDATE `creature` SET `position_x` = 2353.2, `position_y` = -5844.39, `position_z` = 101.593, `orientation` = 5.6188 WHERE `guid` = 129283 AND `id1` = 28609;
UPDATE `creature` SET `position_x` = 2392.12, `position_y` = -5844.45, `position_z` = 108.994, `orientation` = 3.0858 WHERE `guid` = 129284 AND `id1` = 28609;



-- Waypoints

DELETE FROM `waypoint_data` WHERE `id` IN (12927200, 12928200, 12928300, 12928400);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(12927200, 1, 2226.18, -5731.67, 102.017, NULL, 0, 0, 0, 100, 0),
(12927200, 2, 2234.35, -5738.26, 102.214, NULL, 0, 0, 0, 100, 0),
(12927200, 3, 2242.78, -5744.52, 102.309, NULL, 0, 0, 0, 100, 0),
(12927200, 4, 2250.79, -5752.1, 101.528, NULL, 0, 0, 0, 100, 0),
(12927200, 5, 2257.7, -5760, 101.073, NULL, 0, 0, 0, 100, 0),
(12927200, 6, 2266.39, -5770.03, 100.979, NULL, 0, 0, 0, 100, 0),
(12927200, 7, 2257.7, -5760, 101.073, NULL, 0, 0, 0, 100, 0),
(12927200, 8, 2250.79, -5752.1, 101.528, NULL, 0, 0, 0, 100, 0),
(12927200, 9, 2242.78, -5744.52, 102.309, NULL, 0, 0, 0, 100, 0),
(12927200, 10, 2234.35, -5738.26, 102.214, NULL, 0, 0, 0, 100, 0),
(12927200, 11, 2226.18, -5731.67, 102.017, NULL, 0, 0, 0, 100, 0),
(12927200, 12, 2219.23, -5726.22, 101.816, NULL, 0, 0, 0, 100, 0),

(12928200, 1, 2214.83, -5884.92, 100.855, NULL, 0, 0, 0, 100, 0),
(12928200, 2, 2209.52, -5885, 101.008, NULL, 0, 0, 0, 100, 0),
(12928200, 3, 2204.1, -5883.88, 101.159, NULL, 0, 0, 0, 100, 0),
(12928200, 4, 2195.65, -5882.51, 101.208, NULL, 0, 0, 0, 100, 0),
(12928200, 5, 2187.06, -5880.64, 101.065, NULL, 0, 0, 0, 100, 0),
(12928200, 6, 2195.65, -5882.51, 101.208, NULL, 0, 0, 0, 100, 0),
(12928200, 7, 2204.1, -5883.88, 101.159, NULL, 0, 0, 0, 100, 0),
(12928200, 8, 2209.52, -5885, 101.008, NULL, 0, 0, 0, 100, 0),
(12928200, 9, 2214.83, -5884.92, 100.855, NULL, 0, 0, 0, 100, 0),
(12928200, 10, 2221.08, -5885.01, 100.68, NULL, 0, 0, 0, 100, 0),

(12928300, 1, 2358.94, -5843.76, 103.624, NULL, 0, 0, 0, 100, 0),
(12928300, 2, 2367.94, -5842.23, 106.039, NULL, 0, 0, 0, 100, 0),
(12928300, 3, 2376.98, -5841.91, 108.059, NULL, 0, 0, 0, 100, 0),
(12928300, 4, 2385.39, -5843.93, 108.588, NULL, 0, 0, 0, 100, 0),
(12928300, 5, 2392.12, -5844.45, 108.994, NULL, 0, 0, 0, 100, 0),
(12928300, 6, 2385.39, -5843.93, 108.588, NULL, 0, 0, 0, 100, 0),
(12928300, 7, 2376.98, -5841.91, 108.059, NULL, 0, 0, 0, 100, 0),
(12928300, 8, 2367.94, -5842.23, 106.039, NULL, 0, 0, 0, 100, 0),
(12928300, 9, 2358.94, -5843.76, 103.624, NULL, 0, 0, 0, 100, 0),
(12928300, 10, 2353.2, -5844.39, 101.593, NULL, 0, 0, 0, 100, 0),

(12928400, 1, 2385.39, -5843.93, 108.588, NULL, 0, 0, 0, 100, 0),
(12928400, 2, 2376.98, -5841.91, 108.059, NULL, 0, 0, 0, 100, 0),
(12928400, 3, 2367.94, -5842.23, 106.039, NULL, 0, 0, 0, 100, 0),
(12928400, 4, 2358.94, -5843.76, 103.624, NULL, 0, 0, 0, 100, 0),
(12928400, 5, 2353.2, -5844.39, 101.593, NULL, 0, 0, 0, 100, 0),
(12928400, 6, 2358.94, -5843.76, 103.624, NULL, 0, 0, 0, 100, 0),
(12928400, 7, 2367.94, -5842.23, 106.039, NULL, 0, 0, 0, 100, 0),
(12928400, 8, 2376.98, -5841.91, 108.059, NULL, 0, 0, 0, 100, 0),
(12928400, 9, 2385.39, -5843.93, 108.588, NULL, 0, 0, 0, 100, 0),
(12928400, 10, 2392.12, -5844.45, 108.994, NULL, 0, 0, 0, 100, 0);


-- Change movement type and wander distance

UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 2 WHERE `guid` = 129272 AND `id1` = 28609;
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 2 WHERE `guid` = 129282 AND `id1` = 28609;
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 2 WHERE `guid` = 129283 AND `id1` = 28609;
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 2 WHERE `guid` = 129284 AND `id1` = 28609;


-- Set path id

UPDATE `creature_addon` SET `path_id` = 12927200 WHERE (`guid` IN (129272));
UPDATE `creature_addon` SET `path_id` = 12928200 WHERE (`guid` IN (129282));
UPDATE `creature_addon` SET `path_id` = 12928300 WHERE (`guid` IN (129283));
UPDATE `creature_addon` SET `path_id` = 12928400 WHERE (`guid` IN (129284));


-- Set Stealth Movement (already present in one of these Guids)

UPDATE `creature_addon` SET `bytes1` = 131072 WHERE (`guid` IN (129272, 129282, 129283, 129284));


-- Add Comments in creature Database

UPDATE `creature` SET `Comment` = "has guid specific SAI" WHERE (`id1` = 28609) AND (`guid` IN (129272, 129282, 129283, 129284));


-- SmartAI


DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -129272);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129272, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - Out of Combat - Set Visibility Off'),
(-129272, 0, 1, 0, 101, 0, 100, 0, 1, 15, 2000, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - On 1 or More Players in Range - Set Visibility On'),
(-129272, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - On Aggro - Set Visibility On'),
(-129272, 0, 3, 0, 9, 0, 100, 0, 0, 0, 6000, 9000, 0, 5, 11, 25710, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - Within 0-5 Range - Cast \'Heroic Strike\''),
(-129272, 0, 4, 0, 0, 0, 100, 0, 9000, 15000, 16000, 19000, 0, 0, 11, 53399, 1, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - In Combat - Cast \'Sweeping Slam\''),
(-129272, 0, 5, 0, 23, 0, 100, 0, 48356, 0, 0, 0, 0, 0, 11, 48356, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - On Aura \'See Wintergarde Invisibility\' - Cast \'See Wintergarde Invisibility\'');


DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -129282);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129282, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - Out of Combat - Set Visibility Off'),
(-129282, 0, 1, 0, 101, 0, 100, 0, 1, 15, 2000, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - On 1 or More Players in Range - Set Visibility On'),
(-129282, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - On Aggro - Set Visibility On'),
(-129282, 0, 3, 0, 9, 0, 100, 0, 0, 0, 6000, 9000, 0, 5, 11, 25710, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - Within 0-5 Range - Cast \'Heroic Strike\''),
(-129282, 0, 4, 0, 0, 0, 100, 0, 9000, 15000, 16000, 19000, 0, 0, 11, 53399, 1, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - In Combat - Cast \'Sweeping Slam\''),
(-129282, 0, 5, 0, 23, 0, 100, 0, 48356, 0, 0, 0, 0, 0, 11, 48356, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - On Aura \'See Wintergarde Invisibility\' - Cast \'See Wintergarde Invisibility\'');


DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -129283);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129283, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - Out of Combat - Set Visibility Off'),
(-129283, 0, 1, 0, 101, 0, 100, 0, 1, 15, 2000, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - On 1 or More Players in Range - Set Visibility On'),
(-129283, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - On Aggro - Set Visibility On'),
(-129283, 0, 3, 0, 9, 0, 100, 0, 0, 0, 6000, 9000, 0, 5, 11, 25710, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - Within 0-5 Range - Cast \'Heroic Strike\''),
(-129283, 0, 4, 0, 0, 0, 100, 0, 9000, 15000, 16000, 19000, 0, 0, 11, 53399, 1, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - In Combat - Cast \'Sweeping Slam\''),
(-129283, 0, 5, 0, 23, 0, 100, 0, 48356, 0, 0, 0, 0, 0, 11, 48356, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - On Aura \'See Wintergarde Invisibility\' - Cast \'See Wintergarde Invisibility\'');


DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -129284);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-129284, 0, 0, 0, 1, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - Out of Combat - Set Visibility Off'),
(-129284, 0, 1, 0, 101, 0, 100, 0, 1, 15, 2000, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - On 1 or More Players in Range - Set Visibility On'),
(-129284, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 47, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - On Aggro - Set Visibility On'),
(-129284, 0, 3, 0, 9, 0, 100, 0, 0, 0, 6000, 9000, 0, 5, 11, 25710, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - Within 0-5 Range - Cast \'Heroic Strike\''),
(-129284, 0, 4, 0, 0, 0, 100, 0, 9000, 15000, 16000, 19000, 0, 0, 11, 53399, 1, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - In Combat - Cast \'Sweeping Slam\''),
(-129284, 0, 5, 0, 23, 0, 100, 0, 48356, 0, 0, 0, 0, 0, 11, 48356, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scarlet Infantryman - On Aura \'See Wintergarde Invisibility\' - Cast \'See Wintergarde Invisibility\'');
