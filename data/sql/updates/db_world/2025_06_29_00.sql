-- DB update 2025_06_28_00 -> 2025_06_29_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 29313 AND `ScriptName` = 'spell_gen_cooldown_all';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (29313 , 'spell_gen_cooldown_all');
