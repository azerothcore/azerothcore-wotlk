-- INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624454393059603100');

SET @SERGEANT_BLY_ENTRY = 7604;
SET @SOURCE_TYPE_CREATURE = 0;
SET @SERGEANT_BLY_GOSSIP_MENU = 941;

-- Cleaning up Sergeant Bly's script
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = @SERGEANT_BLY_GOSSIP_MENU) AND (`OptionID` IN (1));

-- New Condition Unit has Data set, used to display his gossip menu option when he's ready to be fought.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = @SERGEANT_BLY_GOSSIP_MENU);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, @SERGEANT_BLY_GOSSIP_MENU, 0, 0, 0, 103, 1, 3, 3, 0, 0, 0, 0, '', 'Checking if Sergeant Bly has field 3 and data 3');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = @SERGEANT_BLY_GOSSIP_MENU) AND (`SourceEntry` = 1515);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, @SERGEANT_BLY_GOSSIP_MENU, 1515, 0, 0, 103, 1, 0, 0, 0, 0, 0, 0, '', 'Show Text if GetData(0) == 0');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = @SERGEANT_BLY_GOSSIP_MENU) AND (`SourceEntry` = 1516);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, @SERGEANT_BLY_GOSSIP_MENU, 1516, 0, 0, 103, 1, 1, 1, 0, 0, 0, 0, '', 'Show Text if GetData(0) == 1');
