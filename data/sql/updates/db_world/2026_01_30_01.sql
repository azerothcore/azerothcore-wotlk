-- DB update 2026_01_30_00 -> 2026_01_30_01
DELETE FROM `smart_scripts` WHERE `entryorguid` = 23377 AND `id` = 3 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23377, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 1, 23377, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, 'Skyguard Ace - On Respawn - Start Waypoint Movement');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 23377 AND `id` IN (4, 5, 6) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(23377,0,4,0,38,0,100,0,2,2,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0.0,0.0,0.0,0.0,'On Data Set - Talk 2'),
(23377,0,5,0,38,0,100,0,3,3,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0.0,0.0,0.0,0.0,'On Data Set - Talk 3');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 2183800 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2183800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, 'Terokk - On Script - Set Immune Flags'),
(2183800, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 24240, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, 'Terokk - On Script - Summon Lightning Spell'),
(2183800, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 11, 39579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, 'Terokk - On Script - Shadow Form'),
(2183800, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, 'Terokk - On Script - Summon Talk'),
(2183800, 9, 4, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, 'Terokk - On Script - Remove Immune Flags'),
(2183800, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, 'Terokk - On Script - Attack Invoker');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 2183801 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2183801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 40726, 0, 0, 0, 0, 0, 5, 0, 1, 0, 0, 0.0, 0.0, 0.0, 0.0, 'Terokk - On Script - Cast "Chosen One"'),
(2183801, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 11, 40722, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0.0, 'Terokk - On Script - Cast "Will of the Arakkoa God"');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 21838 AND `id` = 19 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21838, 0, 19, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 23377, 3, 240000, 0, 0, 0, 8, 0, 0, 0, 0, -3771.6, 3499.32, 317.88, 2.5, 'Terokk - On Aggro Summon "Skyguard Ace"');

UPDATE `smart_scripts` SET `target_type` = 19 WHERE `entryorguid` = 21838 AND `id` IN (4, 7, 13, 14) AND `source_type` = 0;
UPDATE `smart_scripts` SET `action_param1` = 2, `action_param2` = 2, `comment` = 'Terokk - Between 0-50% Health - Set Data 2 2 (Skyguard Ace) (No Repeat)' WHERE `entryorguid` = 21838 AND `id` = 4 AND `source_type` = 0;
UPDATE `smart_scripts` SET `target_param1` = 23377 WHERE `entryorguid` = 21838 AND `id` IN (4, 7, 13, 14) AND `source_type` = 0;
UPDATE `smart_scripts` SET `action_param1` = 1, `action_param2` = 1 WHERE `entryorguid` = 21838 AND `id` = 7 AND `source_type` = 0;

DELETE FROM `creature_text` WHERE `CreatureID` = 21838 AND `GroupID` = 3;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
    (21838,3,0,'Who calls me to this world? The stars are not yet aligned... my powers fail me! You will pay for this!',14,0,100.0,0,0,0,21639,0,'Terokk');

UPDATE `creature_text` SET `Text` = 'Kwa! You cannot kill me, I am immortal!' WHERE `CreatureID` = 21838 AND `GroupID` = 1;
UPDATE `creature_text` SET `BroadcastTextId` = 24020 WHERE `CreatureID` = 21838 AND `GroupID` = 1;

DELETE FROM `creature_text` WHERE `CreatureID` = 23377;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(23377,1,0,'Quickly! Use the flames and support ground troops. Its ancient magic should cleanse Terokk''s shield.',14,0,100.0,0,0,0,24021,0,'Skyguard Ace'),
(23377,2,0,'Enemy sighted! Fall into formation and prepare for bombing maneuvers!',14,0,100.0,0,0,0,21439,0,'Skyguard Ace'),
(23377,3,0,'They did it!  Enemy down!  Return to base!',14,0,100.0,0,0,0,21437,0,'Skyguard Ace');

UPDATE `creature_template` SET `unit_flags` = 2 WHERE `entry` = 23377;

DELETE FROM `waypoints` WHERE `entry` = 23377;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(23377, 1, -3774.55, 3514.51, 325.551, NULL, 0, 'Skyguard Ace'),
(23377, 2, -3794.88, 3497.48, 325.551, NULL, 0, 'Skyguard Ace'),
(23377, 3, -3808.63, 3515.7, 325.551, NULL, 0, 'Skyguard Ace'),
(23377, 4, -3783.6, 3524.59, 325.551, NULL, 0, 'Skyguard Ace');
