-- DB update 2026_10_15_06 -> 2026_10_15_07
--
-- Hungering Plaguehound (31556): sleeping in the Weeping Quarry, as sniffed
DELETE FROM `creature_template_addon` WHERE `entry` = 31556;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(31556, 0, 0, 0, 1, 0, 0, '45787 18950');

UPDATE `creature` SET `VerifiedBuild` = 52237 WHERE `id` = 31556 AND `guid` BETWEEN 121846 AND 121853;
