-- DB update 2026_06_08_01 -> 2026_06_10_00
-- Stoneclaw Totem pulses should not break stealth (Patch 3.2.2).
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (5729, 6393, 6394, 6395, 10423, 10424, 25512, 58586, 58587, 58588);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(5729, 64),
(6393, 64),
(6394, 64),
(6395, 64),
(10423, 64),
(10424, 64),
(25512, 64),
(58586, 64),
(58587, 64),
(58588, 64);
