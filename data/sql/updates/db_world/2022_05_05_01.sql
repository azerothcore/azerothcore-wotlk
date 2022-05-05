-- DB update 2022_05_05_00 -> 2022_05_05_01
-- Fix gossip for Captured Arko'narin
UPDATE `creature_template` SET `gossip_menu_id`=3129 WHERE `entry`=11016;
DELETE FROM `gossip_menu` WHERE `MenuID`=30229;
DELETE FROM `gossip_menu` WHERE `MenuID`=3129 AND `TextID`=4114;
INSERT INTO `gossip_menu` (`MenuID`,`TextID`) VALUES (3129,4114);

-- Conditions for gosip text
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=3129;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14,3129,4113,0,0,8,0,5202,0,0,0,0,0,'','Captured Arko''narin - Show Gossip Menu Text 4113 if Quest 5202 is rewarded'),
(14,3129,4114,0,0,8,0,5203,0,0,0,0,0,'','Captured Arko''narin - Show Gossip Menu Text 4114 if Quest 5203 is rewarded');
