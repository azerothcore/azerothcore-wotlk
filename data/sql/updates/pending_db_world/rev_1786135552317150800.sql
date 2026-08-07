-- Override the Templates
DELETE FROM `creature_addon` WHERE (`guid` IN (100354, 100355, 100356, 100357, 100358, 100359, 100456, 100459));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(100354, 0, 0, 1, 1, 0, 0, ''),
(100355, 0, 0, 1, 1, 0, 0, ''),
(100356, 0, 0, 1, 1, 0, 0, ''),
(100357, 0, 0, 1, 1, 0, 0, ''),
(100358, 0, 0, 1, 1, 0, 0, ''),
(100359, 0, 0, 1, 1, 0, 0, ''),
(100456, 0, 0, 0, 1, 0, 0, ''),
(100459, 0, 0, 0, 1, 0, 0, '');

-- The previous flags came from the auras, not inherent to the template
UPDATE `creature_template` SET `unit_flags` = 32768, `dynamicflags` = 0 WHERE (`entry` IN (26159, 26160));

-- Spell is already cast on Quest Accepted, no need to double it
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 26158;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 26158) AND (`source_type` = 0);
