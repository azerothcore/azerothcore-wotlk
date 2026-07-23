-- DB update 2025_10_31_00 -> 2025_10_31_01

-- Set Rooted
UPDATE `creature_template_movement` SET `Rooted` = 1 WHERE (`CreatureId` = 16129);
