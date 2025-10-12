-- DB update 2025_09_10_01 -> 2025_09_10_02
--
DELETE FROM `creature_template_addon` WHERE `entry`=29854;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`bytes1`,`mount`,`auras`) VALUES
(29854,0,1,0, '');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 13) AND (`SourceGroup` = 1) AND (`SourceEntry` = 56393);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 1, 56393, 0, 0, 31, 0, 3, 29854, 0, 0, 0, 0, '', 'Feed Stormcrest Eagle target Stormcrest Eagle'),
(13, 1, 56393, 0, 0, 1, 0, 56393, 0, 0, 1, 0, 0, '', 'Feed Stormcrest Eagle target must not have Feed Stormcrest Eagle aura');

DELETE FROM `spell_script_names` WHERE `spell_id` = 56393;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(56393, 'spell_feed_stormcrest_eagle');
