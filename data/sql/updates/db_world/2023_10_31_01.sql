-- DB update 2023_10_31_00 -> 2023_10_31_01
-- Blistering Rot
DELETE FROM `spell_custom_attr` WHERE `spell_id`=32722;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (32722, 4194304);
