-- DB update 2025_10_24_02 -> 2025_10_24_03
-- Add Waypoint
DELETE FROM `waypoint_data` WHERE `id` = 2875000;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(2875000, 1, 6174.28, -2017.25, 245.116, NULL, 0, 1, 0, 100, 0);

-- Set SmartAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28750;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 28750);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28750, 0, 0, 3, 8, 0, 100, 512, 52245, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 20, 190716, 25, 0, 0, 2, 0, 0, 0, 'Blight Geist - On Spellhit \'Harvest Blight Crystal\' - Store Targetlist'),
(28750, 0, 1, 3, 8, 0, 100, 512, 52245, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 20, 190939, 25, 0, 0, 2, 0, 0, 0, 'Blight Geist - On Spellhit \'Harvest Blight Crystal\' - Store Targetlist'),
(28750, 0, 2, 3, 8, 0, 100, 512, 52245, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 20, 190940, 25, 0, 0, 2, 0, 0, 0, 'Blight Geist - On Spellhit \'Harvest Blight Crystal\' - Store Targetlist'),
(28750, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 2, 0, 0, 0, 'Blight Geist - On Spellhit \'Harvest Blight Crystal\' - Move To Stored'),
(28750, 0, 4, 0, 34, 0, 100, 512, 8, 1, 0, 0, 0, 0, 80, 2875000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - On Reached Point 1 - Run Script'),
(28750, 0, 5, 0, 8, 0, 100, 512, 52244, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - On Spellhit \'Charm Geist\' - Say Line 0'),
(28750, 0, 6, 0, 8, 0, 100, 512, 52252, 0, 0, 0, 0, 0, 11, 52243, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - On Spellhit \'Charm Channel\' - Cast \'Orange Radiation, Small\''),
(28750, 0, 7, 8, 109, 0, 100, 512, 0, 2875000, 0, 0, 0, 0, 11, 61456, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - On Path 2875000 Finished - Cast \'Evil Teleport Visual Only\''),
(28750, 0, 8, 9, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 11, 52248, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - On Path 2875000 Finished - Cast \'Kill Credit - Blighted Geist\''),
(28750, 0, 9, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - On Path 2875000 Finished - Despawn In 2000 ms');

-- Set Action List
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2875000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2875000, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - Actionlist - Set Orientation Stored'),
(2875000, 9, 1, 0, 0, 0, 100, 512, 2000, 2000, 0, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - Actionlist - Play Emote 25'),
(2875000, 9, 2, 0, 0, 0, 100, 512, 2000, 2000, 0, 0, 0, 0, 5, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - Actionlist - Play Emote 35'),
(2875000, 9, 3, 0, 0, 0, 100, 512, 2000, 2000, 0, 0, 0, 0, 99, 3, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - Actionlist - Set Lootstate Deactivated'),
(2875000, 9, 4, 0, 0, 0, 100, 512, 1000, 1000, 0, 0, 0, 0, 232, 2875000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Blight Geist - Actionlist - Start Path 2875000');
