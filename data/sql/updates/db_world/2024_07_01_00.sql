-- DB update 2024_06_29_11 -> 2024_07_01_00
--
DELETE FROM `acore_string` WHERE `entry` = 602;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(602, ' [rewarded]');
