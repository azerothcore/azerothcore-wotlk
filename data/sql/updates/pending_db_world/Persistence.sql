
-- Set Unit Flags (Persistence)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |256|512|33554432 WHERE (`entry` = 29863);
