-- DB update 2023_09_17_13 -> 2023_09_18_00
-- Hearts of the Pure Rp -------------

-- The orientation of the initial NPC This is roughly towards the coordinates that need to be sniffed 
-- UPDATE `creature` SET `orientation`=4.41048 WHERE `guid`=41833;

-- Use SmatAI
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5693;

-- Update emoticons
UPDATE `creature_text` SET `Emote`=25 WHERE `CreatureID`=5693 AND `GroupID`=0 AND `ID`=0;-- EMOTE_ONESHOT_POINT
UPDATE `creature_text` SET `Emote`=1 WHERE `CreatureID`=5693 AND `GroupID`=1 AND `ID`=0;-- EMOTE_ONESHOT_TALK
UPDATE `creature_text` SET `Emote`=25 WHERE `CreatureID`=5693 AND `GroupID`=2 AND `ID`=0;-- EMOTE_ONESHOT_POINT
UPDATE `creature_text` SET `Emote`=1 WHERE `CreatureID`=5693 AND `GroupID`=3 AND `ID`=0;-- EMOTE_ONESHOT_TALK
UPDATE `creature_text` SET `Emote`=11 WHERE `CreatureID`=5693 AND `GroupID`=4 AND `ID`=0;-- EMOTE_ONESHOT_LAUGH

-- Update unit_flags Make summoned NPCs unattackable and unselectable
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5692;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 5692);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5692, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 18, 256|512|33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Comar Villard Projection - Just_Summoned - set_unit_flag');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5691;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 5691);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5691, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 18, 256|512|33554432, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Comar Villard Projection - Just_Summoned - set_unit_flag');

-- SmatAI Start-------------------------------------
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5693;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 5693);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5693, 0, 0, 0, 19, 0, 100, 0, 1476, 0, 0, 0, 0, 80, 569300, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Godrick Farsan - On Quest \'Hearts of the Pure\' Taken - Run Script'),
(5693, 0, 1, 0, 20, 0, 100, 0, 1472, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Godrick Farsan - reward quest emote');

-- Timed events
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 569300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(569300, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearts of the Pure - Godrick Farsan - Set Active'),
(569300, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Remove Quest Giver npc flags from self.'),
(569300, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 12, 5691, 3, 28000, 0, 0, 0, 8, 0, 0, 0, 0, 1781.16, 61.13, -61.4065, 4.869, 'Hearts of the Pure - Godrick Farsan - Spawn NPC'),
(569300, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 12, 5692, 3, 28000, 0, 0, 0, 8, 0, 0, 0, 0, 1785.77, 60.27, -61.4065, 3.961, 'Hearts of the Pure - Godrick Farsan - Spawn NPC'),
(569300, 9, 4, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 5691, 10, 0, 0, 0, 0, 0, 0, 'Hearts of the Pure - Godrick Farsan - Face NPC'),
(569300, 9, 5, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearts of the Pure - Godrick Farsan - Talk'),
(569300, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearts of the Pure - Godrick Farsan - Talk'),
(569300, 9, 7, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 5692, 5, 0, 0, 0, 0, 0, 0, 'Hearts of the Pure - Godrick Farsan - Face NPC'),
(569300, 9, 8, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearts of the Pure - Godrick Farsan - Talk'),
(569300, 9, 9, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearts of the Pure - Godrick Farsan - Talk'),
(569300, 9, 10, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearts of the Pure - Godrick Farsan - Face Player'),
(569300, 9, 11, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearts of the Pure - Godrick Farsan - Talk'),
(569300, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 48, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearts of the Pure - Godrick Farsan - Remove Active'),
(569300, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Hearts of the Pure - Godrick Farsan - Add NPC Flags');
