-- DB update 2026_10_24_06 -> 2026_10_24_07
--
DELETE FROM `creature_text` WHERE `CreatureID` IN (18597, 18652, 18653);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(18597, 0, 0, 'Drink this, Zahlia.  It is not as potent as I\'d hoped, but perhaps it will help.', 12, 0, 100, 1, 0, 0, 15639, 0, 'Sha\'nir'),
(18652, 0, 0, 'I... I can see...', 12, 0, 100, 0, 0, 0, 15636, 0, 'Zahlia'),
(18652, 1, 0, 'I thought I\'d never see my son\'s face again.  Come here, Seth!  Let mom take a look at you!', 12, 0, 100, 0, 0, 0, 15637, 0, 'Zahlia'),
(18653, 0, 0, 'Don\'t cry mommy.  I\'m right here, see?', 12, 0, 100, 0, 0, 0, 15638, 0, 'Seth');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (18597, 18653);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (18597, 18653) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (1859701, 1865300) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18597, 0, 0, 0, 20, 0, 100, 0, 10020, 0, 0, 0, 0, 0, 80, 1859701, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sha\'nir - On Quest \'A Cure for Zahlia\' Rewarded - Run Script'),
(1859701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Set Walk'),
(1859701, 9, 1, 0, 0, 0, 100, 0, 875, 875, 0, 0, 0, 0, 71, 0, 0, 3699, 3697, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Equip Potions'),
(1859701, 9, 2, 0, 0, 0, 100, 0, 1609, 1609, 0, 0, 0, 0, 17, 133, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Set Emote State \'Use Standing No Sheathe\''),
(1859701, 9, 3, 0, 0, 0, 100, 0, 7266, 7266, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Set Emote State \'None\''),
(1859701, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Unequip Potions'),
(1859701, 9, 5, 0, 0, 0, 100, 0, 1250, 1250, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1607.125, 5299.7305, -38.577827, 0, 'Sha\'nir - Actionlist - Move To Position'),
(1859701, 9, 6, 0, 0, 0, 100, 0, 2984, 2984, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Say Line 0'),
(1859701, 9, 7, 0, 0, 0, 100, 0, 3469, 3469, 0, 0, 0, 0, 71, 0, 0, 2199, 0, 0, 0, 10, 66908, 18652, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Equip Vial (Zahlia)'),
(1859701, 9, 8, 0, 0, 0, 100, 0, 2031, 2031, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 10, 66908, 18652, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Play Emote \'Eat No Sheathe\' (Zahlia)'),
(1859701, 9, 9, 0, 0, 0, 100, 0, 6219, 6219, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 66908, 18652, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Say Line 0 (Zahlia)'),
(1859701, 9, 10, 0, 0, 0, 100, 0, 2297, 2297, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 10, 66908, 18652, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Unequip Vial (Zahlia)'),
(1859701, 9, 11, 0, 0, 0, 100, 0, 1250, 1250, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 10, 66908, 18652, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Set Stand State Kneel (Zahlia)'),
(1859701, 9, 12, 0, 0, 0, 100, 0, 2422, 2422, 0, 0, 0, 0, 5, 18, 0, 0, 0, 0, 0, 10, 66908, 18652, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Play Emote \'Cry\' (Zahlia)'),
(1859701, 9, 13, 0, 0, 0, 100, 0, 1203, 1203, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1606.39, 5292.01, -38.5767, 2.94102, 'Sha\'nir - Actionlist - Move To Home Position'),
(1859701, 9, 14, 0, 0, 0, 100, 0, 1344, 1344, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 10, 66908, 18652, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Say Line 1 (Zahlia)'),
(1859701, 9, 15, 0, 0, 0, 100, 0, 2312, 2312, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 10, 66908, 18652, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Remove Stand State Kneel (Zahlia)'),
(1859701, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 10, 66909, 18653, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Set Walk (Seth)'),
(1859701, 9, 17, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 1865300, 0, 0, 0, 0, 0, 10, 66909, 18653, 0, 0, 0, 0, 0, 0, 'Sha\'nir - Actionlist - Run Script (Seth)'),
(18653, 0, 0, 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Seth - On Reached Point 1 - Say Line 0'),
(1865300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1607.6587, 5301.146, -38.577797, 0, 'Seth - Actionlist - Move To Position'),
(1865300, 9, 1, 0, 0, 0, 100, 0, 23469, 23469, 0, 0, 0, 0, 69, 2, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, -1612.66, 5315.41, -40.2089, 6.04818, 'Seth - Actionlist - Move To Home Position');
