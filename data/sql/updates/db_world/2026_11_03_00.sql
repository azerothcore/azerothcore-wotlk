-- DB update 2026_11_02_00 -> 2026_11_03_00
--
-- Durnholde Armorer: sniffed faction and unit_flags, CREATURE_FLAG_EXTRA_CANNOT_ENTER_COMBAT
UPDATE `creature_template` SET `faction` = 634, `unit_flags` = `unit_flags` & ~0x200, `flags_extra` = `flags_extra` | 0x2000, `VerifiedBuild` = 42940 WHERE `entry` IN (18764, 20523);
