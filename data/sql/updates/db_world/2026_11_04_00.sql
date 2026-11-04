-- DB update 2026_11_03_04 -> 2026_11_04_00
--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 9742 AND `SourceEntry` = 4 AND `ElseGroup` = 6;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 9742, 4, 0, 6, 2, 0, 38624, 1, 0, 1, 0, 0, '', 'High-Oracle Soo-say - Show Gossip if player doesn\'t already have Moodle\'s Stress Ball'),
(15, 9742, 4, 0, 6, 8, 0, 12580, 0, 0, 0, 0, 0, '', 'High-Oracle Soo-say - Show Gossip if player Has Rewarded Quest The Mosswalker Savior'),
(15, 9742, 4, 0, 6, 47, 0, 12581, 1, 0, 0, 0, 0, '', 'High-Oracle Soo-say - Show Gossip if player has not taken Quest A Hero\'s Burden');
