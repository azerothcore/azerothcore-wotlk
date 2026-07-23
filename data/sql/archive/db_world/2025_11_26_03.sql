-- DB update 2025_11_26_02 -> 2025_11_26_03

-- Set right factions (sniffed)
UPDATE `creature_template` SET `faction` = 2068 WHERE (`entry` = 31301);
UPDATE `creature_template` SET `faction` = 1770 WHERE (`entry` = 31306);
UPDATE `creature_template` SET `faction` = 2102 WHERE (`entry` = 30698);

-- Set Unit Flags (sniffed)
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |64 WHERE (`entry` = 30698);
UPDATE `creature_template` SET `unit_flags` = `unit_flags` |32768 WHERE (`entry` IN (31314, 31428));

-- Set emote 25 on text 0 (Crusader Olakin Sainrith)
UPDATE `creature_text` SET `Emote` = 25 WHERE (`CreatureID` = 31428) AND (`GroupID` IN (0));

-- Delete Olakin spawn point (it must be summoned)
DELETE FROM `creature` WHERE `id1` = 31428;

-- Set new Sniffed Spawn Points (Margrave Dhakar, Ebon Blade Veteran)
DELETE FROM `creature` WHERE (`id1` IN (31306, 31314));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(74974, 31306, 0, 0, 571, 0, 0, 1, 175, 1, 6865.82, 3577.98, 736.045, 2.93215, 300, 0, 0, 37800, 11982, 0, 0, 0, 0, '', NULL, 0, NULL),
(75082, 31314, 0, 0, 571, 0, 0, 1, 175, 1, 6865.11, 3570.75, 736.079, 3.01942, 120, 0, 0, 12600, 3994, 0, 0, 0, 0, '', NULL, 0, NULL),
(75083, 31314, 0, 0, 571, 0, 0, 1, 175, 1, 6868.48, 3579.73, 736.148, 2.9496, 120, 0, 0, 12600, 3994, 0, 0, 0, 0, '', NULL, 0, NULL),
(75084, 31314, 0, 0, 571, 0, 0, 1, 175, 1, 6866.22, 3574.63, 735.908, 3.03687, 120, 0, 0, 12600, 3994, 0, 0, 0, 0, '', NULL, 0, NULL),
(75085, 31314, 0, 0, 571, 0, 0, 1, 175, 1, 6869.78, 3584.1, 735.892, 2.87979, 120, 0, 0, 12600, 3994, 0, 0, 0, 0, '', NULL, 0, NULL);

-- SmartAI (Margrave Dhakar)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31306;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31306);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31306, 0, 0, 1, 62, 0, 100, 0, 10060, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - On Gossip Option 0 Selected - Store Targetlist'),
(31306, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - On Gossip Option 0 Selected - Close Gossip'),
(31306, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - On Gossip Option 0 Selected - Set Npc Flag '),
(31306, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3130600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - On Gossip Option 0 Selected - Run Script'),
(31306, 0, 4, 5, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - On Data Set 1 1 - Set Event Phase 1'),
(31306, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 74956, 30698, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - On Data Set 1 1 - Start Attacking'),
(31306, 0, 6, 0, 7, 1, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3130601, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - On Evade - Run Script (Phase 1)'),
(31306, 0, 7, 0, 4, 1, 100, 0, 0, 0, 0, 0, 0, 0, 11, 58949, 2, 0, 0, 0, 0, 10, 74956, 30698, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - On Aggro - Cast \'Ride Morbidus\' (Phase 1)'),
(31306, 0, 8, 0, 0, 0, 100, 1, 1000, 2000, 0, 0, 0, 0, 11, 37548, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - In Combat - Cast \'Taunt\' (No Repeat)'),
(31306, 0, 9, 0, 0, 0, 100, 0, 3000, 4000, 6000, 8000, 0, 0, 11, 5547, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - In Combat - Cast \'Swing\'');

-- Action List (Margrave Dhakar)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` IN (3130600, 3130601));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3130600, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 12, 31301, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6858.5957, 3580.4998, 736.75116, 5.67231, 'Margrave Dhakar - Actionlist - Summon Creature \'The Lich King\''),
(3130600, 9, 1, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - Actionlist - Say Line 0'),
(3130601, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - Actionlist - Play Emote 4'),
(3130601, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Margrave Dhakar - Actionlist - Despawn In 5000 ms');

-- SmartAI (Lich King)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31301;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31301);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31301, 0, 0, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 3130100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - On Just Summoned - Run Script');

-- Action List (Lich King)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3130100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3130100, 9, 0, 0, 0, 0, 100, 0, 100, 100, 0, 0, 0, 0, 11, 34427, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - Actionlist - Cast \'Ethereal Teleport\''),
(3130100, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 11, 53274, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - Actionlist - Cast \'Icebound Visage\''),
(3130100, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - Actionlist - Say Line 0'),
(3130100, 9, 3, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - Actionlist - Say Line 1'),
(3130100, 9, 4, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - Actionlist - Say Line 2'),
(3130100, 9, 5, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - Actionlist - Say Line 3'),
(3130100, 9, 6, 0, 0, 0, 100, 0, 8000, 8000, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - Actionlist - Say Line 4'),
(3130100, 9, 7, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 12, 31428, 8, 0, 0, 0, 0, 8, 0, 0, 0, 0, 6857.33, 3571.49, 735.892, 1.15191, 'The Lich King - Actionlist - Summon Creature \'Crusader Olakin Sainrith\''),
(3130100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 30698, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - Actionlist - Set Data 1 1'),
(3130100, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'The Lich King - Actionlist - Despawn Instant');

-- SmartAI (Crusader Olakin Sainrith)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31428;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31428);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31428, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 2, 1770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - On Just Summoned - Set Faction 1770'),
(31428, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 80, 3142800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - On Just Summoned - Run Script'),
(31428, 0, 2, 3, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - On Data Set 1 1 - Set Event Phase 1'),
(31428, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 74956, 30698, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - On Data Set 1 1 - Start Attacking'),
(31428, 0, 4, 0, 7, 1, 100, 0, 0, 0, 0, 0, 0, 0, 41, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - On Evade - Despawn In 8000 ms (Phase 1)');

-- Action List (Crusader Olakin Sainrith)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3142800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3142800, 9, 0, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crusader Olakin Sainrith - Actionlist - Say Line 0');

-- SmartAI (Morbidus)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30698;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30698);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30698, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 80, 3069800, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morbidus - On Data Set 1 1 - Run Script'),
(30698, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morbidus - On Reset - Set Flags Immune To Players & Immune To NPC\'s'),
(30698, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 33, 30698, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 0, 0, 'Morbidus - On Just Died - Quest Credit \'null\'');

-- Action List (Morbidus)
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 3069800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3069800, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morbidus - Actionlist - Remove Flags Immune To Players & Immune To NPC\'s'),
(3069800, 9, 1, 0, 0, 0, 100, 0, 200, 200, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 31306, 0, 200, 0, 0, 0, 0, 0, 'Morbidus - Actionlist - Set Data 1 1'),
(3069800, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 31428, 0, 200, 0, 0, 0, 0, 0, 'Morbidus - Actionlist - Set Data 1 1'),
(3069800, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 31314, 0, 200, 0, 0, 0, 0, 0, 'Morbidus - Actionlist - Set Data 1 1');

-- SmartAI (Ebon Blade Veteran)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 31314;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 31314);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(31314, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ebon Blade Veteran - On Data Set 1 1 - Set Event Phase 1'),
(31314, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 74956, 30698, 0, 0, 0, 0, 0, 0, 'Ebon Blade Veteran - On Data Set 1 1 - Start Attacking'),
(31314, 0, 2, 0, 0, 0, 100, 0, 3000, 6000, 10000, 14000, 0, 0, 11, 50688, 2, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ebon Blade Veteran - In Combat - Cast \'Plague Strike\''),
(31314, 0, 3, 0, 7, 1, 100, 0, 0, 0, 0, 0, 0, 0, 41, 12000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ebon Blade Veteran - On Evade - Despawn In 12000 ms (Phase 1)');
