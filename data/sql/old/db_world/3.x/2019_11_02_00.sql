-- DB update 2019_11_01_00 -> 2019_11_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_11_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_11_01_00 2019_11_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1571392526938836693'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1571392526938836693');

-- Icefist waypoint movement
UPDATE `creature` SET `MovementType` = 2, `spawndist` = 0 WHERE `guid` = 107388;
UPDATE `creature_addon` SET `path_id` = 2700400 WHERE `guid` = 107388;

-- Icefist / Chilltusk: Yell on aggro
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (27004,27005) AND `id` = 2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(27004,0,2,0,4,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Icefist - On Aggro - Say Line 0'),
(27005,0,2,0,4,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chilltusk - On Aggro - Say Line 0');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 3 AND `SourceEntry` IN (27004,27005) AND `SourceId` = 0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(22,3,27004,0,0,9,0,12145,0,0,0,0,0,'','Icefist yell (SAI) needs quest ''Canyon Chase'''),
(22,3,27005,0,0,9,0,12143,0,0,0,0,0,'','Chilltusk yell (SAI) needs quest ''Canyon Chase''');

-- Icefist Forager: Run to Icefist; summon further Icefist Foragers and follow each other
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27123;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 27123;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` IN (2712300,2712301);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(27123,0,0,0,54,0,50,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Icefist Forager - On Just Summoned - Say Line 0'),
(27123,0,1,2,54,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Icefist Forager - On Just Summoned - Set Active On'),
(27123,0,2,3,61,0,100,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Icefist Forager - Linked - Set React State ''Passive'''),
(27123,0,3,0,61,0,100,0,0,0,0,0,0,29,1,0,0,0,0,0,9,27123,1,50,0,0,0,0,0,'Icefist Forager - Linked - Follow ''Icefist Forager'''),
(27123,0,4,0,38,0,100,0,1,1,0,0,0,53,1,2712300,0,0,0,0,1,0,0,0,0,0,0,0,0,'Icefist Forager - On Data Set 1 1 - Start Waypoint Movement'),
(27123,0,5,0,40,0,100,0,22,2712300,0,0,0,80,2712300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Icefist Forager - On Waypoint 22 Reached - Call Action List'),
(27123,0,6,0,40,0,100,0,40,2712300,0,0,0,80,2712301,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Icefist Forager - On Waypoint 40 Reached - Call Action List'),

(2712300,9,0,0,0,0,100,0,500,500,0,0,0,12,27123,3,27000,0,0,0,8,0,0,0,0,4195.21,1011.01,59.8479,0,'Icefist Forager - On Script - Summon Creature ''Icefist Forager'''),
(2712300,9,1,0,0,0,100,0,1000,1000,0,0,0,12,27123,3,26000,0,0,0,8,0,0,0,0,4188.77,1015.76,61.3748,0,'Icefist Forager - On Script - Summon Creature ''Icefist Forager'''),
(2712301,9,0,0,0,0,100,0,500,500,0,0,0,12,27123,3,19000,0,0,0,8,0,0,0,0,4128.45,1118.02,58.9496,0,'Icefist Forager - On Script - Summon Creature ''Icefist Forager'''),
(2712301,9,1,0,0,0,100,0,1000,1000,0,0,0,12,27123,3,18000,0,0,0,8,0,0,0,0,4126,1126.8,58.6246,0,'Icefist Forager - On Script - Summon Creature ''Icefist Forager''');

-- Chilltusk Forager: Run to Chilltusk; summon further Chilltusk Foragers and follow each other
UPDATE `creature_template` SET `speed_run` = 2.14286, `AIName` = 'SmartAI' WHERE `entry` = 27171;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 27171;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` IN (2717100,2717101);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(27171,0,0,0,54,0,50,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chilltusk Forager - On Just Summoned - Say Line 0'),
(27171,0,1,2,54,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chilltusk Forager - On Just Summoned - Set Active On'),
(27171,0,2,3,61,0,100,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chilltusk Forager - Linked - Set React State ''Passive'''),
(27171,0,3,0,61,0,100,0,0,0,0,0,0,29,1,0,0,0,0,0,9,27171,1,50,0,0,0,0,0,'Chilltusk Forager - Linked - Follow ''Chilltusk Forager'''),
(27171,0,4,0,38,0,100,0,1,1,0,0,0,53,1,2717100,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chilltusk Forager - On Data Set 1 1 - Start Waypoint Movement'),
(27171,0,5,0,40,0,100,0,36,2717100,0,0,0,80,2717100,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chilltusk Forager - On Waypoint 22 Reached - Call Action List'),
(27171,0,6,0,40,0,100,0,52,2717100,0,0,0,80,2717101,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Chilltusk Forager - On Waypoint 40 Reached - Call Action List'),

(2717100,9,0,0,0,0,100,0,500,500,0,0,0,12,27171,3,27000,0,0,0,8,0,0,0,0,4663.38,-192.147,78.6202,0,'Chilltusk Forager - On Script - Summon Creature ''Chilltusk Forager'''),
(2717100,9,1,0,0,0,100,0,1000,1000,0,0,0,12,27171,3,26000,0,0,0,8,0,0,0,0,4636.91,-175.839,76.8374,0,'Chilltusk Forager - On Script - Summon Creature ''Chilltusk Forager'''),
(2717101,9,0,0,0,0,100,0,500,500,0,0,0,12,27171,3,17000,0,0,0,8,0,0,0,0,4591.49,-305.193,83.6176,0,'Chilltusk Forager - On Script - Summon Creature ''Chilltusk Forager'''),
(2717101,9,1,0,0,0,100,0,1000,1000,0,0,0,12,27171,3,16000,0,0,0,8,0,0,0,0,4588.68,-309.771,84.6019,0,'Chilltusk Forager - On Script - Summon Creature ''Chilltusk Forager''');

-- Kontokanis: Summon Icefist Foragers
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26979;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 26979;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 2697900;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(26979,0,0,0,19,0,100,0,12145,0,0,0,0,80,2697900,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Kontokanis - On Quest ''Canyon Chase'' Accepted - Call Action List'),

(2697900,9,0,0,0,0,100,0,500,500,0,0,0,12,27123,3,39000,0,0,0,8,0,0,0,0,4329.02,980.721,91.1397,0,'Kontokanis - On Script - Summon Creature ''Icefist Forager'''),
(2697900,9,1,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,9,27123,1,50,0,0,0,0,0,'Kontokanis - On Script - Set Data 1 1 (Icefist Forager)'),
(2697900,9,2,0,0,0,100,0,1000,1000,0,0,0,12,27123,3,38000,0,0,0,8,0,0,0,0,4328.75,977.255,90.4251,0,'Kontokanis - On Script - Summon Creature ''Icefist Forager''');

-- Duane: Summon Chilltusk Foragers
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 26978;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 26978;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 2697800;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(26978,0,0,0,19,0,100,0,12143,0,0,0,0,80,2697800,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Duane - On Quest ''Canyon Chase'' Accepted - Call Action List'),

(2697800,9,0,0,0,0,100,0,500,500,0,0,0,12,27171,3,46000,0,0,0,8,0,0,0,0,4554.83,15.5639,69.1968,0,'Duane - On Script - Summon Creature ''Chilltusk Forager'''),
(2697800,9,1,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,9,27171,1,50,0,0,0,0,0,'Duane - On Script - Set Data 1 1 (Chilltusk Forager)'),
(2697800,9,2,0,0,0,100,0,1000,1000,0,0,0,12,27171,3,45000,0,0,0,8,0,0,0,0,4554.83,15.5639,69.1968,0,'Duane - On Script - Summon Creature ''Chilltusk Forager''');

-- Creature texts for Icefist, Chilltusk, Icefist Forager and Chilltusk Forager
DELETE FROM `creature_text` WHERE `CreatureId` IN (27004,27005,27123,27171);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(27004,0,0,'Hah! My slaves brought back a real meal this time!',14,0,100,0,0,0,26162,0,'Icefist'),
(27005,0,0,'Hah! My slaves brought back a real meal this time!',14,0,100,0,0,0,26188,0,'Chilltusk'),
(27123,0,0,'Run away!',12,0,100,0,0,0,26179,0,'Icefist Forager'),
(27123,0,1,'I don''t wanna die!',12,0,100,0,0,0,26180,0,'Icefist Forager'),
(27123,0,2,'Big guy will save us!',12,0,100,0,0,0,26181,0,'Icefist Forager'),
(27123,0,3,'Ahh!!!',12,0,100,0,0,0,26182,0,'Icefist Forager'),
(27123,0,4,'They''re everywhere!',12,0,100,0,0,0,26183,0,'Icefist Forager'),
(27171,0,0,'Run away!',12,0,100,0,0,0,26179,0,'Chilltusk Forager'),
(27171,0,1,'I don''t wanna die!',12,0,100,0,0,0,26180,0,'Chilltusk Forager'),
(27171,0,2,'Big guy will save us!',12,0,100,0,0,0,26181,0,'Chilltusk Forager'),
(27171,0,3,'Ahh!!!',12,0,100,0,0,0,26182,0,'Chilltusk Forager'),
(27171,0,4,'They''re everywhere!',12,0,100,0,0,0,26183,0,'Chilltusk Forager');

-- Waypoints for Icefist Forager
DELETE FROM `waypoints` WHERE `entry` = 2712300;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`)
VALUES
(2712300,1,4329.57,982.507,91.5652,'Icefist Forager'),
(2712300,2,4326.12,981.914,90.95,''),
(2712300,3,4319.46,981.222,84.7116,''),
(2712300,4,4314.1,982.313,83.5768,''),
(2712300,5,4307.14,986.06,81.3415,''),
(2712300,6,4304.23,992.166,78.9614,''),
(2712300,7,4302.37,1000.1,75.3801,''),
(2712300,8,4301.02,1008.03,71.326,''),
(2712300,9,4299.87,1015.29,67.8692,''),
(2712300,10,4296.85,1022.88,64.9376,''),
(2712300,11,4291.7,1028.73,62.6756,''),
(2712300,12,4285.12,1033.9,60.4301,''),
(2712300,13,4277.21,1037.57,58.9712,''),
(2712300,14,4269.11,1039.11,58.6038,''),
(2712300,15,4260.37,1039.3,58.6038,''),
(2712300,16,4251.51,1038.02,58.6059,''),
(2712300,17,4243.53,1035.14,58.6047,''),
(2712300,18,4235.13,1029.88,58.6036,''),
(2712300,19,4226.5,1024.32,58.6042,''),
(2712300,20,4217.43,1020.78,58.6038,''),
(2712300,21,4207.15,1020.52,58.7366,''),
(2712300,22,4197.49,1024.2,59.0955,''),
(2712300,23,4189.21,1029.81,59.1588,''),
(2712300,24,4184.92,1034.41,60.9238,''),
(2712300,25,4181.48,1039.54,62.8408,''),
(2712300,26,4178.14,1046.08,61.5611,''),
(2712300,27,4176.65,1049.88,61.638,''),
(2712300,28,4175.45,1054.15,61.3005,''),
(2712300,29,4174.16,1058.75,60.973,''),
(2712300,30,4173.03,1062.8,61.1375,''),
(2712300,31,4171.36,1067.9,60.3635,''),
(2712300,32,4169.54,1072.45,59.5869,''),
(2712300,33,4166.39,1077.49,58.7253,''),
(2712300,34,4162.72,1083.31,58.6106,''),
(2712300,35,4159.5,1089.65,58.6042,''),
(2712300,36,4156.41,1097.08,58.607,''),
(2712300,37,4153.7,1105.15,58.6177,''),
(2712300,38,4149.26,1112.01,58.6055,''),
(2712300,39,4142.07,1119.5,58.604,''),
(2712300,40,4138.07,1125.36,58.604,''),
(2712300,41,4136.3,1133.18,58.604,''),
(2712300,42,4136.02,1141.32,58.604,''),
(2712300,43,4136.1,1150.54,58.6323,''),
(2712300,44,4136.74,1159.96,58.704,''),
(2712300,45,4138.79,1169.41,58.6039,''),
(2712300,46,4142.2,1178.71,58.6117,''),
(2712300,47,4145.04,1189.16,58.604,''),
(2712300,48,4146.9,1198.78,58.6046,''),
(2712300,49,4148.2,1209.31,58.6038,''),
(2712300,50,4148.31,1219.45,58.6038,''),
(2712300,51,4147.21,1228.77,58.6433,''),
(2712300,52,4142.38,1235.18,59.7402,''),
(2712300,53,4136.1,1240.19,61.8044,''),
(2712300,54,4129.03,1244.01,63.1273,''),
(2712300,55,4122.35,1246.78,62.0909,''),
(2712300,56,4115.52,1248.21,60.6138,''),
(2712300,57,4108.4,1248.25,57.782,''),
(2712300,58,4101.3,1248.64,56.9812,''),
(2712300,59,4093.02,1248.54,57.0848,''),
(2712300,60,4084.06,1247.94,57.3119,''),
(2712300,61,4077.81,1246.61,58.4554,''),
(2712300,62,4070.6,1244.66,59.9453,''),
(2712300,63,4062.63,1242.01,60.9094,''),
(2712300,64,4054.81,1238.93,60.8014,''),
(2712300,65,4046.63,1235.52,59.2468,''),
(2712300,66,4037.67,1232.16,56.8641,''),
(2712300,67,4028.46,1228.81,55.6524,''),
(2712300,68,4022.45,1226.57,55.625,''),
(2712300,69,4014.88,1223.83,55.4938,''),
(2712300,70,4006.65,1221.21,55.5059,''),
(2712300,71,3997.72,1218.98,55.7807,''),
(2712300,72,3987.48,1218.23,56.4639,'');

-- Waypoints for Chilltusk Forager
DELETE FROM `waypoints` WHERE `entry` = 2717100;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`)
VALUES
(2717100,1,4557.27,15.5183,69.1891,'Chilltusk Forager'),
(2717100,2,4560.34,9.75374,67.3004,''),
(2717100,3,4565.52,2.7378,67.1821,''),
(2717100,4,4572.48,-2.54618,68.4027,''),
(2717100,5,4578.86,-6.85738,69.3388,''),
(2717100,6,4585.94,-10.9296,69.6996,''),
(2717100,7,4594.51,-14.9046,69.7048,''),
(2717100,8,4602.61,-18.8091,69.6355,''),
(2717100,9,4611.34,-22.7196,69.4459,''),
(2717100,10,4619.29,-25.7951,69.2441,''),
(2717100,11,4628.08,-28.9227,69.1948,''),
(2717100,12,4636.71,-32.4664,70.1679,''),
(2717100,13,4644.73,-36.9869,70.0754,''),
(2717100,14,4652.07,-42.1597,68.6755,''),
(2717100,15,4659.27,-47.7131,67.6558,''),
(2717100,16,4665.88,-53.628,68.5529,''),
(2717100,17,4672.71,-59.9945,69.0265,''),
(2717100,18,4679.51,-66.878,68.6836,''),
(2717100,19,4685.95,-74.4216,68.7836,''),
(2717100,20,4689.87,-81.2803,70.0001,''),
(2717100,21,4688.58,-87.0006,71.2571,''),
(2717100,22,4684.47,-92.0315,71.844,''),
(2717100,23,4678.69,-96.9296,71.5379,''),
(2717100,24,4674.77,-103.493,73.1387,''),
(2717100,25,4675.64,-109.843,74.5781,''),
(2717100,26,4677.5,-115.738,75.4031,''),
(2717100,27,4678.86,-120.932,74.9768,''),
(2717100,28,4679.22,-128.481,73.8392,''),
(2717100,29,4678.63,-135.92,72.8321,''),
(2717100,30,4677.41,-143.045,73.1227,''),
(2717100,31,4675.11,-149.859,72.9902,''),
(2717100,32,4670.89,-156.283,73.1142,''),
(2717100,33,4666.1,-162.613,73.4022,''),
(2717100,34,4661.02,-169.007,73.9531,''),
(2717100,35,4655.68,-175.931,74.9361,''),
(2717100,36,4652.27,-182.946,75.5948,''),
(2717100,37,4649.75,-191.05,75.8577,''),
(2717100,38,4648.27,-197.891,76.7077,''),
(2717100,39,4647.1,-206.441,77.6749,''),
(2717100,40,4645.48,-214.555,77.5441,''),
(2717100,41,4643.12,-223.104,78.0612,''),
(2717100,42,4640.46,-231.679,78.8965,''),
(2717100,43,4637.56,-241.039,80.08,''),
(2717100,44,4634.21,-250.739,81.7782,''),
(2717100,45,4630.85,-259.685,82.9359,''),
(2717100,46,4627.63,-268.691,82.2517,''),
(2717100,47,4624.46,-278.457,81.543,''),
(2717100,48,4620.73,-287.498,81.3849,''),
(2717100,49,4615.94,-296.178,81.9145,''),
(2717100,50,4609.96,-304.654,82.0043,''),
(2717100,51,4604.27,-312.766,82.2026,''),
(2717100,52,4599.54,-321.338,82.5639,''),
(2717100,53,4595.89,-331.533,82.9468,''),
(2717100,54,4592.8,-341.443,83.2384,''),
(2717100,55,4591.34,-352.422,83.8433,''),
(2717100,56,4589.39,-362.615,84.076,''),
(2717100,57,4586.27,-372.845,83.7386,''),
(2717100,58,4581.74,-382.062,83.3873,''),
(2717100,59,4576.54,-390.633,83.2152,''),
(2717100,60,4570.59,-399.84,83.0784,''),
(2717100,61,4562.94,-405.849,82.5896,''),
(2717100,62,4554.21,-411.039,81.6998,''),
(2717100,63,4544.41,-416.435,81.1152,''),
(2717100,64,4534.87,-420.221,81.1077,''),
(2717100,65,4524.54,-423.545,80.7849,''),
(2717100,66,4513.66,-427.051,80.2432,''),
(2717100,67,4502.91,-430.605,79.9293,''),
(2717100,68,4492.56,-434.194,79.2592,''),
(2717100,69,4482.01,-437.961,78.5641,''),
(2717100,70,4471.47,-441.754,78.3501,''),
(2717100,71,4464.14,-445.927,78.3186,''),
(2717100,72,4459.8,-453.681,79.5557,''),
(2717100,73,4458.18,-462.511,80.6825,''),
(2717100,74,4456.44,-470.358,81.3727,''),
(2717100,75,4450.61,-476.071,83.909,''),
(2717100,76,4445.03,-479.462,86.2938,''),
(2717100,77,4439.44,-483.495,87.3736,''),
(2717100,78,4432.89,-488.558,86.1981,''),
(2717100,79,4427.68,-492.509,84.9365,'');

-- Waypoints for Icefist
DELETE FROM `waypoint_data` WHERE `id` = 2700400;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(2700400,1,4092.9,1248.45,57.0979,0,0,0,0,100,0),
(2700400,2,4099.77,1249.77,57.1511,0,0,0,0,100,0),
(2700400,3,4106.94,1251.36,58.226,0,0,0,0,100,0),
(2700400,4,4113.32,1252.07,61.53,0,0,0,0,100,0),
(2700400,5,4118.42,1252.58,63.7147,0,0,0,0,100,0),
(2700400,6,4124.24,1253.05,66.3462,0,0,0,0,100,0),
(2700400,7,4118.13,1252.14,63.3562,0,0,0,0,100,0),
(2700400,8,4111.47,1250.9,60.173,0,0,0,0,100,0),
(2700400,9,4105.37,1249.87,57.5133,0,0,0,0,100,0),
(2700400,10,4099.16,1248.82,57.1543,0,0,0,0,100,0),
(2700400,11,4092.58,1247.86,57.1452,0,0,0,0,100,0),
(2700400,12,4087.38,1247.11,57.182,0,0,0,0,100,0),
(2700400,13,4081.21,1246.82,57.5886,0,0,0,0,100,0),
(2700400,14,4074.94,1245.48,59.0856,0,0,0,0,100,0),
(2700400,15,4069.5,1244.14,60.1133,0,0,0,0,100,0),
(2700400,16,4064.46,1242.64,60.8721,0,0,0,0,100,0),
(2700400,17,4058.51,1240.27,61.1122,0,0,0,0,100,0),
(2700400,18,4052.29,1237.91,60.3015,0,0,0,0,100,0),
(2700400,19,4045.86,1235.46,59.0972,0,0,0,0,100,0),
(2700400,20,4039.77,1233.45,57.1813,0,0,0,0,100,0),
(2700400,21,4033.51,1231.19,56.0797,0,0,0,0,100,0),
(2700400,22,4027.02,1228.91,55.6409,0,0,0,0,100,0),
(2700400,23,4021.69,1226.85,55.623,0,0,0,0,100,0),
(2700400,24,4029.13,1229.63,55.6573,0,0,0,0,100,0),
(2700400,25,4035.91,1232.14,56.4725,0,0,0,0,100,0),
(2700400,26,4042.8,1234.7,58.0304,0,0,0,0,100,0),
(2700400,27,4050.03,1237.36,59.8516,0,0,0,0,100,0),
(2700400,28,4057.24,1239.7,61.0242,0,0,0,0,100,0),
(2700400,29,4064.07,1242.05,60.7711,0,0,0,0,100,0),
(2700400,30,4070.91,1244.39,59.7917,0,0,0,0,100,0),
(2700400,31,4076.74,1246.07,58.6959,0,0,0,0,100,0),
(2700400,32,4084.51,1247.71,57.2739,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
