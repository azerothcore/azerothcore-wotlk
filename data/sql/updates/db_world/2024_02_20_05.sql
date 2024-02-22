-- DB update 2024_02_20_04 -> 2024_02_20_05
-- Wand of Holiday Cheer
DELETE FROM `spell_custom_attr` WHERE `spell_id`=26074;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (26074, 128);
