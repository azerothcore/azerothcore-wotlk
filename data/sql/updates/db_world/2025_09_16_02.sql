-- DB update 2025_09_16_01 -> 2025_09_16_02
--
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_dragonblight_flame_fury';
INSERT INTO `spell_script_names` VALUES
(50348, 'spell_dragonblight_flame_fury');
