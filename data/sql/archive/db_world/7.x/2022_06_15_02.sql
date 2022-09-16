-- DB update 2022_06_15_01 -> 2022_06_15_02
DELETE FROM `spell_script_names` WHERE `spell_id` = 24834;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(24834, 'spell_shadow_bolt_whirl');
