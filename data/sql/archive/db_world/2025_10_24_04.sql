-- DB update 2025_10_24_03 -> 2025_10_24_04
DELETE FROM `creature_text` WHERE `CreatureID` = 19738;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(19738, 0, 0, 'Hahaha! We''re coming for you, little goblins!', 14, 0, 100, 0, 0, 0, 17408, 0, 'Doomclaw - On Death'),
(19738, 1, 0, 'Work harder, dogs!', 12, 0, 100, 0, 0, 0, 17953, 0, 'Doomclaw - Random Say 1'),
(19738, 1, 1, 'This is hard work. I feel like I need a vacation. You there, put your back into it!', 12, 0, 100, 0, 0, 0, 17960, 0, 'Doomclaw - Random Say 2'),
(19738, 1, 2, 'Faster, or you will taste The Claw!', 12, 0, 100, 0, 0, 0, 17954, 0, 'Doomclaw - Random Say 3');

UPDATE `creature_template` SET `AIName`='SmartAI', `ScriptName`='' WHERE `entry`=19738;

DELETE FROM `smart_scripts` WHERE `entryorguid`=19738 AND `source_type`=0 AND `id` IN (4, 5);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19738, 0, 4, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomclaw - On Death - Say Line 0'),
(19738, 0, 5, 0, 1, 0, 100, 0, 10000, 15000, 12000, 25000, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomclaw - OOC - Say Random Text');
