-- DB update 2026_06_11_02 -> 2026_06_16_00
DELETE FROM `spell_script_names` WHERE `spell_id` = 20216 AND `ScriptName` = 'spell_pal_divine_favor';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(20216, 'spell_pal_divine_favor');
