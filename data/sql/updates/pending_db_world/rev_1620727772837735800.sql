INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1620727772837735800');

DELETE FROM `creature` WHERE (`id` = 14686);
INSERT INTO `creature` VALUES
(3110404, 14686, 129, 0, 0, 1, 1, 0, 0, 2583.95, 695.333, 56.534, 2.11163, 86400, 0, 0, 10688, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `creature_text` WHERE (`CreatureID` = 14686);
INSERT INTO `creature_text` VALUES (14686, 0, 0, 'Thank you for becoming my next victim!', 14, 0, 100, 0, 0, 0, 0, 0, 'Lady Falther\'ess');

UPDATE `creature_template` SET `speed_walk` = 1, `dmgschool` = 5, `AIName` = 'SmartAI' WHERE (`entry` = 14686);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 14686);
INSERT INTO `smart_scripts` VALUES
(14686, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 3, 0, 1691, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Falther\'ess - On Respawn - Morph To Model 1691'),
(14686, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 2, 35, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Falther\'ess - On Respawn - Set Faction 35'),
(14686, 0, 2, 0, 10, 0, 100, 0, 0, 10, 1, 1, 1, 49, 0, 0, 0, 0, 0, 0, 21, 10, 0, 0, 0, 0, 0, 0, 0, 'Lady Falther\'ess - Within 0-10 Range Out of Combat LoS - Start Attacking'),
(14686, 0, 3, 0, 0, 0, 100, 0, 3000, 3000, 15000, 15000, 0, 11, 16838, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Lady Falther\'ess - In Combat - Cast \'Banshee Shriek\'');

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 157819;

DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` = 157819);
INSERT INTO `smart_scripts` VALUES
(157819, 1, 0, 1, 70, 0, 100, 0, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 11, 14686, 8, 1, 0, 0, 0, 0, 0, 'Holding Pen - On Gameobject State Changed - Say Line 0'),
(157819, 1, 1, 2, 61, 0, 100, 0, 2, 0, 0, 0, 0, 2, 21, 0, 0, 0, 0, 0, 11, 14686, 8, 1, 0, 0, 0, 0, 0, 'Holding Pen - On Gameobject State Changed - Set Faction 21'),
(157819, 1, 2, 0, 61, 0, 100, 0, 2, 0, 0, 0, 0, 3, 0, 10698, 0, 0, 0, 0, 11, 14686, 8, 1, 0, 0, 0, 0, 0, 'Holding Pen - On Gameobject State Changed - Morph To Model 10698');
