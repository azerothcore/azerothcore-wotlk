INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1628235089665543589');

-- Conditions for spell "21086 Encouragement"
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=3 AND `SourceEntry`=21086 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=11663 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 21086, 0, 0, 31, 0, 3, 11663, 0, 0, 0, 0, '', 'Encouragement Effects 1 and Effect 2  - can target Flamewaker Healer');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=3 AND `SourceEntry`=21086 AND `SourceId`=0 AND `ElseGroup`=1 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=11664 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 21086, 0, 1, 31, 0, 3, 11664, 0, 0, 0, 0, '', 'Encouragement Effects 1 and Effect 2 - can target Flamewaker Elite');

-- Conditions for spell "21090 Champion"
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=7 AND `SourceEntry`=21090 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=11663 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 7, 21090, 0, 0, 31, 0, 3, 11663, 0, 0, 0, 0, '', 'Champion - can target Flamewaker Healer');
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=7 AND `SourceEntry`=21090 AND `SourceId`=0 AND `ElseGroup`=1 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=11664 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 7, 21090, 0, 1, 31, 0, 3, 11664, 0, 0, 0, 0, '', 'Champion - can target Flamewaker Elite');

-- Conditions for spell "21087 Immunity"
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=3 AND `SourceEntry`=21087 AND `SourceId`=0 AND `ElseGroup`=0 AND `ConditionTypeOrReference`=31 AND `ConditionTarget`=0 AND `ConditionValue1`=3 AND `ConditionValue2`=11663 AND `ConditionValue3`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 3, 21087, 0, 0, 31, 0, 3, 11663, 0, 0, 0, 0, '', 'Champion - can target Flamewaker Healer');

-- Texts
DELETE FROM `creature_text` WHERE `CreatureID`=12018 AND `GroupID`=7 AND `ID`=0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(12018, 7, 0, 'You think you\'ve won already? Perhaps you\'ll need another lesson in pain!', 14, 0, 100, 0, 0, 0, 8545, 0, 'majordomo SAY_LAST_ADD');

-- Majordomu summon
DELETE FROM `creature_summon_groups` WHERE `summonerId`=12018;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`) VALUES
(12018, 0, 1, 11663, 761.652, -1164.3, -119.533, 3.3919, 1, 10000),
(12018, 0, 1, 11663, 747.323, -1149.24, -120.06, 3.6629, 1, 10000),
(12018, 0, 1, 11663, 766.734, -1183.16, -119.292, 2.9889, 1, 10000),
(12018, 0, 1, 11663, 757.364, -1198.31, -118.652, 2.3095, 1, 10000),
(12018, 0, 1, 11664, 752.349, -1159.19, -119.261, 3.6032, 1, 10000),
(12018, 0, 1, 11664, 738.015, -1152.22, -119.512, 4.0792, 1, 10000),
(12018, 0, 1, 11664, 757.246, -1189.79, -118.633, 2.5333, 1, 10000),
(12018, 0, 1, 11664, 745.916, -1199.35, -118.119, 1.8932, 1, 10000);
