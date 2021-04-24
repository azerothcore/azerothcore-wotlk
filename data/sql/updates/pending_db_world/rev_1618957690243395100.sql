INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1618957690243395100');

UPDATE `creature_template` SET `npcflag`=`npcflag`|1 WHERE `entry` = 30596;

DELETE FROM `creature_template_addon` WHERE `entry` = 30596;
INSERT INTO `creature_template_addon` (`entry`, `bytes2`) VALUES
(30596, 0);

DELETE FROM `gossip_menu` WHERE `MenuID`=9999 AND `TextID`=13857;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9999, 13857);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=9999;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 9999, 13856, 0, 0, 15, 0, 32, 0, 0, 1, 0, 0, "", "Show gossip text 13856 if player is NOT a Death Knight"),
(14, 9999, 13857, 0, 0, 15, 0, 32, 0, 0, 0, 0, 0, "", "Show gossip text 13857 if player is a Death Knight");
