-- DB update 2024_06_15_00 -> 2024_06_15_01
--
DELETE FROM `spell_custom_attr` WHERE `spell_id`=40103;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (40103, 4194304);
