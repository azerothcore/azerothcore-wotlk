INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1554741101083171200');

UPDATE `creature_template` SET `unit_flags` = 4 WHERE `entry` = 22443;
UPDATE `creature_template` SET `flags_extra`= 2 WHERE `entry` IN (22471,22472);
UPDATE `creature_template` SET `InhabitType` = '3' WHERE `entry` = 22500;
UPDATE `creature_template` SET `ScriptName` = 'npc_deahts_fel_cannon' WHERE `entry` = 22443;
UPDATE `creature_template` SET `ScriptName` = 'npc_deaths_door_fell_cannon_target_bunny' WHERE `entry` = 22495;
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 22472;
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 22471;

DELETE FROM `conditions` WHERE  `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=39221 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=22471 AND `ConditionValue3`=0;
DELETE FROM `conditions` WHERE  `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=39221 AND `SourceId`=0 AND `ElseGroup`=1 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=22472 AND `ConditionValue3`=0;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=39221 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=22495 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES (13, 1, 39221, 0, 0, 31, 0, 3, 22495, 0, 0, 0, 0, '', 'Target Death\'s Door Fel Cannon Target Bunny');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=39219 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=22443 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES (13, 1, 39219, 0, 0, 31, 0, 3, 22443, 0, 0, 0, 0, '', 'Target Death\'s Door Fel Cannon');

DELETE FROM `creature` WHERE `id`=22495;
INSERT INTO `creature` (`guid`,`id`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(78947, 22495, 530, 0, 0, 1, 1, 0, 0, 2191.68725585938, 5478.57275390625, 160.826309204102, 0.456801176071167, 1, 0, 0, 6986, 0, 0, 0, 0, 0, '', 0),
(78948, 22495, 530, 0, 0, 1, 1, 0, 0, 1978.12377929688, 5319.36865234375, 162.545059204102, 2.30369400978088, 300, 0, 0, 6986, 0, 0, 0, 0, 0, '', 0);
