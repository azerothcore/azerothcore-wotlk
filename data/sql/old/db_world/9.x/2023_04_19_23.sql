-- DB update 2023_04_19_22 -> 2023_04_19_23
--
DELETE FROM `spell_custom_attr` WHERE `spell_id`=33684;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (33684,4096);

