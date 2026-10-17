-- DB update 2025_03_13_00 -> 2025_03_15_00
--
-- SPELL_ATTR0_CU_ONLY_ONE_AREA_AURA 45402 Demonic Vapor
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 45402;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES(45402, 536870912);
