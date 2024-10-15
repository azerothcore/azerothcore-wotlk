-- DB update 2024_10_14_29 -> 2024_10_15_30

UPDATE `creature_template` SET `MovementType`= 0, `movementId`= 0 WHERE (`entry` = 28683);
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = 128455 AND `id1` = 28683;

DELETE FROM `creature_addon` WHERE (`guid` IN (128455));
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(128455, 12845500, 2409, 0, 1, 0, 0, NULL);
