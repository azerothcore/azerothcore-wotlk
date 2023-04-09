-- DB update 2023_04_09_10 -> 2023_04_09_11
-- 28728 - Feign Death - Used by outland Basilisks && 35385 - Threshalisk Charge - Used by outland Basilisks
DELETE FROM `spell_script_names` WHERE `spell_id` IN (28728,35385);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(28728,'spell_gen_feign_death_all_flags'),
(35385,'spell_gen_threshalisk_charge');

-- All creatures that use Threshalisk Charge (35385) and Feign Death (28728)
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (20607,20924,19730,19729,20283,19706,20279,20280,20987,20925);

DELETE FROM `creature_text` WHERE `CreatureID` IN (20607,20924,19730,19729,20283,19706,20279,20280,20987,20925);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(20607, 0, 0, '%s stops playing dead and charges forward!', 16, 0, 100, 0, 0, 0, 18325, 0, 'Craghide Basilisk - EMOTE_STOP_PLAY_DEAD'),
(20924, 0, 0, '%s stops playing dead and charges forward!', 16, 0, 100, 0, 0, 0, 18325, 0, 'Grishnath Basilisk - EMOTE_STOP_PLAY_DEAD'),
(19730, 0, 0, '%s stops playing dead and charges forward!', 16, 0, 100, 0, 0, 0, 18325, 0, 'Ironspine Gazer - EMOTE_STOP_PLAY_DEAD'),
(19729, 0, 0, '%s stops playing dead and charges forward!', 16, 0, 100, 0, 0, 0, 18325, 0, 'Ironspine Threshalisk - EMOTE_STOP_PLAY_DEAD'),
(20283, 0, 0, '%s stops playing dead and charges forward!', 16, 0, 100, 0, 0, 0, 18325, 0, 'Marshrock Stomper - EMOTE_STOP_PLAY_DEAD'),
(19706, 0, 0, '%s stops playing dead and charges forward!', 16, 0, 100, 0, 0, 0, 18325, 0, 'Marshrock Threshalisk - EMOTE_STOP_PLAY_DEAD'),
(20279, 0, 0, '%s stops playing dead and charges forward!', 16, 0, 100, 0, 0, 0, 18325, 0, 'Ragestone Threshalisk - EMOTE_STOP_PLAY_DEAD'),
(20280, 0, 0, '%s stops playing dead and charges forward!', 16, 0, 100, 0, 0, 0, 18325, 0, 'Ragestone Trampler - EMOTE_STOP_PLAY_DEAD'),
(20987, 0, 0, '%s stops playing dead and charges forward!', 16, 0, 100, 0, 0, 0, 18325, 0, 'Ruuan Weald Basilisk - EMOTE_STOP_PLAY_DEAD'),
(20925, 0, 0, '%s stops playing dead and charges forward!', 16, 0, 100, 0, 0, 0, 18325, 0, 'Scalded Basilisk - EMOTE_STOP_PLAY_DEAD');

-- ID 20607 (Craghide Basilisk)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20607, 0, 0, 0, 9, 0, 20, 0, 0, 40, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Craghide Basilisk - Within 0-40 Range - Cast \'Threshalisk Charge\''),
(20607, 0, 1, 0, 0, 0, 100, 0, 7000, 11000, 45000, 50000, 0, 11, 35313, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Craghide Basilisk - In Combat - Cast \'Hypnotic Gaze\''),
(20607, 0, 2, 3, 2, 0, 30, 0, 0, 15, 0, 0, 0, 11, 28728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Craghide Basilisk - Between 0-15% Health - Cast \'Feign Death\''),
(20607, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Craghide Basilisk - Between 0-15% Health - Stop Attacking'),
(20607, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Craghide Basilisk - Between 0-15% Health - Set Event Phase 1'),
(20607, 0, 5, 6, 0, 1, 100, 0, 6000, 6000, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Craghide Basilisk - In Combat - Cast \'Threshalisk Charge\' (Phase 1)'),
(20607, 0, 6, 0, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Craghide Basilisk - In Combat - Say Line 0 (Phase 1)');

-- ID 20924 (Grishnath Basilisk)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20924, 0, 0, 0, 2, 0, 100, 512, 0, 70, 0, 0, 0, 11, 37590, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grishnath Basilisk - Between 0-70% Health - Cast \'Soften\' I'),
(20924, 0, 1, 0, 2, 0, 100, 512, 0, 40, 0, 0, 0, 11, 37590, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grishnath Basilisk - Between 0-40% Health - Cast \'Soften\' II'),
(20924, 0, 2, 0, 2, 0, 100, 512, 0, 10, 0, 0, 0, 11, 37590, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grishnath Basilisk - Between 0-10% Health - Cast \'Soften\' III'),
(20924, 0, 3, 4, 2, 0, 30, 0, 0, 15, 0, 0, 0, 11, 28728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grishnath Basilisk - Between 0-15% Health - Cast \'Feign Death\''),
(20924, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grishnath Basilisk - Between 0-15% Health - Stop Attacking'),
(20924, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Grishnath Basilisk - Between 0-15% Health - Set Event Phase 1'),
(20924, 0, 6, 7, 0, 1, 100, 0, 6000, 6000, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Grishnath Basilisk - In Combat - Cast \'Threshalisk Charge\' (Phase 1)'),
(20924, 0, 7, 0, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Grishnath Basilisk - In Combat - Say Line 0 (Phase 1)');

-- ID 19730 (Ironspine Gazer)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19730, 0, 0, 0, 9, 0, 20, 0, 0, 40, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Gazer - Within 0-40 Range - Cast \'Threshalisk Charge\''),
(19730, 0, 1, 0, 0, 0, 100, 0, 7000, 11000, 45000, 50000, 0, 11, 35313, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Gazer - In Combat - Cast \'Hypnotic Gaze\''),
(19730, 0, 2, 3, 2, 0, 30, 0, 0, 15, 0, 0, 0, 11, 28728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Gazer - Between 0-15% Health - Cast \'Feign Death\''),
(19730, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Gazer - Between 0-15% Health - Stop Attacking'),
(19730, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Gazer - Between 0-15% Health - Set Event Phase 1'),
(19730, 0, 5, 6, 0, 1, 100, 0, 6000, 6000, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Gazer - In Combat - Cast \'Threshalisk Charge\' (Phase 1)'),
(19730, 0, 6, 0, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Gazer - In Combat - Say Line 0 (Phase 1)');

-- ID 19729 (Ironspine Threshalisk)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19729, 0, 0, 0, 9, 0, 20, 0, 0, 40, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Threshalisk - Within 0-40 Range - Cast \'Threshalisk Charge\''),
(19729, 0, 1, 2, 2, 0, 60, 0, 0, 15, 0, 0, 0, 11, 28728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Threshalisk - Between 0-15% Health - Cast \'Feign Death\''),
(19729, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Threshalisk - Between 0-15% Health - Stop Attacking'),
(19729, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Threshalisk - Between 0-15% Health - Set Event Phase 1'),
(19729, 0, 4, 5, 0, 1, 100, 0, 6000, 6000, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Threshalisk - In Combat - Cast \'Threshalisk Charge\' (Phase 1)'),
(19729, 0, 5, 0, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ironspine Threshalisk - In Combat - Say Line 0 (Phase 1)');

-- ID 20283 (Marshrock Stomper)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20283;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20283, 0, 0, 0, 0, 0, 100, 0, 5000, 10000, 15000, 30000, 0, 11, 12612, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshrock Stomper - In Combat - Cast \'Stomp\''),
(20283, 0, 1, 2, 2, 0, 30, 0, 0, 30, 0, 0, 0, 11, 28728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshrock Threshalisk - Between 0-30% Health - Cast \'Feign Death\''),
(20283, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshrock Threshalisk - Between 0-30% Health - Stop Attacking'),
(20283, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshrock Threshalisk - Between 0-30% Health - Set Event Phase 1'),
(20283, 0, 4, 5, 0, 1, 100, 0, 6000, 6000, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshrock Threshalisk - In Combat - Cast \'Threshalisk Charge\' (Phase 1)'),
(20283, 0, 5, 0, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshrock Threshalisk - In Combat - Say Line 0 (Phase 1)');

-- ID 19706 (Marshrock Threshalisk)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19706, 0, 0, 0, 9, 0, 20, 0, 0, 40, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshrock Threshalisk - Within 0-40 Range - Cast \'Threshalisk Charge\''),
(19706, 0, 1, 2, 2, 0, 50, 0, 0, 15, 0, 0, 0, 11, 28728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshrock Threshalisk - Between 0-15% Health - Cast \'Feign Death\''),
(19706, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshrock Threshalisk - Between 0-15% Health - Stop Attacking'),
(19706, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshrock Threshalisk - Between 0-15% Health - Set Event Phase 1'),
(19706, 0, 4, 5, 0, 1, 100, 0, 6000, 6000, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshrock Threshalisk - In Combat - Cast \'Threshalisk Charge\' (Phase 1)'),
(19706, 0, 5, 0, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Marshrock Threshalisk - In Combat - Say Line 0 (Phase 1)');

-- ID 20279 (Ragestone Threshalisk)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20279, 0, 0, 0, 2, 0, 100, 0, 0, 20, 0, 0, 0, 11, 3019, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragestone Threshalisk - Between 0-20% Health - Cast \'Frenzy\''),
(20279, 0, 1, 2, 2, 0, 30, 0, 0, 15, 0, 0, 0, 11, 28728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragestone Threshalisk - Between 0-15% Health - Cast \'Feign Death\''),
(20279, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragestone Threshalisk - Between 0-15% Health - Stop Attacking'),
(20279, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragestone Threshalisk - Between 0-15% Health - Set Event Phase 1'),
(20279, 0, 4, 5, 0, 1, 100, 0, 6000, 6000, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragestone Threshalisk - In Combat - Cast \'Threshalisk Charge\' (Phase 1)'),
(20279, 0, 5, 0, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragestone Threshalisk - In Combat - Say Line 0 (Phase 1)');

-- ID 20280 (Ragestone Trampler)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20280, 0, 0, 0, 0, 0, 100, 0, 5000, 11000, 25000, 28000, 0, 11, 3019, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragestone Trampler - In Combat - Cast \'Frenzy\''),
(20280, 0, 1, 0, 0, 0, 100, 0, 11000, 20000, 7000, 12000, 0, 11, 5568, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragestone Trampler - In Combat - Cast \'Trample\''),
(20280, 0, 2, 3, 2, 0, 30, 0, 0, 15, 0, 0, 0, 11, 28728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragestone Trampler - Between 0-15% Health - Cast \'Feign Death\''),
(20280, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragestone Trampler - Between 0-15% Health - Stop Attacking'),
(20280, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragestone Trampler - Between 0-15% Health - Set Event Phase 1'),
(20280, 0, 5, 6, 0, 1, 100, 0, 6000, 6000, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragestone Trampler - In Combat - Cast \'Threshalisk Charge\' (Phase 1)'),
(20280, 0, 6, 0, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ragestone Trampler - In Combat - Say Line 0 (Phase 1)');

-- ID 20987 (Ruuan Weald Basilisk)
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20987;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20987, 0, 0, 0, 9, 0, 20, 0, 0, 40, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ruuan Weald Basilisk - Within 0-40 Range - Cast \'Threshalisk Charge\''),
(20987, 0, 1, 2, 2, 0, 60, 0, 0, 15, 0, 0, 0, 11, 28728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ruuan Weald Basilisk - Between 0-15% Health - Cast \'Feign Death\''),
(20987, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ruuan Weald Basilisk - Between 0-15% Health - Stop Attacking'),
(20987, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ruuan Weald Basilisk - Between 0-15% Health - Set Event Phase 1'),
(20987, 0, 4, 5, 0, 1, 100, 0, 6000, 6000, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Ruuan Weald Basilisk - In Combat - Cast \'Threshalisk Charge\' (Phase 1)'),
(20987, 0, 5, 0, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ruuan Weald Basilisk - In Combat - Say Line 0 (Phase 1)');

-- ID 20925 (Scalded Basilisk)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20925, 0, 0, 0, 0, 0, 85, 0, 8000, 13000, 14000, 19000, 0, 11, 35236, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scalded Basilisk - In Combat - Cast \'Heat Wave\''),
(20925, 0, 1, 2, 2, 0, 30, 0, 0, 15, 0, 0, 0, 11, 28728, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scalded Basilisk - Between 0-15% Health - Cast \'Feign Death\''),
(20925, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scalded Basilisk - Between 0-15% Health - Stop Attacking'),
(20925, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scalded Basilisk - Between 0-15% Health - Set Event Phase 1'),
(20925, 0, 4, 5, 0, 1, 100, 0, 6000, 6000, 0, 0, 0, 11, 35385, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Scalded Basilisk - In Combat - Cast \'Threshalisk Charge\' (Phase 1)'),
(20925, 0, 5, 0, 61, 1, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Scalded Basilisk - In Combat - Say Line 0 (Phase 1)');
