-- DB update 2025_10_19_00 -> 2025_10_21_00

-- Set Unit Flags (Persistence)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |256|512|33554432 WHERE (`entry` = 29863);
