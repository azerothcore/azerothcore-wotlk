-- DB update 2025_07_14_00 -> 2025_07_15_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = -53301 AND `ScriptName` = 'spell_hun_explosive_shot';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (-53301, 'spell_hun_explosive_shot');
