-- DB update 2025_09_20_01 -> 2025_09_20_02
--
DELETE FROM `creature_template_addon` WHERE `entry` = 25494;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(25494, 0, 0, 0, 0, 0, 0, '45655');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 45656);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 45656, 0, 0, 31, 0, 3, 25493, 0, 0, 0, 0, '', 'Cauldron Purification hit West En\'kilah Cauldron'),
(13, 1, 45656, 0, 1, 31, 0, 3, 25490, 0, 0, 0, 0, '', 'Cauldron Purification hit East En\'kilah Cauldron'),
(13, 1, 45656, 0, 2, 31, 0, 3, 25492, 0, 0, 0, 0, '', 'Cauldron Purification hit Central En\'kilah Cauldron');

UPDATE `creature` SET `position_x`  = 4022.822, `position_y` = 3604.8394, `position_z` = 104.910614, `orientation` = 1.675516128540039062 WHERE `id1` = 25492;

DELETE FROM `creature_template_movement` WHERE `CreatureID` = 25492;
INSERT INTO `creature_template_movement` (`CreatureID`, `Ground`, `Swim`, `Flight`) VALUES
(25492, 1, 0, 1);
