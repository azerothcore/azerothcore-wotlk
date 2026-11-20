-- DB update 2026_11_20_01 -> 2026_11_20_02
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 59556;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(59556, 'spell_gen_cancel_aura');
