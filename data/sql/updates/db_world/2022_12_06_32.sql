-- DB update 2022_12_06_31 -> 2022_12_06_32
--
UPDATE `creature_template` SET `detection_range` = 35 WHERE `entry` IN (17734, 20187);
