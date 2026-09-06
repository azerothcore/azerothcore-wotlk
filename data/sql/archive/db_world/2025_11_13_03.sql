-- DB update 2025_11_13_02 -> 2025_11_13_03
--
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 53094;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(53094, 0x00400000);
