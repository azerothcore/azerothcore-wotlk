-- DB update 2023_03_01_04 -> 2023_03_01_05
--
DELETE FROM `creature` WHERE `id1`=19823 AND `guid` IN (1007, 10994, 25745, 25746);
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`) VALUES
(1007 , 19823, 530, 1, -4486.58, 1998.88, 112.765, 0.113942, 300, 20, 1),
(10994, 19823, 530, 1, -4527.13, 2106.33, 38.1019, 0.221064, 300, 20, 1),
(25745, 19823, 530, 1, -4561.13, 2024.76, 92.2968, 5.31829, 300, 20, 1),
(25746, 19823, 530, 1, -4399.99, 2334.17, 28.1067, 0.071826, 300, 20, 1);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19823);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19823, 0, 0, 0, 6, 0, 100, 512, 0, 0, 0, 0, 0, 11, 38223, 3, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Crazed Colossus - On Just Died - Cast \'Quest Credit: Crazed Colossus\''),
(19823, 0, 1, 0, 2, 0, 100, 1, 0, 75, 0, 0, 0, 11, 37947, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crazed Colossus - Between 0-75% Health - Cast \'Serverside - Summon Crazed Shardling\' (No Repeat)'),
(19823, 0, 2, 0, 2, 0, 100, 1, 0, 50, 0, 0, 0, 11, 37948, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crazed Colossus - Between 0-50% Health - Cast \'Serverside - Summon Crazed Shardling\' (No Repeat)'),
(19823, 0, 3, 0, 2, 0, 100, 1, 0, 25, 0, 0, 0, 11, 37949, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crazed Colossus - Between 0-25% Health - Cast \'Serverside - Summon Crazed Shardling\' (No Repeat)');

UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 0 WHERE `ID` IN (37947, 37948, 37949);

DELETE FROM `creature_text` WHERE `CreatureID`=22054;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(22054, 0, 0, 'Brashly you have attacked my children, Illidan! The pact is broken. Giant will never side with elf! NEVER!', 14, 0, 100, 0, 0, 0, 19737, 2, 'Behemothon, King of the Colossi'),
(22054, 1, 0, '%s roars in defiance.', 16, 0, 100, 0, 0, 3685, 19739, 2, 'Behemothon, King of the Colossi');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2205400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2205400, 9, 0, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Behemothon, King of the Colossi - Actionlist - Say Line 0'),
(2205400, 9, 1, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Behemothon, King of the Colossi - Actionlist - Say Line 1');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22054;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 22054);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(22054, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 3, 0, 20577, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Behemothon, King of the Colossi - On Respawn - Hack: Change modelid to correct one by script'),
(22054, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Behemothon, King of the Colossi - On Respawn - Set Active On'),
(22054, 0, 2, 0, 38, 0, 100, 0, 1, 1, 60000, 60000, 0, 80, 2205400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Behemothon, King of the Colossi - On Data Set 1 1 - Run Script');

UPDATE `creature_template_addon` SET `visibilityDistanceType` = 5 WHERE (`entry` = 22054);

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21769);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21769, 0, 0, 1, 62, 0, 100, 512, 30008, 1, 0, 0, 0, 56, 31108, 1, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Or\'barokh - On Gossip Option 1 Selected - Add Item \'Kor\'kron Flare Gun\' 1 Time'),
(21769, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Or\'barokh - On Gossip Option 1 Selected - Close Gossip'),
(21769, 0, 2, 0, 1, 0, 100, 0, 120000, 120000, 300000, 300000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Or\'barokh - Out of Combat - Say Line 0'),
(21769, 0, 3, 4, 62, 0, 100, 512, 8443, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Or\'barokh - On Gossip Option 0 Selected - Close Gossip'),
(21769, 0, 4, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 85, 38172, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Overlord Or\'barokh - On Gossip Option 0 Selected - Invoker Cast \'Serverside - Create Kor`kron Flare Gun\''),
(21769, 0, 5, 0, 20, 0, 100, 0, 10769, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 77278, 22054, 0, 0, 0, 0, 0, 0, 'Overlord Or\'barokh - On Quest \'Dissension Amongst the Ranks...\' Finished - Set Data 1 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21773);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21773, 0, 0, 0, 1, 0, 100, 0, 120000, 120000, 200000, 260000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thane Yoregar - Out of Combat - Say Line 0'),
(21773, 0, 1, 2, 62, 0, 100, 512, 8457, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thane Yoregar - On Gossip Option 0 Selected - Close Gossip'),
(21773, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 85, 38251, 2, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Thane Yoregar - On Gossip Option 0 Selected - Invoker Cast \'Serverside - Create Wildhammer Flare Gun\''),
(21773, 0, 3, 0, 20, 0, 100, 0, 10776, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 77278, 22054, 0, 0, 0, 0, 0, 0, 'Thane Yoregar - On Quest \'Dissension Amongst the Ranks...\' Finished - Set Data 1 1');
