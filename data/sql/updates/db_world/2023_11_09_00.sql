-- DB update 2023_11_08_07 -> 2023_11_09_00
-- Acidic Bite
DELETE FROM `spell_custom_attr` WHERE `spell_id`=36796;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (36796, 4194304);
