-- Update Smart Script to directly invoke whisper to player without needing to scan for closest player. 
DELETE FROM `smart_scripts` WHERE `id` = 0 AND `entryorguid` IN (19293, 19294);
INSERT INTO `smart_scripts`
(`entryorguid`, `event_type`,`event_chance`,`event_flags`, `event_param1`, `action_type`, `target_type`,`target_param1`, `comment`)
VALUES
(19293, 19, 100, 512, 10349, 1, 19, 19294, 'Tola\'thion - On Quest Taken - Force Galandria to whisper quest taker');