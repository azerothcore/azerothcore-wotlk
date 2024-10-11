-- DB update 2023_11_08_01 -> 2023_11_08_02
-- Carnivorous Bite, Sticky Ooze
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (30639,30494);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(30639, 4194304),
(30494, 4194304);
