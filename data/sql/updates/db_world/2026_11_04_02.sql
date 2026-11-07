-- DB update 2026_11_04_01 -> 2026_11_04_02
--
-- Quest 9678 "The First Trial": kill credit only, Gilded Brazier (181956) and Sangrias Stillblade (17716) in SmartAI
UPDATE `quest_template_addon` SET `SpecialFlags` = `SpecialFlags` & ~2 WHERE `ID` = 9678;

-- Serverside 'Complete First Trial' quest-complete spell, not used by anything
DELETE FROM `spell_dbc` WHERE `ID` = 31265 AND `Effect_1` = 16;

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI', `ScriptName` = '' WHERE `entry` = 181956;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 181956 AND `source_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(181956, 1, 0, 0, 64, 0, 100, 0, 1, 0, 0, 0, 0, 0, 12, 17716, 4, 300000, 0, 0, 2, 8, 0, 0, 0, 0, 8032.587, -7524.518, 149.68073, 6.161012, 'Gilded Brazier - On Gossip Hello - Summon Creature \'Sangrias Stillblade\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 1) AND (`SourceEntry` = 181956) AND (`SourceId` = 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 181956, 1, 0, 47, 0, 9678, 8, 0, 0, 0, 0, '', 'Gilded Brazier - Player has quest \'The First Trial\' in progress'),
(22, 1, 181956, 1, 0, 29, 1, 17716, 200, 0, 1, 0, 0, '', 'Gilded Brazier - No alive \'Sangrias Stillblade\' within 200 yards');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 17716 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17716, 0, 0, 0, 1, 0, 100, 257, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sangrias Stillblade - Out of Combat - Say Line 0 (No Repeat) (Dont Reset)'),
(17716, 0, 1, 0, 1, 0, 100, 1, 2000, 2000, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 8051.857, -7543.9897, 149.69759, 0, 'Sangrias Stillblade - Out of Combat - Move To Point 1 (No Repeat)'),
(17716, 0, 2, 3, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sangrias Stillblade - On Point 1 Reached - Set Home Position'),
(17716, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 1771600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sangrias Stillblade - On Point 1 Reached - Run Script'),
(17716, 0, 4, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sangrias Stillblade - On Aggro - Set Npc Flags None'),
(17716, 0, 5, 0, 9, 0, 100, 1, 0, 0, 0, 0, 8, 25, 11, 22120, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sangrias Stillblade - Within 8-25 Range - Cast \'Charge\' (No Repeat)');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1771600 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1771600, 9, 0, 0, 0, 0, 100, 0, 1300, 1300, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 60, 0, 0, 0, 0, 0, 0, 0, 'Sangrias Stillblade - Actionlist - Start Attack Closest Player');

DELETE FROM `waypoints` WHERE `entry` = 17716 AND `pointid` IN (1, 2);
