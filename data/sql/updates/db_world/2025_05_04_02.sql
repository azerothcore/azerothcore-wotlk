-- DB update 2025_05_04_01 -> 2025_05_04_02
-- Avenging Spirit - Wither
DELETE FROM `spell_custom_attr` WHERE `spell_id`=48585;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (48585, 4194304);
