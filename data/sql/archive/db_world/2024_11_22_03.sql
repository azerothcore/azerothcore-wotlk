-- DB update 2024_11_22_02 -> 2024_11_22_03
DELETE FROM `spell_custom_attr` WHERE `spell_id`=43299;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (43299, 4194304);
