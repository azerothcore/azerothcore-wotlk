-- Introspection
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (40055,40165,40166,40167);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(40055, 4096),
(40165, 4096),
(40166, 4096),
(40167, 4096);
