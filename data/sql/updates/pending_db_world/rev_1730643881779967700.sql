-- Spotlight
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (29683,32214);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(29683, 536870912),
(32214, 536870912);
