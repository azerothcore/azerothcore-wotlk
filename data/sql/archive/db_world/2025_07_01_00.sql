-- DB update 2025_06_30_00 -> 2025_07_01_00
-- DB update 2025_06_29_02 -> 2025_06_29_03
--
SET @NPC := 29175;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2199.3313,-5271.9775,88.125336,0,0,1,0,100,0),
(@PATH,2,2235.2202,-5278.9307,79.06934,0,0,1,0,100,0),
(@PATH,3,2253.4414,-5284.3496,82.44837,0,0,1,0,100,0),
(@PATH,4,2281.2556,-5299.5728,84.998795,1.692969322204589843,0,1,0,100,0);

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 29175;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29175) AND (`source_type` = 0) AND (`id` IN (0, 1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29175, 0, 0, 1, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 206, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Tirion Fordring - On Path 0 Finished - Dismount'),
(29175, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1.692969322, 'Highlord Tirion Fordring - On Path 0 Finished - Set Orientation 1.692969322');

UPDATE `creature_text` SET `Type` = 41 WHERE `CreatureId` = 29173 AND `GroupId` = 72 AND `ID` = 0;
