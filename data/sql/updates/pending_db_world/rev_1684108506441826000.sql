--
SET @NPC := 151089 * 10;
DELETE FROM `waypoint_data` WHERE `id` = @NPC;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`) VALUES
(@NPC, 1, 184.78966, 290.3699, -8.18139, 0),
(@NPC, 2, 178.51125, 287.97794, -8.183065, 0),
(@NPC, 3, 171.82281, 289.97687, -8.185595, 0),
(@NPC, 4, 178.51125, 287.97794, -8.183065, 0);

UPDATE `creature_template` SET `MovementType` = 2 WHERE `entry` IN (16807, 20568);

DELETE FROM `creature_template_addon` WHERE `entry` IN (16807, 20568);
INSERT INTO `creature_template_addon` (`entry`, `path_id`) VALUES
(16807, @NPC),
(20568, @NPC);

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 3) AND (`SourceEntry` = 17083) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 3, 17083, 0, 0, 31, 0, 4, 0, 0, 0, 0, 0, '', 'Only play SAI Event if Invoker is a Player');
