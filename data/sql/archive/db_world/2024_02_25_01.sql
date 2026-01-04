-- DB update 2024_02_25_00 -> 2024_02_25_01
--
DELETE FROM `spell_custom_attr` WHERE `spell_id`=36482;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (36482, 4194304);
