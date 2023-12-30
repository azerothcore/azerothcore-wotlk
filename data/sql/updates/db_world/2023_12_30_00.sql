-- DB update 2023_12_28_00 -> 2023_12_30_00
-- Rotting Touch
DELETE FROM `spell_custom_attr` WHERE `spell_id`=50196;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (50196, 4194304);
