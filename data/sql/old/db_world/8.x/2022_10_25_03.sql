-- DB update 2022_10_25_02 -> 2022_10_25_03
--
UPDATE `spell_dbc` SET `MaxTargets`=0 WHERE `id`=24019;

DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=24071;

DELETE FROM `spell_script_names` WHERE `spell_id`=24019;
INSERT INTO `spell_script_names` VALUES
(24019,'spell_axe_flurry');
