-- DB update 2023_09_25_06 -> 2023_09_25_07
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_warl_glyph_of_voidwalker' AND `spell_id` = 56247;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(56247, 'spell_warl_glyph_of_voidwalker');
