-- Kel'Thuzad and the rescued Warsong soldiers (quest 11652, Borean Tundra) never speak.
-- Kel'Thuzad has a line in creature_text but nothing ever calls it, and the soldiers have
-- none at all. His yell goes through a timed action list so it doesn't start over the sound
-- he already plays. Injured Warsong Shaman (27108) is left out, its retail text is unconfirmed.
DELETE FROM `creature_text` WHERE `CreatureID` IN (27106, 27107, 27110) AND `GroupID` = 0 AND `ID` = 0;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(27106, 0, 0, 'I will protect you, friend!', 12, 0, 100, 0, 0, 0, 0, 0, 'Injured Warsong Warrior - Rescued'),
(27107, 0, 0, 'Thank you, friend. Now these beasts shall feel the fury of the Sunwell!', 12, 0, 100, 0, 0, 0, 0, 0, 'Injured Warsong Mage - Rescued'),
(27110, 0, 0, 'Thanks, buddy! Let\'s see if I can\'t get this hunk o\' junk movin\' faster!', 12, 0, 100, 0, 0, 0, 0, 0, 'Injured Warsong Engineer - Rescued');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 25465 AND `source_type` = 0 AND `id` = 3;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25465, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 2546500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - Out of Combat - Call Timed Actionlist (Talk after voice line)');

UPDATE `smart_scripts` SET `link` = 3 WHERE `entryorguid` = 25465 AND `source_type` = 0 AND `id` = 1;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 2546500 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2546500, 9, 0, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kel\'Thuzad - Actionlist - Talk Line 0 (after voice line)');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27106, 27107, 27110) AND `source_type` = 0 AND `id` = 2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27106, 0, 2, 1, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Warrior - On Spell Hit - Talk Line 0'),
(27107, 0, 2, 1, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Mage - On Spell Hit - Talk Line 0'),
(27110, 0, 2, 1, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Injured Warsong Engineer - On Spell Hit - Talk Line 0');

UPDATE `smart_scripts` SET `link` = 2 WHERE `entryorguid` IN (27106, 27107, 27110) AND `source_type` = 0 AND `id` = 0;
