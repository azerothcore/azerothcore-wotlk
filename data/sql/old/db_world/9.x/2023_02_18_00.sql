-- DB update 2023_02_17_12 -> 2023_02_18_00
--
DELETE FROM `smart_scripts` WHERE `entryorguid`=18956 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18956, 0, 0, 2, 62, 0, 100, 1, 7868, 0, 0, 0, 0, 80, 1895600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lakka - On Gossip Option 0 Selected - Run Script (No Repeat)'),
(18956, 0, 1, 0, 40, 0, 100, 0, 9, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lakka - On Waypoint 9 Reached - Despawn (0)'),
(18956, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lakka - On Link - Close Gossip');

DELETE FROM `smart_scripts` WHERE `entryorguid`=1895600 AND `source_type`=9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1895600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 33, 18956, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Lakka - On Script - Quest Credit \'Brother Against Brother\''),
(1895600, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Lakka - On Script - Say Line 0'),
(1895600, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lakka - On Script - Remove NPC Flag Gossip'),
(1895600, 9, 3, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 20, 183051, 5, 0, 0, 0, 0, 0, 0, 'Lakka - On Script - Activate Closest Gameobject \'Sethekk Cage\''),
(1895600, 9, 4, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 53, 0, 1895600, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lakka - On Script - Start Waypoint');

DELETE FROM `waypoints` WHERE `entry`=1895600 AND `point_comment`='Lakka';
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(1895600, 1, -156.811, 159.9, 0.552411, NULL, 0, 'Lakka'),
(1895600, 2, -152.811, 162.15, 0.552411, NULL, 0, 'Lakka'),
(1895600, 3, -148.561, 163.65, 0.552411, NULL, 0, 'Lakka'),
(1895600, 4, -141.811, 164.9, 0.552411, NULL, 0, 'Lakka'),
(1895600, 5, -136.061, 167.4, 0.552411, NULL, 0, 'Lakka'),
(1895600, 6, -129.811, 171.4, 0.552411, NULL, 0, 'Lakka'),
(1895600, 7, -118.061, 173.9, 0.552411, NULL, 0, 'Lakka'),
(1895600, 8, -99.0612, 173.4, 0.302411, NULL, 0, 'Lakka'),
(1895600, 9, -79.8091, 172.757, 0.010726, NULL, 0, 'Lakka');

DELETE FROM `gossip_menu` WHERE `MenuID`=7868;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(7868, 9635),
(7868, 9636);

DELETE FROM `gossip_menu_option` WHERE `MenuID`=7868;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`) VALUES
(7868, 0, 0, 'I\'ll have you out of there in just a moment.', 16054, 1, 1, 0, 0, 0, 0, '', 0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14, 15) AND `SourceGroup`=7868;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 7868, 9635, 0, 0, 29, 1, 18472, 20, 0, 0, 0, 0, '', 'Gossip text requires boss Darkweaver Sith NOT defeated'),
(14, 7868, 9636, 0, 0, 29, 1, 18472, 20, 1, 0, 0, 0, '', 'Gossip text requires boss Darkweaver Sith defeated'),
(15, 7868, 0, 0, 0, 29, 1, 18472, 20, 1, 0, 0, 0, '', 'Gossip option requires boss Darkweaver Sith defeated');

DELETE FROM `npc_text` WHERE `ID`=9635;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES
(9635,'Please, $r, get me out of here! Unlocking the cage will surely attract my brother\'s attention. Kill Darkweaver Syth!');

DELETE FROM `gameobject_template_addon` WHERE `entry`=183051;
INSERT INTO `gameobject_template_addon` VALUES
(183051,112,32,0,0,0,0,0,0);
