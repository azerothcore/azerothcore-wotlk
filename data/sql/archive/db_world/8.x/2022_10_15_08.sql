-- DB update 2022_10_15_07 -> 2022_10_15_08
--
UPDATE `creature_template` SET `mingold` = 0, `maxgold` = 0 WHERE (`entry` = 15334);
