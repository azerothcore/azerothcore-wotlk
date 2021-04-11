INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1617739461755573400');

DELETE FROM `spell_script_names` WHERE (`spell_id` IN (23567, 23568, 23569, 23696, 24412, 24413, 24414));
INSERT INTO `spell_script_names` VALUES
(23567, 'spell_gen_bandage'),
(23568, 'spell_gen_bandage'),
(23569, 'spell_gen_bandage'),
(23696, 'spell_gen_bandage'),
(24412, 'spell_gen_bandage'),
(24413, 'spell_gen_bandage'),
(24414, 'spell_gen_bandage');
