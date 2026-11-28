-- DB update 2026_10_25_02 -> 2026_10_25_03
--
-- SPELL_ATTR0_CU_IGNORE_BINARY (512) for spells that must not be auto-classified as binary.
DELETE FROM `spell_custom_attr` WHERE `spell_id` IN (62311, 64596, 63038, 63830);
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
(62311, 512), -- Cosmic Smash (Algalon)
(64596, 512), -- Cosmic Smash (Algalon)
(63038, 512), -- Dark Volley (Yogg-Saron)
(63830, 512); -- Malady of the Mind (Yogg-Saron)

 -- Water Spray (Mimiron)
UPDATE `spell_custom_attr` SET `attributes` = `attributes` | 512 WHERE `spell_id` = 64619;
