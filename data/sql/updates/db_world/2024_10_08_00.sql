-- DB update 2024_10_04_00 -> 2024_10_08_00
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 41342;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (41342, 32768);
