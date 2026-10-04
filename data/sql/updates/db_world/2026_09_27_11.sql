-- DB update 2026_09_27_10 -> 2026_09_27_11
--
UPDATE `creature_template` SET `skinloot` = 0 WHERE `entry` IN (11262, 36566);
