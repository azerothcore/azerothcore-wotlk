-- DB update 2023_11_08_02 -> 2023_11_08_03
-- Virulent Poison
DELETE FROM `spell_custom_attr` WHERE `spell_id`=16427;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (16427, 4194304);
