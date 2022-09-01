-- Voodoo Spirit - Add aura 24051
DELETE FROM `creature_template_addon` WHERE (`entry` = 15009);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(15009, 0, 0, 0, 0, 0, 0, '24051');
