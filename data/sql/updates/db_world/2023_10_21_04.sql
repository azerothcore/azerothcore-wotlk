-- DB update 2023_10_21_03 -> 2023_10_21_04
-- Quest: Corrupted Sabers
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 55002) AND (`SourceEntry` = 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 55002, 1, 0, 0, 47, 0, 4506, 8, 0, 0, 0, 0, '', 'Show Corrupted Saber gossip menu option only if player is on the quest "Corrupted Sabers".');

DELETE FROM `creature_text` WHERE `CreatureID` IN (9936,10042);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(10042, 0, 0, '%s follows $n obediently.', 16, 0, 100, 0, 0, 0, 5940, 0, 'Corrupted Saber');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `gossip_menu_id` = 55002, `npcflag` = `npcflag`|1 WHERE (`entry` = 10042);
UPDATE `creature_template` SET `AIName` = '', `gossip_menu_id` = 0, `npcflag` = `npcflag`&~1 WHERE (`entry` = 9936);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 9937);
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 993700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(9937, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 993700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - On Just Summoned - Run Script'),
(9937, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - On Just Summoned - Remove Npc Flags Gossip'),
(9937, 0, 2, 3, 75, 0, 100, 0, 0, 9996, 5, 2000, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - On Distance 5y To Creature - Set Rooted On'),
(9937, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 82, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - On Distance 5y To Creature - Add Npc Flags Gossip'),
(9937, 0, 4, 5, 62, 0, 100, 0, 55002, 1, 0, 0, 0, 0, 26, 4506, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - On Gossip Option 1 Selected - Quest Credit \'Corrupted Sabers\' to Owner or Summoner'),
(9937, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - On Gossip Option 1 Selected - Close Gossip'),
(9937, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 10000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - On Gossip Option 1 Selected - Despawn In 10000 ms'),
(993700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - Actionlist - Say Line 0'),
(993700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 136, 1, 0, 5, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - Actionlist - Set Run Speed to 0.5'),
(993700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 4582.23, -216.14, 300.23, 0, 'Common Kitten - Actionlist - Move To Position'),
(993700, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 36, 10042, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - Actionlist - Update Template To \'Corrupted Saber\''),
(993700, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 16510, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - Actionlist - Cast \'Corrupted Saber Visual (DND)\''),
(993700, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - Actionlist - Remove Npc Flags Gossip'),
(993700, 9, 6, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - Actionlist - Say Line 0'),
(993700, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 29, 2, 90, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - Actionlist - Start Follow Owner Or Summoner'),
(993700, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 136, 1, 1, 42, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Common Kitten - Actionlist - Set Run Speed to 1.42');
