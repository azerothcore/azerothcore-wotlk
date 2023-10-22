-- DB update 2023_03_03_00 -> 2023_03_04_00
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_dragonblight_corrosive_spit';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (47447, 'spell_dragonblight_corrosive_spit');
