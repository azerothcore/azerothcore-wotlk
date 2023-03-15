-- DB update 2023_03_15_03 -> 2023_03_15_04
-- Karaaz <Consortium Quartermaster>
DELETE FROM `creature_text` WHERE `CreatureID`=20242;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20242, 0, 0, 'Of course none of my goods are stolen.  But if someone asks, you didn\'t get them from me!', 12, 0, 100, 1, 0, 0, 17914, 0, 'Karaaz'),
(20242, 0, 1, 'The latest blueprints, patterns and schematics are available right here.  These instructions are so simple to follow they practically craft themselves!', 12, 0, 100, 1, 0, 0, 17915, 0, 'Karaaz'),
(20242, 0, 2, 'The best selection of smuggled goods is available right here, $n.  Great for the whole family!  Avoid goblin taxation and naaru prohibition - the Consortium is here to fill your every shopping need!', 12, 0, 100, 1, 0, 0, 17916, 0, 'Karaaz'),
(20242, 0, 3, 'Pssst!  I have something that might interest you, $n.  It fell off a pack mule in Nagrand!', 12, 0, 100, 1, 0, 0, 17917, 0, 'Karaaz');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 20242 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20242, 0, 0, 0, 38, 0, 100, 0, 0, 1, 120000, 120000, 0, 1, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Karaaz - On Data Set 0 1 - Say Line 0 (Areatrigger 4495 Invoker)');

-- Areatrigger
DELETE FROM `areatrigger_scripts` WHERE `entry`=4495;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES (4495, 'SmartTrigger');

DELETE FROM `smart_scripts` WHERE `entryorguid`=4495 AND `source_type`=2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(4495, 2, 0, 1, 46, 0, 100, 0, 4495, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Areatrigger (The Stormspire) - On Trigger - Store Targetlist'),
(4495, 2, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 100, 1, 0, 0, 0, 0, 0, 19, 20242, 0, 0, 0, 0, 0, 0, 0, 'Areatrigger (The Stormspire) - On Link - Send Target 1 (Karaaz)'),
(4495, 2, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 20242, 0, 0, 0, 0, 0, 0, 0, 'Areatrigger (The Stormspire) - On Link - Set Data 0 1 (Karaaz)');
