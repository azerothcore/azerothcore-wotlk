-- DB update 2025_11_27_07 -> 2025_11_27_08

-- Set respawn time to 120 secs.
UPDATE `creature` SET `spawntimesecs` = 120 WHERE `id1` = 31306 AND `guid` = 74974;

-- Add row Set Invincibility to 1% (Margrave Dhakar)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31306;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 31306) AND (`source_type` = 0) AND (`id` IN (10));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31306, 0, 10, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 42, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - On Reset - Set Invincibility Hp 1%');
