-- DB update 2023_02_23_01 -> 2023_02_25_00
-- Scarlet Gallant - Crusader Strike - single aura stack
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 14517;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (14517, 4194304);
