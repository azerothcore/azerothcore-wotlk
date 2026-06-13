-- DB update 2025_10_10_01 -> 2025_10_11_00
-- Removes skinloot ID from the kodo appration
UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` = 11521;
