-- DB update 2026_04_29_06 -> 2026_04_29_07
--
-- workaround to apply gobject scaling of 23020 Crystal Imprisonment (SPELL_AURA_MOD_SCALE), value = -90
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 179644;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 179644) AND (`source_type` = 1) AND (`id` IN (0));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(179644, 1, 0, 0, 63, 0, 100, 0, 0, 0, 0, 0, 0, 0, 227, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Imprisoned Doomguard - On Just Created - Set Scale to 10%');

DELETE FROM `creature_text` WHERE (`CreatureID` = 14452);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(14452, 0, 0, 'A sacrifice will be due if I am ever called upon, mortal...', 12, 8, 100, 0, 0, 0, 9590, 0, '');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `id` IN (4, 5) AND `entryorguid` = 12396);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(12396, 0, 4, 0, 8, 0, 100, 1, 23019, 0, 0, 0, 0, 0, 80, 1239600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - On Spellhit \'Crystal Prison Dummy DND\' - Run Script (No Repeat)');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1239600) AND (`source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1239600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 36, 14452, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - Actionlist - Update Template To \'Enslaved Doomguard Commander\''),
(1239600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 23020, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - Actionlist - Cast \'Crystal Imprisonment\''),
(1239600, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(1239600, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - Actionlist - Stop Combat'),
(1239600, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - Actionlist - Say Line 0'),
(1239600, 9, 5, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 11, 23022, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - Actionlist - Cast \'Serverside - Crystal Prison Conjure DND\''),
(1239600, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doomguard Commander - Actionlist - Despawn Instant');
