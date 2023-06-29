-- DB update 2023_06_24_06 -> 2023_06_26_00
-- Shay Leafrunner - On Quest - Wandering Shay --
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 7774);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 7774);
INSERT INTO `smart_scripts` VALUES
(7774, 0, 0, 0, 19, 0, 100, 0, 2845, 0, 0, 0, 0, 80, 777400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - On Quest \'Wandering Shay\' Taken - Run Script'),
(7774, 0, 1, 0, 8, 0, 100, 0, 11402, 0, 0, 0, 0, 80, 777401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - On Spellhit \'Shay`s Bell\' - Run Script'),
(7774, 0, 2, 0, 75, 0, 100, 0, 0, 7765, 7, 10000, 0, 80, 777402, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - On Distance To Creature - Run Script'),
(7774, 0, 3, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 80, 777403, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - On Just Died - Run Script'),
(7774, 0, 4, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 67, 61, 30000, 35000, 60000, 65000, 100, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - On Data Set 1 1 - Create Timed Event'),
(7774, 0, 5, 6, 59, 0, 100, 0, 61, 0, 0, 0, 0, 73, 38, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - On Timed Event 61 Triggered - Trigger Timed Event 38'),
(7774, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - On Timed Event 61 Triggered - Stop Follow '),
(7774, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 89, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - On Data Set 1 1 - Start Random Movement'),
(7774, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - On Data Set 1 1 - Say Line 2'),
(7774, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - On Data Set 1 1 - Say Line 3'),
(7774, 0, 10, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 74, 61, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - On Respawn - Remove Timed Event 61'),
(7774, 0, 11, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 6, 2845, 0, 0, 0, 0, 0, 18, 10, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - On Just Died - Fail Quest \'Wandering Shay\''),
(7774, 0, 12, 0, 75, 0, 100, 1, 0, 7765, 10, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 11, 7765, 10, 1, 0, 0, 0, 0, 0, 'Shay Leafrunner - On Distance To Creature - Say Line 0');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 777400);
INSERT INTO `smart_scripts` VALUES
(777400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(777400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 29, 2, 3, 7765, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - Actionlist - Start Follow Invoker'),
(777400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - Actionlist - Say Line 0'),
(777400, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - Actionlist - Set Data 1 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 777401);
INSERT INTO `smart_scripts` VALUES
(777401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 29, 2, 3, 7765, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - Actionlist - Start Follow Invoker'),
(777401, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - Actionlist - Say Line 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 777402);
INSERT INTO `smart_scripts` VALUES
(777402, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 15, 2845, 0, 0, 0, 0, 0, 18, 10, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - Actionlist - Quest Credit \'Wandering Shay\''),
(777402, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - Actionlist - Say Line 4');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 777403);
INSERT INTO `smart_scripts` VALUES
(777403, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 6, 2845, 0, 0, 0, 0, 0, 18, 10, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - Actionlist - Fail Quest \'Wandering Shay\''),
(777403, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(777403, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 74, 61, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shay Leafrunner - Actionlist - Remove Timed Event 61');
