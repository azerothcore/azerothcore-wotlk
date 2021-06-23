INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624454393059603100');

SET @SERGEANT_BLY_ENTRY = 7604;
SET @SERGEANT_BLY_ACTIONLIST = 760400;
SET @SOURCE_TYPE_ACTIONLIST = 9;
SET @SOURCE_TYPE_CREATURE = 0;
SET @SERGEANT_BLY_GOSSIP_MENU = 941;

-- Cleaning up Sergeant Bly's script
DELETE FROM `gossip_menu_option` WHERE (`MenuID` = @SERGEANT_BLY_GOSSIP_MENU) AND (`OptionID` IN (1));

-- ||||||||||||||||||||||||||||||
-- | New re-worked Sergeant Bly |
-- ||||||||||||||||||||||||||||||
-- New Condition Unit has Data set, used to display his gossip menu option when he's ready to be fought.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = @SERGEANT_BLY_GOSSIP_MENU) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 13) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 0) AND (`ConditionValue2` = 3) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, @SERGEANT_BLY_GOSSIP_MENU, 0, 0, 0, 103, 1, 3, 3, 0, 0, 0, 0, '', 'Checking if Sergeant Bly has field 3 and data 3');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 760402) AND (`source_type` = 9) AND (`id` IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(760402, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 3, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1883.82, 1200.83, 8.87, 0, 'Sergeant Bly - Actionlist - Move To Position'),
(760402, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 1874.11, 1206.17, 8.87, 0, 'Sergeant Bly - Actionlist - Move to pos target 1'),
(760402, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 1894.5, 1204.4, 8.87, 0, 'Sergeant Bly - Actionlist - Move to pos target 1'),
(760402, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 1877.52, 1199.63, 8.87, 0, 'Sergeant Bly - Actionlist - Move to pos target 1'),
(760402, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 201, 1, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 1891.83, 1201.45, 8.87, 0, 'Sergeant Bly - Actionlist - Move to pos target 1'),
(760402, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1883.82, 1200.83, 8.87, 4.68, 'Sergeant Bly - Actionlist - Set Home Position'),
(760402, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Actionlist - Set Data 2 0'),
(760402, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 12, 2, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Actionlist - Set Data 2 0'),
(760402, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Actionlist - Set Data 2 0'),
(760402, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 0, 0, 0, 0, 0, 12, 4, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Actionlist - Set Data 2 0'),
(760402, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 34, 3, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Actionlist - Set Instance Data 3 to 3'),
(760402, 9, 11, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Actionlist - Set Npc Flags Gossip'),
(760402, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 12, 3, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Actionlist - Set Npc Flags Gossip');
