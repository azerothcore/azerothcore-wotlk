-- DB update 2023_11_12_00 -> 2023_11_12_01
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` IN (6974,6989,6973,6975,7210) AND `id1` IN (2718,2717,2716,2716,2907);
DELETE FROM `creature_addon` WHERE (`guid` IN (6974,6989,6973,6975,7210));
INSERT INTO `creature_addon` (`guid`, `path_id`, `bytes2`) VALUES
(6974, 69740, 1),
(6989, 69890, 1),
(6973, 69730, 1),
(6975, 69750, 1),
(7210, 72100, 1);
