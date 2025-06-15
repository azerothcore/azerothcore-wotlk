-- DB update 2025_06_15_00 -> 2025_06_15_01
UPDATE `spell_script_names` SET `ScriptName` = 'spell_gen_area_aura_select_players_and_caster' WHERE `spell_id` = 53642;

DELETE FROM `spell_custom_attr` WHERE `spell_id` = 53642;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (53642, 2048);
