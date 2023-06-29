-- DB update 2023_04_23_01 -> 2023_04_23_02
-- 18116 (Daggerfen Assassin)
UPDATE `creature_template_addon` SET `auras` = '22766' WHERE `entry` = 18116;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18116);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18116, 0, 0, 0, 0, 0, 100, 0, 4000, 4000, 10000, 10000, 0, 11, 35204, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Daggerfen Assassin - In Combat - Cast \'Toxic Fumes\''),
(18116, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daggerfen Assassin - Between 0-15% Health - Flee For Assist (No Repeat)');

-- 18115 (Daggerfen Muckdweller)
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 18115);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18115, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 4000, 8000, 0, 11, 35201, 32, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Daggerfen Muckdweller - In Combat - Cast \'Paralytic Poison\''),
(18115, 0, 1, 0, 2, 0, 100, 1, 0, 15, 0, 0, 0, 25, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Daggerfen Muckdweller - Between 0-15% Health - Flee For Assist (No Repeat)');

-- 19733 (Daggerfen Servant)
DELETE FROM `spell_script_names` WHERE `spell_id`=35207;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (35207, 'spell_gen_bandage');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19733);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19733, 0, 0, 0, 74, 0, 100, 0, 0, 25, 8000, 12000, 5, 11, 35207, 32, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Daggerfen Servant - On Friendly Between 0-25% Health - Cast \'Bandage\'');
