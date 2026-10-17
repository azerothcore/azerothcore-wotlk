-- DB update 2026_08_02_02 -> 2026_08_02_03
--
DELETE FROM `spell_script_names` WHERE `ScriptName` IN ('spell_hodir_shatter_chest', 'spell_hodir_shatter_chest_timer_aura');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (65272, 'spell_hodir_shatter_chest_timer_aura');
