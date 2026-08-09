--
DELETE FROM `creature_template_addon` WHERE (`entry` IN (32919, 33401));
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(32919, 0, 0, 0, 0, 0, 0, '62639 62641 62640'),
(33401, 0, 0, 0, 0, 0, 0, '62639 62641 62640');
