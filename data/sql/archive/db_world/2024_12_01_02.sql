-- DB update 2024_12_01_01 -> 2024_12_01_02
--
-- lookout
-- spawn coords, hp 58682 from 75449
DELETE FROM `creature` WHERE (`id1` = 24175) AND (`guid` = 89281);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(89281, 24175, 0, 0, 568, 0, 0, 1, 1, 1, 206.92128, 1473.4196, 26.000067, 3.9619, 7200, 0, 0, 58682, 0, 0, 0, 0, 0, '', 0);

UPDATE `creature_template` SET `unit_flags` = `unit_flags` | (64 | 32768) WHERE (`entry` = 24175);

UPDATE `creature_template_model` SET `VerifiedBuild` = 53788 WHERE (`CreatureID` = 24175) AND `Idx` = 0;

DELETE FROM `waypoint_data` WHERE `id` = 2417500;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `move_type`) VALUES
(2417500, 1, 226.08507, 1461.7535, 25.916739, NULL, 1),
(2417500, 2, 228.17633, 1433.8473, 27.119087, NULL, 1),
(2417500, 3, 227.73102, 1412.5535, 34.49932, NULL, 1),
(2417500, 4, 228.17111, 1388.2885, 42.451878, NULL, 1),
(2417500, 5, 232.54265, 1374.3815, 47.329865, NULL, 1),
(2417500, 6, 263.18665, 1376.4918, 49.32171, NULL, 1),
(2417500, 7, 281.35666, 1378.9646, 49.32171, NULL, 1),
(2417500, 8, 312.53738, 1389.2349, 57.287518, NULL, 1),
(2417500, 9, 330.47836, 1394.2004, 71.362785, NULL, 1);

-- summon amani eagle at Akil'zon
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 43487);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 43487, 0, 0, 31, 0, 3, 23574, 0, 0, 0, 0, '', 'Summon Amani Eagle target Akil\'zon');

-- summon amani warrior at Eagle Troll Spawn Target
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 43486);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 43486, 0, 0, 31, 0, 3, 24325, 0, 0, 0, 0, '', 'Summon Amani Eagle target Eagle Troll Spawn Target');

DELETE FROM `creature_text` WHERE (`CreatureID` = 24175) AND (`GroupID` = 0);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(24175, 0, 0, 'Akil\'zon, the invaders approach!', 14, 0, 100, 5, 0, 0, 22971, 0, 'Amani\'shi Lookout');

UPDATE `creature_template` SET `ScriptName` = 'npc_amanishi_lookout' WHERE (`entry` = 24175);
UPDATE `creature_template` SET `ScriptName` = 'npc_eagle_trash_aggro_trigger' WHERE (`entry` = 24223);
UPDATE `creature_template` SET `ScriptName` = 'npc_amanishi_tempest' WHERE (`entry` = 24549);

-- add missing wind walker and protector spawns
SET @GUID:= 93762;
SET @VERIFIED_BUILD:=0;
DELETE FROM `creature` WHERE (`id1` = 24179) AND (`guid` BETWEEN @GUID+0 AND @GUID+3);
DELETE FROM `creature` WHERE (`id1` = 24180) AND (`guid` BETWEEN @GUID+4 AND @GUID+7);
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@GUID+0, 24179, 0, 0, 568, 0, 0, 1, 1, 1, 284.0440, 1372.3200, 49.4050, 2.77507, 1800, 0, 0, @VERIFIED_BUILD, 0, 0, 0, 0, 0, '', 0),
(@GUID+1, 24179, 0, 0, 568, 0, 0, 1, 1, 1, 231.7970, 1393.4200, 40.5887, 1.69297, 1800, 0, 0, @VERIFIED_BUILD, 0, 0, 0, 0, 0, '', 0),
(@GUID+2, 24179, 0, 0, 568, 0, 0, 1, 1, 1, 244.8070, 1367.6600, 48.9498, 2.61799, 1800, 0, 0, @VERIFIED_BUILD, 0, 0, 0, 0, 0, '', 0),
(@GUID+3, 24179, 0, 0, 568, 0, 0, 1, 1, 1, 232.7490, 1428.7000, 28.8242, 1.83260, 1800, 0, 0, @VERIFIED_BUILD, 0, 0, 0, 0, 0, '', 0),
(@GUID+4, 24180, 0, 0, 568, 0, 0, 1, 1, 1, 274.3580, 1385.1600, 49.4050, 3.75246, 1800, 0, 0, @VERIFIED_BUILD, 0, 0, 0, 0, 0, '', 0),
(@GUID+5, 24180, 0, 0, 568, 0, 0, 1, 1, 1, 223.8010, 1424.9400, 29.4699, 1.16937, 1800, 0, 0, @VERIFIED_BUILD, 0, 0, 0, 0, 0, '', 0),
(@GUID+6, 24180, 0, 0, 568, 0, 0, 1, 1, 1, 224.0690, 1394.2600, 40.1985, 1.30900, 1800, 0, 0, @VERIFIED_BUILD, 0, 0, 0, 0, 0, '', 0),
(@GUID+7, 24180, 0, 0, 568, 0, 0, 1, 1, 1, 246.9080, 1375.1500, 49.4050, 2.89725, 1800, 0, 0, @VERIFIED_BUILD, 0, 0, 0, 0, 0, '', 0);
