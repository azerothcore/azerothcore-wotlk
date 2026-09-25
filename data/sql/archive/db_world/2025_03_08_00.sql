-- DB update 2025_03_06_01 -> 2025_03_08_00

-- Add Disable Gravity
UPDATE `creature_template_movement` SET `Flight` = 1 WHERE (`CreatureId` = 25502);
