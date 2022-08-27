-- DB update 2022_07_24_04 -> 2022_07_24_05
--
-- Crocs movement is a scripted action that occurs about every 30 seconds, not normal random movement
UPDATE `creature` SET `wander_distance`=0, `MovementType`=0 WHERE `id1`=15043;

DELETE FROM `smart_scripts` WHERE `entryorguid`=15043 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(15043, 0, 0, 0, 0, 0, 100, 0, 8000, 9000, 11000, 12000, 0, 11, 3604, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Zulian Crocolisk - In Combat - Cast \'Tendon Rip\''),
(15043, 0, 1, 0, 0, 0, 100, 0, 17000, 19000, 22000, 24000, 0, 11, 13445, 1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Zulian Crocolisk - In Combat - Cast \'Rend\''),
(15043, 0, 2, 0, 1, 0, 100, 0, 30000, 30000, 40000, 40000, 0, 89, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ZG Crocolisks will wander a small amount for about 10 seconds out of every 40 (wander on-2)'),
(15043, 0, 3, 0, 1, 0, 100, 0, 39500, 39500, 40000, 40000, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'ZG Crocolisks will wander a small amount for about 10 seconds out of every 40 (wander on-0)'),
(15043, 0, 4, 0, 1, 0, 100, 0, 39999, 39999, 40000, 40000, 0, 101, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Send ZG Croclisks toward home position to control wandering range (set home POS)'),
(15043, 0, 5, 0, 1, 0, 100, 0, 40000, 40000, 40000, 40000, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Send ZG Croclisks toward home position to control wandering range (reset to home POS)');
