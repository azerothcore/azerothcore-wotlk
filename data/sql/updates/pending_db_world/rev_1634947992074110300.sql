INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634947992074110300');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -24869;

DELETE FROM `spell_script_names` WHERE `spell_id` = -24869 AND `ScriptName` = 'spell_gen_holiday_buff_food';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-24869, 'spell_gen_holiday_buff_food');
