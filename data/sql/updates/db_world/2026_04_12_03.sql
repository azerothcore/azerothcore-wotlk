-- DB update 2026_04_12_02 -> 2026_04_12_03
-- Add SPELL_ATTR0_CU_DONT_BREAK_STEALTH (0x40) to Distract (1725)
UPDATE `spell_custom_attr` SET `attributes` = `attributes` | 0x40 WHERE `spell_id` = 1725;
