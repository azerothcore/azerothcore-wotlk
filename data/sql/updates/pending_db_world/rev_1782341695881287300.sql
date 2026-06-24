-- Freya - Detonating Lashers: submerge visual + no-crit auras on spawn (issue #26255)
DELETE FROM `creature_template_addon` WHERE `entry` IN (32918, 33399);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(32918, 0, 0, 0, 0, 0, 0, '28819 64481'),
(33399, 0, 0, 0, 0, 0, 0, '28819 64481');
