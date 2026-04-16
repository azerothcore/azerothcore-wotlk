-- DB update 2026_04_14_00 -> 2026_04_15_00
-- Erekem Guards: add UNIT_FLAG_IMMUNE_TO_PC (0x100)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 0x100 WHERE `entry` IN (29395, 31513);
