-- DB update 2026_11_23_00 -> 2026_11_23_01
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (66829, 67315, 67316, 67317, 66061);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(66829, 'spell_valkyr_uber_spell_controller'),
(67315, 'spell_valkyr_uber_spell_controller'),
(67316, 'spell_valkyr_uber_spell_controller'),
(67317, 'spell_valkyr_uber_spell_controller'),
(66061, 'spell_valkyr_special_2_dummy_cooldown');
