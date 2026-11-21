--
-- Potent Fungus removes Mini through spell_amanitar_potent_fungus, which also consumes the fungus
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 56648 AND `spell_effect` = -57055 AND `type` = 1;

DELETE FROM `spell_script_names` WHERE `spell_id` = 56648 AND `ScriptName` = 'spell_amanitar_potent_fungus';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(56648, 'spell_amanitar_potent_fungus');

-- Healthy Mushroom
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30391);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30391, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Healthy Mushroom - On Respawn - Set Reactstate Passive'),
(30391, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3039100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Healthy Mushroom - On Respawn - Run Script'),
(30391, 0, 2, 3, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 56648, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Healthy Mushroom - On Just Died - Cast \'Potent Fungus\''),
(30391, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 227, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Healthy Mushroom - On Just Died - Set Scale 10%'),
(30391, 0, 4, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 80, 3039101, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Healthy Mushroom - On Action 2 Done - Run Script');

-- Grow is removed before shrinking, since any later scale aura change would recalculate the scale from it
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (3039100, 3039101));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3039100, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 227, 105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Healthy Mushroom - Actionlist - Set Scale 105%'),
(3039100, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 11, 57059, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Healthy Mushroom - Actionlist - Cast \'Serverside - Grow\''),
(3039101, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 57059, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Healthy Mushroom - Actionlist - Remove Aura \'Serverside - Grow\''),
(3039101, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 227, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Healthy Mushroom - Actionlist - Set Scale 10%');

-- Poisonous Mushroom
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30435);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30435, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - On Respawn - Set Reactstate Passive'),
(30435, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3043501, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - On Respawn - Run Script'),
(30435, 0, 2, 0, 26, 0, 100, 1, 0, 3, 0, 0, 1, 0, 223, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - In Combat LoS - Do Action ID 1 (No Repeat)'),
(30435, 0, 3, 0, 32, 0, 100, 1, 1, 150, 0, 0, 0, 0, 223, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - On Damaged Between 1-150 - Do Action ID 1 (No Repeat)'),
(30435, 0, 4, 0, 72, 0, 100, 1, 1, 0, 0, 0, 0, 0, 80, 3043500, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - On Action 1 Done - Run Script (No Repeat)'),
(30435, 0, 5, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 227, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - On Just Died - Set Scale 10%'),
(30435, 0, 6, 0, 72, 0, 100, 0, 2, 0, 0, 0, 0, 0, 80, 3043502, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - On Action 2 Done - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (3043500, 3043501, 3043502));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3043500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 57061, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - Actionlist - Cast \'Poison Cloud\''),
(3043500, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 28, 57059, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - Actionlist - Remove Aura \'Serverside - Grow\''),
(3043500, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 227, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - Actionlist - Set Scale 10%'),
(3043500, 9, 3, 0, 0, 0, 100, 0, 3650, 3650, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - Actionlist - Despawn Instant'),
(3043501, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 227, 105, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - Actionlist - Set Scale 105%'),
(3043501, 9, 1, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 11, 57059, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - Actionlist - Cast \'Serverside - Grow\''),
(3043502, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 57059, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - Actionlist - Remove Aura \'Serverside - Grow\''),
(3043502, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 227, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Poisonous Mushroom - Actionlist - Set Scale 10%');
