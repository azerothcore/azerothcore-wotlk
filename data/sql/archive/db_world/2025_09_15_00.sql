-- DB update 2025_09_14_02 -> 2025_09_15_00
--
DELETE FROM `creature_text` WHERE `CreatureID` = 29650;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(29650, 0, 0, 'It\'s those blasted iron dwarves again! Somehow, they found him before we did.', 12, 0, 100, 5, 0, 30322, 0, 'Archeologist Andorin - On Quest On Brann\'s Trail Rewarded'),
(29650, 1, 0, 'They\'re not going to give up until they find him. We can\'t allow that to happen, $n, and Brann knows it.', 12, 0, 100, 1, 0, 30323, 0, 'Archeologist Andorin - On Quest On Brann\'s Trail Rewarded'),
(29650, 2, 0, 'There are some rather cryptic instructions in this note. Brann must\'ve had some kind of backup plan, but he can\'t keep evading capture forever...', 12, 0, 100, 1, 0, 30324, 0, 'Archeologist Andorin - On Quest On Brann\'s Trail Rewarded'),
(29650, 3, 0, 'It\'s up to you to find him before the irons do!', 12, 0, 100, 25, 0, 30325, 0, 'Archeologist Andorin - On Quest On Brann\'s Trail Rewarded');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 29650) AND (`source_type` = 0) AND (`id` IN (0, 1, 2, 3, 4, 5));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29650, 0, 0, 1, 62, 0, 100, 512, 9929, 1, 0, 0, 0, 0, 56, 40971, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaeologist Andorin - On Gossip Option 1 Selected - Add Item \'Brann\'s Communicator\' 1 Time'),
(29650, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaeologist Andorin - On Gossip Option 1 Selected - Close Gossip'),
(29650, 0, 2, 3, 20, 0, 100, 0, 12854, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaeologist Andorin - On Quest \'On Brann\'s Trail\' Finished - Say Line 0'),
(29650, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaeologist Andorin - On Quest \'On Brann\'s Trail\' Finished - Say Line 1 (5000ms delay)'),
(29650, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaeologist Andorin - On Quest \'On Brann\'s Trail\' Finished - Say Line 2 (10000ms delay)'),
(29650, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 16000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Archaeologist Andorin - On Quest \'On Brann\'s Trail\' Finished - Say Line 3 (16000ms delay)');
