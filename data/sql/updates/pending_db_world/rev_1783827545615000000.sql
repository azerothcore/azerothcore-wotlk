-- Fix The Battle of Darrowshire progression and restore Marduk the Black's missing scene.

UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 33554434, `AIName` = 'SmartAI' WHERE `entry` = 10939;

UPDATE `smart_scripts` SET `action_param3` = 1 WHERE `entryorguid` = 10944 AND `source_type` = 0 AND `id` IN (4, 5);

UPDATE `smart_scripts` SET `action_param2` = 4 WHERE `entryorguid` = 10946 AND `source_type` = 0 AND `id` = 6;

UPDATE `smart_scripts` SET `link` = 13 WHERE `entryorguid` = 10948 AND `source_type` = 0 AND `id` = 2;

UPDATE `smart_scripts` SET `link` = 0, `event_type` = 61, `event_param1` = 0, `event_param2` = 0, `action_param1` = 1, `target_x` = 1489, `target_y` = -3676, `target_z` = 80 WHERE `entryorguid` = 10948 AND `source_type` = 0 AND `id` = 4;

UPDATE `smart_scripts` SET `action_param1` = 10948, `comment` = 'Davil Lightfire - Actionlist - Summon Darrowshire Defender' WHERE `entryorguid` = 1094400 AND `source_type` = 9 AND `id` IN (4, 6, 8);

UPDATE `smart_scripts` SET `target_x` = 1446.8, `target_y` = -3694.27, `target_z` = 76.5966, `comment` = 'Davil Lightfire - Actionlist - Summon Captain Redpath in the Town Square' WHERE `entryorguid` = 1094401 AND `source_type` = 9 AND `id` = 11;

DELETE FROM `creature_text` WHERE `CreatureID` = 10948 AND `GroupID` = 6;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(10948, 6, 0, 'Davil Lightfire is defeated! Darrowshire is lost!', 14, 0, 100, 0, 0, 0, 7366, 0, 'Darrowshire Defender - Davil Lightfire Defeated');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10937) AND (`source_type` = 0) AND (`id` IN (4, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10937, 0, 4, 15, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 19, 10948, 50, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Notify Darrowshire Defender');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 5) AND (`SourceEntry` = 10937) AND (`SourceId` = 0) AND (`ElseGroup` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 5, 10937, 0, 0, 29, 1, 10939, 10, 0, 1, 0, 0, '', 'Captain Redpath - On Death - Do Not Announce While Marduk the Black Is Nearby');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10948) AND (`source_type` = 0) AND (`id` = 3);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10948, 0, 3, 0, 38, 0, 100, 0, 1, 4, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - On Data Set - Say Horgus Is Slain');

UPDATE `smart_scripts` SET `link` = 9 WHERE `entryorguid` = 10937 AND `source_type` = 0 AND `id` = 3;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10937 AND `source_type` = 0 AND `id` IN (5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27)) OR (`entryorguid` = 10944 AND `source_type` = 0 AND `id` IN (6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19)) OR (`entryorguid` = 10948 AND `source_type` = 0 AND `id` IN (5, 8, 9, 10, 11, 12, 13, 14, 15, 16)) OR (`entryorguid` = 10950 AND `source_type` = 0 AND `id` IN (1, 2, 3, 4)) OR (`entryorguid` IN (1093701, 1093702, 1093703, 1093704, 1094800) AND `source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10937, 0, 5, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 50, 0, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Reset - Attack Closest Enemy'),
(10937, 0, 8, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 87, 1093701, 1093702, 1093703, 1093704, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Reached Home - Start Random Patrol'),
(10937, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1484.68, -3668.74, 80.6953, 0, 'Captain Redpath - On Spawn - Set Rally Point as Home'),
(10937, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 69, 10, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1484.68, -3668.74, 80.6953, 0, 'Captain Redpath - On Spawn - Move to Rally Point'),
(10937, 0, 11, 0, 34, 0, 100, 0, 8, 0, 0, 0, 0, 0, 87, 1093701, 1093702, 1093703, 1093704, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Point Reached - Continue Random Patrol'),
(10937, 0, 12, 13, 60, 0, 100, 0, 6000, 6000, 45000, 45000, 0, 0, 12, 10950, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 1484.68, -3668.74, 80.6953, 0, 'Captain Redpath - Every 45 Seconds - Summon Redpath Militia at Northern Rally Point'),
(10937, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 10950, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 1493.53, -3695.01, 80.1347, 0, 'Captain Redpath - Every 45 Seconds - Summon Redpath Militia at Southern Rally Point'),
(10937, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 10950, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 1505.28, -3718.83, 83.343, 0, 'Captain Redpath - Every 45 Seconds - Summon Redpath Militia at Eastern Rally Point'),
(10937, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10951, 150, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Despawn Marauding Corpses'),
(10937, 0, 16, 17, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10952, 150, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Despawn Marauding Skeletons'),
(10937, 0, 17, 18, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10953, 150, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Despawn Servants of Horgus'),
(10937, 0, 18, 19, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10954, 150, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Despawn Bloodletters'),
(10937, 0, 19, 20, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10947, 150, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Despawn Darrowshire Traitors'),
(10937, 0, 20, 21, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10949, 150, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Despawn Silver Hand Disciples'),
(10937, 0, 21, 22, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10950, 150, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Despawn Redpath Militia'),
(10937, 0, 22, 23, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10946, 150, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Despawn Horgus the Ravager'),
(10937, 0, 23, 24, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10939, 150, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Despawn Marduk the Black'),
(10937, 0, 24, 25, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10938, 150, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Despawn Redpath the Corrupted'),
(10937, 0, 25, 26, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10944, 150, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Despawn Davil Lightfire'),
(10937, 0, 26, 27, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10948, 150, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Despawn Darrowshire Defenders'),
(10937, 0, 27, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 5721, 0, 0, 0, 0, 0, 18, 150, 0, 0, 0, 0, 0, 0, 0, 'Captain Redpath - On Death - Fail Quest The Battle of Darrowshire'),
(10944, 0, 6, 7, 6, 0, 100, 512, 0, 0, 0, 0, 0, 0, 45, 1, 5, 0, 0, 0, 0, 19, 10948, 100, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Announce Event Failure'),
(10944, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10951, 150, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Despawn Marauding Corpses'),
(10944, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10952, 150, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Despawn Marauding Skeletons'),
(10944, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10953, 150, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Despawn Servants of Horgus'),
(10944, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10954, 150, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Despawn Bloodletters'),
(10944, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10947, 150, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Despawn Darrowshire Traitors'),
(10944, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10949, 150, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Despawn Silver Hand Disciples'),
(10944, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10950, 150, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Despawn Redpath Militia'),
(10944, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10937, 150, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Despawn Captain Redpath'),
(10944, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10946, 150, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Despawn Horgus the Ravager'),
(10944, 0, 16, 17, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10939, 150, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Despawn Marduk the Black'),
(10944, 0, 17, 18, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10938, 150, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Despawn Redpath the Corrupted'),
(10944, 0, 18, 19, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 5000, 0, 0, 0, 0, 0, 11, 10948, 150, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Despawn Darrowshire Defenders'),
(10944, 0, 19, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 6, 5721, 0, 0, 0, 0, 0, 18, 150, 0, 0, 0, 0, 0, 0, 0, 'Davil Lightfire - On Death - Fail Quest The Battle of Darrowshire'),
(10948, 0, 8, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 30, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - After Reaching Home - Attack Closest Enemy'),
(10948, 0, 9, 0, 38, 0, 100, 0, 1, 5, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - On Event Failure - Say Davil Lightfire Is Defeated'),
(10948, 0, 10, 0, 52, 0, 100, 512, 3, 10948, 0, 0, 0, 0, 80, 1094800, 2, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - On Victory Text Over - Run Cleanup Actionlist'),
(10948, 0, 13, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 101, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1489, -3676, 80, 0, 'Darrowshire Defender - On Spawn - Set Rally Point as Home'),
(10948, 0, 14, 8, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - On Reached Home - Move Randomly'),
(10948, 0, 15, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - On AI Init - Set Idle Movement'),
(10948, 0, 16, 8, 34, 0, 100, 0, 8, 1, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 30, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - On Rally Point Reached - Attack Closest Enemy'),
(10950, 0, 1, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 25, 50, 0, 0, 0, 0, 0, 0, 0, 'Redpath Militia - On Reset - Attack Closest Enemy'),
(10950, 0, 4, 0, 21, 0, 100, 0, 0, 0, 0, 0, 0, 0, 89, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Redpath Militia - On Reached Home - Move Randomly'),
(1093701, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 69, 11, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1493.53, -3695.01, 80.1347, 0, 'Captain Redpath - Actionlist - Patrol to Southern Rally Point'),
(1093702, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 69, 12, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1446.8, -3694.27, 76.5966, 0, 'Captain Redpath - Actionlist - Patrol to Town Square'),
(1093703, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 69, 13, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1484.68, -3668.74, 80.6953, 0, 'Captain Redpath - Actionlist - Patrol to Northern Rally Point'),
(1093704, 9, 0, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 69, 14, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 1505.28, -3718.83, 83.343, 0, 'Captain Redpath - Actionlist - Patrol to Eastern Rally Point'),
(1094800, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10951, 150, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Skeletal Troopers'),
(1094800, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10952, 150, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Skeletal Executioners'),
(1094800, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10953, 150, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Servants of Horgus'),
(1094800, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10954, 150, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Bloodletters'),
(1094800, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10947, 150, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Darrowshire Traitors'),
(1094800, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10949, 150, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Silver Hand Disciples'),
(1094800, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10950, 150, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Redpath Militia'),
(1094800, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10937, 150, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Captain Redpath'),
(1094800, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10946, 150, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Horgus the Ravager'),
(1094800, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10939, 150, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Marduk the Black'),
(1094800, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10938, 150, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Redpath the Corrupted'),
(1094800, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10944, 150, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Davil Lightfire'),
(1094800, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 11, 10948, 150, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Other Darrowshire Defenders'),
(1094800, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 2000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Darrowshire Defender - Actionlist - Despawn Self');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 1094401) AND (`source_type` = 9) AND (`id` IN (26, 27));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1094401, 9, 26, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 12, 10939, 1, 10000, 0, 0, 0, 19, 10937, 100, 0, 0, 2, 0, 0, 0, 'Davil Lightfire - Actionlist - Summon Marduk the Black Beside Captain Redpath');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 10939 AND `source_type` = 0) OR (`entryorguid` = 1093900 AND `source_type` = 9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(10939, 0, 0, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 0, 80, 1093900, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marduk the Black - On Just Summoned - Run Transformation Actionlist'),
(1093900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marduk the Black - Actionlist - Say Line 0'),
(1093900, 9, 1, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 0, 0, 51, 0, 0, 0, 0, 0, 0, 19, 10937, 100, 0, 0, 0, 0, 0, 0, 'Marduk the Black - Actionlist - Kill Captain Redpath'),
(1093900, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 12, 10938, 4, 300000, 0, 0, 0, 19, 10937, 100, 1, 0, 0, 0, 0, 0, 'Marduk the Black - Actionlist - Summon Redpath the Corrupted at Captain Redpath'),
(1093900, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 19, 10937, 100, 1, 0, 0, 0, 0, 0, 'Marduk the Black - Actionlist - Despawn Captain Redpath'),
(1093900, 9, 4, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marduk the Black - Actionlist - Despawn Self');
