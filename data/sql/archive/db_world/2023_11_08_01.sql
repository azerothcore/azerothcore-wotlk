-- DB update 2023_11_08_00 -> 2023_11_08_01
-- Sundering Swipe
DELETE FROM `spell_custom_attr` WHERE `spell_id`=35147;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (35147, 4194304);
