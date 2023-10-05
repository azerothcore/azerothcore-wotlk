-- DB update 2023_08_24_02 -> 2023_08_25_00
-- Insertion Aura Has Brewfest Mug
DELETE FROM `spell_custom_attr` WHERE (`spell_id` = 42533);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (42533, 16777216);
