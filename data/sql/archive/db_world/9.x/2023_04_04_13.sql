-- DB update 2023_04_04_12 -> 2023_04_04_13
--
UPDATE `creature_template` SET `detection_range`=65 WHERE `entry` IN (20465,21943);
UPDATE `creature_template` SET `minlevel`=70, `maxlevel`=70 WHERE `entry`=21943;
