-- DB update 2024_11_26_00 -> 2024_11_26_01
DELETE FROM `spell_custom_attr` WHERE `spell_id`=44132;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (44132, 4194304);
