INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625686259138336600');

-- Handled now with SAI
DELETE FROM `event_scripts` WHERE `id` = 8605;

-- Spawntime changed to 10 secs to prevent abuse
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI', `Data2` = 0, `Data3` = 10000 WHERE (`entry` = 179910);

-- Spawn Vilebranch Kidnapper using spawn coords from sniffs and force attack invocker
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 179910);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(179910, 1, 0, 1, 70, 0, 100, 0, 2, 0, 0, 0, 0, 12, 14748, 4, 15000, 1, 0, 0, 8, 1, 0, 0, 0, 421.357, -4806.02, 11.9855, 3.12414, 'Lard\'s Picnic Basket - On Gameobject State Changed - Summon Creature \'Vilebranch Kidnapper\''),
(179910, 1, 1, 2, 61, 0, 100, 0, 2, 0, 0, 0, 0, 12, 14748, 4, 15000, 1, 0, 0, 8, 0, 0, 0, 0, 399.936, -4824.07, 9.13856, 5.39307, 'Lard\'s Picnic Basket - On Gameobject State Changed - Summon Creature \'Vilebranch Kidnapper\''),
(179910, 1, 2, 0, 61, 0, 100, 0, 2, 0, 0, 0, 0, 12, 14748, 4, 15000, 1, 0, 0, 8, 0, 0, 0, 0, 378.172, -4784.85, -2.44194, 4.29351, 'Lard\'s Picnic Basket - On Gameobject State Changed - Summon Creature \'Vilebranch Kidnapper\'');

-- Update speed_walk according to sniffs
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 14748); -- It was 1.1
