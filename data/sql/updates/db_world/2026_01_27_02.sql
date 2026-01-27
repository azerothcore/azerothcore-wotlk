-- DB update 2026_01_27_01 -> 2026_01_27_02
--
UPDATE `creature_template` SET `lootid` = 30921 WHERE (`entry` = 31321);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 31321);

UPDATE `creature_template` SET `lootid` = 30922 WHERE (`entry` = 31320);
DELETE FROM `creature_loot_template` WHERE (`Entry` = 31320);

UPDATE `creature_template` SET `lootid` = 31255 WHERE (`entry` = 31322);
DELETE FROM `creature_loot_template` WHERE `Entry` = 31322;

UPDATE `creature_template` SET `lootid` = 30894 WHERE (`entry` = 31323);
DELETE FROM `creature_loot_template` WHERE `Entry` = 31323;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31322;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31322);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31322, 0, 0, 0, 0, 0, 100, 0, 5200, 9500, 11750, 16250, 0, 0, 11, 60960, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Saronite Shaper - In Combat - Cast \'War Stomp\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31320;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31320);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31320, 0, 0, 1, 8, 0, 100, 512, 58283, 0, 0, 0, 0, 0, 33, 31481, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Umbral Brute - On Spellhit \'Throw Rock\' - Quest Credit'),
(31320, 0, 1, 2, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Umbral Brute - On Spellhit \'Throw Rock\' - Say Line 0'),
(31320, 0, 2, 3, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 2, 1692, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Umbral Brute - On Spellhit \'Throw Rock\' - Set Faction 1692'),
(31320, 0, 3, 4, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 2, 1693, 0, 0, 0, 0, 0, 19, 31321, 15, 0, 0, 0, 0, 0, 0, 'Umbral Brute - On Spellhit \'Throw Rock\' - Set Faction 1693'),
(31320, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 31321, 15, 0, 0, 0, 0, 0, 0, 'Umbral Brute - On Spellhit \'Throw Rock\' - Start Attacking'),
(31320, 0, 5, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Umbral Brute - On Reset - Reset Faction'),
(31320, 0, 6, 0, 2, 0, 100, 1, 0, 30, 0, 0, 0, 0, 11, 50420, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Umbral Brute - Between 0-30% Health - Cast \'Enrage\' (No Repeat)'),
(31320, 0, 7, 0, 0, 0, 100, 0, 3000, 4000, 7000, 8000, 0, 0, 11, 13446, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Umbral Brute - In Combat - Cast \'Strike\''),
(31320, 0, 8, 0, 0, 0, 100, 0, 6000, 7000, 10000, 11000, 0, 0, 11, 10966, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Umbral Brute - In Combat - Cast \'Uppercut\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31321;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31321);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31321, 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Runesmith - On Reset - Reset Faction'),
(31321, 0, 1, 0, 0, 0, 100, 0, 3200, 7500, 9750, 13250, 0, 0, 11, 46202, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Skeletal Runesmith - In Combat - Cast \'Pierce Armor\'');

UPDATE `gameobject` SET `phaseMask` = `phaseMask`|4 WHERE `id` = 193004 AND `guid` IN (99724, 99725, 99726, 99727);

DELETE FROM `creature_text` WHERE (`CreatureID` = 30922);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(30922, 0, 0, 'No one throws rocks at me!', 12, 0, 100, 0, 0, 0, 32217, 0, 'Matchmaker (13147)'),
(30922, 0, 1, 'You wouldn\'t like me when I\'m angry...', 12, 0, 100, 0, 0, 0, 32218, 0, 'Matchmaker (13147)'),
(30922, 0, 2, 'Finally! An excuse to squash you!', 12, 0, 100, 0, 0, 0, 32220, 0, 'Matchmaker (13147)'),
(30922, 0, 3, 'You die for good this time, skeleton!', 12, 0, 100, 0, 0, 0, 32221, 0, 'Matchmaker (13147)'),
(30922, 0, 4, 'Last straw...', 12, 0, 100, 0, 0, 0, 32222, 0, 'Matchmaker (13147)'),
(30922, 0, 5, 'I was waiting for a reason to tear you bone from bone!', 12, 0, 100, 0, 0, 0, 32223, 0, 'Matchmaker (13147)'),
(30922, 0, 6, 'That\'s the last mistake you\'ll make, skeleton.', 12, 0, 100, 0, 0, 0, 32224, 0, 'Matchmaker (13147)');

DELETE FROM `creature_text` WHERE (`CreatureID` = 31320);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(31320, 0, 0, 'No one throws rocks at me!', 12, 0, 100, 0, 0, 0, 32217, 0, 'Matchmaker (13147)'),
(31320, 0, 1, 'You wouldn\'t like me when I\'m angry...', 12, 0, 100, 0, 0, 0, 32218, 0, 'Matchmaker (13147)'),
(31320, 0, 2, 'Finally! An excuse to squash you!', 12, 0, 100, 0, 0, 0, 32220, 0, 'Matchmaker (13147)'),
(31320, 0, 3, 'You die for good this time, skeleton!', 12, 0, 100, 0, 0, 0, 32221, 0, 'Matchmaker (13147)'),
(31320, 0, 4, 'Last straw...', 12, 0, 100, 0, 0, 0, 32222, 0, 'Matchmaker (13147)'),
(31320, 0, 5, 'I was waiting for a reason to tear you bone from bone!', 12, 0, 100, 0, 0, 0, 32223, 0, 'Matchmaker (13147)'),
(31320, 0, 6, 'That\'s the last mistake you\'ll make, skeleton.', 12, 0, 100, 0, 0, 0, 32224, 0, 'Matchmaker (13147)');
