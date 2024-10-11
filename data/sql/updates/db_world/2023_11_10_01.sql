-- DB update 2023_11_10_00 -> 2023_11_10_01
-- Sunder Armor
DELETE FROM `spell_custom_attr` WHERE `spell_id`=16145;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (16145, 4194304);
