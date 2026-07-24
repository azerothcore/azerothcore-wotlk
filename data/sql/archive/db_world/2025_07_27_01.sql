-- DB update 2025_07_27_00 -> 2025_07_27_01
--
DELETE FROM `acore_string` WHERE `entry` = 179;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(179, '| AccountFlags:');
