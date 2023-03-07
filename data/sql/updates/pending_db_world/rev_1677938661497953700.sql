-- Polly (pre E.C.A.C)
UPDATE `creature_template` SET `minlevel` = 50, `maxlevel` = 50 WHERE `entry` = 7167;

DELETE FROM `creature_text` WHERE `CreatureID`=7167;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(7167, 0, 0, 'MmmmmMmmmm... Enormous chemically altered cracker....', 12, 0, 100, 0, 0, 0, 3167, 0, 'Polly - SAY_ON_ECAC'),
(7167, 1, 0, 'SQUAWK!!!', 14, 0, 100, 0, 0, 0, 3170, 0, 'Polly - SAY_SPAWN');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 7167);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7167, 0, 0, 0, 54, 0, 100, 1, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 10, 0, 0, 0, 0, 0, 0, 0, 'Polly - On Just Summoned - Start Attacking closest player '),
(7167, 0, 1, 0, 1, 0, 100, 1, 73000, 73000, 60000, 60000, 0, 11, 8822, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Polly - OOC - Cast Stealth'),
(7167, 0, 2, 3, 8, 0, 100, 513, 9976, 0, 0, 0, 0, 1, 0, 2500, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Polly - On Spellhit \'Polly Eats the E.C.A.C.\' - Say Line 0 (No Repeat)'),
(7167, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Polly - On Spellhit \'Polly Eats the E.C.A.C.\' - Set Faction 35 (No Repeat)'),
(7167, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Polly - On Spellhit \'Polly Eats the E.C.A.C.\' - Set Home Position (No Repeat)'),
(7167, 0, 5, 6, 52, 0, 100, 513, 0, 7167, 0, 0, 0, 12, 7168, 4, 60000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Polly - On Text 0 Over - Summon Creature \'Polly\' (No Repeat)'),
(7167, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Polly - On Text 0 Over - Despawn Instant (No Repeat)');

-- Polly (after E.C.A.C)
DELETE FROM `creature_text` WHERE `CreatureID`=7168;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(7168, 0, 0, 'What the squawk??? Squawk squawk, squawk? SQUAWK!', 12, 0, 100, 0, 0, 0, 3165, 0, 'Polly - SAY_ON_ECAC');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7168;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 7168);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(7168, 0, 0, 1, 54, 0, 100, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Polly - On Just Summoned - Say Line 0 (No Repeat)'),
(7168, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 21, 10, 0, 0, 0, 0, 0, 0, 0, 'Polly - On Just Summoned - Start Attacking (No Repeat)');
