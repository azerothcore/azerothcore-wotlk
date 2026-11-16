-- DB update 2026_11_16_02 -> 2026_11_16_03
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (67547, 68084) AND `ScriptName` = 'spell_valkyr_clear_auras';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(67547, 'spell_valkyr_clear_auras'),
(68084, 'spell_valkyr_clear_auras');
