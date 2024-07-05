-- DB update 2023_03_16_05 -> 2023_03_16_06
--
UPDATE `creature_template` SET `minlevel` = 63, `maxlevel` = 63 WHERE (`entry` = 20700);
UPDATE `creature_template` SET `AIName` = '' WHERE (`entry` = 18703);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18703) AND (`source_type` = 0);

DELETE FROM `creature_template_addon` WHERE (`entry` = 20700);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(20700, 0, 0, 0, 1, 0, 0, '24051');
