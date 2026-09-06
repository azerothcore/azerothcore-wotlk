-- DB update 2025_05_23_04 -> 2025_05_23_05
-- Captured Totem - NON_ATTACKABLE
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|2 WHERE (`entry` = 23811);
