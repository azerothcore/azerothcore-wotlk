INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627743560834389300');

DELETE FROM `spell_script_names` WHERE `spell_id`=23134;
INSERT INTO `spell_script_names` VALUES
(23134, 'spell_item_goblin_bomb');
