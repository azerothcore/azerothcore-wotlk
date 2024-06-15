-- DB update 2023_01_30_00 -> 2023_01_31_00
--
DELETE FROM `spell_script_names` WHERE `spell_id`=30421;
INSERT INTO `spell_script_names` VALUES
(30421,'spell_nether_portal_perseverence');
