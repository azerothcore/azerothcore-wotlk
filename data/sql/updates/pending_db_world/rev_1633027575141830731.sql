INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633027575141830731');

DELETE FROM `spell_script_names` WHERE `spell_id` = 15712 AND `ScriptName` = "spell_item_linken_boomerang";
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (15712, "spell_item_linken_boomerang");

