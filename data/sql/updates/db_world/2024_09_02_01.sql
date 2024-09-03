-- DB update 2024_09_02_00 -> 2024_09_02_01
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 40253;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (40253, 536870912);
