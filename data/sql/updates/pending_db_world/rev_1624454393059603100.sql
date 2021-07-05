-- INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624454393059603100');

SET @SERGEANT_BLY_ENTRY = 7604;
SET @SERGEANT_BLY_ALIST = 760400;
SET @SERGEANT_BLY_GOSSIP_MENU = 941;

SET @SOURCE_TYPE_CREATURE = 0;
SET @CONDITION_UNIT_DATA = 103;

-- New Condition Unit has Data set, used to display his gossip menu option when he's ready to be fought.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = @SERGEANT_BLY_GOSSIP_MENU);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, @SERGEANT_BLY_GOSSIP_MENU, 0, 0, 0, @CONDITION_UNIT_DATA, 1, 3, 3, 0, 0, 0, 0, '', 'Checking if Sergeant Bly has field 3 and data 3');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = @SERGEANT_BLY_GOSSIP_MENU) AND (`SourceEntry` = 1515);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, @SERGEANT_BLY_GOSSIP_MENU, 1515, 0, 0, @CONDITION_UNIT_DATA, 1, 0, 0, 0, 0, 0, 0, '', 'Show Text if GetData(0) == 0');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` = @SERGEANT_BLY_GOSSIP_MENU) AND (`SourceEntry` = 1516);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, @SERGEANT_BLY_GOSSIP_MENU, 1516, 0, 0, @CONDITION_UNIT_DATA, 1, 1, 1, 0, 0, 0, 0, '', 'Show Text if GetData(0) == 1');

-- SERGEANT BLY SMARTAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7604;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 7604);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7604, 0, 0, 0, 38, 0, 100, 257, 1, 1, 0, 0, 0, 80, 760400, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Data Set 1 1 - Run Script (No Repeat)'),
(7604, 0, 1, 2, 34, 0, 100, 257, 8, 1, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Reached Point 1 - Set Home Position (No Repeat)'),
(7604, 0, 2, 4, 61, 0, 100, 0, 8, 1, 0, 0, 0, 80, 760401, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Reached Point 1 - Run Script (No Repeat)'),
(7604, 0, 3, 0, 0, 0, 100, 0, 3000, 10000, 9000, 15000, 0, 11, 12170, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - In Combat - Cast \'Revenge\''),
(7604, 0, 4, 0, 61, 0, 100, 0, 8, 1, 0, 0, 0, 11, 3637, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Reached Point 1 - Cast \'Improved Blocking III\' (No Repeat)'),
(7604, 0, 5, 0, 0, 0, 100, 0, 3000, 10000, 17000, 27000, 0, 11, 11972, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - In Combat - Cast \'Shield Bash\''),
(7604, 0, 6, 0, 77, 0, 100, 257, 1, 2, 0, 0, 0, 80, 760402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Missing comment for event_type 77 - Run Script (No Repeat)'),
(7604, 0, 7, 8, 62, 0, 100, 257, 941, 1, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Gossip Option 1 Selected - Close Gossip (No Repeat)'),
(7604, 0, 8, 9, 61, 0, 100, 0, 941, 1, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Gossip Option 1 Selected - Set Orientation Invoker (No Repeat)'),
(7604, 0, 9, 0, 61, 0, 100, 0, 941, 1, 0, 0, 0, 80, 760403, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Gossip Option 1 Selected - Run Script (No Repeat)'),
(7604, 0, 10, 0, 34, 0, 100, 257, 8, 2, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Reached Point 2 - Set Home Position (No Repeat)'),
(7604, 0, 11, 12, 34, 0, 100, 257, 8, 3, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Reached Point 3 - Set Home Position (No Repeat)'),
(7604, 0, 12, 0, 61, 0, 100, 0, 8, 3, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - On Reached Point 3 - Set Data 3 3 (No Repeat)'),
(7604, 0, 13, 0, 60, 0, 100, 0, 7000, 9000, 4000, 7000, 0, 223, 1, 2, 0, 0, 0, 0, 9, 7789, 18, 100, 0, 0, 0, 0, 0, 'Sergeant Bly - On Update - Start random waypoint movement creature 7789'),
(7604, 0, 14, 0, 60, 0, 100, 0, 7000, 9000, 4000, 6000, 0, 223, 1, 2, 0, 0, 0, 0, 9, 7787, 18, 100, 0, 0, 0, 0, 0, 'Sergeant Bly - On Update - Start random waypoint movement creature 7787'),
(7604, 0, 15, 0, 60, 0, 100, 0, 7000, 9000, 5000, 8000, 0, 223, 1, 2, 0, 0, 0, 0, 9, 8876, 18, 100, 0, 0, 0, 0, 0, 'Sergeant Bly - On Update - Start random waypoint movement creature 8876'),
(7604, 0, 16, 0, 60, 0, 100, 0, 7000, 8000, 4000, 4500, 0, 223, 1, 2, 0, 0, 0, 0, 9, 7788, 18, 100, 0, 0, 0, 0, 0, 'Sergeant Bly - On Update - Start random waypoint movement creature 7788'),
(7604, 0, 17, 0, 60, 0, 100, 0, 7000, 8000, 6000, 6500, 0, 223, 1, 2, 0, 0, 0, 0, 9, 8877, 18, 100, 0, 0, 0, 0, 0, 'Sergeant Bly - On Update - Start random waypoint movement creature 8877');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = @SERGEANT_BLY_ALIST+1) AND (`source_type` = 9) AND (`id` IN (3, 4));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@SERGEANT_BLY_ALIST+1, 9, 3, 0, 0, 0, 100, 0, 60000, 60000, 0, 0, 0, 107, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Summon Creature Group'),
(@SERGEANT_BLY_ALIST+1, 9, 4, 0, 0, 0, 100, 0, 90000, 90000, 0, 0, 0, 107, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sergeant Bly - Script9 - Summon Creature Group');

DELETE FROM `gossip_menu_option` WHERE (`MenuID` = @SERGEANT_BLY_GOSSIP_MENU);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(@SERGEANT_BLY_GOSSIP_MENU, 0, 0, "That\'s it!  I\'m tired of helping you out.  It\'s time we settled things on the battlefield!", 4165, 1, 1, 0, 0, 0, 0, '', 0, 0);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = @SERGEANT_BLY_ALIST+2) AND (`source_type` = 9) AND (`id` IN (11));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@SERGEANT_BLY_ALIST+2, 9, 11, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 81, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, "Sergeant Bly - Script9 - Set NPC Flag");

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (7789, 7787, 8876, 7788, 8877);
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7789) AND (`source_type` = 0) AND (`id` IN (2));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7787) AND (`source_type` = 0) AND (`id` IN (0));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8876) AND (`source_type` = 0) AND (`id` IN (4));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7788) AND (`source_type` = 0) AND (`id` IN (0));
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 8877) AND (`source_type` = 0) AND (`id` IN (2));

-- This part of the script is experimental
-- Altering Waypoints table to group them and a new SmartAI Action for Random Waypoint Group:
-- allows for several pathing options for mobs, like for example Zul'farrak's mobs on Pyramid event
-- ALTER TABLE `waypoints`	ADD COLUMN `wp_group` MEDIUMINT(7) UNSIGNED NOT NULL DEFAULT '0' AFTER `pointid`;
-- ALTER TABLE `waypoints`
-- DROP PRIMARY KEY,
-- ADD PRIMARY KEY (`entry`, `pointid`, `wp_group`) USING BTREE;

DELETE FROM `waypoints` WHERE `entry` IN (7789, 7787, 8876, 7788, 8877);
INSERT INTO `waypoints` (`entry`, `pointid`, `wp_group`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(7789, 0, 1, 1900.05, 1228.05, 9.22243, NULL),
(7789, 1, 1, 1897.53, 1241.17, 20.4998, NULL),
(7789, 2, 1, 1892.34, 1259.13, 38.3703, NULL),
(7789, 0, 2, 1876.97, 1227.56, 9.59821, NULL),
(7789, 1, 2, 1879.39, 1243.26, 23.0368, NULL),
(7789, 0, 4, 1879.39, 1243.26, 23.0368, NULL),
(7789, 2, 2, 1882.09, 1258.41, 38.0934, NULL),
(7789, 1, 4, 1882.09, 1258.41, 38.0934, NULL),
(7789, 0, 3, 1897.53, 1241.17, 20.4998, NULL),
(7789, 1, 3, 1879.39, 1243.26, 23.0368, NULL),
(7787, 0, 1, 1900.05, 1228.05, 9.22243, NULL),
(7787, 1, 1, 1897.53, 1241.17, 20.4998, NULL),
(7787, 2, 1, 1892.34, 1259.13, 38.3703, NULL),
(7787, 0, 2, 1876.97, 1227.56, 9.59821, NULL),
(7787, 1, 2, 1879.39, 1243.26, 23.0368, NULL),
(7787, 0, 4, 1879.39, 1243.26, 23.0368, NULL),
(7787, 2, 2, 1882.09, 1258.41, 38.0934, NULL),
(7787, 1, 4, 1882.09, 1258.41, 38.0934, NULL),
(7787, 0, 3, 1897.53, 1241.17, 20.4998, NULL),
(7787, 1, 3, 1879.39, 1243.26, 23.0368, NULL),
(8876, 0, 1, 1900.05, 1228.05, 9.22243, NULL),
(8876, 1, 1, 1897.53, 1241.17, 20.4998, NULL),
(8876, 2, 1, 1892.34, 1259.13, 38.3703, NULL),
(8876, 0, 2, 1876.97, 1227.56, 9.59821, NULL),
(8876, 1, 2, 1879.39, 1243.26, 23.0368, NULL),
(8876, 0, 4, 1879.39, 1243.26, 23.0368, NULL),
(8876, 2, 2, 1882.09, 1258.41, 38.0934, NULL),
(8876, 1, 4, 1882.09, 1258.41, 38.0934, NULL),
(8876, 0, 3, 1897.53, 1241.17, 20.4998, NULL),
(8876, 1, 3, 1879.39, 1243.26, 23.0368, NULL),
(7788, 0, 1, 1900.05, 1228.05, 9.22243, NULL),
(7788, 1, 1, 1897.53, 1241.17, 20.4998, NULL),
(7788, 2, 1, 1892.34, 1259.13, 38.3703, NULL),
(7788, 0, 2, 1876.97, 1227.56, 9.59821, NULL),
(7788, 1, 2, 1879.39, 1243.26, 23.0368, NULL),
(7788, 0, 4, 1879.39, 1243.26, 23.0368, NULL),
(7788, 2, 2, 1882.09, 1258.41, 38.0934, NULL),
(7788, 1, 4, 1882.09, 1258.41, 38.0934, NULL),
(7788, 0, 3, 1897.53, 1241.17, 20.4998, NULL),
(7788, 1, 3, 1879.39, 1243.26, 23.0368, NULL),
(8877, 0, 1, 1900.05, 1228.05, 9.22243, NULL),
(8877, 1, 1, 1897.53, 1241.17, 20.4998, NULL),
(8877, 2, 1, 1892.34, 1259.13, 38.3703, NULL),
(8877, 0, 2, 1876.97, 1227.56, 9.59821, NULL),
(8877, 1, 2, 1879.39, 1243.26, 23.0368, NULL),
(8877, 0, 4, 1879.39, 1243.26, 23.0368, NULL),
(8877, 2, 2, 1882.09, 1258.41, 38.0934, NULL),
(8877, 1, 4, 1882.09, 1258.41, 38.0934, NULL),
(8877, 0, 3, 1897.53, 1241.17, 20.4998, NULL),
(8877, 1, 3, 1879.39, 1243.26, 23.0368, NULL);