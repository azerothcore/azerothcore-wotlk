-- DB update 2025_06_29_01 -> 2025_06_29_02
--
DELETE FROM `acore_string` WHERE `entry` IN (1184,1185);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(1184, '| Guild Ranks:'),
(1185, '| {} - {}');
