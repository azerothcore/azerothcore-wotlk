INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648996451912542300');

DELETE FROM `spell_script_names` WHERE `spell_id`=22247;
INSERT INTO `spell_script_names` VALUES
(22247,'spell_suppression_aura');
