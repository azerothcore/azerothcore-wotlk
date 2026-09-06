-- DB update 2025_11_21_01 -> 2025_11_21_02
--
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 54581;
DELETE FROM `spell_script_names` WHERE `spell_id` = 54581;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(54581, 'spell_mammoth_explosion');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29402) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29402, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 41, 3000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironwool Mammoth - On Spellhit \'Throw U.D.E.D.\' - Despawn In 3000 ms');
