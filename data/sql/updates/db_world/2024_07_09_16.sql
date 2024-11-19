-- DB update 2024_07_09_15 -> 2024_07_09_16
-- Sturdy Plate
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|33554432 WHERE (`entry` = 32839);
