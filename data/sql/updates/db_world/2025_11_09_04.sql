-- DB update 2025_11_09_03 -> 2025_11_09_04
--
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (52671, 59834);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(52671, 0x00400000),
(59834, 0x00400000);
