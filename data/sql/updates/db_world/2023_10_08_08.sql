-- DB update 2023_10_08_07 -> 2023_10_08_08
-- Annihilator - Armor Shatter
DELETE FROM `spell_custom_attr` WHERE `spell_id`=16928;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (16928, 4194304);

-- Bashguuder & Bashguuder - Puncture Armor
DELETE FROM `spell_custom_attr` WHERE `spell_id`=17315;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (17315, 4194304);
