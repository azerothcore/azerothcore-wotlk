INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1595505810975581600');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25773) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25773, 0, 0, 0, 54, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Fizzcrank Survivor - On Just Summoned - Say Line 0');

UPDATE `creature_template` SET `unit_flags` = 2 WHERE (`entry` = 25773);

DELETE FROM `spell_script_names` WHERE `spell_id`=45980 AND `ScriptName`='spell_q11712_re_cursive';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (45980, 'spell_q11712_re_cursive');
