-- DB update 2025_08_12_01 -> 2025_08_13_00
-- Anub'ar Venomancer - Poison Bolt
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 53617;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (53617, 4194304);

-- Anub'ar Venomancer - Poison Bolt(H)
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 59359;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (59359, 4194304);
