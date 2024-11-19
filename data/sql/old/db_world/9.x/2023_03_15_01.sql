-- DB update 2023_03_15_00 -> 2023_03_15_01
--
UPDATE `creature_template_addon` SET `bytes2` = 1, `visibilityDistanceType` = 5 WHERE (`entry` = 19851);
UPDATE `creature_template` SET `unit_flags` = 32768, `flags_extra` = `flags_extra`|2097152 WHERE (`entry` = 19851);

DELETE FROM `creature` WHERE `id1`=19851; -- Delete extra Negatron
UPDATE `creature` SET `spawntimesecs`=120 WHERE `id1` IN (19737, 19849);

DELETE FROM `creature_summon_groups` WHERE `summonerId`=19851 AND `entry`=19541;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(19851, 0, 0, 19541, 3035.4849, 3630.7654, 144.4357, 1.488142371177673339, 4, 60000, 'Netherstorm Agent - You, Robot - Negatron Failure Event'),
(19851, 0, 0, 19541, 3029.642, 3638.9456, 143.87413, 1.169370532035827636, 4, 60000, 'Netherstorm Agent - You, Robot - Negatron Failure Event');

DELETE FROM `waypoints` WHERE `entry` IN (1985100, 1985101, 1973700, 1973701, 1973702, 1973703) AND `point_comment` IN ('Negatron', 'Engineering Crewmember');
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `point_comment`) VALUES
(1985100,1,3137.2078,3268.273,110.69139,NULL,'Negatron'),
(1985100,2,3128.09,3294.4512,107.87908,NULL,'Negatron'),
(1985100,3,3121.0325,3314.7815,110.84304,NULL,'Negatron'), -- Doctor Vomisa face Negatron
(1985100,4,3113.2158,3336.4111,107.649345,NULL,'Negatron'),
(1985100,5,3104.8281,3361.3098,104.649345,NULL,'Negatron'),
(1985100,6,3097.5208,3381.5989,105.865395,NULL,'Negatron'),
(1985101,1,3053.5566,3421.556,111.00708,NULL,'Negatron'),
(1985101,2,3051.7932,3455.1265,118.63066,NULL,'Negatron'),
(1985101,3,3034.655,3492.1448,134.73538,NULL,'Negatron'),
(1985101,4,3024.468,3515.7493,143.77145,NULL,'Negatron'),
(1985101,5,3028.9001,3538.7004,144.36063,NULL,'Negatron'),
(1985101,6,3036.7417,3573.2764,143.18323,NULL,'Negatron'),
(1985101,7,3049.1687,3585.138,143.41333,NULL,'Negatron'),
(1973700,1,3031.1257,3688.058,143.15771,NULL,'Engineering Crewmember'), -- 70613
(1973700,2,3011.8333,3689.197,143.637,NULL,'Engineering Crewmember'),
(1973701,1,3071.3098,3668.194,142.37271,NULL,'Engineering Crewmember'), -- 70612
(1973701,2,3089.5693,3678.5586,142.48721,NULL,'Engineering Crewmember'),
(1973701,3,3108.9783,3684.0244,142.99113,NULL,'Engineering Crewmember'),
(1973701,4,3121.0576,3690.8025,143.11064,NULL,'Engineering Crewmember'),
(1973702,1,3071.934,3660.8694,142.9512,NULL,'Engineering Crewmember'), -- 70614
(1973702,2,3084.3215,3655.3108,142.87344,NULL,'Engineering Crewmember'),
(1973702,3,3090.7234,3645.0745,143.13007,NULL,'Engineering Crewmember'),
(1973702,4,3090.0159,3629.1611,143.10968,NULL,'Engineering Crewmember'),
(1973702,5,3081.2068,3620.2065,143.60968,NULL,'Engineering Crewmember'),
(1973703,1,3026.3057,3644.5496,143.46822,NULL,'Engineering Crewmember'), -- 70615
(1973703,2,3009.577,3644.3416,143.75604,NULL,'Engineering Crewmember');

UPDATE `creature_text` SET `Emote`=25, `BroadcastTextId`=17456 WHERE `CreatureID`=19832 AND `GroupID`=0 AND `ID`=0;

DELETE FROM `creature_text` WHERE `CreatureID` IN (19570, 19849, 19851);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(19570, 0, 0, 'Oh no!  The X-52 Nether-Rocket is being attacked!  Guards!  Guards!', 14, 0, 100, 5, 0, 0, 17474, 0, 'Rocket-Chief Fuselage'),
(19849, 0, 0, 'The %s, having fought the good fight, falls to pieces.', 16, 0, 100, 0, 0, 0, 18587, 0, 'Scrap Reaver X6000'),
(19851, 0, 0, 'I AM DEATH!  PREPARE YOUR TOWN FOR ANNIHILATION!', 14, 0, 100, 0, 0, 0, 17455, 0, 'Negatron'),
(19851, 1, 0, 'YOUR SAD ATTEMPT AT CREATING A FEL REAVER TO STOP ME HAS FAILED!  NOW, ON TO AREA 52!', 14, 0, 100, 0, 0, 0, 17468, 0, 'Negatron');

-- After reaching Area 52, Negatron causes Engineering Crewmembers to flee (WPs) and Rocket-Chief to perform a short event
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19737;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (-70612, -70613, -70614, -70615));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-70613, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 53, 1, 1973700, 0, 0, 500, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineering Crewmember - On Data Set 1 1 - Start Waypoint (Negatron Failure Event)'),
(-70612, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 53, 1, 1973701, 0, 0, 500, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineering Crewmember - On Data Set 1 1 - Start Waypoint (Negatron Failure Event)'),
(-70614, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 53, 1, 1973702, 0, 0, 500, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineering Crewmember - On Data Set 1 1 - Start Waypoint (Negatron Failure Event)'),
(-70614, 0, 1, 0, 38, 0, 100, 0, 2, 2, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 70731, 19776, 0, 0, 0, 0, 0, 0, 'Engineering Crewmember - On Data Set 2 2 - Set Orientation Closest Creature \'Experimental Pilot\''),
(-70614, 0, 2, 0, 38, 0, 100, 0, 3, 3, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.19912, 'Engineering Crewmember - On Data Set 3 3 - Set Orientation 2,199120'),
(-70615, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 53, 1, 1973703, 0, 0, 500, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Engineering Crewmember - On Data Set 1 1 - Start Waypoint (Negatron Failure Event)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19570;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19570);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19570, 0, 0, 1, 38, 0, 100, 0, 1, 1, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rocket-Chief Fuselage - On Data Set 1 1 - Set Run On'),
(19570, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3062.3855, 3661.3877, 143.09126, 0, 'Rocket-Chief Fuselage - On Data Set 1 1 - Move To Position'),
(19570, 0, 2, 3, 34, 0, 100, 0, 0, 1, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 19851, 100, 0, 0, 0, 0, 0, 0, 'Rocket-Chief Fuselage - On Reached Point 1 - Set Orientation Closest Creature \'Negatron\''),
(19570, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 0, 59, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rocket-Chief Fuselage - On Reached Point 1 - Set Run Off'),
(19570, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 67, 1, 60000, 60000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rocket-Chief Fuselage - On Reached Point 1 - Create Timed Event'),
(19570, 0, 5, 0, 59, 0, 100, 0, 1, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Rocket-Chief Fuselage - On Timed Event 1 Triggered - Evade');

-- Doctor Vomisa
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19832);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19832, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 0, 12, 19851, 4, 300000, 0, 0, 0, 8, 0, 0, 0, 0, 3148.74, 3233.88, 97.6867, 1.90637, 'Doctor Vomisa, Ph.T. - On Data Set 1 1 - Summon Creature \'Negatron\''),
(19832, 0, 1, 2, 38, 0, 100, 512, 2, 2, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 5.072320938110352, 'Doctor Vomisa, Ph.T. - On Data Set 2 2 - Set Orientation 5.072320938110352'),
(19832, 0, 2, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Doctor Vomisa, Ph.T. - On Data Set 2 2 - Say Line 0');

-- Scrap Reaver X6000
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 19849;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19849);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19849, 0, 0, 1, 8, 0, 100, 513, 34630, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 70967, 19832, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - On Spellhit \'Scrap Reaver X6000\' - Set Data 1 1 on Doctor Vomisa, Ph.T. - Summon Negatron'),
(19849, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - On Spellhit \'Scrap Reaver X6000\' - Store Targetlist Invoker Party'),
(19849, 0, 2, 0, 38, 0, 100, 512, 1, 1, 0, 0, 0, 80, 1984900, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - On Data Set 1 1 - Run Success Script'),
(19849, 0, 3, 0, 11, 0, 100, 512, 0, 0, 0, 0, 0, 80, 1984901, 2, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - On Respawn - Run Respawn Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1984900, 1984901));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1984900, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 33, 19851, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Quest Credit \'You, Robot\''),
(1984900, 9, 1, 0, 0, 0, 100, 512, 10000, 10000, 0, 0, 0, 18, 33556488, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Set Flags PvP Attackable & Pet In Combat & Not Selectable'),
(1984900, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 103, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Set Rooted On'),
(1984900, 9, 3, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Set Flag Standstate Dead'),
(1984900, 9, 4, 0, 0, 0, 100, 512, 200, 200, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Say Line 0'),
(1984900, 9, 5, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 41, 6000, 120, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Despawn In 6000 ms'),
(1984901, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Remove FlagStandstate Dead'),
(1984901, 9, 1, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 19, 33556488, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Remove Flags PvP Attackable & Pet In Combat & Not Selectable'),
(1984901, 9, 2, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 103, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Scrap Reaver X6000 - Actionlist - Set Rooted Off');

-- Negatron
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19851);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19851, 0, 0 , 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1985100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On Just Summoned - Run Script'),
(19851, 0, 1 , 0, 40, 0, 100, 0, 3, 1985100, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 10, 70967, 19832, 0, 0, 0, 0, 0, 0, 'Negatron - On Waypoint 3 Reached - Set Data 2 2 on Doctor Vomisa, Ph.T.'),
(19851, 0, 2 , 0, 58, 0, 100, 0, 6, 1985100, 0, 0, 0, 80, 1985101, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On Waypoint Finished - Run Script'),
(19851, 0, 3 , 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On Reset - Set Event Phase 1 (Allow Failure Event Timer to Start)'),
(19851, 0, 4 , 0, 1, 1, 100, 1, 15000, 15000, 0, 0, 0, 80, 1985102, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Out of Combat - Run Failure Event Script (Phase 1)'),
(19851, 0, 5 , 0, 58, 0, 100, 0, 7, 1985101, 0, 0, 0, 80, 1985103, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On Waypoint Finished - Run Script'),
(19851, 0, 6 , 0, 34, 0, 100, 0, 8, 1, 0, 0, 0, 80, 1985104, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On MovementInform 1 - Run Script'),
(19851, 0, 7 , 8, 6, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 19849, 100, 0, 0, 0, 0, 0, 0, 'Negatron - On Just Died - Set Data 1 1 on Scrap Reaver X6000 - Start Success Event'),
(19851, 0, 8 , 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 41, 15000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - On Just Died - Despawn In 15000 ms'),
(19851, 0, 9 , 0, 9, 0, 100, 0, 8, 25, 15000, 21000, 1, 11, 35570, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Within 8-25 Range - Cast \'Charge\''),
(19851, 0, 10, 0, 9, 0, 100, 0, 0, 5, 8000, 12000, 0, 11, 34625, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Within 0-5 Range - Cast \'Demolish\''),
(19851, 0, 11, 0, 0, 0, 100, 0, 15000, 19000, 21000, 25000, 0, 11, 35565, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - In Combat - Cast \'Earthquake\''),
(19851, 0, 12, 0, 2, 0, 100, 0, 0, 50, 16000, 22000, 0, 11, 34624, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Between 0-50% Health - Cast \'Frenzy\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (1985100, 1985101, 1985102, 1985103, 1985104));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1985100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 48, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Active On'),
(1985100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 33536, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Flags Immune To Players'),
(1985100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1985100, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Start Waypoint'),
(1985100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 15742, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Cast \'Ashcrombe`s Teleport\''),
(1985100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Event Phase 2 (Do Not Start Timer for Failure Event)'),

(1985101, 9, 0, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 10, 70967, 19832, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Orientation Creature \'Doctor Vomisa, Ph.T.\''),
(1985101, 9, 1, 0, 0, 0, 100, 0, 150, 150, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Say Line 0'),
(1985101, 9, 2, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 18, 32768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Remove Immunity Flags'),
(1985101, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, 70975, 19849, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Start Attacking Scrap Reaver X6000'),

(1985102, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 53, 1, 1985101, 0, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Start Waypoint'),
(1985102, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 18, 33536, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Flags Immune To Players & Immune To NPC\'s'),
(1985102, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Say Line 1'),

(1985103, 9, 0, 0, 0, 0, 100, 0, 300, 300, 0, 0, 0, 11, 34427, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Cast \'Ethereal Teleport\''),
(1985103, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 62, 530, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 3044.2, 3622.36, 143.269, 0, 'Negatron - Actionlist - Teleport'),
(1985103, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 59, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Run On'),
(1985103, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 69, 1, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3037.824, 3659.001, 143.53865, 0, 'Negatron - Actionlist - Move To Position'),
(1985103, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 9, 19737, 0, 200, 1, 0, 0, 0, 0, 'Negatron - Actionlist - Set Data 1 1 on Engineering Crewmembers'),
(1985103, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 70009, 19570, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Set Data 1 1 on Rocket-Chief Fuselage'),

(1985104, 9, 0, 0, 0, 0, 100, 0, 150, 150, 0, 0, 0, 5, 54, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Play Emote 54'),
(1985104, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 183987, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3030.1443, 3656.7964, 159.49426, 0.15707901, 'Negatron - Actionlist - Summon Gameobject \'Rocket Fire\''),
(1985104, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 183987, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3047.6445, 3668.2544, 158.13696, 0.017452462, 'Negatron - Actionlist - Summon Gameobject \'Rocket Fire\''),
(1985104, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 183987, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3029.779, 3677.4927, 158.64986, 1.3439013, 'Negatron - Actionlist - Summon Gameobject \'Rocket Fire\''),
(1985104, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 183987, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3038.2305, 3670.395, 197.78914, 6.073746, 'Negatron - Actionlist - Summon Gameobject \'Rocket Fire\''),
(1985104, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 183987, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3042.363, 3667.0383, 180.62209, 4.747296, 'Negatron - Actionlist - Summon Gameobject \'Rocket Fire\''),
(1985104, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 50, 183987, 180000, 0, 0, 0, 0, 8, 0, 0, 0, 0, 3031.6763, 3671.5273, 180.86804, 0.69813144, 'Negatron - Actionlist - Summon Gameobject \'Rocket Fire\''),
(1985104, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 70009, 19570, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Say Line 0 (Rocket-Chief Fuselage)'),
(1985104, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Remove Flag Immune To NPC'),
(1985104, 9, 9, 0, 0, 0, 100, 0, 800, 800, 0, 0, 0, 107, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Summon Creature Group 0'),
(1985104, 9, 10, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 19541, 100, 0, 0, 0, 0, 0, 0, 'Negatron - Actionlist - Start Attacking');

-- Experimental Pilot Refactor
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19776);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19776, 0, 0, 0, 25, 0, 100, 512, 0, 0, 0, 0, 0, 53, 0, 19776, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - On Reset - Start Waypoint'),
(19776, 0, 1, 0, 40, 0, 100, 512, 8, 19776, 0, 0, 0, 80, 1977600, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - On Waypoint 8 Reached - Run Script'),
(19776, 0, 2, 3, 40, 0, 100, 512, 15, 19776, 0, 0, 0, 54, 300000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - On Waypoint 15 Reached - Pause Waypoint'),
(19776, 0, 3, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 5.0689, 'Experimental Pilot - On Waypoint 15 Reached - Set Orientation 5,0689');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1977600);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1977600, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 54, 140000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Pause Waypoint'),
(1977600, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.11134, 'Experimental Pilot - Actionlist - Set Orientation 2.11134'),
(1977600, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 10, 70614, 19737, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Set Data 2 2'),
(1977600, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 1, 0, 15000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Say Line 0'),
(1977600, 9, 4, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 1, 0, 20000, 0, 0, 0, 0, 10, 70614, 19737, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Say Line 0'),
(1977600, 9, 5, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 0, 1, 1, 20000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Say Line 1'),
(1977600, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Play Emote 6'),
(1977600, 9, 7, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 0, 1, 1, 15000, 0, 0, 0, 0, 10, 70614, 19737, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Say Line 1'),
(1977600, 9, 8, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 5, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Play Emote 6'),
(1977600, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 1, 2, 15000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Say Line 2'),
(1977600, 9, 10, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 1, 2, 10000, 0, 0, 0, 0, 10, 70614, 19737, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Say Line 2'),
(1977600, 9, 11, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 1, 3, 15000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Say Line 3'),
(1977600, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 5, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Play Emote 6'),
(1977600, 9, 13, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 1, 3, 10000, 0, 0, 0, 0, 10, 70614, 19737, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Say Line 3'),
(1977600, 9, 14, 0, 0, 0, 100, 0, 10000, 10000, 0, 0, 0, 1, 4, 15000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Say Line 4'),
(1977600, 9, 15, 0, 0, 0, 100, 0, 15000, 15000, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 10, 70614, 19737, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Say Line 4'),
(1977600, 9, 16, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 45, 3, 3, 0, 0, 0, 0, 10, 70614, 19737, 0, 0, 0, 0, 0, 0, 'Experimental Pilot - Actionlist - Set Data 3 3');

-- Don't play Experimental Pilot Script if there are no Crewmembers nearby
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2) AND (`SourceEntry` = 19776);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, 19776, 0, 0, 29, 1, 19737, 10, 0, 0, 0, 0, '', 'Only Run Script if creature Engineering Crewmember (19737) is nearby');

-- Netherstorm Agent
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 19541);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(19541, 0, 0, 0, 1, 0, 80, 0, 60000, 60000, 200000, 230000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherstorm Agent - Out of Combat - Say Line 0'),
(19541, 0, 1, 0, 9, 0, 100, 0, 5, 30, 3600, 3600, 0, 11, 36246, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherstorm Agent - Within 5-30 Range - Cast \'Shoot Tech Gun\''),
(19541, 0, 2, 0, 54, 0, 100, 512, 0, 0, 0, 0, 0, 80, 1954100, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherstorm Agent - On Just Summoned - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 1954100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1954100, 9, 0, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 2, 1770, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherstorm Agent - Actionlist - Set Faction 1770'),
(1954100, 9, 1, 0, 0, 0, 100, 512, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Netherstorm Agent - Actionlist - Set Invincibility Hp 1'),
(1954100, 9, 2, 0, 0, 0, 100, 512, 1200, 1200, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 19, 19851, 100, 0, 0, 0, 0, 0, 0, 'Netherstorm Agent - Actionlist - Start Attacking');

-- Conditions for controlling Scrap Reaver X6000
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceEntry` = 34630) AND (`ConditionTypeOrReference` IN (28, 29)) AND (`ConditionValue1` IN (19851, 10248));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 34630, 0, 0, 29, 0, 19851, 200, 0, 1, 0, 0, '', 'Only cast Scrap Reaver X6000 if Negatron is not spawned'),
(17, 0, 34630, 0, 0, 28, 0, 10248, 0, 0, 1, 0, 0, '', 'Only cast Scrap Reaver X6000 if quest You, Robot is not completed');

-- Quest not being completable
UPDATE `quest_template_addon` SET `SpecialFlags`=`SpecialFlags`&~2 WHERE (`ID` = 10248);
