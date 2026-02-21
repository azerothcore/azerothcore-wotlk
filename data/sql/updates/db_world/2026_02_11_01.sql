-- DB update 2026_02_11_00 -> 2026_02_11_01
-- Pathing for  Entry: 5042
SET @NPC := 90458;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=-8760.21,`position_y`=811.9198,`position_z`=97.793724 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-8760.21,811.9198,97.793724,NULL,0,0,0,100,0),
(@PATH,2,-8763.192,810.93536,97.74572,NULL,0,0,0,100,0),
(@PATH,3,-8763.192,810.93536,97.74572,2.199114799499511718,12000,0,0,100,0),
(@PATH,4,-8769.179,814.3151,97.8737,NULL,0,0,0,100,0),
(@PATH,5,-8755.52,814.1872,97.88151,NULL,0,0,0,100,0),
(@PATH,6,-8755.52,814.1872,97.88151,3.839724302291870117,12000,0,0,100,0),
(@PATH,7,-8766.348,820.14746,97.870056,NULL,0,0,0,100,0),
(@PATH,8,-8766.348,820.14746,97.870056,3.874630928039550781,12000,0,0,100,0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5042;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 5042);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(5042, 0, 0, 0, 108, 0, 100, 0, 3, 0, 0, 0, 0, 0, 80, 504200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nurse Lillian - On Point 3 of Path Any Reached - Run Script'),
(5042, 0, 1, 0, 108, 0, 100, 0, 6, 0, 0, 0, 0, 0, 80, 504200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nurse Lillian - On Point 6 of Path Any Reached - Run Script'),
(5042, 0, 2, 0, 108, 0, 100, 0, 8, 0, 0, 0, 0, 0, 80, 504200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nurse Lillian - On Point 8 of Path Any Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 504200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(504200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nurse Lillian - Actionlist - Set Flag Standstate Kneel'),
(504200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Nurse Lillian - Actionlist - Say Line');

DELETE FROM `creature_text` WHERE (`CreatureID` = 5042);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(5042, 0, 0, 'You\'re going to be just fine.', 12, 7, 100, 1, 0, 0, 1682, 0, 'Nurse Lillian'),
(5042, 0, 1, 'Drink this, it will help.', 12, 7, 100, 1, 0, 0, 1679, 0, 'Nurse Lillian'),
(5042, 0, 2, 'Let me help you with those.', 12, 7, 100, 1, 0, 0, 1685, 0, 'Nurse Lillian'),
(5042, 0, 3, 'Feeling better I see.', 12, 7, 100, 1, 0, 0, 1678, 0, 'Nurse Lillian'),
(5042, 0, 4, 'Some of this ointment should help.', 12, 7, 100, 1, 0, 0, 1681, 0, 'Nurse Lillian'),
(5042, 0, 5, 'Take this, drink it down.', 12, 7, 100, 1, 0, 0, 1683, 0, 'Nurse Lillian'),
(5042, 0, 6, 'This should ease the pain.', 12, 7, 100, 1, 0, 0, 1680, 0, 'Nurse Lillian'),
(5042, 0, 7, 'You will keep all your fingers and toes, not to worry.', 12, 7, 100, 1, 0, 0, 1684, 0, 'Nurse Lillian'),
(5042, 0, 8, 'You\'re going to be just fine.', 12, 7, 100, 1, 0, 0, 1682, 0, 'Nurse Lillian');

SET @GUID := 12837;

DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+13 AND `id1` IN (5043, 4996, 6237, 4995);
DELETE FROM `creature` WHERE `guid` IN (79522,79550,79558,79580,90453,90454,90455,90456,90457,90472,90473,90474,90475,120726,120727,120728,120756,120757,120758,120759,120762) AND `id1` IN (5043, 4996, 6237, 4995);
INSERT INTO `creature` (`guid`, `id1`, `map`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@GUID+0 , 4996, 0, 0, -8757.4443359375, 812.39703369140625, 97.71795654296875, 2.286381244659423828, 120, 45327, 1, ''),
(@GUID+1 , 4996, 0, 0, -8762.8095703125, 812.35577392578125, 97.71795654296875, 0.715584993362426757, 120, 45327, 1, ''),
(@GUID+2 , 4996, 0, 0, -8756.3095703125, 813.4608154296875, 97.71795654296875, 2.443460941314697265, 120, 45327, 1, ''),
(@GUID+3 , 4996, 0, 0, -8767.583984375, 819.58966064453125, 97.71795654296875, 5.009094715118408203, 120, 45327, 1, ''),
(@GUID+4 , 4996, 0, 0, -8764.927734375, 815.26214599609375, 97.71795654296875, 0.593411922454833984, 120, 45327, 1, ''),
(@GUID+5 , 4996, 0, 0, -8763.865234375, 813.7657470703125, 97.71795654296875, 0.645771801471710205, 120, 45327, 1, ''),
(@GUID+6 , 6237, 0, 1, -8779.48828125, 823.29180908203125, 97.71795654296875, 1.471759438514709472, 120, 45327, 1, ''),
(@GUID+7 , 6237, 0, 1, -8791.2314453125, 835.568603515625, 97.71795654296875, 6.113029003143310546, 120, 45327, 1, ''),
(@GUID+8 , 6237, 0, 1, -8792.388671875, 831.44061279296875, 97.72733306884765625, 0.211701273918151855, 120, 45327, 1, ''),
(@GUID+9 , 6237, 0, 1, -8786.2099609375, 822.29278564453125, 97.7254180908203125, 1.109707117080688476, 120, 45327, 1, ''),
(@GUID+10, 4995, 0, 1, -8785.0107421875, 826.6419677734375, 97.75400543212890625, 0.820304751396179199, 120, 45327, 1, ''),
(@GUID+11, 4995, 0, 1, -8782.9091796875, 826.6568603515625, 97.57006072998046875, 1.064650893211364746, 120, 45327, 1, ''),
(@GUID+12, 4995, 0, 1, -8787.681640625, 832.94757080078125, 97.455596923828125, 0.261799395084381103, 120, 45327, 1, ''),
(@GUID+13, 4995, 0, 1, -8787.1953125, 829.95263671875, 97.75400543212890625, 0.796267867088317871, 120, 45327, 1, '');

DELETE FROM `creature_formations` WHERE (`leaderGUID` = @GUID+3);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`) VALUES
(@GUID+3, @GUID+0, 0, 0, 3, 0, 0),
(@GUID+3, @GUID+1, 0, 0, 3, 0, 0),
(@GUID+3, @GUID+2, 0, 0, 3, 0, 0),
(@GUID+3, @GUID+3, 0, 0, 3, 0, 0),
(@GUID+3, @GUID+4, 0, 0, 3, 0, 0),
(@GUID+3, @GUID+5, 0, 0, 3, 0, 0),
(@GUID+3, @GUID+6, 0, 0, 3, 0, 0),
(@GUID+3, @GUID+7, 0, 0, 3, 0, 0);

UPDATE `creature` SET `position_x` = -8799.5703125, `position_y` = 828.39599609375, `position_z` = 97.753997802734375, `orientation` = 0.9686967134475708, `CreateObject` = 1, `VerifiedBuild` = 45327 WHERE `guid` = 89325 AND `id1` = 1719;

DELETE FROM `creature_addon` WHERE (`guid` IN (79522, 79550, 79558, 79580, 90457));
DELETE FROM `creature_addon` WHERE (`guid` BETWEEN @GUID AND @GUID+13);
INSERT INTO `creature_addon` (`guid`, `bytes1`) VALUES
(@GUID+0, 1),
(@GUID+1, 3),
(@GUID+2, 1),
(@GUID+3, 1),
(@GUID+4, 3),
(@GUID+5, 3);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 6237;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 6237) AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(6237, 0, 0, 0, 0, 0, 100, 0, 0, 3000, 3000, 6000, 0, 0, 11, 6660, 64, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Stockade Archer - In Combat - Cast \'Shoot\'');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 1719);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1719, 0, 0, 0, 1, 0, 100, 0, 0, 0, 20000, 43000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden Thelwater - Out of Combat - Say Line'),
(1719, 0, 1, 0, 1, 0, 100, 512, 0, 0, 1800000, 1800000, 0, 0, 107, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Warden Thelwater - Out of Combat - Summon Creature Group \'Defias Rioter\''),
(1719, 0, 2, 0, 17, 0, 100, 512, 5043, 0, 0, 0, 0, 0, 201, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, -8785.28, 829.17, 97.5, 0, 'Warden Thelwater - On Summoned Unit - Move To Position');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 171900);

DELETE FROM `creature_summon_groups` WHERE `summonerId` = 1719 AND `summonerType` = 0 AND `entry` = 5043;
INSERT INTO `creature_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `summonType`, `summonTime`, `Comment`) VALUES
(1719, 0, 0, 5043, -8762.42578125, 842.49249267578125, 87.6991729736328125, 0.942477762699127197, 4, 30000, 'Defias Rioter'),
(1719, 0, 0, 5043, -8763.640625, 843.8431396484375, 87.74048614501953125, 1.134464025497436523, 4, 30000, 'Defias Rioter'),
(1719, 0, 0, 5043, -8763.9404296875, 842.83203125, 88.064422607421875, 5.497786998748779296, 4, 30000, 'Defias Rioter'),
(1719, 0, 0, 5043, -8764.96484375, 845.6055908203125, 87.71747589111328125, 3.228859186172485351, 4, 30000, 'Defias Rioter'),
(1719, 0, 0, 5043, -8765.03125, 843.9947509765625, 88.11328125, 0.331612557172775268, 4, 30000, 'Defias Rioter'),
(1719, 0, 0, 5043, -8766.08203125, 846.09759521484375, 87.93059539794921875, 5.567600250244140625, 4, 30000, 'Defias Rioter'),
(1719, 0, 0, 5043, -8766.8154296875, 848.52008056640625, 87.59954071044921875, 4.433136463165283203, 4, 30000, 'Defias Rioter'),
(1719, 0, 0, 5043, -8766.833984375, 846.41839599609375, 88.07654571533203125, 3.647738218307495117, 4, 30000, 'Defias Rioter');
