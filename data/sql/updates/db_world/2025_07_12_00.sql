-- DB update 2025_07_10_00 -> 2025_07_12_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 53099 AND `ScriptName` = 'spell_portal_effect_acherus';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES(53099, 'spell_portal_effect_acherus');
DELETE FROM `spell_scripts` WHERE `id`=53099 AND `effIndex`=0;
