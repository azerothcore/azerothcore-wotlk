-- DB update 2022_03_27_21 -> 2022_03_27_22
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_27_21';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_27_21 2022_03_27_22 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648344440179668500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648344440179668500');

-- Removed Creature GUIDS 28458,134022,134023 
-- New Creature GUIDS 76265,86827,86828,86829,86830,86831,152333,152334,152335,152336,152337,152338,152339,97406,97407,97408,97431
-- New Game Events 88, 89

-- -------------------------------------Pyrewood Village Updates----------------------------------------
-- Pyrewood Event Time Correction (Nights) - Triggered way too early
UPDATE `game_event` SET `start_time` = '2015-07-29 21:00:00', `length` = 540 WHERE `eventEntry` = 25;

-- Moonrage Sentry Faction Fix was not hostile to Alliance
UPDATE `creature_template` SET `faction` = 24 WHERE `entry` = 1893;

-- ---------------------------------------Rams, Ultham, and Rotten Ghouls----------------------------------------

-- Rams Night Position Adjustment and creature change
UPDATE creature SET `id1` = 12372, `position_x` = -5509.63, `position_y` = -1323.89, `position_z` = 397.516, `orientation` = 2.32328 WHERE `guid` = 86173; -- Frost Ram -> Brown Ram
UPDATE creature SET `id1` = 12373, `position_x` = -5505.42, `position_y` = -1320.18, `position_z` = 397.516, `orientation` = 3.25541 WHERE `guid` = 86174;  -- Black Ram -> Gray Ram

-- New Creature Entries
DELETE FROM `creature` WHERE `guid` in (76265,86827,86828,86829,86830,86831,152333,152334,152335,152336,152337,152338,152339,97406,97407,97408,97431);
INSERT INTO `creature` (`guid`,`id1`,`id2`,`id3`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(76265,4772,0,0,0,0,0,1,1,1,-5523.24,-1333.6,398.555,2.68781,300,0,0,0,0,0,0,0,0,'',0), -- Ultham at night
(86827,846,0,0,0,0,0,1,1,0,-10084.3,1559.49,40.8883,3.00608,300,1,0,0,0,1,0,0,0,'',0), -- Leprithus Minion
(86828,846,0,0,0,0,0,1,1,0,-10082.4,1556.31,41.0149,2.17749,300,1,0,0,0,1,0,0,0,'',0), -- Leprithus Minion
(86829,846,0,0,0,0,0,1,1,0,-11281.5,1017.69,94.4474,5.30334,300,1,0,0,0,1,0,0,0,'',0), -- Leprithus Minion
(86830,846,0,0,0,0,0,1,1,0,-11275.7,1022.68,94.7905,5.70782,300,1,0,0,0,1,0,0,0,'',0), -- Leprithus Minion
(86831,846,0,0,0,0,0,1,1,0,-10988.2,1600.1,45.6427,5.37523,300,5,0,0,0,1,0,0,0,'',0), -- Rotten Ghouls
(152333,846,0,0,0,0,0,1,1,0,-10958.9,1603.63,47.8132,1.78282,300,5,0,0,0,1,0,0,0,'',0),
(152334,846,0,0,0,0,0,1,1,0,-10976.4,1610.5,46.0335,1.98,300,5,0,0,0,1,0,0,0,'',0),
(152335,846,0,0,0,0,0,1,1,0,-10990.2,1623.08,45.1017,4.4604,300,5,0,0,0,1,0,0,0,'',0),
(152336,846,0,0,0,0,0,1,1,0,-10962.3,1625.83,46.4382,3.24442,300,5,0,0,0,1,0,0,0,'',0),
(152337,846,0,0,0,0,0,1,1,0,-10015.2,1424.47,40.94,3.27601,300,5,0,0,0,1,0,0,0,'',0),
(152338,846,0,0,0,0,0,1,1,0,-10025.1,1419.18,41.218,2.72701,300,5,0,0,0,1,0,0,0,'',0),
(152339,846,0,0,0,0,0,1,1,0,-10025,1427.11,41.107,1.61175,300,5,0,0,0,1,0,0,0,'',0),
(97406,12374,0,0,0,0,0,1,1,0,-5499.52,-1322.37,397.516,0.224179,300,1,0,0,0,1,0,0,0,'',0), -- Rams in corral at night
(97407,14546,0,0,0,0,0,1,1,0,-5508.02,-1334.34,397.516,5.21587,300,1,0,0,0,1,0,0,0,'',0),
(97408,14547,0,0,0,0,0,1,1,0,-5497.96,-1332.61,397.516,0.488367,300,1,0,0,0,1,0,0,0,'',0),
(97431,14548,0,0,0,0,0,1,1,0,-5502.12,-1335.15,397.516,0.569738,300,1,0,0,0,1,0,0,0,'',0);

-- ---------------------------Eastvale Logging Camp Children Updates---------------------------------

-- Children Position Adjustment
UPDATE creature SET `wander_distance` = 8, `MovementType` = 1 WHERE `guid` IN (86156,86157,86158,86159,86354);
UPDATE creature SET `position_x` = -9511.99, `position_y` = -1272.53, `position_z` = 43.669, `orientation` = 5.56961 WHERE `guid` = 86354;  -- Eric
UPDATE creature SET `position_x` = -9507.03, `position_y` = -1275.85, `position_z` = 44.1562, `orientation` = 5.16513 WHERE `guid` = 86156; -- Jay
UPDATE creature SET `position_x` = -9511.31, `position_y` = -1285.64, `position_z` = 44.1448, `orientation` = 3.93122 WHERE `guid` = 86159;  -- Kevin

-- ------------------------------------Nocturnal (Pyrewood Village) Event----------------------------

-- Nocturnal Only Creatures
DELETE FROM `game_event_creature` WHERE `eventEntry` = 25 and `guid` in (76265,86173,86174,86831,152333,152334,152335,152336,152337,152338,152339,97406,97407,97408,97431);
INSERT INTO `game_event_creature` (`eventEntry`,`guid`) VALUES
(25,76265), -- Ultham Ironhorn Ram Trainer
(25,86173), -- Rams - Brown Ram in Corral
(25,86174), -- Rams - Gray Ram in Corral
(25,86831), -- Rotten Ghouls replace Fleshrippers/Smugglers in Westfall
(25,152333),
(25,152334),
(25,152335),
(25,152336),
(25,152337),
(25,152338),
(25,152339),
(25,97406), -- Rams in Corral
(25,97407), -- Swift Rams in Corral
(25,97408),
(25,97431);

DELETE FROM `game_event_creature` WHERE `eventEntry` = -25 and `guid` in (4147,4148,4149,4150,4154,4155,4156,52594,52595,52596,89879,90128,90279,90280);
INSERT INTO `game_event_creature` (`eventEntry`,`guid`) VALUES
(-25,4147), -- Rams out of Corral
(-25,4148),
(-25,4149),
(-25,4150), -- Ultham Ironhorn out of Corral
(-25,4154), -- More Rams out of Corral
(-25,4155),
(-25,4156),
(-25,52594), -- Fleshrippers replace Ghouls in Westfall
(-25,52595),
(-25,52596),
(-25,90279), 
(-25,90280),
(-25,89879), -- Defias Smugglers
(-25,90128);

-- -------------------------------------New Evening Event-------------------------------------------

DELETE FROM `game_event` WHERE `eventEntry` = 88;
INSERT INTO `game_event` (`eventEntry`,`start_time`,`end_time`,`occurence`,`length`,`holiday`,`holidayStage`,`description`,`world_event`,`announce`) VALUES
(88,'2016-10-28 18:00:00','2030-12-30 23:00:00',1440,720,0,0,'Evening',0,2);

-- Morning and Full Daytime Only Creatures/NPCs
DELETE FROM `game_event_creature` WHERE `eventEntry` = -88 and `guid` in (86158,86159,86157,86354,86156,79700,79702,79815,79816,79817,87092,87088,87090,87089,87082,87091,84028,87023,79720,79721,86596,89294,86597,79803,79804,79812,90439,90440,90443);
INSERT INTO `game_event_creature` (`eventEntry`,`guid`) VALUES
(-88,79700), -- Adam and Billy
(-88,79702),
(-88,79815), -- Justin Brandon Roman
(-88,79816),
(-88,79817),
(-88,87092), -- Miss Danna and students
(-88,87088),
(-88,87090),
(-88,87089),
(-88,87082),
(-88,87091),
(-88,84028),
(-88,87023),
(-88,79720), -- Donna and William
(-88,79721),
(-88,86596), -- Janey Suzanne and Lisan
(-88,89294),
(-88,86597),
(-88,79803), -- Orphans running around
(-88,79804),
(-88,79812),
(-88,90439), -- Karlee Chaddis, Paige Chaddis, and Gil
(-88,90440),
(-88,90443),
(-88,86158), -- Eastvale Logging Camp Children
(-88,86159),
(-88,86157),
(-88,86354),
(-88,86156);

-- -------------------------------------New Leprithus Event-------------------------------------------

DELETE FROM `creature_formations` WHERE `leaderGUID` in (134020,134021);
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(134020,86828,3,160,515,0,0),
(134020,86827,3,210,515,0,0),
(134020,134020,0,0,515,0,0),

(134021,86830,3,160,515,0,0),
(134021,86829,5,210,515,0,0),
(134021,134021,0,0,515,0,0);

DELETE FROM `creature` WHERE `guid` in (28458,134022,134023); -- Remove un-needed Leprithus creatures
UPDATE creature SET `wander_distance` = 0, `MovementType` = 0 WHERE `guid` = 134020;
UPDATE creature SET `position_x` = -11277.3, `position_y` = 1021.93, `position_z` = 94.7337, `orientation` = 5.18302, `wander_distance` = 0, `MovementType` = 2 WHERE `guid` = 134021; -- South Graveyard
UPDATE creature SET `position_x` = -10084.583, `position_y` = 1557.266, `position_z` = 40.848, `orientation` = 3.926646, `wander_distance` = 0, `MovementType` = 0 WHERE `guid` = 134020; -- North Graveyard

DELETE FROM `creature_addon` WHERE `guid` = 134021;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(134021,1340210,0,0,1,0,0,NULL);

DELETE FROM `game_event` WHERE `eventEntry` = 89;
INSERT INTO `game_event` (`eventEntry`,`start_time`,`end_time`,`occurence`,`length`,`holiday`,`holidayStage`,`description`,`world_event`,`announce`) VALUES
(89,'2016-10-28 20:00:00','2030-12-30 23:00:00',1440,600,0,0,'Leprithus',0,2);

DELETE FROM `game_event_creature` WHERE `eventEntry` = 89 and `guid` in (134020,134021,86827,86828,86829,86830);
INSERT INTO `game_event_creature` (`eventEntry`,`guid`) VALUES
(89,134020), -- Leprithus North Graveyard
(89,134021), -- Leprithus South Graveyard
(89,86827), -- Rotten Ghoul Minions of Leprithus
(89,86828),
(89,86829),
(89,86830);

DELETE FROM `pool_template` WHERE `entry` = 1004;
DELETE FROM `pool_creature` WHERE `guid` in (28458,134020,134021,134022,134023);

DELETE FROM `smart_scripts` WHERE `entryorguid` = 572 and `source_type` = 0 and `id` = 3;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(572,0,3,0,68,0,100,0,89,0,0,0,0,70,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Leprithus - On Game Event \'Leprithus\' Start - Respawn');

DELETE FROM `waypoint_data` WHERE `id` = 1340210;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(1340210,1,-11277.3,1021.93,94.7337,5.18302,0,0,0,100,0),
(1340210,2,-11257.1,988.193,83.3336,5.69163,0,0,0,100,0),
(1340210,3,-11244.4,962.304,83.269,5.05783,0,0,0,100,0),
(1340210,4,-11240.5,948.932,75.6219,5.30995,0,0,0,100,0),
(1340210,5,-11212.6,921.358,54.3906,5.10103,0,0,0,100,0),
(1340210,6,-11194.6,895.302,48.4349,5.39948,0,0,0,100,0),
(1340210,7,-11172.6,876.756,41.3173,6.03015,0,0,0,100,0),
(1340210,8,-11146.3,866.02,38.4824,5.63196,0,0,0,100,0),
(1340210,9,-11126,851.423,40.3828,5.64138,0,0,0,100,0),
(1340210,10,-11086.8,834.864,40.7715,0.273191,0,0,0,100,0),
(1340210,11,-11059.5,846.814,38.6569,6.25714,0,0,0,100,0),
(1340210,12,-11039.1,843.255,36.3932,5.48039,0,0,0,100,0),
(1340210,13,-11012.4,812.002,37.4404,5.31939,0,0,0,100,0),
(1340210,14,-11002.7,788.433,36.4366,5.5715,0,0,0,100,0),
(1340210,15,-10982.7,761.666,43.9919,5.11518,0,0,0,100,0),
(1340210,16,-10962.6,736.809,46.4806,6.21378,0,0,0,100,0),
(1340210,17,-10913.9,722.066,42.727,5.94361,0,0,0,100,0),
(1340210,18,-10867.737,699.722,30.941,0,0,0,0,100,0),
(1340210,19,-10866.525,667.412,30.936,4.8221,60000,0,0,100,0),
(1340210,20,-10869.88,687.586,30.891,0,0,0,0,100,0),
(1340210,21,-10844.104,724.133,33.873,0,0,0,0,100,0),
(1340210,22,-10844.079,750.508,34.406,1.5668,5000,0,0,100,0),
(1340210,23,-10895.047,742.711,34.959,0,0,0,0,100,0),
(1340210,24,-10962.6,736.809,46.4806,6.21378,0,0,0,100,0),
(1340210,25,-10982.7,761.666,43.9919,5.11518,0,0,0,100,0),
(1340210,26,-11002.7,788.433,36.4366,5.5715,0,0,0,100,0),
(1340210,27,-11012.4,812.002,37.4404,5.31939,0,0,0,100,0),
(1340210,28,-11039.1,843.255,36.3932,5.48039,0,0,0,100,0),
(1340210,29,-11059.5,846.814,38.6569,6.25714,0,0,0,100,0),
(1340210,30,-11086.8,834.864,40.7715,0.273191,0,0,0,100,0),
(1340210,31,-11126,851.423,40.3828,5.64138,0,0,0,100,0),
(1340210,32,-11146.3,866.02,38.4824,5.63196,0,0,0,100,0),
(1340210,33,-11172.6,876.756,41.3173,6.03015,0,0,0,100,0),
(1340210,34,-11194.6,895.302,48.4349,5.39948,0,0,0,100,0),
(1340210,35,-11212.6,921.358,54.3906,5.10103,0,0,0,100,0),
(1340210,36,-11240.5,948.932,75.6219,5.30995,0,0,0,100,0),
(1340210,37,-11244.4,962.304,83.269,5.05783,0,0,0,100,0),
(1340210,38,-11257.1,988.193,83.3336,5.69163,10000,0,0,100,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_27_22' WHERE sql_rev = '1648344440179668500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
