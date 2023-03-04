-- DB update 2023_03_04_03 -> 2023_03_04_04
--
DELETE FROM `acore_string` WHERE `entry` = 187;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUE
(187, 'This name is profane, choose another one');
