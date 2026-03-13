-- DB update 2024_10_11_04 -> 2024_10_12_00
UPDATE `creature_template` SET `unit_flags` = 33587202 WHERE (`entry` = 28782);


DELETE FROM `creature_text` WHERE (`CreatureID` = 28782) AND (`GroupID` = 0) AND (`ID` IN (0));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES(28782, 0, 0, '%s rears up, beckoning you to ride it.', 16, 0, 100.0, 0, 0, 0, 29069, 0, 'Archerus Deathcharger');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28768;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28768) AND (`source_type` = 0) AND (`id` IN (6, 8, 9, 10, 11));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28768, 0, 6, 8, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 19, 28782, 5, 0, 0, 0, 0, 0, 0, 'Dark Rider of Acherus - On Death - Enter Evade Mode'),
(28768, 0, 8, 9, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 19, 28782, 5, 0, 0, 0, 0, 0, 0, 'Dark Rider of Acherus - On Death - Root In Place'),
(28768, 0, 9, 10, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 28782, 5, 0, 0, 0, 0, 0, 0, 'Dark Rider of Acherus - On Death - Emote Message'),
(28768, 0, 10, 11, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 19, 33554432, 0, 0, 0, 0, 0, 19, 28782, 5, 0, 0, 0, 0, 0, 0, 'Dark Rider of Acherus - On Death - Remove Not Selectable Unit Flag'),
(28768, 0, 11, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 142, 100, 0, 0, 0, 0, 0, 19, 28782, 5, 0, 0, 0, 0, 0, 0, 'Dark Rider of Acherus - On Death - Ensure Health Is Full When Revealed To Player');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 28782;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 28782) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(28782, 0, 0, 0, 27, 0, 100, 512, 0, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Archerus DeathCharger - On Mount - Remove Root Effect');
