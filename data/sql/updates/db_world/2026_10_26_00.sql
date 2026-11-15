-- DB update 2026_10_25_03 -> 2026_10_26_00
--
-- Intellect Buffs (1124) must hold the intellect single buffs (1083), Spirit Buffs (1125) the spirit ones (1085)
DELETE FROM `spell_group` WHERE `id` = 1124 AND `spell_id` IN (-1083, -1085);
DELETE FROM `spell_group` WHERE `id` = 1125 AND `spell_id` IN (-1083, -1085);
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES (1124, -1083), (1125, -1085);
