-- DB update 2023_11_16_06 -> 2023_11_16_07
-- Sunder Armor
DELETE FROM `spell_custom_attr` WHERE `spell_id`=15572;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (15572, 4194304);
