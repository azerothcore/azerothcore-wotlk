-- DB update 2025_11_13_05 -> 2025_11_14_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 50380;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(50380, 'spell_bloodspore_haze');

DELETE FROM `spell_custom_attr` WHERE `spell_id` = 50380;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(50380, 0x00400000);
