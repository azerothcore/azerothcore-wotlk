-- DB update 2024_07_19_03 -> 2024_07_21_00
--
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (25646, 13444);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(25646, 4194304),
(13444, 4194304);
