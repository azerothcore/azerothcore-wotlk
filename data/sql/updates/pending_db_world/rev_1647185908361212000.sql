INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647185908361212000');

DELETE FROM `spell_script_names` WHERE `spell_id`=45831;
INSERT INTO `spell_script_names` VALUES
(45831,'spell_gen_av_drekthar_presence');
