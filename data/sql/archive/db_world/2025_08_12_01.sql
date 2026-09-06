-- DB update 2025_08_12_00 -> 2025_08_12_01
-- Anub'ar Guardian - Sunder Armor, Sunder Armor(H)
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (53618, 59350);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(53618, 4194304),
(59350, 4194304);
