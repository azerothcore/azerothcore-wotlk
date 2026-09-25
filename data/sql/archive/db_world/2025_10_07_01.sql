-- DB update 2025_10_07_00 -> 2025_10_07_01
--
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 25084;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25084);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25084, 0, 0, 1, 8, 0, 100, 1, 45109, 0, 0, 0, 0, 0, 11, 45110, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Greengill Slave - On Spellhit \'Orb of Murloc Control\' - Cast \'Greengill Slave Freed\' (No Repeat)'),
(25084, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45111, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greengill Slave - On Spellhit \'Orb of Murloc Control\' - Cast \'Enrage\' (No Repeat)'),
(25084, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 36, 25085, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greengill Slave - On Spellhit \'Orb of Murloc Control\' - Update Template To \'Freed Greengill Slave\' (No Repeat)'),
(25084, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 9, 25073, 0, 100, 0, 0, 0, 0, 0, 'Greengill Slave - On Spellhit \'Orb of Murloc Control\' - Start Attacking (No Repeat)'),
(25084, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 25060, 100, 0, 0, 0, 0, 0, 0, 'Greengill Slave - On Spellhit \'Orb of Murloc Control\' - Start Attacking (No Repeat)'),
(25084, 0, 5, 6, 7, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greengill Slave - On Evade - Despawn In 5000 ms'),
(25084, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Greengill Slave - On Evade - Start Random Movement');

DELETE FROM `spell_custom_attr` WHERE `spell_id` = 45111;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(45111, 0x00000800);
