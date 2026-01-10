-- DB update 2024_07_04_05 -> 2024_07_04_06
--
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 38510;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(38510, 2147483648);
