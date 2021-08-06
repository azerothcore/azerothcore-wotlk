INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627725819856031500');

DELETE FROM `spell_script_names` WHERE `scriptname`= "spell_mage_combustion_proc";
INSERT INTO `spell_script_names` (`spell_id`,`scriptname`) VALUES (28682, "spell_mage_combustion_proc");
