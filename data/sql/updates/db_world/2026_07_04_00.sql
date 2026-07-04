-- DB update 2026_07_03_03 -> 2026_07_04_00
-- Honor Among Thieves triggered combo point (51699) is beneficial for the rogue:
-- mark it positive so it never pulls the rogue into combat with the targeted enemy
-- (SPELL_ATTR0_CU_POSITIVE_EFF0 | SPELL_ATTR0_CU_POSITIVE_EFF1)
DELETE FROM `spell_custom_attr` WHERE `spell_id` = 51699;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (51699, 0x6000000);
