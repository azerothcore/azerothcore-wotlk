-- DB update 2023_08_06_01 -> 2023_08_06_02
--
UPDATE `creature_template` SET `ScriptName` = 'npc_magister_aledis' WHERE `entry` = 20159;

-- Gossip to start combat vs event completion and quest reward
UPDATE `conditions` SET `ConditionTypeOrReference`=28, `Comment`='Show gossip option 0 if player has quest Arelion\'s Secret completed OR' WHERE `SourceGroup`=8081 AND `ElseGroup`=0;

DELETE FROM `conditions` WHERE `SourceGroup`=8081 AND `ElseGroup`=1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 8081, 0, 0, 1, 8, 0, 10286, 0, 0, 0, 0, 0, '', 'Show gossip option 0 if player has quest Arelion\'s Secret rewarded');
