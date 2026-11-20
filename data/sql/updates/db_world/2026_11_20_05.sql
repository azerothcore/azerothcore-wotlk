-- DB update 2026_11_20_04 -> 2026_11_20_05
-- Sapph: remove the deleted quest-credit event link.
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30956 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30956,0,0,0,4,0,100,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sapph - On Aggro - Say Line 0'),
(30956,0,1,0,9,0,100,0,0,0,9000,13000,10,40,11,61077,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Sapph - Within 10-40 Range - Cast \'Chains of Ice\''),
(30956,0,2,0,106,0,100,0,18000,25000,18000,25000,0,8,11,61058,1,0,0,0,0,2,0,0,0,0,0,0,0,0,'Sapph - Within 0-8 Range - Cast \'Hungering Cold\''),
(30956,0,3,0,0,0,100,0,60000,120000,120000,240000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sapph - In Combat - Say Line 1'),
(30956,0,4,0,5,0,100,1,0,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sapph - On Killed Unit - Say Line 2'),
(30956,0,5,0,6,0,100,1,0,0,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sapph - On Just Died - Say Line 3 (No Repeat)');

-- Freed Crusader: follow the retail sequence. Each line gets its own creature_text group.
UPDATE `creature_text` SET `GroupID` = `ID`, `ID` = 0 WHERE `CreatureID` = 30274 AND `GroupID` = 0 AND `ID` > 0;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (3027400, 3027401, 3027402, 3027403) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3027400,9,0,0,0,0,100,0,0,0,0,0,0,0,87,3027401,3027402,3027403,0,0,0,1,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Call Random Timed Action List (Might, Kings, Wisdom)'),
(3027400,9,1,0,0,0,100,0,3000,4900,0,0,0,0,11,56539,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Cast \'Holy Light\''),
(3027400,9,2,0,0,0,100,0,100,100,0,0,0,0,1,3,0,1,0,0,0,7,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Say Line 3'),
(3027400,9,3,0,0,0,100,0,3000,3000,0,0,0,0,53,2,30274,0,13008,1000,0,1,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Start Waypoint'),
(3027400,9,4,0,0,0,100,0,60000,60000,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Despawn (fallback)'),
(3027401,9,0,0,0,0,100,0,0,0,0,0,0,0,11,56520,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Cast \'Blessing of Might\''),
(3027401,9,1,0,0,0,100,0,100,100,0,0,0,0,1,0,0,1,0,0,0,7,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Say Line 0'),
(3027402,9,0,0,0,0,100,0,0,0,0,0,0,0,11,56525,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Cast \'Blessing of Kings\''),
(3027402,9,1,0,0,0,100,0,100,100,0,0,0,0,1,1,0,1,0,0,0,7,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Say Line 1'),
(3027403,9,0,0,0,0,100,0,0,0,0,0,0,0,11,56521,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Cast \'Blessing of Wisdom\''),
(3027403,9,1,0,0,0,100,0,100,100,0,0,0,0,1,2,0,1,0,0,0,7,0,0,0,0,0,0,0,0,'Freed Crusader - On Script - Say Line 2');
