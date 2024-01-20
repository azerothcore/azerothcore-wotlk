-- DB update 2023_06_02_03 -> 2023_06_02_04
--
UPDATE `creature_template` SET `mingold` = 0, `maxgold` = 0 WHERE `entry` = 16470;
