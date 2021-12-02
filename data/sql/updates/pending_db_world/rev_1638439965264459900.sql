INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638439965264459900');

-- Theramore Preserver
-- Corrected Heal and Renew spell IDs
-- More accurate SmartAI compared to Classic wow
-- Sniffed the spells casted
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 3386;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3386) AND (`source_type` = 0) AND (`id` IN (0, 1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3386, 0, 0, 0, 0, 0, 100, 0, 3000, 6000, 12000, 14000, 0, 11, 6074, 32, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Theramore Preserver - In Combat - Cast \'Renew\''),
(3386, 0, 1, 0, 0, 0, 100, 0, 1000, 3000, 4000, 5500, 0, 11, 9734, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Theramore Preserver - In Combat - Cast \'Holy Smite\''),
(3386, 0, 2, 0, 2, 0, 100, 1, 5, 40, 0, 0, 0, 11, 2052, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Theramore Preserver - Between 5-40% Health - Cast \'Lesser Heal\' (No Repeat)');
