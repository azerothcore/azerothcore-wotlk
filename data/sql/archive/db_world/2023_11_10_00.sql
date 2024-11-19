-- DB update 2023_11_09_00 -> 2023_11_10_00
-- Tunneler Acid
DELETE FROM `spell_custom_attr` WHERE `spell_id`=14120;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (14120, 4194304);
