-- Add language string for pinfo online time
DELETE FROM `acore_string` WHERE `entry` = 35410;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(35410, '¦ Online for:  {}');
