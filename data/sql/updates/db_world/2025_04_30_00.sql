-- DB update 2025_04_29_01 -> 2025_04_30_00
--
DELETE FROM `spell_script_names` WHERE `spell_id` = 46771 and `ScriptName` = 'spell_eredar_twins_flame_sear';
INSERT INTO `spell_script_names` VALUES (46771,'spell_eredar_twins_flame_sear');
