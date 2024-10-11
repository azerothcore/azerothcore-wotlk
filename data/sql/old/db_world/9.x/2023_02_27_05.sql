-- DB update 2023_02_27_04 -> 2023_02_27_05
-- Baron Revilgaz - On Pirates' Day - Show appropriate gossip
DELETE FROM `conditions` WHERE  `SourceGroup`=6685 AND `SourceEntry`=13062;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 6685, 13062, 0, 0, 12, 0, 50, 0, 0, 0, 0, 0, '', 'Baron Revilgaz - On Pirates\' Day event - Show appropriate gossip');
