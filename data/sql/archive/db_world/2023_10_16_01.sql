-- DB update 2023_10_16_00 -> 2023_10_16_01
-- Scourge Banner
DELETE FROM `spell_script_names` WHERE `spell_id`=16989 AND `ScriptName`='spell_gen_planting_scourge_banner';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (16989, 'spell_gen_planting_scourge_banner');
