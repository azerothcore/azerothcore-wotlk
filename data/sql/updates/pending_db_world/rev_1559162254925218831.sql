INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1559162254925218831');

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pal_item_healing_discount' AND `spell_id`=37705;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(37705, 'spell_item_eye_of_gruul_healing_discount');
