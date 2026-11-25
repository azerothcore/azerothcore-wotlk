-- DB update 2026_11_25_01 -> 2026_11_25_02
--
DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` = 28524;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(0, 28524, 64, '', '', 'Sapphiron: ignore LOS for Frost Breath, checked by spell_sapphiron_frost_explosion');

DELETE FROM `spell_script_names` WHERE `spell_id` = 28524 AND `ScriptName` = 'spell_sapphiron_frost_explosion';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(28524, 'spell_sapphiron_frost_explosion');
