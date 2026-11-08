-- DB update 2026_11_08_01 -> 2026_11_08_02
-- Aspect of Neptulon (21332): mark its dummy effect negative so the hit target enters combat with the caster
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 21332;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES
-- SPELL_ATTR0_CU_NEGATIVE_EFF0 (0x1000)
(21332, 4096); -- Aspect of Neptulon
