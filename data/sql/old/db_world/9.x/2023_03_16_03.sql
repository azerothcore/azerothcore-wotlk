-- DB update 2023_03_16_02 -> 2023_03_16_03
-- Warchief's blessing - Add NO_PVP_FLAG
DELETE FROM `spell_custom_attr` WHERE `spell_id`=16609;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (16609, 128);
