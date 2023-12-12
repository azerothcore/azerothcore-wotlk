-- DB update 2023_10_29_01 -> 2023_10_31_00
-- Venom Sting
DELETE FROM `spell_custom_attr` WHERE `spell_id`=5416;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (5416, 4194304);
