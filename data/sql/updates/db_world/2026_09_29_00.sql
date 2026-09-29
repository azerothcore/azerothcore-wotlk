-- DB update 2026_09_28_03 -> 2026_09_29_00
DELETE FROM `spell_script_names` WHERE `spell_id` = 62323;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(62323, 'spell_hookshot');
