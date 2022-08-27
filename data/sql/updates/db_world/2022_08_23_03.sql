-- DB update 2022_08_23_02 -> 2022_08_23_03
--
UPDATE `creature_template` SET `mingold` = 0, `maxgold` = 0 WHERE `entry` IN (15344, 15555);
