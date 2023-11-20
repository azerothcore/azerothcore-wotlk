-- DB update 2023_11_19_06 -> 2023_11_20_00
UPDATE `quest_template_addon` SET `SpecialFlags` = 2 WHERE (`ID` = 4964);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6266;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 6266);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6266, 0, 0, 0, 19, 0, 100, 512, 4975, 0, 0, 0, 0, 0, 80, 626600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Menara Voidrender - On Quest \'The Completed Orb of Noh\'Orahil\' Taken - Run Script'),
(6266, 0, 1, 0, 19, 0, 100, 512, 4964, 0, 0, 0, 0, 0, 80, 626600, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Menara Voidrender - On Quest \'The Completed Orb of Dar\'Orahil\' Taken - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 626600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(626600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 83, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Menara Voidrender  - Remove Gossip and Quest Giver npc flags from self.'),
(626600, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 11, 16633, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Menara Voidrender - Cast self - Create Item Visual'),
(626600, 9, 2, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 15, 4975, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Menara Voidrender - On Script - Quest Credit \'The Completed Orb of Noh\'Orahil\''),
(626600, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 15, 4964, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Menara Voidrender - On Script - Quest Credit \'The Completed Orb of Dar\'Orahil\''),
(626600, 9, 4, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 82, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Menara Voidrender - Add Gossip and Quest Giver npc flags to self.');



