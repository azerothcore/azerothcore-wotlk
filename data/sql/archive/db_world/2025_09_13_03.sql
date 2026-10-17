-- DB update 2025_09_13_02 -> 2025_09_13_03
-- Removes the skinLoot from Soriid the Devourer
UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` = 8204;
