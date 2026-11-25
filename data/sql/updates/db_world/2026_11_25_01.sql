-- DB update 2026_11_25_00 -> 2026_11_25_01
--
-- Bountiful Table Hostess: UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC (TrinityCore 1c07b178a)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 768 WHERE `entry` = 34653;
