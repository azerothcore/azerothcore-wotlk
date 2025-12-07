-- PrevQuestID 11239 to 11231, make Of Keys and Cages the prerequisite, not In Service to the Light
UPDATE `quest_template_addon` SET `PrevQuestID` = 11231 WHERE (`ID` = 11432);

-- Add Mage-Lieutenant Malister's text
DELETE FROM `creature_text` WHERE (`CreatureID` = 23888) AND (`GroupID` IN (0));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23888, 0, 0, '$N, I would have words with you.', 15, 0, 100, 0, 0, 0, 0, 0, 'Mage-Lieutenant Malister - Quest 11231');

-- Father Levariol - Store player who completes Of Keys and Cages and send to Mage-Lieutenant Malister
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 24038;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 24038);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24038, 0, 1, 2, 20, 0, 100, 0, 11231, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Father Levariol - Store player who completes Of Keys and Cages - Quest 11231'),
(24038, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 23888, 0, 0, 0, 0, 0, 0, 0, 'Father Levariol - Send stored target to Mage-Lieutenant Malister - Quest 11231'),
(24038, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 23888, 0, 0, 0, 0, 0, 0, 0, 'Father Levariol - SET_DATA to Mage-Lieutenant Malister - Quest 11231');

-- Mage-Lieutenant Malister - On SET_DATA, whisper to stored target
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23888;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23888) AND (`source_type` = 0) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23888, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Mage-Lieutenant Malister - On DATA_SET whisper to stored target - Quest 11231');

