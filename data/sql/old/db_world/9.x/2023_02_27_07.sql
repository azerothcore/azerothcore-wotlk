-- DB update 2023_02_27_06 -> 2023_02_27_07
-- 
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|32768, `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = 21027);

DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 21027);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(21027, 1, 1, 0, 0, 0, 0, 0);

DELETE FROM `script_waypoint` WHERE `entry`=21027;

DELETE FROM `waypoints` WHERE `entry` IN (2102700, 2102701, 2102702) AND `point_comment`='Earthmender Wilda';
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(2102700,1,-2673.4028,1347.086,34.450996,NULL,'Earthmender Wilda'),
(2102700,2,-2698.3552,1336.2699,34.436684,NULL,'Earthmender Wilda'),
(2102700,3,-2717.746,1327.2448,33.727425,NULL,'Earthmender Wilda'),
(2102700,4,-2750.501,1308.4788,33.51492,NULL,'Earthmender Wilda'),
(2102700,5,-2758.456,1291.1246,33.21175,NULL,'Earthmender Wilda'),
(2102700,6,-2749.859,1271.7311,33.179966,NULL,'Earthmender Wilda'),
(2102700,7,-2735.675,1250.0884,33.481762,NULL,'Earthmender Wilda'),
(2102700,8,-2728.0457,1239.5994,33.55585,NULL,'Earthmender Wilda'),
(2102700,9,-2724.7705,1235.3615,33.36293,NULL,'Earthmender Wilda'),

(2102701,1 ,-2747.9248,1267.6305,33.185226,NULL,'Earthmender Wilda'),
(2102701,2 ,-2759.827,1286.5345,33.22729,NULL,'Earthmender Wilda'),
(2102701,3 ,-2756.9617,1306.5089,33.385166,NULL,'Earthmender Wilda'),
(2102701,4 ,-2725.8306,1321.6727,33.399662,NULL,'Earthmender Wilda'),
(2102701,5 ,-2713.258,1311.8943,33.88253,NULL,'Earthmender Wilda'),
(2102701,6 ,-2703.6812,1297.7561,32.952988,NULL,'Earthmender Wilda'),
(2102701,7 ,-2696.5117,1290.1486,34.049046,NULL,'Earthmender Wilda'),
(2102701,8 ,-2676.7317,1285.51,30.529482,NULL,'Earthmender Wilda'),
(2102701,9 ,-2654.9558,1274.1897,25.2051,NULL,'Earthmender Wilda'),
(2102701,10,-2644.617,1264.0071,23.524517,NULL,'Earthmender Wilda'),
(2102701,11,-2638.541,1253.4718,21.101715,NULL,'Earthmender Wilda'),
(2102701,12,-2646.6775,1220.6115,7.959275,NULL,'Earthmender Wilda'),
(2102701,13,-2656.3025,1203.6542,6.292024,NULL,'Earthmender Wilda'),
(2102701,14,-2672.9521,1186.2338,3.1785104,NULL,'Earthmender Wilda'),
(2102701,15,-2686.0994,1175.7258,5.3469415,NULL,'Earthmender Wilda'),
(2102701,16,-2697.5493,1163.4832,5.5097775,NULL,'Earthmender Wilda'),
(2102701,17,-2712.2507,1149.6624,4.1310344,NULL,'Earthmender Wilda'),
(2102701,18,-2731.7368,1141.202,2.0495586,NULL,'Earthmender Wilda'),
(2102701,19,-2755.1863,1145.8915,6.0910826,NULL,'Earthmender Wilda'), -- It shouldn't be much further

(2102702,1,-2775.921,1163.6531,6.2431016,NULL,'Earthmender Wilda'),
(2102702,2,-2785.0398,1176.4891,5.9446754,NULL,'Earthmender Wilda'),
(2102702,3,-2805.2222,1203.5836,6.2892222,NULL,'Earthmender Wilda'),
(2102702,4,-2823.8367,1230.3197,6.2648115,NULL,'Earthmender Wilda'),
(2102702,5,-2841.9836,1247.9833,6.7960606,NULL,'Earthmender Wilda'),
(2102702,6,-2850.0354,1263.7803,7.0559444,NULL,'Earthmender Wilda'),
(2102702,7,-2842.1345,1282.2969,8.041483,NULL,'Earthmender Wilda'),
(2102702,8,-2845.81,1293.1658,6.371023,NULL,'Earthmender Wilda'),
(2102702,9,-2870.9836,1302.0223,6.796061,NULL,'Earthmender Wilda');

DELETE FROM `creature_text` WHERE `CreatureID` IN (21027, 21029, 21044);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(21027, 0, 0, 'Thank you, kind soul. You have freed me from the watery prison of Coilskar but many more are being held prisoner nearby. Will you assist me in freeing them as well?', 12, 0, 100, 2, 0, 0, 18665, 0, 'Earthmender Wilda - Freed'),
(21027, 1, 0, 'I sense the tortured spirits, $n. They are this way. Come quickly!', 12, 0, 100, 0, 0, 0, 18668, 0, 'Earthmender Wilda - Escort Start'),
(21027, 2, 0, 'Watch out!', 12, 0, 100, 0, 0, 0, 18687, 0, 'Earthmender Wilda - Aggro'),
(21027, 2, 1, 'Naga attackers! Defend yourself!', 12, 0, 100, 0, 0, 0, 18688, 0, 'Earthmender Wilda - Aggro'),
(21027, 3, 0, 'Grant me protection, $n. I must break through their foul magic!', 12, 0, 100, 0, 0, 0, 18669, 0, 'Earthmender Wilda - Free Water Spirits'),
(21027, 4, 0, 'Now we must find the exit.', 12, 0, 100, 1, 0, 0, 18670, 0, 'Earthmender Wilda - Finished Water Spirits'),
(21027, 5, 0, 'The naga of Coilskar are exceptionally cruel to their prisoners. It is a miracle that I survived inside that watery prison for as long as I did. Earthmother be praised.', 12, 0, 100, 0, 0, 0, 18685, 0, 'Earthmender Wilda - Say Random'),
(21027, 5, 1, 'Lady Vashj must answer for these atrocities. She must be brought to justice!', 12, 0, 100, 0, 0, 0, 18684, 0, 'Earthmender Wilda - Say Random'),
(21027, 5, 2, 'The tumultuous nature of the great waterways of Azeroth and Draenor are a direct result of tormented water spirits.', 12, 0, 100, 0, 0, 0, 18675, 0, 'Earthmender Wilda - Say Random'),
(21027, 5, 3, 'The naga do not respect nature. They twist and corrupt it to meet their needs. They live to agitate the spirits.', 12, 0, 100, 0, 0, 0, 18673, 0, 'Earthmender Wilda - Say Random'),
(21027, 6, 0, 'It shouldn\'t be much further, $n. The exit is just up ahead.', 12, 0, 100, 1, 0, 0, 18671, 0, 'Earthmender Wilda - Escort Progress'),
(21027, 7, 0, 'Thank you, $n. Please return to my brethren at the Altar of Damnation, near the Hand of Gul\'dan, and tell them that Wilda is safe. May the Earthmother watch over you...', 12, 0, 100, 0, 0, 0, 18672, 0, 'Earthmender Wilda - Escort End'),
(21029, 0, 0, 'Thank you, earthmender.', 12, 12, 100, 0, 0, 0, 18664, 0, 'Captured Water Spirit - Earthmender Wilda Escort'),
(21044, 0, 0, 'Kill them all!', 12, 0, 100, 0, 0, 0, 18692, 0, 'Coilskar Assassin'),
(21044, 0, 1, 'You will never essscape Coilssskarrr...', 12, 0, 100, 0, 0, 0, 18693, 0, 'Coilskar Assassin');

-- Earthmender Wilda Trigger
UPDATE `creature_template_movement` SET `Rooted` = 1 WHERE (`CreatureId` = 21041);
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33555200 WHERE (`entry` = 21041);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21041;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21041);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21041, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 11, 35928, 0, 0, 0, 0, 0, 10, 25119, 21027, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda Trigger - On Data Set 1 1 - Cast \'Watery Prison\''),
(21041, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 92, 0, 35928, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda Trigger - On Data Set 2 2 - Interrupt Spell \'Watery Prison\'');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceEntry` = 21041) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 1, 21041, 0, 0, 31, 1, 3, 21041, 25125, 1, 0, 0, '', 'Earthmender Wilda Trigger GUID 25125 acts as movement target, does not cast spells'),
(22, 2, 21041, 0, 0, 31, 1, 3, 21041, 25125, 1, 0, 0, '', 'Earthmender Wilda Trigger GUID 25125 acts as movement target, does not cast spells');

-- Keeper of the Cistern
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 20795);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20795, 0, 0, 0, 0, 0, 100, 0, 0, 1000, 2500, 4700, 0, 11, 32011, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Keeper of the Cistern - In Combat - Cast \'Water Bolt\''),
(20795, 0, 1, 0, 9, 0, 100, 0, 0, 10, 12000, 16500, 0, 11, 11831, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Keeper of the Cistern - Within 0-10 Range - Cast \'Frost Nova\''),
(20795, 0, 2, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 21027, 100, 0, 0, 0, 0, 0, 0, 'Keeper of the Cistern - On Just Died - Set Data 1 1');

-- Earthmender Wilda
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 21027);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(21027, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 80, 2102700, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - On Respawn - Run Script'),
(21027, 0, 1, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 2102701, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - On Data Set 1 1 - Run Script'),
(21027, 0, 2, 3, 19, 0, 100, 0, 10451, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - On Quest \'Escape from Coilskar Cistern\' Taken - Store Targetlist'),
(21027, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 80, 2102702, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - On Quest \'Escape from Coilskar Cistern\' Taken - Run Script'),
(21027, 0, 4, 0, 58, 0, 100, 0, 9, 2102700, 0, 0, 0, 80, 2102703, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - On Waypoint Finished - Run Script'),
(21027, 0, 5, 0, 58, 0, 100, 0, 19, 2102701, 0, 0, 0, 80, 2102704, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - On Waypoint Finished - Run Script'),
(21027, 0, 6, 0, 58, 0, 100, 0, 9, 2102702, 0, 0, 0, 80, 2102705, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - On Waypoint Finished - Run Script'),
(21027, 0, 7, 0, 40, 0, 8, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - On Waypoint 0 Reached - Say Line 5'),
(21027, 0, 8, 0, 40, 0, 10, 0, 0, 0, 0, 0, 0, 11, 35937, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - On Waypoint 0 Reached - Cast \'Serverside - Summon Ambush\''),
(21027, 0, 9, 0, 4, 0, 50, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - On Aggro - Say Line 2'),
(21027, 0, 10, 0, 0, 0, 100, 0, 1000, 3500, 1500, 4500, 0, 11, 16006, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - In Combat - Cast \'Chain Lightning\''),
(21027, 0, 11, 0, 0, 0, 100, 0, 10000, 20000, 15000, 30000, 0, 11, 15786, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - In Combat - Cast \'Earthbind Totem\''),
(21027, 0, 12, 0, 14, 0, 100, 0, 1000, 30, 5000, 15000, 0, 11, 12491, 64, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Friendly At 1000 Health - Cast \'Healing Wave\''),
(21027, 0, 13, 0, 0, 0, 100, 0, 7500, 15000, 12000, 21000, 0, 11, 12548, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - In Combat - Cast \'Frost Shock\''),
(21027, 0, 14, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 6, 10451, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - On Just Died - Fail Quest \'Escape from Coilskar Cistern\'');

-- Actionlists for Earthmender Wilda
DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2102700, 2102701, 2102702, 2102703, 2102704, 2102705));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2102700, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 60, 0, 30, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Disable Gravity'),
(2102700, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Remove Npc Flags Questgiver'),
(2102700, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35921, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Cast \'Water Bubble\''),
(2102700, 9, 3, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 21041, 0, 40, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Set Data 1 1'),

(2102701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 9, 21041, 0, 50, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Set Data 2 2'),
(2102701, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 0, 0, 0, 0, 0, 0, 10, 25125, 21041, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Move To Closest Creature \'Earthmender Wilda Trigger\''),
(2102701, 9, 2, 0, 0, 0, 100, 0, 12000, 12000, 0, 0, 0, 28, 35921, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Remove Aura \'Water Bubble\''),
(2102701, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 60, 0, 100, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Set Fly Off'),
(2102701, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 205, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Fall'),
(2102701, 9, 5, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 100, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Set Orientation Closest Player'),
(2102701, 9, 6, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Say Line 0'),
(2102701, 9, 7, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Add Npc Flags Questgiver'),

(2102702, 9, 0, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Remove Npc Flags Questgiver'),
(2102702, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 495, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Set Faction 495'),
(2102702, 9, 2, 0, 0, 0, 100, 0, 1300, 1300, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Say Line 1'),
(2102702, 9, 3, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 53, 0, 2102700, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Start Waypoint'),

(2102703, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Set Reactstate Passive'),
(2102703, 9, 1, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 1, 3, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Say Line 3'),
(2102703, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35933, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Cast \'Break Water Prison\''),
(2102703, 9, 3, 0, 0, 0, 100, 0, 15800, 15800, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 21, 40, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Set Orientation Closest Player'),
(2102703, 9, 4, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 21029, 0, 100, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Set Data 1 1'),
(2102703, 9, 5, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Say Line 4'),
(2102703, 9, 6, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 53, 0, 2102701, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Start Waypoint'),
(2102703, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Set Reactstate Aggressive'),

(2102704, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 6, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Say Line 6'),
(2102704, 9, 1, 0, 0, 0, 100, 0, 3300, 3300, 0, 0, 0, 53, 0, 2102702, 0, 10451, 6000, 2, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Start Waypoint'),

(2102705, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 7, 0, 1, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Say Line 7'),
(2102705, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 9, 21029, 0, 100, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Set Data 2 2'),
(2102705, 9, 2, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 5, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Earthmender Wilda - Actionlist - Play Emote 5');

-- Captured Water Spirits
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33024 WHERE (`entry` = 21029);
UPDATE `creature_template_addon` SET `auras` = '' WHERE (`entry` = 21029);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 21029;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-25120, -25121, -25122, -25123, -25124));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-25120, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 2102900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Data Set 1 1 - Run Script'),
(-25120, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Data Set 2 2 - Despawn Instant'),
(-25120, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Cast \'Water Bubble\''),

(-25121, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 2102901, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Data Set 1 1 - Run Script'),
(-25121, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Data Set 2 2 - Despawn Instant'),
(-25121, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Cast \'Water Bubble\''),

(-25122, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 2102902, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Data Set 1 1 - Run Script'),
(-25122, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Data Set 2 2 - Despawn Instant'),
(-25122, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Cast \'Water Bubble\''),

(-25124, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 2102904, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Data Set 1 1 - Run Script'),
(-25124, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Data Set 2 2 - Despawn Instant'),
(-25124, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Cast \'Water Bubble\''),

(-25123, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 80, 2102903, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Data Set 1 1 - Run Script'),
(-25123, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Data Set 2 2 - Despawn Instant'),
(-25123, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 11, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - On Respawn - Cast \'Water Bubble\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 2102900 AND 2102904);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2102900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 28, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Remove Aura \'Water Bubble\''),
(2102900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 495, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Set Faction 495'),
(2102900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 29, 1, 90, 0, 0, 0, 0, 10, 25123, 21029, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Start Follow Closest Creature \'Captured Water Spirit\''),
(2102900, 9, 3, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Set Fly Off'),
(2102900, 9, 4, 0, 0, 0, 100, 0, 800, 800, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Say Line 0'),
(2102900, 9, 5, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 29, 2, 215, 0, 0, 0, 0, 10, 25123, 21029, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Start Follow Closest Creature \'Captured Water Spirit\''),

(2102901, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 28, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Remove Aura \'Water Bubble\''),
(2102901, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 495, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Set Faction 495'),
(2102901, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 29, 1, 120, 0, 0, 0, 0, 10, 25123, 21029, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Start Follow Closest Creature \'Captured Water Spirit\''),
(2102901, 9, 3, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Set Fly Off'),
(2102901, 9, 4, 0, 0, 0, 100, 0, 800, 800, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Say Line 0'),
(2102901, 9, 5, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 29, 2, 215, 0, 0, 0, 0, 10, 25120, 21029, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Start Follow Closest Creature \'Captured Water Spirit\''),

(2102902, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 28, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Remove Aura \'Water Bubble\''),
(2102902, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 495, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Set Faction 495'),
(2102902, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 29, 1, 150, 0, 0, 0, 0, 10, 25123, 21029, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Start Follow Closest Creature \'Captured Water Spirit\''),
(2102902, 9, 3, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Set Fly Off'),
(2102902, 9, 4, 0, 0, 0, 100, 0, 800, 800, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Say Line 0'),
(2102902, 9, 5, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 29, 2, 135, 0, 0, 0, 0, 10, 25123, 21029, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Start Follow Closest Creature \'Captured Water Spirit\''),

(2102904, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 28, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Remove Aura \'Water Bubble\''),
(2102904, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 495, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Set Faction 495'),
(2102904, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 29, 1, 90, 0, 0, 0, 0, 10, 25123, 21029, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Start Follow Closest Creature \'Captured Water Spirit\''),
(2102904, 9, 3, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Set Fly Off'),
(2102904, 9, 4, 0, 0, 0, 100, 0, 800, 800, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Say Line 0'),
(2102904, 9, 5, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 29, 2, 135, 0, 0, 0, 0, 10, 25122, 21029, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Start Follow Closest Creature \'Captured Water Spirit\''),

(2102903, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 28, 35929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Remove Aura \'Water Bubble\''),
(2102903, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 2, 495, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Set Faction 495'),
(2102903, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 29, 1, 0, 0, 0, 0, 0, 10, 25119, 21027, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Start Follow Closest Creature \'Earthmender Wilda\''),
(2102903, 9, 3, 0, 0, 0, 100, 0, 3600, 3600, 0, 0, 0, 60, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Set Fly Off'),
(2102903, 9, 4, 0, 0, 0, 100, 0, 800, 800, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Say Line 0'),
(2102903, 9, 5, 0, 0, 0, 100, 0, 2400, 2400, 0, 0, 0, 29, 2, 180, 0, 0, 0, 0, 10, 25119, 21027, 0, 0, 0, 0, 0, 0, 'Captured Water Spirit - Actionlist - Start Follow Closest Creature \'Earthmender Wilda\'');

-- Fix for serverside spell
UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 0 WHERE `ID` = 35937;
