-- Stoneclaw Totem pulses should not break stealth (Patch 3.2.2).
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN
(5729, 6393, 6394, 6395, 10423, 10424, 25512, 58586, 58587, 58588);

INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(5729, 96),
(6393, 96),
(6394, 96),
(6395, 96),
(10423, 96),
(10424, 96),
(25512, 96),
(58586, 96),
(58587, 96),
(58588, 96);
