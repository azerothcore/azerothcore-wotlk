-- DB update 2022_07_03_06 -> 2022_07_03_07
--
UPDATE `creature_template` SET `mingold` = 0, `maxgold` = 0 WHERE (`entry` = 4196);
