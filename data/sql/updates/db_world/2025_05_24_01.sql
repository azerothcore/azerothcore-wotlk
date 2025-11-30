-- DB update 2025_05_24_00 -> 2025_05_24_01
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (29102,29103));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29102, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Reset - Set Event Phase 1'),
(29102, 0, 1, 0, 24, 1, 100, 0, 52196, 1, 1000, 2000, 0, 0, 11, 53348, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Target Buffed With \'Frostbrood Vanquisher\' - Cast \'Arrow Assault\' (Phase 1)'),
(29102, 0, 2, 0, 9, 1, 100, 0, 2000, 4000, 4000, 6000, 40, 150, 11, 53345, 64, 0, 1, 0, 0, 9, 0, 40, 150, 0, 0, 0, 0, 0, 'Hearthglen Crusader - Within 40-150 Range - Cast \'Arrow Assault\' (Phase 1)'),
(29102, 0, 3, 0, 8, 0, 100, 0, 53110, 1, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearthglen Crusader - On Spellhit \'Devour Humanoid\' - Set Event Phase 2'),
(29103, 0, 0, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Reset - Set Event Phase 1'),
(29103, 0, 1, 0, 24, 1, 100, 0, 52196, 1, 1000, 2000, 0, 0, 11, 53348, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Target Buffed With \'Frostbrood Vanquisher\' - Cast \'Arrow Assault\' (Phase 1)'),
(29103, 0, 2, 0, 9, 1, 100, 0, 2000, 4000, 4000, 6000, 40, 150, 11, 53345, 64, 0, 1, 0, 0, 9, 0, 40, 150, 0, 0, 0, 0, 0, 'Tirisfal Crusader - Within 40-150 Range - Cast \'Arrow Assault\' (Phase 1)'),
(29103, 0, 3, 0, 8, 0, 100, 0, 53110, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Tirisfal Crusader - On Spellhit \'Devour Humanoid\' - Set Event Phase 2');

DELETE FROM `spell_script_names` WHERE `spell_id`=53111 AND `ScriptName`='spell_q12779_an_end_to_all_things_devour_aura';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (53111, 'spell_q12779_an_end_to_all_things_devour_aura');
