-- DB update 2022_03_27_19 -> 2022_03_27_20
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_03_27_19';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_03_27_19 2022_03_27_20 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648089119541675100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648089119541675100');

/* Fixes/Changes: Reginald Windosr/Adam and Billy/Extra Guard/Justin Brandon and Roman/Miss Danna/Donna and William/Janey Suzanne and Lisan/
Orphanage/Karlee Chaddis, Paige, Gil, and Fizzles/Lil' Timmy/Sewer Beast/Underwater Construction Worker/Defias Prisoner */

-- ----------------------------------------Reginald Windsor----------------------------------------------------------------------

-- Reginald is dead in WOTLK
DELETE FROM `creature` WHERE `guid` = 86900;
DELETE FROM `creature_addon` WHERE `guid` = 86900;
DELETE FROM `waypoint_data` WHERE `id` = 869000;

-- Refurbished Steam Tank Fix -- Removing Reginald's creature table entry breaks model 25289 for the tank
UPDATE `creature_template` SET `modelid1` = 25341, `modelid2` = 0 WHERE `entry` = 29144;

-- ----------------------------------------End Reginald Windsor------------------------------------------------------------------
-- ----------------------------------------Adam and Billy------------------------------------------------------------------------

DELETE FROM `creature` WHERE `guid` in (120700,120702); -- Remove duplicate Adam and Billy creatures

DELETE FROM `creature_addon` WHERE `guid` in (79700,79702,120700,120702);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(79700,0,0,0,1,0,0,NULL),
(79702,0,0,0,1,0,0,NULL);

UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` in (1366,1367);

DELETE FROM `smart_scripts` WHERE `entryorguid` in (1366,1367,136600,136601,136602,136700,136701);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(1366,0,0,1,1,0,100,1,15000,15000,0,0,0,53,0,1366,1,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - OOC (No Repeat) - Start Waypoint'),
(1366,0,1,0,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - Linked - Set Data 1 0 \'Billy\''),
(1366,0,2,0,40,0,100,0,1,1366,0,0,0,80,136600,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - On Waypoint 1 Reached - Run Script'),
(1366,0,3,0,40,0,100,0,20,1366,0,0,0,45,1,10,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Waypoint 20 Reached - Set Data 1 10 \'Billy\''),
(1366,0,4,0,40,0,100,0,22,1366,0,0,0,80,136601,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - On Waypoint 22 Reached - Run Script'),
(1366,0,5,0,40,0,100,0,37,1366,0,0,0,45,1,10,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Waypoint 37 Reached - Set Data 1 10 \'Billy\''),
(1366,0,6,0,40,0,100,0,39,1366,0,0,0,80,136602,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - On Waypoint 39 Reached - Run Script'),
(1366,0,7,0,40,0,100,0,113,1366,0,0,0,45,1,10,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Waypoint 113 Reached - Set Data 1 10 \'Billy\''),
(1366,0,8,0,38,0,100,0,1,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - On Data Set 1 1 - Say Random 0'),

(1367,0,0,0,38,0,100,0,1,0,0,0,0,29,0,330,0,0,0,0,10,79702,1366,0,0,0,0,0,0,'Billy - On Data Set 1 0 - Set Follow'),
(1367,0,1,0,38,0,100,0,1,2,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,-8746.148,534.447,96.338,0.942478,'Billy - On Data Set 1 2 - Move to POS'),
(1367,0,2,0,38,0,100,0,1,4,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0.942478,'Billy - On Data Set 1 4 - Set Orientation'),
(1367,0,3,0,38,0,100,0,1,3,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,-8793.934,771.825,96.338,1.6493,'Billy - On Data Set 1 3 - Move to POS'),
(1367,0,4,0,38,0,100,0,1,5,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,1.6493,'Billy - On Data Set 1 5 - Set Orientation'),
(1367,0,5,0,38,0,100,0,1,6,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,-8842.04,956.97,96.338,5.40947,'Billy - On Data Set 1 6 - Move to POS'),
(1367,0,6,0,38,0,100,0,1,7,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,5.40947,'Billy - On Data Set 1 7 - Set Orientation'),
(1367,0,7,0,38,0,100,0,1,8,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Billy - On Data Set 1 8 - Set Phase 1'),
(1367,0,8,0,38,0,100,0,1,9,0,0,0,22,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Billy - On Data Set 1 9 - Set Phase 0'),
(1367,0,9,0,38,0,100,0,1,10,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Billy - On Data Set 1 10 - Say Line 1'),
(1367,0,10,0,1,0,100,0,30000,30000,90000,160000,0,80,136700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Billy - OOC - Run Script'),
(1367,0,11,0,1,1,20,0,8000,8000,90000,150000,0,80,136701,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Billy - OOC - Run Script (Phase 1)'),

-- Billy talk without the boot story and are there any fish dialogue
(136700,9,0,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Billy - On Script - Say Random 0'),
(136700,9,1,0,0,0,100,0,8000,12000,0,0,0,45,1,1,0,0,0,0,10,79702,1366,0,0,0,0,0,0,'Billy - On Script - Set Data 1 1 \'Adam\''),
(136700,9,2,0,0,0,100,0,8000,8000,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Billy - On Script - Set Run Off (Pause)'),

-- Billy talk about him catching an old boot can say it only when he is at a dock
(136701,9,0,0,0,0,100,0,0,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Billy - On Script - Say Line 2'),
(136701,9,1,0,0,0,100,0,11000,11000,0,0,0,45,1,1,0,0,0,0,10,79702,1366,0,0,0,0,0,0,'Billy - On Script - Set Data 1 1 \'Adam\''),
(136701,9,2,0,0,0,100,0,8000,8000,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Billy - On Script - Set Run Off (Pause)'),

-- Starting Dock
(136600,9,0,0,0,0,100,0,0,0,0,0,0,54,2300000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - On Script - Pause Waypoint'),
(136600,9,1,0,0,0,100,0,0,0,0,0,0,45,1,8,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 8 \'Billy\''),
(136600,9,2,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,1.01889,'Adam - On Script - Set Orientation'),
(136600,9,3,0,0,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 2 \'Billy\''),
(136600,9,4,0,0,0,100,0,3000,3000,0,0,0,45,1,4,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 4 \'Billy\''),
(136600,9,5,0,0,0,100,0,1800000,2280000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - On Script - Say Line 1'),
(136600,9,6,0,0,0,100,0,2000,2000,0,0,0,65,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - On Script - Resume Waypoint'),
(136600,9,7,0,0,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 0 \'Billy\''),
(136600,9,8,0,0,0,100,0,0,0,0,0,0,45,1,9,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 9 \'Billy\''),

-- Second Dock
(136601,9,0,0,0,0,100,0,0,0,0,0,0,54,2300000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - On Script - Pause Waypoint'),
(136601,9,1,0,0,0,100,0,0,0,0,0,0,45,1,8,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 8 \'Billy\''),
(136601,9,2,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,1.68,'Adam - On Script - Set Orientation'),
(136601,9,3,0,0,0,100,0,0,0,0,0,0,45,1,3,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 3 \'Billy\''),
(136601,9,4,0,0,0,100,0,3000,3000,0,0,0,45,1,5,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 5 \'Billy\''),
(136601,9,5,0,0,0,100,0,1800000,2280000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - On Script - Say Line 1'),
(136601,9,6,0,0,0,100,0,2000,2000,0,0,0,65,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - On Script - Resume Waypoint'),
(136601,9,7,0,0,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 0 \'Billy\''),
(136601,9,8,0,0,0,100,0,0,0,0,0,0,45,1,9,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 9 \'Billy\''),

-- Third Dock
(136602,9,0,0,0,0,100,0,0,0,0,0,0,54,2300000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - On Script - Pause Waypoint'),
(136602,9,1,0,0,0,100,0,0,0,0,0,0,45,1,8,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 8 \'Billy\''),
(136602,9,2,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,5.4067,'Adam - On Script - Set Orientation'),
(136602,9,3,0,0,0,100,0,0,0,0,0,0,45,1,6,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 6 \'Billy\''),
(136602,9,4,0,0,0,100,0,3000,3000,0,0,0,45,1,7,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 7 \'Billy\''),
(136602,9,5,0,0,0,100,0,1800000,2280000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - On Script - Say Line 1'),
(136602,9,6,0,0,0,100,0,2000,2000,0,0,0,65,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Adam - On Script - Resume Waypoint'),
(136602,9,7,0,0,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 0 \'Billy\''),
(136602,9,8,0,0,0,100,0,0,0,0,0,0,45,1,9,0,0,0,0,10,79700,1367,0,0,0,0,0,0,'Adam - On Script - Set Data 1 9 \'Billy\'');

DELETE FROM `creature_text` WHERE `CreatureID` in (1367,1366);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(1367,0,0,'I heard that there are these huge fish that can walk on land to hunt, and eat people!',12,7,100,1,0,0,139,0,'Billy - Talk'),
(1367,0,1,'My daddy says that in the ocean, there are fish so big they could swallow a whole ship.',12,7,100,1,0,0,133,0,'Billy - Talk'),
(1367,0,2,'I heard a story about this golden fish, and if you caught it you would get three wishes!',12,7,100,1,0,0,141,0,'Billy - Talk'),
(1367,0,3,'And one time, at camp, I caught a fish that was bigger than I am!!',12,7,100,1,0,0,140,0,'Billy - Talk'),
(1367,0,4,'I caught a big one last week, it had three eyes!',12,7,100,1,0,0,132,0,'Billy - Talk'),
(1367,0,5,'My daddy can catch more fish than your daddy!',12,7,100,1,0,0,134,0,'Billy - Talk'),
(1367,1,0,'Think there are any fish in here?',12,7,100,1,0,0,131,0,'Billy - Talk'),
(1367,2,0,'Look! Look! I caught something! Aww....it\'s just a stinky ol\' boot.',12,7,100,1,0,0,135,0,'Billy - Talk'),

(1366,0,0,'You\'re making that up.',12,7,100,1,0,0,144,0,'Adam - Talk'),
(1366,0,1,'Shhh! You\'re scaring the fish away.',12,7,100,1,0,0,143,0,'Adam - Talk'),
(1366,0,2,'Really?',12,7,100,1,0,0,147,0,'Adam - Talk'),
(1366,0,3,'Nuh uh.',12,7,100,1,0,0,136,0,'Adam - Talk'),
(1366,0,4,'Maybe we should go to the bridge and fish.',12,7,100,1,0,0,146,0,'Adam - Talk'),
(1366,0,5,'Liar!',12,7,100,1,0,0,138,0,'Adam - Talk'),
(1366,0,6,'If you fished as well as you talked the ocean wouldn\'t have any fish left.',12,7,100,1,0,0,142,0,'Adam - Talk'),
(1366,0,7,'If you could catch a fish big enough for your mouth we\'d never be hungry again.',12,7,100,1,0,0,145,0,'Adam - Talk'),
(1366,1,0,'C\'mon, let\'s try somewhere else.',12,7,100,1,0,0,1086,0,'Adam - Talk');

DELETE FROM `waypoints` WHERE `entry` = 1366;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(1366,1,-8747.28,535.483,96.338,0,0,'Adam'),
(1366,2,-8753.812,529.035,96.339,0,0,'Adam'),
(1366,3,-8763.095,535.144,97.396,0,0,'Adam'),
(1366,4,-8762.947,547.032,97.396,0,0,'Adam'),
(1366,5,-8752.085,560.404,97.398,0,0,'Adam'),
(1366,6,-8746.01,564.915,97.4001,0,0,'Adam'),
(1366,7,-8729.92,581.294,97.6775,0,0,'Adam'),
(1366,8,-8719.58,591.033,98.4713,0,0,'Adam'),
(1366,9,-8712.04,594.001,98.6079,0,0,'Adam'),
(1366,10,-8707.26,600.676,98.9982,0,0,'Adam'),
(1366,11,-8704.46,616.407,100.215,0,0,'Adam'),
(1366,12,-8705.6,629.078,100.477,0,0,'Adam'),
(1366,13,-8708.67,645.787,99.9994,0,0,'Adam'),
(1366,14,-8716.46,666.585,98.8681,0,0,'Adam'),
(1366,15,-8724.09,676.482,98.6317,0,0,'Adam'),
(1366,16,-8728.54,684.167,98.7324,0,0,'Adam'),
(1366,17,-8733.47,695.151,98.723,0,0,'Adam'),
(1366,18,-8743.6,709.876,98.2678,0,0,'Adam'),
(1366,19,-8762.525,732.975,98.74,0,0,'Adam'),
(1366,20,-8781.188,743.14,99.253,0,0,'Adam'),
(1366,21,-8794.655,752.188,97.432,0,0,'Adam'),
(1366,22,-8795.867,771.807,96.338,0,0,'Adam'),
(1366,23,-8794.655,752.188,97.432,0,0,'Adam'),
(1366,24,-8798.565,744.748,97.620,0,0,'Adam'),
(1366,25,-8845.016,722.505,97.193,0,0,'Adam'),
(1366,26,-8851.771,733.43,99.925,0,0,'Adam'),
(1366,27,-8860.571,747.201,99.95,0,0,'Adam'),
(1366,28,-8869.517,760.847,96.742,0,0,'Adam'),
(1366,29,-8863.425,769.865,96.77,0,0,'Adam'),
(1366,30,-8829.957,794.505,96.72,0,0,'Adam'),
(1366,31,-8820.471,843.081,98.95,0,0,'Adam'),
(1366,32,-8829.243,895.12,98.128,0,0,'Adam'),
(1366,33,-8850.94,928.807,102.017,0,0,'Adam'),
(1366,34,-8843.91,933.491,104.097,0,0,'Adam'), 
(1366,35,-8816.65,953.442,100.743,0,0,'Adam'),
(1366,36,-8828.869,972.542,98.555,0,0,'Adam'),
(1366,37,-8838.333,972.233,97.846,0,0,'Adam'),
(1366,38,-8846.433,965.744,96.338,0,0,'Adam'),
(1366,39,-8840.67,958.553,96.338,0,0,'Adam'),
(1366,40,-8846.433,965.744,96.338,0,0,'Adam'),
(1366,41,-8838.333,972.233,97.846,0,0,'Adam'),
(1366,42,-8828.869,972.542,98.555,0,0,'Adam'),
(1366,43,-8816.65,953.442,100.743,0,0,'Adam'),
(1366,44,-8767.52,895.508,101.256,0,0,'Adam'),
(1366,45,-8753.45,892,101.896,0,0,'Adam'),
(1366,46,-8740.3,893.588,101.375,0,0,'Adam'),
(1366,47,-8726.64,877.216,102.712,0,0,'Adam'),
(1366,48,-8711.78,859.391,96.9622,0,0,'Adam'),
(1366,49,-8709.601,858.748,96.993,0,0,'Adam'),
(1366,50,-8712.475,853.661,96.86,0,0,'Adam'),
(1366,51,-8718.147,846.137,96.43,0,0,'Adam'),
(1366,52,-8727.39,831.585,96.2625,0,0,'Adam'),
(1366,53,-8726.35,812.836,97.0629,0,0,'Adam'),
(1366,54,-8717.01,798.201,97.1855,0,0,'Adam'),
(1366,55,-8717.02,792.913,97.1566,0,0,'Adam'),
(1366,56,-8728.06,775.333,98.0319,0,0,'Adam'),
(1366,57,-8733.64,764.22,97.9501,0,0,'Adam'),
(1366,58,-8722.22,747.857,98.0333,0,0,'Adam'),
(1366,59,-8711.9,732.893,97.8112,0,0,'Adam'),
(1366,60,-8698.59,714.268,97.0168,0,0,'Adam'),
(1366,61,-8691.63,704.794,97.1053,0,0,'Adam'),
(1366,62,-8683.28,695.683,97.8567,0,0,'Adam'),
(1366,63,-8671.771,683.623,98.876,0,0,'Adam'),
(1366,64,-8669.76,678.045,99.3877,0,0,'Adam'),
(1366,65,-8662.717,666.586,100.377,0,0,'Adam'),
(1366,66,-8654.11,660.351,100.865,0,0,'Adam'),
(1366,67,-8639.43,656.589,101.082,0,0,'Adam'),
(1366,68,-8631.83,655.639,100.63,0,0,'Adam'),
(1366,69,-8620.59,654.378,99.1946,0,0,'Adam'),
(1366,70,-8597.947,657.882,98.377,0,0,'Adam'),
(1366,71,-8593.052,656.774,98.221,0,0,'Adam'),
(1366,72,-8578.838,662.088,97.607,0,0,'Adam'),
(1366,73,-8561.86,674.735,97.0168,0,0,'Adam'),
(1366,74,-8556.46,676.784,97.0168,0,0,'Adam'),
(1366,75,-8542.79,686.774,97.6239,0,0,'Adam'),
(1366,76,-8532.769,688.506,97.661,0,0,'Adam'),
(1366,77,-8528.005,682.699,99.567,0,0,'Adam'),
(1366,78,-8522.24,670.618,102.794,0,0,'Adam'),
(1366,79,-8519.8,666.4,102.615,0,0,'Adam'),
(1366,80,-8512.94,656.648,100.901,0,0,'Adam'),
(1366,81,-8513.15,648.714,100.292,0,0,'Adam'),
(1366,82,-8518.18,642.361,100.092,0,0,'Adam'),
(1366,83,-8538.04,630.723,100.404,0,0,'Adam'),
(1366,84,-8554.03,617.81,102.053,0,0,'Adam'),
(1366,85,-8564.5,613.48,102.435,0,0,'Adam'),
(1366,86,-8576.12,601.799,103.26,0,0,'Adam'),
(1366,87,-8582.44,589.572,103.691,0,0,'Adam'),
(1366,88,-8586.68,575.605,102.985,0,0,'Adam'),
(1366,89,-8585.96,565.941,102.26,0,0,'Adam'),
(1366,90,-8578.9,545.988,101.779,0,0,'Adam'),
(1366,91,-8581.73,541.012,102.09,0,0,'Adam'),
(1366,92,-8590.09,533.912,104.76,0,0,'Adam'),
(1366,93,-8598.32,527.164,106.399,0,0,'Adam'),
(1366,94,-8605.67,520.882,105.748,0,0,'Adam'),
(1366,95,-8610.26,515.735,103.79,0,0,'Adam'),
(1366,96,-8613.43,514.684,103.401,0,0,'Adam'),
(1366,97,-8618.8,518.794,103.068,0,0,'Adam'),
(1366,98,-8635.17,535.152,99.9833,0,0,'Adam'),
(1366,99,-8647.39,546.721,97.8568,0,0,'Adam'),
(1366,100,-8655.78,552.938,96.9435,0,0,'Adam'),
(1366,101,-8671.86,552.874,97.2037,0,0,'Adam'),
(1366,102,-8679.66,549.654,97.5031,0,0,'Adam'),
(1366,103,-8689.63,540.268,97.828,0,0,'Adam'),
(1366,104,-8698.98,530.295,97.7173,0,0,'Adam'),
(1366,105,-8712.64,520.242,97.2398,0,0,'Adam'),
(1366,106,-8715.24,521.571,97.4039,0,0,'Adam'),
(1366,107,-8720.77,528.729,99.1496,0,0,'Adam'),
(1366,108,-8729.84,539.87,101.105,0,0,'Adam'),
(1366,109,-8735.95,547.101,100.845,0,0,'Adam'),
(1366,110,-8745.79,557.737,97.7107,0,0,'Adam'),
(1366,111,-8755.938,556.376,97.396,0,0,'Adam'),
(1366,112,-8762.947,547.032,97.396,0,0,'Adam'),
(1366,113,-8763.095,535.144,97.396,0,0,'Adam'),
(1366,114,-8753.812,529.035,96.339,0,0,'Adam');

-- ---------------------------------------------End Adam and Billy----------------------------------------------------------
-- -----------------------------------------Canals Extra Guard Cleanup------------------------------------------------------

-- Duplicate Solidier just randomly moving around another stationary guard
DELETE FROM `creature` WHERE `guid` = 120682;
DELETE FROM `creature_addon` WHERE `guid` = 120682;

-- -----------------------------------------End Canals Extra Guard Cleanup---------------------------------------------------
-- -------------------------------------------Justin, Brandon, and Roman-----------------------------------------------------

UPDATE `creature` SET `MovementType` = 0 WHERE `guid` in (79815,79816,79817);
UPDATE `creature_addon` SET `path_id` = 0,`bytes2` = 1 WHERE `guid` in (79815,79816,79817);
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` in (1368,1370,1371);

DELETE FROM `smart_scripts` WHERE `entryorguid` in (1368,1370,1371,136800,137000,137001);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(1368,0,0,0,38,0,100,0,1,0,0,0,0,29,0,75,0,0,0,0,10,79817,1370,0,0,0,0,0,0,'Justin - On Data Set 1 0 - Set Follow'),
(1368,0,1,0,38,0,100,0,1,2,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,-8582.03,633.634,96.3386,5.0381,'Justin - On Data Set 1 2 - Move to POS'),
(1368,0,2,0,38,0,100,0,1,4,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,5.0381,'Justin - On Data Set 1 4 - Set Orientation'),
(1368,0,3,0,38,0,100,0,1,3,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,-8675.673,909.057,96.338,3.768,'Justin - On Data Set 1 3 - Move to POS'),
(1368,0,4,0,38,0,100,0,1,5,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,3.768,'Justin - On Data Set 1 5 - Set Orientation'),
(1368,0,5,0,1,0,100,0,30000,30000,80000,160000,0,80,136800,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justin - OOC - Run Script'),

(1371,0,0,0,38,0,100,0,1,0,0,0,0,29,0,285,0,0,0,0,10,79817,1370,0,0,0,0,0,0,'Roman - On Data Set 1 0 - Set Follow'),
(1371,0,1,0,38,0,100,0,1,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Roman - On Data Set 1 1 - Say Random 0'),
(1371,0,2,0,38,0,100,0,1,2,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,-8583.88,633.127,96.3386,5.0381,'Roman - On Data Set 1 2 - Move to POS'),
(1371,0,3,0,38,0,100,0,1,4,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,5.0381,'Roman - On Data Set 1 4 - Set Orientation'),
(1371,0,4,0,38,0,100,0,1,3,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,-8673.55,912.143,96.338,2.282,'Roman - On Data Set 1 3 - Move to POS'),
(1371,0,5,0,38,0,100,0,1,5,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,2.282,'Roman - On Data Set 1 5 - Set Orientation'),

(1370,0,0,1,1,0,100,1,25000,25000,0,0,0,53,0,1370,1,0,0,0,1,0,0,0,0,0,0,0,0,'Brandon - OOC (No Repeat) - Start Waypoint'),
(1370,0,1,2,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,79815,1368,0,0,0,0,0,0,'Brandon - Linked - Set Data 1 0 \'Justin\''),
(1370,0,2,0,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,79816,1371,0,0,0,0,0,0,'Brandon - Linked - Set Data 1 0 \'Roman\''),
(1370,0,3,0,40,0,100,0,1,1370,0,0,0,80,137000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Brandon - On Waypoint 1 Reached - Run Script'),
(1370,0,4,0,40,0,100,0,32,1370,0,0,0,80,137001,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Brandon - On Waypoint 32 Reached - Run Script'),
(1370,0,5,0,38,0,100,0,1,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Brandon - On Data Set 1 1 - Say Random 0'),

(136800,9,0,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Justin - On Script - Say Random 0'),
(136800,9,1,0,0,0,100,0,4000,8000,0,0,0,45,1,1,0,0,0,0,10,79817,1370,0,0,0,0,0,0,'Justin - On Script - Set Data 1 1 \'Brandon\''),
(136800,9,2,0,0,0,100,0,6000,9000,0,0,0,45,1,1,0,0,0,0,10,79816,1371,0,0,0,0,0,0,'Justin - On Script - Set Data 1 1 \'Roman\''),

-- Starting Dock
(137000,9,0,0,0,0,100,0,0,0,0,0,0,54,4520000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Brandon - On Script - Pause Waypoint'),
(137000,9,1,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0.2961,'Brandon - On Script - Set Orientation'),
(137000,9,2,0,0,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,10,79816,1371,0,0,0,0,0,0,'Brandon - On Script - Set Data 1 2 \'Roman\''),
(137000,9,3,0,0,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,10,79815,1368,0,0,0,0,0,0,'Brandon - On Script - Set Data 1 2 \'Justin\''),
(137000,9,4,0,0,0,100,0,3000,3000,0,0,0,45,1,4,0,0,0,0,10,79816,1371,0,0,0,0,0,0,'Brandon - On Script - Set Data 1 4 \'Roman\''),
(137000,9,5,0,0,0,100,0,0,0,0,0,0,45,1,4,0,0,0,0,10,79815,1368,0,0,0,0,0,0,'Brandon - On Script - Set Data 1 4 \'Justin\''),
(137000,9,6,0,0,0,100,0,3600000,4500000,0,0,0,65,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Brandon - On Script - Resume Waypoint'),
(137000,9,7,0,0,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,79815,1368,0,0,0,0,0,0,'Brandon - On Script - Set Data 1 0 \'Justin\''),
(137000,9,8,0,0,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,79816,1371,0,0,0,0,0,0,'Brandon - On Script - Set Data 1 0 \'Roman\''),

-- Second Dock
(137001,9,0,0,0,0,100,0,0,0,0,0,0,54,4520000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Brandon - On Script - Pause Waypoint'),
(137001,9,1,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,2.282,'Brandon - On Script - Set Orientation'),
(137001,9,2,0,0,0,100,0,0,0,0,0,0,45,1,3,0,0,0,0,10,79816,1371,0,0,0,0,0,0,'Brandon - On Script - Set Data 1 3 \'Roman\''),
(137001,9,3,0,0,0,100,0,0,0,0,0,0,45,1,3,0,0,0,0,10,79815,1368,0,0,0,0,0,0,'Brandon - On Script - Set Data 1 3 \'Justin\''),
(137001,9,4,0,0,0,100,0,3000,3000,0,0,0,45,1,5,0,0,0,0,10,79816,1371,0,0,0,0,0,0,'Brandon - On Script - Set Data 1 5 \'Roman\''),
(137001,9,5,0,0,0,100,0,0,0,0,0,0,45,1,5,0,0,0,0,10,79815,1368,0,0,0,0,0,0,'Brandon - On Script - Set Data 1 5 \'Justin\''),
(137001,9,6,0,0,0,100,0,3600000,4500000,0,0,0,65,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Brandon - On Script - Resume Waypoint'),
(137001,9,7,0,0,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,79815,1368,0,0,0,0,0,0,'Brandon - On Script - Set Data 1 0 \'Justin\''),
(137001,9,8,0,0,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,79816,1371,0,0,0,0,0,0,'Brandon - On Script - Set Data 1 0 \'Roman\'');

DELETE FROM `creature_text` WHERE `CreatureID` in (1368,1370,1371);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(1368,0,0,'And so the knights stood before the charging Horde and held their ground as a thousand berserk orcs came through the valley.',12,7,100,1,0,0,150,0,'Justin - Talk'),
(1368,0,1,'And that\'s how Lothar killed thirty six orcs with his bare hands!',12,7,100,1,0,0,149,0,'Justin - Talk'),
(1368,0,2,'And then the rabbit just bit his head off... I swear.',12,7,100,1,0,0,155,0,'Justin - Talk'),
(1368,0,3,'They say he can turn into a raven sometimes.',12,7,100,1,0,0,151,0,'Justin - Talk'),
(1368,0,4,'You know there are crocolisks in the Canals. They were brought from the swamp as pets, but got thrown in the canals.',12,7,100,1,0,0,156,0,'Justin - Talk'),
(1368,0,5,'You know why orc eyes glow red? It\'s because they drink blood!',12,7,100,1,0,0,152,0,'Justin - Talk'),
(1368,0,6,'I swear, people have actually seen them. Pandaren really do exist!',12,7,100,1,0,0,154,0,'Justin - Talk'),
(1368,0,7,'There is no spoon.',12,7,100,1,0,0,153,0,'Justin - Talk'),

(1370,0,0,'My father says that\'s just a story.',12,7,100,1,0,0,168,0,'Brandon - Talk'),
(1370,0,1,'Can you imagine?',12,7,100,1,0,0,169,0,'Brandon - Talk'),
(1370,0,2,'Oh c\'mon, that\'s not true.',12,7,100,1,0,0,166,0,'Brandon - Talk'),
(1370,0,3,'Oh yeah, I heard about that.',12,7,100,1,0,0,158,0,'Brandon - Talk'),
(1370,0,4,'Really?',12,7,100,1,0,0,147,0,'Brandon - Talk'),
(1370,0,5,'Sounds kinda like one of Billy\'s fish stories to me.',12,7,100,1,0,0,170,0,'Brandon - Talk'),
(1370,0,6,'That\'s neat.',12,7,100,1,0,0,167,0,'Brandon - Talk'),
(1370,0,7,'Wow.',12,7,100,1,0,0,157,0,'Brandon - Talk'),

(1371,0,0,'Eww... that\'s not a fish!',12,7,100,1,0,0,173,0,'Roman - Talk'),
(1371,0,1,'I don\'t think there\'s any fish in these canals.',12,7,100,1,0,0,177,0,'Roman - Talk'),
(1371,0,2,'I got worm guts on my shoes.',12,7,100,1,0,0,174,0,'Roman - Talk'),
(1371,0,3,'I hope that was a fish!',12,7,100,1,0,0,176,0,'Roman - Talk'),
(1371,0,4,'I think I see something.',12,7,100,1,0,0,172,0,'Roman - Talk'),
(1371,0,5,'Something smells funny.',12,7,100,1,0,0,175,0,'Roman - Talk'),
(1371,0,6,'Worm goes on the hook, hook goes in the water. Fish is in the water, our fish.',12,7,100,1,0,0,178,0,'Roman - Talk'),
(1371,0,7,'I thought I heard something.',12,7,100,1,0,0,171,0,'Roman - Talk');

DELETE FROM `waypoint_scripts` WHERE `id` >= 285 and `id` <= 307;
DELETE FROM `waypoint_data` WHERE `id` in (798150,798160,798170);

DELETE FROM `waypoints` WHERE `entry` = 1370;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(1370,1,-8580.51,635.108,96.3386,0,0,'Brandon'),
(1370,2,-8582.773,635.572,96.338,0,0,'Brandon'),
(1370,3,-8593.052,656.774,98.221,0,0,'Brandon'),
(1370,4,-8597.947,657.882,98.377,0,0,'Brandon'),
(1370,5,-8620.59,654.378,99.1946,0,0,'Brandon'),
(1370,6,-8631.83,655.639,100.63,0,0,'Brandon'),
(1370,7,-8639.43,656.589,101.082,0,0,'Brandon'),
(1370,8,-8654.11,660.351,100.865,0,0,'Brandon'),
(1370,9,-8662.717,666.586,100.377,0,0,'Brandon'),
(1370,10,-8669.76,678.045,99.3877,0,0,'Brandon'),
(1370,11,-8671.771,683.623,98.876,0,0,'Brandon'),
(1370,12,-8683.28,695.683,97.8567,0,0,'Brandon'),
(1370,13,-8691.63,704.794,97.1053,0,0,'Brandon'),
(1370,14,-8698.59,714.268,97.0168,0,0,'Brandon'),
(1370,15,-8711.9,732.893,97.8112,0,0,'Brandon'),
(1370,16,-8722.22,747.857,98.0333,0,0,'Brandon'),
(1370,17,-8733.64,764.22,97.9501,0,0,'Brandon'),
(1370,18,-8728.06,775.333,98.0319,0,0,'Brandon'),
(1370,19,-8717.02,792.913,97.1566,0,0,'Brandon'),
(1370,20,-8717.01,798.201,97.1855,0,0,'Brandon'),
(1370,21,-8726.35,812.836,97.0629,0,0,'Brandon'),
(1370,22,-8727.39,831.585,96.2625,0,0,'Brandon'),
(1370,23,-8718.147,846.137,96.43,0,0,'Brandon'),
(1370,24,-8712.475,853.661,96.86,0,0,'Brandon'),
(1370,25,-8709.601,858.748,96.993,0,0,'Brandon'),
(1370,26,-8705.86,860.48,97.0867,0,0,'Brandon'),
(1370,27,-8692.29,871.475,97.0226,0,0,'Brandon'),
(1370,28,-8682.01,878.208,97.0173,0,0,'Brandon'),
(1370,29,-8658.599,900.099,97.549,0,0,'Brandon'),
(1370,30,-8663.312,909.099,96.958,0,0,'Brandon'),
(1370,31,-8667.227,911.786,96.338,0,0,'Brandon'),
(1370,32,-8674.834,911.015,96.338,0,0,'Brandon'),
(1370,33,-8667.227,911.786,96.338,0,0,'Brandon'),
(1370,34,-8663.312,909.099,96.958,0,0,'Brandon'),
(1370,35,-8658.599,900.099,97.549,0,0,'Brandon'),
(1370,36,-8682.01,878.208,97.0173,0,0,'Brandon'),
(1370,37,-8692.29,871.475,97.0226,0,0,'Brandon'),
(1370,38,-8705.86,860.48,97.0867,0,0,'Brandon'),
(1370,39,-8709.601,858.748,96.993,0,0,'Brandon'),
(1370,40,-8712.475,853.661,96.86,0,0,'Brandon'),
(1370,41,-8718.147,846.137,96.43,0,0,'Brandon'),
(1370,42,-8727.39,831.585,96.2625,0,0,'Brandon'),
(1370,43,-8726.35,812.836,97.0629,0,0,'Brandon'),
(1370,44,-8717.01,798.201,97.1855,0,0,'Brandon'),
(1370,45,-8717.02,792.913,97.1566,0,0,'Brandon'),
(1370,46,-8728.06,775.333,98.0319,0,0,'Brandon'),
(1370,47,-8733.64,764.22,97.9501,0,0,'Brandon'),
(1370,48,-8722.22,747.857,98.0333,0,0,'Brandon'),
(1370,49,-8711.9,732.893,97.8112,0,0,'Brandon'),
(1370,50,-8698.59,714.268,97.0168,0,0,'Brandon'),
(1370,51,-8691.63,704.794,97.1053,0,0,'Brandon'),
(1370,52,-8683.28,695.683,97.8567,0,0,'Brandon'),
(1370,53,-8671.771,683.623,98.876,0,0,'Brandon'),
(1370,54,-8669.76,678.045,99.3877,0,0,'Brandon'),
(1370,55,-8662.717,666.586,100.377,0,0,'Brandon'),
(1370,56,-8654.11,660.351,100.865,0,0,'Brandon'),
(1370,57,-8639.43,656.589,101.082,0,0,'Brandon'),
(1370,58,-8631.83,655.639,100.63,0,0,'Brandon'),
(1370,59,-8620.59,654.378,99.1946,0,0,'Brandon'),
(1370,60,-8597.947,657.882,98.377,0,0,'Brandon'),
(1370,61,-8593.052,656.774,98.221,0,0,'Brandon'),
(1370,62,-8582.773,635.572,96.338,0,0,'Brandon');

-- --------------------------------------------------End Justin, Brandon, and Roman------------------------------------------------
-- ---------------------------------------------------Miss Danna and students------------------------------------------------------

DELETE FROM `creature` WHERE `guid` = 87023;
INSERT INTO `creature` (`guid`,`id1`,`id2`,`id3`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(87023,3509,0,0,0,0,0,1,1,0,-8838.52,670.28,98.0987,0.553153,300,0,0,1,0,0,0,0,0,'',0);

UPDATE `creature` SET `MovementType` = 0 WHERE `guid` in (87092,87088,87090,87089,87082,87091,84028);
UPDATE `creature_addon` SET `path_id` = 0 WHERE `guid` in (87092,87088,87090,87089,87082,87091,84028);

DELETE FROM `waypoint_data` WHERE `id` in (870920,870880,870900,870890,870820,870910,840280);
DELETE FROM `waypoint_scripts` WHERE `id` >= 315 and `id` <= 328 or `id` in (413,414,415);

UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` in (3505,3507,3508,3509,3510,3511,3512,3513);

DELETE FROM `creature_text` WHERE `CreatureID` in (3511,3512,3513);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(3511,0,0,'Why do we have to learn this stuff anyway?',12,7,100,1,0,0,1130,0,'Steven - Talk'),
(3511,0,1,'It\'s better than the drawings in the history tomes.',12,7,100,1,0,0,1131,0,'Steven - Talk'),
(3511,0,2,'Teacher, when are we gonna see the sparkly Mage Tower?',12,7,100,1,0,0,1133,0,'Steven - Talk'),
(3511,0,3,'Teacher, I have to pee!',12,7,100,1,0,0,1136,0,'Steven - Talk'),
(3511,0,4,'Teacher are there night elves in Stormwind? I\'ve never seen a night elf before.',12,7,100,1,0,0,1138,0,'Steven - Talk'),
(3511,0,5,'Teacher, he keeps poking me!',12,7,100,1,0,0,1139,0,'Steven - Talk'),
(3511,0,6,'I heard there are still orcs buried underneath it.',12,7,100,1,0,0,1134,0,'Steven - Talk'),
(3511,0,7,'I wanna see the dragon skeleton in the great library.',12,7,100,1,0,0,1132,0,'Steven - Talk'),
(3512,0,0,'Is it true that the paladins train here?',12,7,100,1,0,0,1153,0,'Jimmy - Talk'),
(3513,0,0,'Here we have the Cathedral of Light, the center of spiritual enlightenment here in Stormwind.',12,7,100,1,0,0,1129,0,'Miss Danna - Talk'),
(3513,1,0,'Here we have Stormwind Keep. Built upon the ruins of Stormwind Castle, which was destroyed by the Horde in the first Great War.',12,7,100,1,0,0,1140,0,'Miss Danna - Talk'),
(3513,2,0,'Yes, that is true. Paladins and priests alike train their skills and research great truths behind the walls of the Cathedral.',12,7,100,1,0,0,1154,0,'Miss Danna - Talk'),
(3513,3,0,'Children if you would please follow me, we will now be going to see the keep where King Varian Wrynn himself sits on his throne.',12,7,100,1,0,0,1155,0,'Miss Danna - Talk'),
(3513,4,0,'When the Horde was shattered, men returned here and began to rebuild the once great city as a testament to our own survival.',12,7,100,1,0,0,1161,0,'Miss Danna - Talk'),
(3513,5,0,'Yes, well...let\'s head on to the monument dedicated to the heroes of the two Great Wars, the Valley of Heroes. Follow me.',12,7,100,1,0,0,1162,0,'Miss Danna - Talk'),
(3513,6,0,'Isn\'t it amazing, children? All who enter the city must walk beneath the watchful eyes of the greatest heroes of our lands.',12,7,100,1,0,0,1163,0,'Miss Danna - Talk'),
(3513,7,0,'Breathtaking. Children, when we return to the school, you will each give an oral report on one of these legendary people.',12,7,100,1,0,0,1165,0,'Miss Danna - Talk'),
(3513,8,0,'Now, take another long look before we make our way to the Holy District and the great Cathedral of Light.',12,7,100,1,0,0,1166,0,'Miss Danna - Talk');

DELETE FROM `smart_scripts` WHERE `entryorguid` in (3505,3507,3508,3509,3510,3511,3512,3513,351300,351301,351302);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3505,0,0,0,38,0,100,0,1,0,0,0,0,29,1,240,0,0,0,0,10,84028,3513,0,0,0,0,0,0,'Pat - On Data Set 1 0 - Set Follow'),
(3507,0,0,0,38,0,100,0,1,0,0,0,0,29,1,220,0,0,0,0,10,84028,3513,0,0,0,0,0,0,'Andi - On Data Set 1 0 - Set Follow'),
(3508,0,0,0,38,0,100,0,1,0,0,0,0,29,1,160,0,0,0,0,10,84028,3513,0,0,0,0,0,0,'Mikey - On Data Set 1 0 - Set Follow'),
(3509,0,0,0,38,0,100,0,1,0,0,0,0,29,1,120,0,0,0,0,10,84028,3513,0,0,0,0,0,0,'Geoff - On Data Set 1 0 - Set Follow'),
(3510,0,0,0,38,0,100,0,1,0,0,0,0,29,1,200,0,0,0,0,10,84028,3513,0,0,0,0,0,0,'Twain - On Data Set 1 0 - Set Follow'),
(3511,0,0,0,38,0,100,0,1,0,0,0,0,29,1,180,0,0,0,0,10,84028,3513,0,0,0,0,0,0,'Steven - On Data Set 1 0 - Set Follow'),
(3511,0,1,0,38,0,100,0,1,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Steven - On Data Set 1 1 - Say 0 0'),
(3512,0,0,0,38,0,100,0,1,0,0,0,0,29,1,140,0,0,0,0,10,84028,3513,0,0,0,0,0,0,'Jimmy - On Data Set 1 0 - Set Follow'),
(3512,0,1,0,38,0,100,0,1,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Jimmy - On Data Set 1 1 - Say 0 0'),
(3513,0,0,0,40,0,100,0,21,3513,0,0,0,80,351300,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Waypoint 21 Reached - Run Script'),
(3513,0,1,0,40,0,100,0,37,3513,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Waypoint 37 Reached - Say 1 0'),
(3513,0,2,0,40,0,100,0,38,3513,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Waypoint 38 Reached - Say 4 0'),
(3513,0,3,0,40,0,100,0,39,3513,0,0,0,80,351301,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Waypoint 39 Reached - Run Script'),
(3513,0,4,0,40,0,100,0,53,3513,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Waypoint 53 Reached - Say 6 0'),
(3513,0,5,0,40,0,100,0,54,3513,0,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Waypoint 54 Reached - Say 7 0'),
(3513,0,6,0,40,0,100,0,55,3513,0,0,0,80,351302,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Waypoint 55 Reached - Run Script'),
(3513,0,7,8,1,0,100,1,25000,25000,0,0,0,53,0,3513,1,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - OOC (No Repeat) - Start Waypoint'),
(3513,0,8,9,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,87082,3512,0,0,0,0,0,0,'Miss Danna - Linked - Set Data 1 0 \'Jimmy\''),
(3513,0,9,10,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,87089,3511,0,0,0,0,0,0,'Miss Danna - Linked - Set Data 1 0 \'Steven\''),
(3513,0,10,11,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,87090,3510,0,0,0,0,0,0,'Miss Danna - Linked - Set Data 1 0 \'Twain\''),
(3513,0,11,12,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,87023,3509,0,0,0,0,0,0,'Miss Danna - Linked - Set Data 1 0 \'Geoff\''),
(3513,0,12,13,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,87088,3508,0,0,0,0,0,0,'Miss Danna - Linked - Set Data 1 0 \'Mikey\''),
(3513,0,13,14,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,87091,3507,0,0,0,0,0,0,'Miss Danna - Linked - Set Data 1 0 \'Andi\''),
(3513,0,14,0,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,87092,3505,0,0,0,0,0,0,'Miss Danna - Linked - Set Data 1 0 \'Pat\''), 
(3513,0,15,0,40,0,100,0,11,3513,0,0,0,54,1500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Waypoint 11 Reached - Pause Waypoint'),

(351300,9,0,0,0,0,100,0,0,0,0,0,0,54,44000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Script - Pause Waypoint'),
(351300,9,1,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0.663,'Miss Danna - On Script - Set Orientation'),
(351300,9,2,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Script - Say 0 0'),
(351300,9,3,0,0,0,100,0,11000,11000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Script - Emote Talk'),
(351300,9,4,0,0,0,100,0,10000,10000,0,0,0,45,1,1,0,0,0,0,10,87082,3512,0,0,0,0,0,0,'Miss Danna - On Script - Set Data 1 1 \'Jimmy\''),
(351300,9,5,0,0,0,100,0,8000,8000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Script - Say 2 0'),
(351300,9,6,0,0,0,100,0,11000,11000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Script - Say 3 0'),

(351301,9,0,0,0,0,100,0,0,0,0,0,0,54,45000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Script - Pause Waypoint'),
(351301,9,1,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,5.433,'Miss Danna - On Script - Set Orientation'),
(351301,9,2,0,0,0,100,0,0,0,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Script - Emote Talk'),
(351301,9,3,0,0,0,100,0,16000,16000,0,0,0,45,1,1,0,0,0,0,10,87089,3511,0,0,0,0,0,0,'Miss Danna - On Script - Set Data 1 1 \'Steven\''),
(351301,9,4,0,0,0,100,0,10000,10000,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Script - Say 5 0'),
(351301,9,5,0,0,0,100,0,18000,18000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Script - Emote Talk'),

(351302,9,0,0,0,0,100,0,0,0,0,0,0,54,19000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Script - Pause Waypoint'),
(351302,9,1,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,3.589,'Miss Danna - On Script - Set Orientation'),
(351302,9,2,0,0,0,100,0,0,0,0,0,0,1,8,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Script - Say 8 0'),
(351302,9,3,0,0,0,100,0,9000,9000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Script - Emote Talk'),
(351302,9,4,0,0,0,100,0,8000,8000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Miss Danna - On Script - Emote Talk');

-- Miss Danna Waypoints
DELETE FROM `waypoints` WHERE `entry` = 3513;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(3513,1,-8824.65,677.359,97.6724,0,0,'Miss Danna'),
(3513,2,-8844.06,721.315,97.3127,0,0,'Miss Danna'),
(3513,3,-8794.66,745.738,97.8358,0,0,'Miss Danna'),
(3513,4,-8765.71,737.339,98.9571,0,0,'Miss Danna'),
(3513,5,-8744.1,711.742,98.1589,0,0,'Miss Danna'),
(3513,6,-8736.13,717.57,101.035,0,0,'Miss Danna'),
(3513,7,-8714.09,735.726,97.8129,0,0,'Miss Danna'),
(3513,8,-8698.83,714.642,97.0168,0,0,'Miss Danna'),
(3513,9,-8657.55,748.029,96.6892,0,0,'Miss Danna'),
(3513,10,-8658.68,767.899,96.6925,0,0,'Miss Danna'),
(3513,11,-8634.49,787.411,96.6512,0,0,'Miss Danna'),
(3513,12,-8662.17,821.239,96.6386,0,0,'Miss Danna'),
(3513,13,-8653.53,826.735,96.5285,0,0,'Miss Danna'),
(3513,14,-8608.62,861.791,96.6798,0,0,'Miss Danna'),
(3513,15,-8600.32,850.058,96.6911,0,0,'Miss Danna'),
(3513,16,-8616.11,837.915,96.7385,0,0,'Miss Danna'),
(3513,17,-8637.49,816.942,96.6393,0,0,'Miss Danna'),
(3513,18,-8629.56,781.904,96.6514,0,0,'Miss Danna'),
(3513,19,-8623.89,774.974,96.6518,0,0,'Miss Danna'),
(3513,20,-8623.29,775.529,96.6512,0,0,'Miss Danna'),  
(3513,21,-8621.904,776.592,96.6512,0,0,'Miss Danna'),
(3513,22,-8594.06,757.656,96.6537,0,0,'Miss Danna'),
(3513,23,-8578.89,737.947,96.6719,0,0,'Miss Danna'),
(3513,24,-8596.77,717.424,96.6572,0,0,'Miss Danna'),
(3513,25,-8562.25,673.301,97.0168,0,0,'Miss Danna'),
(3513,26,-8536.52,690.402,97.6668,0,0,'Miss Danna'),
(3513,27,-8532.456,688.688,97.657,0,0,'Miss Danna'),
(3513,28,-8528.005,682.699,99.567,0,0,'Miss Danna'),
(3513,29,-8522.24,670.618,102.794,0,0,'Miss Danna'),
(3513,30,-8508.77,650.151,100.292,0,0,'Miss Danna'),
(3513,31,-8557.68,615.023,102.352,0,0,'Miss Danna'),
(3513,32,-8568.14,613.353,102.382,0,0,'Miss Danna'),
(3513,33,-8581.15,593.053,103.562,0,0,'Miss Danna'),
(3513,34,-8585.6,562.85,101.927,0,0,'Miss Danna'),
(3513,35,-8573.45,540.833,101.757,0,0,'Miss Danna'),
(3513,36,-8535.68,488.072,101.081,0,0,'Miss Danna'),
(3513,37,-8538.69,479.398,102.572,0,0,'Miss Danna'),
(3513,38,-8548.29,467.484,104.514,0,0,'Miss Danna'),
(3513,39,-8544.94,464.148,104.414,0,0,'Miss Danna'),
(3513,40,-8564.17,466.02,104.524,0,0,'Miss Danna'),
(3513,41,-8583.28,480.99,104.214,0,0,'Miss Danna'),
(3513,42,-8606.08,504.922,103.722,0,0,'Miss Danna'),
(3513,43,-8633.15,534.792,100.272,0,0,'Miss Danna'),
(3513,44,-8655.92,552.797,96.9437,0,0,'Miss Danna'),
(3513,45,-8671.53,554.116,97.1805,0,0,'Miss Danna'),
(3513,46,-8713.5,519.816,97.1699,0,0,'Miss Danna'),
(3513,47,-8731.17,541.957,101.124,0,0,'Miss Danna'),
(3513,48,-8749.98,561.766,97.3988,0,0,'Miss Danna'),
(3513,49,-8736.87,574.559,97.3823,0,0,'Miss Danna'),
(3513,50,-8770.53,609.421,97.2463,0,0,'Miss Danna'),
(3513,51,-8795.9,587.923,97.3792,0,0,'Miss Danna'),
(3513,52,-8827.8,624.687,93.8494,0,0,'Miss Danna'),
(3513,53,-8928.94,540.519,94.3157,0,0,'Miss Danna'),
(3513,54,-8907.67,509.135,93.8416,0,0,'Miss Danna'),
(3513,55,-8933.21,488.088,93.8429,0,0,'Miss Danna'),
(3513,56,-8911.65,505.615,93.8585,0,0,'Miss Danna'),
(3513,57,-8925.24,543.334,94.268,0,0,'Miss Danna'),
(3513,58,-8833.34,620.843,93.4683,0,0,'Miss Danna'),
(3513,59,-8854.67,660.036,96.8874,0,0,'Miss Danna'),
(3513,60,-8838.52,670.28,98.0987,0,0,'Miss Danna');

-- ---------------------------------------End Miss Danna and students------------------------------------------------------
-- ---------------------------------------Donna and William----------------------------------------------------------------

DELETE FROM `creature_formations` WHERE `leaderGUID` = 79720;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(79720,79721,3,180,515,0,0),
(79720,79720,0,0,515,0,0);

DELETE FROM `waypoint_data` WHERE `id` = 797200;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(797200,1,-8731.58,541.932,101.111,0,0,1,0,100,0),
(797200,2,-8720.52,529.999,99.3708,0,0,1,0,100,0),
(797200,3,-8716.57,522.528,97.612,0,0,1,0,100,0),
(797200,4,-8710.38,522.662,97.4771,0,0,1,0,100,0),
(797200,5,-8703.03,528.912,97.669,0,0,1,0,100,0),
(797200,6,-8685.83,539.951,97.7841,0,0,1,0,100,0),
(797200,7,-8679.19,551.407,97.4845,0,0,1,0,100,0),
(797200,8,-8663.87,554.612,96.8751,0,0,1,0,100,0),
(797200,9,-8651.75,548.373,96.9836,0,0,1,0,100,0),
(797200,10,-8638.92,537.941,99.4104,0,0,1,0,100,0),
(797200,11,-8629.57,534.889,100.717,0,0,1,0,100,0),
(797200,12,-8616.79,517.027,103.246,0,0,1,0,100,0),
(797200,13,-8610.89,516.332,103.775,0,0,1,0,100,0),
(797200,14,-8600.68,525.372,106.517,0,0,1,0,100,0),
(797200,15,-8582.68,540.197,102.279,0,0,1,0,100,0),
(797200,16,-8582.6,557.728,101.851,0,0,1,0,100,0),
(797200,17,-8588.54,571.377,102.515,0,0,1,0,100,0),
(797200,18,-8582.75,582.445,103.492,0,0,1,0,100,0),
(797200,19,-8581.09,596.986,103.326,0,0,1,0,100,0),
(797200,20,-8572.61,609.681,102.628,0,0,1,0,100,0),
(797200,21,-8554.31,617.579,102.079,0,0,1,0,100,0),
(797200,22,-8547.34,628.095,100.969,0,0,1,0,100,0),
(797200,23,-8524.76,636.519,99.995,0,0,1,0,100,0),
(797200,24,-8514.57,643.758,100.198,0,0,1,0,100,0),
(797200,25,-8512.06,652.878,100.291,0,0,1,0,100,0),
(797200,26,-8521.83,666.528,102.661,0,0,1,0,100,0),
(797200,27,-8527.96,675.59,101.776,0,0,1,0,100,0),
(797200,28,-8544.53,685.475,97.5076,0,0,1,0,100,0),
(797200,29,-8564.66,672.461,97.0156,0,0,1,0,100,0),
(797200,30,-8573.9,661.108,97.5108,0,0,1,0,100,0),
(797200,31,-8592.18,657.221,98.1965,0,0,1,0,100,0),
(797200,32,-8604.52,656.575,98.7059,0,0,1,0,100,0),
(797200,33,-8620.36,652.313,99.1877,0,0,1,0,100,0),
(797200,34,-8644.6,658.89,101.207,0,0,1,0,100,0),
(797200,35,-8655.94,660.699,100.858,0,0,1,0,100,0),
(797200,36,-8668.29,676.294,99.6044,0,0,1,0,100,0),
(797200,37,-8671.98,683.76,98.8546,0,0,1,0,100,0),
(797200,38,-8705.22,725.675,97.1356,0,0,1,0,100,0),
(797200,39,-8714.54,732.607,97.8152,0,0,1,0,100,0),
(797200,40,-8729.44,723.121,101.552,0,0,1,0,100,0),
(797200,41,-8742.16,710.686,98.2678,0,0,1,0,100,0),
(797200,42,-8738.48,700.884,98.718,0,0,1,0,100,0),
(797200,43,-8752.58,688.263,100.448,0,0,1,0,100,0),
(797200,44,-8773.14,671.75,103.092,0,0,1,0,100,0),
(797200,45,-8774.24,667.734,103.092,0,0,1,0,100,0),
(797200,46,-8762.72,649.633,103.733,0,0,1,0,100,0),
(797200,47,-8759.08,635.326,102.912,0,0,1,0,100,0),
(797200,48,-8758.8,629.108,102.25,0,0,1,0,100,0),
(797200,49,-8761.79,618.03,99.275,0,0,1,0,100,0),
(797200,50,-8792.64,593.169,97.6035,0,0,1,0,100,0),
(797200,51,-8801.18,592.338,97.3394,0,0,1,0,100,0),
(797200,52,-8816.1,613.304,95.2455,0,0,1,0,100,0),
(797200,53,-8828.86,627.785,94.0444,0,0,1,0,100,0),
(797200,54,-8826.57,637.878,94.243,0,0,1,0,100,0),
(797200,55,-8818.02,645.358,94.2658,0,0,1,0,100,0),
(797200,56,-8811.9,638.996,94.2287,0,0,1,0,100,0),
(797200,57,-8812.1,630.047,94.2287,0,0,1,0,100,0),
(797200,58,-8824.53,623.322,93.8413,0,0,1,0,100,0),
(797200,59,-8837.91,642.898,95.4907,0,0,1,0,100,0),
(797200,60,-8851.59,652.393,96.44,0,0,1,0,100,0),
(797200,61,-8847.92,662.602,97.4256,0,0,1,0,100,0),
(797200,62,-8830.06,673.308,98.2819,0,0,1,0,100,0),
(797200,63,-8826.73,680.102,97.2982,0,0,1,0,100,0),
(797200,64,-8833.85,697.773,97.5546,0,0,1,0,100,0),
(797200,65,-8840.86,711.403,97.5683,0,0,1,0,100,0),
(797200,66,-8840.99,722.775,97.3683,0,0,1,0,100,0),
(797200,67,-8826.64,729.331,98.4387,0,0,1,0,100,0),
(797200,68,-8816.81,738.407,97.9223,0,0,1,0,100,0),
(797200,69,-8793.3,743.694,98.3306,0,0,1,0,100,0),
(797200,70,-8768.96,740.105,99.1632,0,0,1,0,100,0),
(797200,71,-8759.32,727.137,98.2857,0,0,1,0,100,0),
(797200,72,-8731.58,697.112,98.6319,0,0,1,0,100,0),
(797200,73,-8730.4,687.347,98.7743,0,0,1,0,100,0),
(797200,74,-8723.18,673.754,98.6213,0,0,1,0,100,0),
(797200,75,-8714.73,664.722,98.9638,0,0,1,0,100,0),
(797200,76,-8706.44,635.994,100.299,0,0,1,0,100,0),
(797200,77,-8705.95,611.391,99.9666,0,0,1,0,100,0),
(797200,78,-8711.1,594.366,98.6165,0,0,1,0,100,0),
(797200,79,-8720.06,591.749,98.5704,0,0,1,0,100,0),
(797200,80,-8734.96,576.142,97.4009,0,0,1,0,100,0),
(797200,81,-8743.7,570.146,97.382,0,0,1,0,100,0),
(797200,82,-8747.05,560.624,97.4024,0,0,1,0,100,0);

-- -----------------------------------------------------------End Donna and William----------------------------------------------------------------
-- -----------------------------------------------------------Janey, Suzanne, and Lisan-------------------------------------------------------------

UPDATE `creature` SET `MovementType` = 0 WHERE `guid` in (86596,89294,86597);
UPDATE `creature_addon` SET `path_id` = 0 WHERE `guid` in (86596,89294,86597);
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` in (1413,1414,1415);

DELETE FROM `smart_scripts` WHERE `entryorguid` in (1413,1414,1415,141300,141500);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(1414,0,0,0,38,0,100,0,1,0,0,0,0,29,1,200,0,0,0,0,10,86596,1413,0,0,0,0,0,0,'Lisan Pierce - On Data Set 1 0 - Set Follow'),
(1414,0,1,0,38,0,100,0,1,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lisan Pierce - On Data Set 1 1 - Say Random 0'),
(1414,0,2,0,38,0,100,0,1,2,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lisan Pierce - On Data Set 1 2 - Set UNIT_STAND_STATE_SIT'),
(1414,0,3,0,38,0,100,0,1,3,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lisan Pierce - On Data Set 1 3 - Remove UNIT_STAND_STATE_SIT'),
(1414,0,4,0,38,0,100,0,1,4,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,-8989.59,858.133,105.605,3.46022,'Lisan Pierce - On Data Set 1 5 - Move to POS'),

(1415,0,0,0,38,0,100,0,1,0,0,0,0,29,0,160,0,0,0,0,10,86596,1413,0,0,0,0,0,0,'Suzanne - On Data Set 1 0 - Set Follow'),
(1415,0,1,0,38,0,100,0,1,2,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Suzanne - On Data Set 1 2 - Set UNIT_STAND_STATE_SIT'),
(1415,0,2,0,38,0,100,0,1,3,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Suzanne - On Data Set 1 3 - Remove UNIT_STAND_STATE_SIT'),
(1415,0,3,0,38,0,100,0,1,4,0,0,0,69,0,0,0,0,0,0,1,0,0,0,0,-8992.66,856.234,105.775,0.595873,'Suzanne - On Data Set 1 5 - Move to POS'),
(1415,0,4,0,1,0,100,0,35000,35000,60000,120000,0,80,141500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Suzanne - OOC - Run Script'),

(1413,0,0,1,1,0,100,1,20000,20000,0,0,0,53,0,1413,1,0,0,0,1,0,0,0,0,0,0,0,0,'Janey Anship - OOC (No Repeat) - Start Waypoint'),
(1413,0,1,2,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,86597,1414,0,0,0,0,0,0,'Janey Anship - Linked - Set Data 1 0 \'Lisan Pierce\''),
(1413,0,2,0,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,89294,1415,0,0,0,0,0,0,'Janey Anship - Linked - Set Data 1 0 \'Suzanne\''),
(1413,0,3,0,40,0,100,0,56,1413,0,0,0,80,141300,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Janey Anship - On Waypoint 56 Reached - Run Script'),
(1413,0,4,0,38,0,100,0,1,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Janey Anship - On Data Set 1 1 - Say Random 0'),

(141500,9,0,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,10,86596,1413,0,0,0,0,0,0,'Suzanne - On Script - Set Data 1 1 \'Janey Anship\''),
(141500,9,1,0,0,0,100,0,14000,15000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Suzanne - On Script - Say 0 0'),
(141500,9,2,0,0,0,100,0,14000,15000,0,0,0,45,1,1,0,0,0,0,10,86597,1414,0,0,0,0,0,0,'Suzanne - On Script - Set Data 1 1 \'Lisan Pierce\''),

(141300,9,0,0,0,0,100,0,0,0,0,0,0,54,310000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Janey Anship - On Script - Pause Waypoint'),
(141300,9,1,0,0,0,100,0,2000,2000,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,5.06,'Janey Anship - On Script - Set Orientation'),
(141300,9,2,0,0,0,100,0,1000,1000,0,0,0,45,1,4,0,0,0,0,10,86597,1414,0,0,0,0,0,0,'Janey Anship - On Script - Set Data 1 4 \'Lisan Pierce\''),
(141300,9,3,0,0,0,100,0,0,0,0,0,0,45,1,4,0,0,0,0,10,89294,1415,0,0,0,0,0,0,'Janey Anship - On Script - Set Data 1 4 \'Suzanne\''),
(141300,9,4,0,0,0,100,0,1000,1000,0,0,0,90,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Janey Anship - On Script - Set UNIT_STAND_STATE_SIT'),
(141300,9,5,0,0,0,100,0,1000,2000,0,0,0,45,1,2,0,0,0,0,10,86597,1414,0,0,0,0,0,0,'Janey Anship - On Script - Set Data 1 2 \'Lisan Pierce\''),
(141300,9,6,0,0,0,100,0,1000,2000,0,0,0,45,1,2,0,0,0,0,10,89294,1415,0,0,0,0,0,0,'Janey Anship - On Script - Set Data 1 2 \'Suzanne\''),
(141300,9,7,0,0,0,100,0,240000,290000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Janey Anship - On Script - Emote Talk'),
(141300,9,8,0,0,0,100,0,1000,1000,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Janey Anship - On Script - Remove UNIT_STAND_STATE_SIT'),
(141300,9,9,0,0,0,100,0,2000,2000,0,0,0,45,1,3,0,0,0,0,10,86597,1414,0,0,0,0,0,0,'Janey Anship - On Script - Set Data 1 3 \'Lisan Pierce\''),
(141300,9,10,0,0,0,100,0,2000,3000,0,0,0,45,1,3,0,0,0,0,10,89294,1415,0,0,0,0,0,0,'Janey Anship - On Script - Set Data 1 3 \'Suzanne\''),
(141300,9,11,0,0,0,100,0,2000,2000,0,0,0,65,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Janey Anship - On Script - Resume Waypoint'),
(141300,9,12,0,0,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,89294,1415,0,0,0,0,0,0,'Janey Anship - On Script - Set Data 1 0 \'Suzanne\''),
(141300,9,13,0,0,0,100,0,1000,1000,0,0,0,45,1,0,0,0,0,0,10,86597,1414,0,0,0,0,0,0,'Janey Anship - On Script - Set Data 1 0 \'Lisan Pierce\'');

DELETE FROM `creature_text` WHERE `CreatureID` in (1413,1414,1415);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(1413,0,0,'If we reverse the Essence flows perhaps we can alter the polarity.',12,7,100,1,0,0,201,0,'Janey Anship - Talk'),
(1413,0,1,'So then the array of magics would cascade into a chain reaction of positively charged energies.',12,7,100,1,0,0,203,0,'Janey Anship - Talk'),
(1413,0,2,'The portal will shift slightly, at this point if you cast a binding cantrip you will solidify it in place.',12,7,100,1,0,0,204,0,'Janey Anship - Talk'),
(1413,0,3,'When the positively aligned energies collide with the negatively charged energies, they don\'t negate one another.',12,7,100,1,0,0,205,0,'Janey Anship - Talk'),
(1413,0,4,'Maginor says that twisting alternating flows of positive energy actually creates a much more stable flow.',12,7,100,1,0,0,206,0,'Janey Anship - Talk'),
(1413,0,5,'The magical wards at that point should be supported enough by the energy flux to contain the entity.',12,7,100,1,0,0,207,0,'Janey Anship - Talk'),
(1413,0,6,'Why can\'t we just shift the array to compensate for the variance in the flux?',12,7,100,1,0,0,208,0,'Janey Anship - Talk'),
(1413,0,7,'Putting in twelve centers of focus might allow the magical energies to form more solidly, adding the necessary stability.',12,7,100,1,0,0,209,0,'Janey Anship - Talk'),

(1414,0,0,'But what if the resulting frequency shift were to send magical feedback up the flows?',12,7,100,1,0,0,210,0,'Lisan Pierce - Talk'),
(1414,0,1,'Wouldn\'t that cause the weave to unravel if not properly anchored before starting the casting?',12,7,100,1,0,0,211,0,'Lisan Pierce - Talk'),
(1414,0,2,'But wouldn\'t that mean crossing the streams? Isn\'t that really bad?',12,7,100,1,0,0,212,0,'Lisan Pierce - Talk'),
(1414,0,3,'The resultant energies could collapse though, and that could cause an energy flux that would give you a migraine for weeks.',12,7,100,1,0,0,213,0,'Lisan Pierce - Talk'),
(1414,0,4,'But isn\'t that what caused the initial problems with Adept Syleria\'s magical formulae?',12,7,100,1,0,0,214,0,'Lisan Pierce - Talk'),
(1414,0,5,'I think not, I don\'t need to be blown up again.',12,7,100,1,0,0,215,0,'Lisan Pierce - Talk'),
(1414,0,6,'That will unbalance the magical focus, though, and cause a reverse vibration in the ether.',12,7,100,1,0,0,216,0,'Lisan Pierce - Talk'),
(1414,0,7,'I suppose that could work, if we had twenty people to cast it with.',12,7,100,1,0,0,217,0,'Lisan Pierce - Talk'),

(1415,0,0,'What if we used three focuses in Tyrean pattern? That should solve it.',12,7,100,1,0,0,218,0,'Suzanne - Talk'),
(1415,0,1,'But if we stabilize it with an anchor thread at the appropriate energy crux then it should work.',12,7,100,1,0,0,219,0,'Suzanne - Talk'),
(1415,0,2,'Always so negative. The chances of that happening are between zero and none.',12,7,100,1,0,0,220,0,'Suzanne - Talk'),
(1415,0,3,'If we use the appropriate sequence we should be ok. Will just take some serious studying before we start.',12,7,100,1,0,0,221,0,'Suzanne - Talk'),
(1415,0,4,'Wow, all of this for a love potion. Hope he\'s worth it.',12,7,100,1,0,0,222,0,'Suzanne - Talk'),
(1415,0,5,'If we use the Surian theory, then yes, but not if we go with the Y\'serian approach.',12,7,100,1,0,0,223,0,'Suzanne - Talk'),
(1415,0,6,'At least we wouldn\'t be around to have to clean it up.',12,7,100,1,0,0,224,0,'Suzanne - Talk'),
(1415,0,7,'Only if we didn\'t follow the proper initialization procedures.',12,7,100,1,0,0,225,0,'Suzanne - Talk');

DELETE FROM `waypoint_scripts` WHERE `id` >= 385 and `id` <= 426 and `id` not in (413,414,415);
DELETE FROM `waypoint_data` WHERE `id` in (865960,892940,865970);

DELETE FROM `waypoints` WHERE `entry` = 1413;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(1413,1,-8953.9,862.547,104.957,0,0,'Janey Anship'),
(1413,2,-8932.12,857.927,100.803,0,0,'Janey Anship'),
(1413,3,-8909.04,850.187,96.281,0,0,'Janey Anship'),
(1413,4,-8896.57,865.822,96.8556,0,0,'Janey Anship'),
(1413,5,-8890.18,881.888,101.184,0,0,'Janey Anship'),
(1413,6,-8888.17,893.701,104.619,0,0,'Janey Anship'),
(1413,7,-8890.076,901.395,107.355,0,0,'Janey Anship'),
(1413,8,-8890.792,903.77,107.813,0,0,'Janey Anship'),
(1413,9,-8894.17,909.79,110.395,0,0,'Janey Anship'),
(1413,10,-8890.685,911.816,110.63,0,0,'Janey Anship'),
(1413,11,-8870.31,923.272,105.91,0,0,'Janey Anship'),
(1413,12,-8855.94,931.187,101.845,0,0,'Janey Anship'),
(1413,13,-8843.91,933.491,104.097,0,0,'Janey Anship'),
(1413,14,-8835.285,938.716,105.319,0,0,'Janey Anship'),
(1413,15,-8824.983,946.589,102.938,0,0,'Janey Anship'),
(1413,16,-8816.65,953.442,100.743,0,0,'Janey Anship'),
(1413,17,-8767.52,895.508,101.256,0,0,'Janey Anship'),
(1413,18,-8753.45,892,101.896,0,0,'Janey Anship'),
(1413,19,-8740.3,893.588,101.375,0,0,'Janey Anship'),
(1413,20,-8726.64,877.216,102.712,0,0,'Janey Anship'),
(1413,21,-8719.896,868.748,101.591,0,0,'Janey Anship'),
(1413,22,-8711.78,859.391,96.9622,0,0,'Janey Anship'),
(1413,23,-8714.17,851.672,96.7801,0,0,'Janey Anship'),
(1413,24,-8724.59,835.118,96.1396,0,0,'Janey Anship'),
(1413,25,-8727.53,820.133,97.0495,0,0,'Janey Anship'),
(1413,26,-8723.35,807.987,97.2959,0,0,'Janey Anship'),
(1413,27,-8717.8,795.688,96.9682,0,0,'Janey Anship'),
(1413,28,-8720.86,784.235,97.7513,0,0,'Janey Anship'),
(1413,29,-8730.39,769.812,98.1267,0,0,'Janey Anship'),
(1413,30,-8729.96,761.621,98.2494,0,0,'Janey Anship'),
(1413,31,-8726.06,753.976,98.2668,0,0,'Janey Anship'),
(1413,32,-8714.42,737.952,97.8087,0,0,'Janey Anship'),
(1413,33,-8728.74,725.086,101.267,0,0,'Janey Anship'),
(1413,34,-8738.14,715.533,100.152,0,0,'Janey Anship'),
(1413,35,-8742.74,709.527,98.3091,0,0,'Janey Anship'),
(1413,36,-8737.21,700.627,98.6984,0,0,'Janey Anship'),
(1413,37,-8776.23,670.457,103.093,0,0,'Janey Anship'),
(1413,38,-8760.45,646.994,103.883,0,0,'Janey Anship'),
(1413,39,-8759.11,627.771,101.892,0,0,'Janey Anship'),
(1413,40,-8763.21,616.245,98.6119,0,0,'Janey Anship'),
(1413,41,-8779.99,602.334,97.3893,0,0,'Janey Anship'),
(1413,42,-8793.37,590.39,97.5755,0,0,'Janey Anship'),
(1413,43,-8817.337,614.697,95.094,0,0,'Janey Anship'),
(1413,44,-8849.81,659.507,97.1312,0,0,'Janey Anship'),
(1413,45,-8834.43,672.377,98.2964,0,0,'Janey Anship'),
(1413,46,-8825.5,677.093,97.6638,0,0,'Janey Anship'),
(1413,47,-8838.31,708.928,97.6485,0,0,'Janey Anship'),
(1413,48,-8851.32,736.847,100.505,0,0,'Janey Anship'),
(1413,49,-8870.66,759.965,96.6871,0,0,'Janey Anship'),
(1413,50,-8880.96,756.982,96.1098,0,0,'Janey Anship'),
(1413,51,-8909.67,790.199,87.4738,0,0,'Janey Anship'),
(1413,52,-8918.12,784.468,87.4199,0,0,'Janey Anship'),
(1413,53,-8930.34,773.156,87.9818,0,0,'Janey Anship'),
(1413,54,-8961.17,770.851,93.8524,0,0,'Janey Anship'),
(1413,55,-8980.98,783.189,98.0365,0,0,'Janey Anship'),
(1413,56,-8990.43,800.731,102.354,0,0,'Janey Anship'),
(1413,57,-8994.98,823.243,104.806,0,0,'Janey Anship'),
(1413,58,-8990.49,849.74,105.812,0,0,'Janey Anship'),
(1413,59,-8992.48,859.067,105.647,0,0,'Janey Anship');

-- ---------------------------------------------------------------End Janey, Suzanne, and Lisan----------------------------------------------------------------------
-- ---------------------------------------------------------------Orphanage-----------------------------------------------------------------------------------------

-- Matron Nightingale is always shown - Not event specific
DELETE FROM `game_event_creature` WHERE `eventEntry` = 10 and `guid` = 79806;

-- Shellene
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` = 14497;
DELETE FROM `smart_scripts` WHERE `entryorguid` in (14497);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(14497,0,0,0,1,0,100,0,30000,30000,160000,240000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shellene - OOC - Say Random 0');

-- Orphans
UPDATE `creature` SET `wander_distance` = 3 WHERE `guid` = 79813;
UPDATE `creature` SET `position_x` = -8614.1933, `position_y` = 739.778, `position_z` = 101.902, `orientation` = 0.55, `MovementType` = 2, `wander_distance` = 0 WHERE `guid` = 79812;

DELETE FROM `creature_addon` WHERE `guid` in (79803,79804,79812);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES
(79803,0,0,0,0,0,0,NULL),
(79804,0,0,0,0,0,0,NULL),
(79812,798120,0,0,0,0,0,NULL);

DELETE FROM `creature_formations` WHERE `leaderGUID` = 79812;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`,`point_1`,`point_2`) VALUES
(79812,79804,2,190,515,0,0),
(79812,79803,1,160,515,0,0),
(79812,79812,0,0,515,0,0);

DELETE FROM `waypoint_data` WHERE `id` = 798120;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(798120,1,-8611.855,741.819,101.902,0,0,1,0,100,0),
(798120,2,-8607.328,736.029,101.902,0,0,1,0,100,0),
(798120,3,-8607.453,731.481,101.906,0,0,1,0,100,0),
(798120,4,-8611.104,730.951,101.904,0,0,1,0,100,0),
(798120,5,-8611.386,732.98,101.902,0,0,1,0,100,0),
(798120,6,-8601.168,740.864,101.948,0,0,1,0,100,0),
(798120,7,-8597.565,740.674,101.904,0,0,1,0,100,0),
(798120,8,-8598.909,736.516,101.904,0,0,1,0,100,0),
(798120,9,-8601.760,733.618,101.904,0,0,1,0,100,0),
(798120,10,-8602.194,730.622,101.904,0,0,1,0,100,0),
(798120,11,-8605.554,727.392,101.904,0,0,1,0,100,0),
(798120,12,-8614.076,727.354,101.904,0,0,1,0,100,0),
(798120,13,-8617.707,733.004,101.896,0,0,1,0,100,0),
(798120,14,-8614.648,735.352,101.901,0,1000,1,0,100,0),
(798120,15,-8611.297,733.998,101.899,0,0,1,0,100,0),
(798120,16,-8610.278,727.638,101.904,0,0,1,0,100,0),
(798120,17,-8603.662,730.019,101.904,0,0,1,0,100,0),
(798120,18,-8601.92,730.248,101.904,0,0,1,0,100,0),
(798120,19,-8602.384,740.663,101.904,0,0,1,0,100,0),
(798120,20,-8598.212,741.582,101.904,0,0,1,0,100,0),
(798120,21,-8596.861,738.872,101.904,0,0,1,0,100,0),
(798120,22,-8603.715,733.69,101.903,0,0,1,0,100,0),
(798120,23,-8611.728,734.924,101.896,0,0,1,0,100,0),
(798120,24,-8613.419,737.851,101.901,0,0,1,0,100,0),
(798120,25,-8611.855,741.819,101.902,0,0,1,0,100,0),
(798120,26,-8614.002,744.876,101.626,0,0,1,0,100,0),
(798120,27,-8618.105,749.692,96.723,0,0,1,0,100,0),
(798120,28,-8615.264,754.488,96.688,0,0,1,0,100,0),
(798120,29,-8610.971,756.185,96.77,0,0,1,0,100,0),
(798120,30,-8604.835,754.705,96.784,0,0,1,0,100,0),
(798120,31,-8599.902,756.884,96.792,0,0,1,0,100,0),
(798120,32,-8601.771,761.891,96.723,0,0,1,0,100,0),
(798120,33,-8607.014,764.106,96.718,0,0,1,0,100,0),
(798120,34,-8610.498,760.02,96.736,0,0,1,0,100,0),
(798120,35,-8612.114,753.82,96.729,0,0,1,0,100,0),
(798120,36,-8609.295,752.037,96.765,0,0,1,0,100,0),
(798120,37,-8607.304,752.856,96.786,0,0,1,0,100,0),
(798120,38,-8605.813,756.485,96.769,0,0,1,0,100,0),
(798120,39,-8607.552,759.231,96.745,0,0,1,0,100,0),
(798120,40,-8612.130,758.924,96.751,0,0,1,0,100,0),
(798120,41,-8616.762,757.048,96.684,0,0,1,0,100,0),
(798120,42,-8625.063,751.401,96.777,0,0,1,0,100,0),
(798120,43,-8623.744,744.051,96.771,0,0,1,0,100,0),
(798120,44,-8624.977,739.424,96.777,0,0,1,0,100,0),
(798120,45,-8630.463,736.526,96.835,0,0,1,0,100,0),
(798120,46,-8634.493,736.914,96.768,0,0,1,0,100,0),
(798120,47,-8635.064,740.133,96.936,0,0,1,0,100,0),
(798120,48,-8632.448,744.383,96.891,0,0,1,0,100,0),
(798120,49,-8627.866,747.073,96.806,0,0,1,0,100,0),
(798120,50,-8624.17,748.017,96.793,0,0,1,0,100,0),
(798120,51,-8618.105,749.692,96.723,0,0,1,0,100,0),
(798120,52,-8614.002,744.876,101.626,0,0,1,0,100,0);

-- --------------------------------------------------------End Orphanage-----------------------------------------------------------------------------------------
-- --------------------------------------------------------Karlee Chaddis, Paige, Gil and Fizzles----------------------------------------------------------------

UPDATE `creature` SET `MovementType` = 0 WHERE `guid` in (90439,90440,90443);
UPDATE `creature_addon` SET `path_id` = 0 WHERE `guid` in (90439,90440,90443);

DELETE FROM `waypoint_data` WHERE `id` in (904390,904400,904430);
DELETE FROM `waypoint_scripts` WHERE `id` in (427,428,429,430,431);

UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` in (2330,2331);

DELETE FROM `creature_text` WHERE `CreatureID` in (3504,2330,2331);
INSERT INTO `creature_text` (`CreatureID`,`GroupID`,`ID`,`Text`,`Type`,`Language`,`Probability`,`Emote`,`Duration`,`Sound`,`BroadcastTextId`,`TextRange`,`comment`) VALUES
(3504,0,0,'Is it true? Are there really crocolisks in the canals?',12,7,100,0,0,0,1098,0,'Gil'),
(3504,0,1,'My feet hurt.',12,7,100,0,0,0,1099,0,'Gil'),
(3504,0,2,'Are we there yet?',12,0,100,0,0,0,2223,0,'Gil'),
(3504,0,3,'Why are we goin\' this way?',12,0,100,0,0,0,1093,0,'Gil'),
(3504,0,4,'I wanna see the Mage Tower.',12,7,100,0,0,0,1097,0,'Gil'),
(3504,0,5,'Where we goin\'?',12,7,100,0,0,0,1094,0,'Gil'),
(3504,0,6,'Why do we always go the same way?',12,7,100,0,0,0,1100,0,'Gil'),
(3504,0,7,'I need to pee.',12,0,100,0,0,0,1095,0,'Gil'),
(3504,1,0,'Billy says Fizzles used to be a great wizard. But he got turned into a rabbit when one of his spells went bad.',12,0,100,0,0,0,1091,0,'Gil'),
(2330,0,0,'Hello, Charys. I have my list, could you get me all of that, especially the last ingredient.',12,7,100,0,0,0,587,0,'Karlee Chaddis'),
(2330,1,0,'Sure, Paige. Just be gentle.',12,7,100,0,0,0,589,0,'Karlee Chaddis'),
(2330,2,0,'Thanks, Charys. C\'mon Paige, sweetie.',12,0,100,0,0,0,590,0,'Karlee Chaddis'),
(2331,0,0,'Mommy? Can I pet Fizzles?',12,0,100,0,0,0,588,0,'Paige Chaddis');

DELETE FROM `smart_scripts` WHERE `entryorguid` in (3504,2330,2331,233000);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(3504,0,0,0,1,0,100,0,60000,60000,180000,200000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gil - Out of Combat - Say Random 0 (No Repeat)'),
(3504,0,1,0,38,0,100,0,1,0,0,0,0,29,0,160,0,0,0,0,10,90439,2330,0,0,0,0,0,0,'Gil - On Data Set 1 0 - Set Follow'),
(3504,0,2,0,38,0,100,0,1,1,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gil - On Data Set 1 1 - Say Line 1'),

(2331,0,0,0,38,0,100,0,1,0,0,0,0,29,0,200,0,0,0,0,10,90439,2330,0,0,0,0,0,0,'Paige Chaddis - On Data Set 1 0 - Set Follow'),
(2331,0,1,0,38,0,100,0,1,1,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Paige Chaddis - On Data Set 1 1 - Say Line 0'),

(2330,0,0,1,1,0,100,1,25000,25000,0,0,0,53,0,2330,1,0,0,0,1,0,0,0,0,0,0,0,0,'Karlee Chaddis - OOC (No Repeat) - Start Waypoint'),
(2330,0,1,2,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,90443,3504,0,0,0,0,0,0,'Karlee Chaddis - Linked - Set Data 1 0 \'Gil\''),
(2330,0,2,0,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,90440,2331,0,0,0,0,0,0,'Karlee Chaddis - Linked - Set Data 1 0 \'Paige Chaddis\''),
(2330,0,3,0,40,0,100,0,28,2330,0,0,0,80,233000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Karlee Chaddis - On Waypoint 28 Reached - Run Script'),

(233000,9,0,0,0,0,100,0,0,0,0,0,0,54,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Karlee Chaddis - On Script - Pause Waypoint'),
(233000,9,1,0,0,0,100,0,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,1.074,'Karlee Chaddis- On Script - Set Orientation'),
(233000,9,2,0,0,0,100,0,1000,1000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Karlee Chaddis- On Script - Say Line 0'),
(233000,9,3,0,0,0,100,0,14000,14000,0,0,0,45,1,1,0,0,0,0,10,90440,2331,0,0,0,0,0,0,'Karlee Chaddis- On Script - Set Data 1 1 \'Paige Chaddis\''),
(233000,9,4,0,0,0,100,0,8000,8000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Karlee Chaddis- On Script - Say Line 1'),
(233000,9,5,0,0,0,100,0,10000,10000,0,0,0,45,1,1,0,0,0,0,10,90443,3504,0,0,0,0,0,0,'Karlee Chaddis- On Script - Set Data 1 1 \'Gil\''),
(233000,9,6,0,0,0,100,0,20000,20000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Karlee Chaddis- On Script - Say Line 2'),
(233000,9,7,0,0,0,100,0,4000,4000,0,0,0,5,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Karlee Chaddis - On Script - Emote Wave');

DELETE FROM `waypoints` WHERE `entry` = 2330;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(2330,1,-8856.26,741.91,100.666,0,0,'Karlee Chaddis'),
(2330,2,-8860.26,747.938,99.9222,0,0,'Karlee Chaddis'),
(2330,3,-8866.15,756.326,97.8264,0,0,'Karlee Chaddis'),
(2330,4,-8870.51,760.372,96.7027,0,0,'Karlee Chaddis'),
(2330,5,-8879.54,756.138,96.2687,0,0,'Karlee Chaddis'),
(2330,6,-8883.45,758.191,95.4731,0,0,'Karlee Chaddis'),
(2330,7,-8907.48,788.261,87.7863,0,0,'Karlee Chaddis'),
(2330,8,-8906.29,794.423,87.3173,0,0,'Karlee Chaddis'),
(2330,9,-8899.1,801.189,87.6105,0,0,'Karlee Chaddis'),
(2330,10,-8899.88,815.041,89.3389,0,0,'Karlee Chaddis'),
(2330,11,-8899.09,826.687,92.5864,0,0,'Karlee Chaddis'),
(2330,12,-8905.65,841.38,95.4271,0,0,'Karlee Chaddis'),
(2330,13,-8905.3,845.868,95.7969,0,0,'Karlee Chaddis'),
(2330,14,-8898.15,863.912,96.2546,0,0,'Karlee Chaddis'),
(2330,15,-8893.39,873.065,98.9773,0,0,'Karlee Chaddis'),
(2330,16,-8888.58,889.208,102.944,0,0,'Karlee Chaddis'),
(2330,17,-8888.8,897.531,105.943,0,0,'Karlee Chaddis'),
(2330,18,-8896.33,913.303,110.988,0,0,'Karlee Chaddis'),
(2330,19,-8904.33,926.304,114.899,0,0,'Karlee Chaddis'),
(2330,20,-8919.41,948.481,117.337,0,0,'Karlee Chaddis'),
(2330,21,-8966.43,954.028,117.362,0,0,'Karlee Chaddis'),
(2330,22,-8982.42,966.381,116.043,0,0,'Karlee Chaddis'),
(2330,23,-8999.42,964.996,116.326,0,0,'Karlee Chaddis'),
(2330,24,-9012.36,953.626,116.256,0,0,'Karlee Chaddis'),
(2330,25,-9008.41,945.283,116.895,0,0,'Karlee Chaddis'),
(2330,26,-9000.86,940.914,117.094,0,0,'Karlee Chaddis'),
(2330,27,-8998.38,939.901,117.094,0,0,'Karlee Chaddis'),
(2330,28,-8996.34,945.169,117.097,0,0,'Karlee Chaddis'),
(2330,29,-8999.05,940.572,117.096,0,0,'Karlee Chaddis'),
(2330,30,-9002.62,941.706,117.095,0,0,'Karlee Chaddis'),
(2330,31,-9012.38,947.61,116.227,0,0,'Karlee Chaddis'),
(2330,32,-9012.45,951.694,116.246,0,0,'Karlee Chaddis'),
(2330,33,-9004.83,961.988,116.276,0,0,'Karlee Chaddis'),
(2330,34,-8998.64,965.802,116.292,0,0,'Karlee Chaddis'),
(2330,35,-8983.94,966.422,116.028,0,0,'Karlee Chaddis'),
(2330,36,-8980.01,965.284,116.256,0,0,'Karlee Chaddis'),
(2330,37,-8971.05,960.59,117.158,0,0,'Karlee Chaddis'),
(2330,38,-8957.87,953.377,117.299,0,0,'Karlee Chaddis'),
(2330,39,-8920.67,947.641,117.337,0,0,'Karlee Chaddis'),
(2330,40,-8908.711,932.625,116.370,0,0,'Karlee Chaddis'),
(2330,41,-8903.206,925.242,114.615,0,0,'Karlee Chaddis'),
(2330,42,-8899.662,918.715,112.635,0,0,'Karlee Chaddis'),
(2330,43,-8894.54,911.478,110.762,0,0,'Karlee Chaddis'),
(2330,44,-8877.53,920.808,107.603,0,0,'Karlee Chaddis'),
(2330,45,-8854.97,933.374,101.999,0,0,'Karlee Chaddis'),
(2330,46,-8848.88,930.711,102.495,0,0,'Karlee Chaddis'),
(2330,47,-8834.61,940.936,105.143,0,0,'Karlee Chaddis'),
(2330,48,-8818.28,953.205,100.678,0,0,'Karlee Chaddis'),
(2330,49,-8815.14,952.722,100.867,0,0,'Karlee Chaddis'),
(2330,50,-8804.01,942.261,101.241,0,0,'Karlee Chaddis'),
(2330,51,-8802.37,936.981,101.242,0,0,'Karlee Chaddis'),
(2330,52,-8777.24,909.299,100.262,0,0,'Karlee Chaddis'),
(2330,53,-8766.76,893.892,101.386,0,0,'Karlee Chaddis'),
(2330,54,-8737.03,892.761,101.221,0,0,'Karlee Chaddis'),
(2330,55,-8731.93,886.272,101.744,0,0,'Karlee Chaddis'),
(2330,56,-8723.13,875.04,102.678,0,0,'Karlee Chaddis'),
(2330,57,-8712.31,861.661,97.2752,0,0,'Karlee Chaddis'),
(2330,58,-8712.2,853.618,96.8655,0,0,'Karlee Chaddis'),
(2330,59,-8725.87,834.533,96.149,0,0,'Karlee Chaddis'),
(2330,60,-8726.58,813.587,97.0276,0,0,'Karlee Chaddis'),
(2330,61,-8717.15,795.784,97.0391,0,0,'Karlee Chaddis'),
(2330,62,-8721.79,782.622,97.8839,0,0,'Karlee Chaddis'),
(2330,63,-8732.2,766.047,98.0898,0,0,'Karlee Chaddis'),
(2330,64,-8724.93,751.443,98.2043,0,0,'Karlee Chaddis'),
(2330,65,-8713.3,732.548,97.8146,0,0,'Karlee Chaddis'),
(2330,66,-8699.05,715.705,97.0168,0,0,'Karlee Chaddis'),
(2330,67,-8661.63,744.699,96.6531,0,0,'Karlee Chaddis'),
(2330,68,-8660.26,765.872,96.6997,0,0,'Karlee Chaddis'),
(2330,69,-8634.36,787.361,96.6525,0,0,'Karlee Chaddis'),
(2330,70,-8632.43,787.372,96.6512,0,0,'Karlee Chaddis'),
(2330,71,-8606.16,761.17,96.7387,0,0,'Karlee Chaddis'),
(2330,72,-8592.08,756.77,96.651,0,0,'Karlee Chaddis'),
(2330,73,-8579.7,737.671,96.7114,0,0,'Karlee Chaddis'),
(2330,74,-8594.53,717.706,96.6514,0,0,'Karlee Chaddis'),
(2330,75,-8581.67,697.638,97.0168,0,0,'Karlee Chaddis'),
(2330,76,-8561.08,673.827,97.0168,0,0,'Karlee Chaddis'),
(2330,77,-8536.53,690.079,97.6665,0,0,'Karlee Chaddis'),
(2330,78,-8530.805,685.554,97.8444,0,0,'Karlee Chaddis'),
(2330,79,-8528.41,679.123,100.793,0,0,'Karlee Chaddis'),
(2330,80,-8517.6,662.84,102.123,0,0,'Karlee Chaddis'),
(2330,81,-8510.36,651.605,100.292,0,0,'Karlee Chaddis'),
(2330,82,-8516.68,643.439,100.134,0,0,'Karlee Chaddis'),
(2330,83,-8557.25,615.273,102.337,0,0,'Karlee Chaddis'),
(2330,84,-8563.65,615.408,102.278,0,0,'Karlee Chaddis'),
(2330,85,-8583.79,586.194,103.594,0,0,'Karlee Chaddis'),
(2330,86,-8584.4,560.743,101.871,0,0,'Karlee Chaddis'),
(2330,87,-8578.23,543.501,101.782,0,0,'Karlee Chaddis'),
(2330,88,-8593.35,530.953,105.659,0,0,'Karlee Chaddis'),
(2330,89,-8609.85,515.571,103.841,0,0,'Karlee Chaddis'),
(2330,90,-8616.86,517.629,103.218,0,0,'Karlee Chaddis'),
(2330,91,-8657.5,553.006,96.9502,0,0,'Karlee Chaddis'),
(2330,92,-8673.57,552.873,97.2864,0,0,'Karlee Chaddis'),
(2330,93,-8713.67,519.808,97.1597,0,0,'Karlee Chaddis'),
(2330,94,-8717.22,524.985,98.1892,0,0,'Karlee Chaddis'),
(2330,95,-8724.539,533.765,100.2637,0,0,'Karlee Chaddis'),
(2330,96,-8734.436,545.427,101.1412,0,0,'Karlee Chaddis'),
(2330,97,-8745.36,557.023,97.6718,0,0,'Karlee Chaddis'),
(2330,98,-8745,566.133,97.4006,0,0,'Karlee Chaddis'),
(2330,99,-8738.14,576.508,97.5043,0,0,'Karlee Chaddis'),
(2330,100,-8769.94,608.175,97.1405,0,0,'Karlee Chaddis'),
(2330,101,-8795.54,589.658,97.4546,0,0,'Karlee Chaddis'),
(2330,102,-8832.6,630.401,94.0918,0,0,'Karlee Chaddis'),
(2330,103,-8851.55,661.112,97.1319,0,0,'Karlee Chaddis'),
(2330,104,-8824.74,678.622,97.5366,0,0,'Karlee Chaddis'),
(2330,105,-8847.34,726.835,97.6974,0,0,'Karlee Chaddis');

-- Fizzles
DELETE FROM `creature` WHERE `guid` = 79379;
INSERT INTO `creature` (`guid`,`id1`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(79379,1419,0,0,0,1,1,0,-8994.19,947.069,118.348,4.29351,300,0,0,8,0,0,0,0,0,'',0);

-- --------------------------------------------------------Karlee Chaddis, Paige, Gil and Fizzles-------------------------------------------------------------------
-- --------------------------------------------------------Lil' Timmy-----------------------------------------------------------------------------------------------

DELETE FROM `creature_formations` WHERE `leaderGUID` = 45501;

UPDATE `creature_addon` SET `path_id` = 0 WHERE `guid` in (45501);
UPDATE `creature_template` SET `AIName` = "SmartAI" WHERE `entry` in (8666,7386);
UPDATE `creature` SET `MovementType` = 0 WHERE `guid` = 45501;
UPDATE `npc_vendor` SET `incrtime` = 3600 WHERE `entry` = 8666 and `item` = 8489;

DELETE FROM `smart_scripts` WHERE `entryorguid` in (8666,866600,7386);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(8666,0,0,0,1,1,100,0,30000,30000,120000,180000,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lil Timmy - Out of Combat - Say Random 0 (Phase 1)'),
(8666,0,1,2,1,0,100,1,10000,10000,0,0,0,53,0,8666,1,0,0,0,1,0,0,0,0,0,0,0,0,'Lil Timmy - OOC (No Repeat) - Start Waypoint'),
(8666,0,2,3,61,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,23427,7386,0,0,0,0,0,0,'Lil Timmy - Linked - Set Data 1 0 \'White Kitten\''),
(8666,0,3,4,61,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,10,23427,7386,0,0,0,0,0,0,'Lil Timmy - Linked - Set Data 1 2 \'White Kitten\''),
(8666,0,4,0,61,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lil Timmy - Linked - Set Event Phase 1'),
(8666,0,5,0,40,0,100,0,91,8666,0,0,0,80,866600,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lil Timmy - On Waypoint 91 Reached - Run Script'),

(7386,0,0,0,38,0,100,0,1,0,0,0,0,29,0,180,0,0,0,0,10,45501,8666,0,0,0,0,0,0,'White Kitten - On Data Set 1 0 - Set Follow'),
(7386,0,1,2,38,0,100,0,1,1,0,0,0,18,2,1,0,0,0,0,1,0,0,0,0,0,0,0,0,"White Kitten - On Data Set 1 1 - Set Unit_flags2 (Hide)"),
(7386,0,2,0,61,0,100,0,0,0,0,0,0,18,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"White Kitten - Linked - Set Unit_flags (Not_Selectable)"),
(7386,0,3,4,38,0,100,0,1,2,0,0,0,19,2,1,0,0,0,0,1,0,0,0,0,0,0,0,0,"White Kitten - On Data Set 1 2 - Set Unit_flags2 (Unhide)"),
(7386,0,4,0,61,0,100,0,0,0,0,0,0,19,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"White Kitten - Linked - Set Unit_flags (Selectable)"),

(866600,9,0,0,0,0,100,0,0,0,0,0,0,54,10802000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lil Timmy - On Script - Pause Waypoint'),
(866600,9,1,0,0,0,100,0,1000,1000,0,0,0,45,1,1,0,0,0,0,10,23427,7386,0,0,0,0,0,0,'Lil Timmy - On Script - Set Data 1 1 \'White Kitten\''),
(866600,9,2,0,0,0,100,0,0,0,0,0,0,18,2,1,0,0,0,0,1,0,0,0,0,0,0,0,0,"Lil Timmy - On Script - Set Unit_flags2 (Hide)"),
(866600,9,3,0,0,0,100,0,0,0,0,0,0,18,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Lil Timmy - On Script - Set Unit_flags (Not_Selectable)"),
(866600,9,4,0,0,0,100,0,0,0,0,0,0,22,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lil Timmy - On Script - Set Event Phase 2'),
(866600,9,5,0,0,0,100,0,5400000,10800000,0,0,0,19,2,1,0,0,0,0,1,0,0,0,0,0,0,0,0,"Lil Timmy - On Script - Set Unit_flags2 (Unhide)"),
(866600,9,6,0,0,0,100,0,0,0,0,0,0,19,33554432,0,0,0,0,0,1,0,0,0,0,0,0,0,0,"Lil Timmy - On Script - Set Unit_flags (Selectable)"),
(866600,9,7,0,0,0,100,0,0,0,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lil Timmy - On Script - Set Event Phase 1'),
(866600,9,8,0,0,0,100,0,0,0,0,0,0,53,0,8666,1,0,0,0,1,0,0,0,0,0,0,0,0,'Lil Timmy - On Script - Start Waypoint'),
(866600,9,9,0,0,0,100,0,0,0,0,0,0,45,1,0,0,0,0,0,10,23427,7386,0,0,0,0,0,0,'Lil Timmy - On Script - Set Data 1 0 \'White Kitten\''),
(866600,9,10,0,0,0,100,0,0,0,0,0,0,45,1,2,0,0,0,0,10,23427,7386,0,0,0,0,0,0,'Lil Timmy - On Script - Set Data 1 2 \'White Kitten\'');

DELETE FROM `waypoint_data` WHERE `id` = 455010;
DELETE FROM `waypoints` WHERE `entry` = 8666;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`point_comment`) VALUES
(8666,1,-8641.4,912.342,99.1397,0,0,'Lil Timmy'),
(8666,2,-8661.71,894.74,97.6239,0,0,'Lil Timmy'),
(8666,3,-8679.15,880.967,97.0168,0,0,'Lil Timmy'),
(8666,4,-8681.12,877.654,97.0168,0,0,'Lil Timmy'),
(8666,5,-8679.29,873.082,97.0168,0,0,'Lil Timmy'),
(8666,6,-8659.98,849.329,97.0168,0,0,'Lil Timmy'),
(8666,7,-8639.96,825.073,96.6251,0,0,'Lil Timmy'),
(8666,8,-8636.74,813.025,96.6486,0,0,'Lil Timmy'),
(8666,9,-8634,793.001,96.6508,0,0,'Lil Timmy'),
(8666,10,-8635.94,785.58,96.6515,0,0,'Lil Timmy'),
(8666,11,-8651.43,775.162,96.6714,0,0,'Lil Timmy'),
(8666,12,-8661.39,764.974,96.6998,0,0,'Lil Timmy'),
(8666,13,-8662.58,758.134,96.6947,0,0,'Lil Timmy'),
(8666,14,-8647.73,738.576,96.6965,0,0,'Lil Timmy'),
(8666,15,-8630.74,726.606,96.7377,0,0,'Lil Timmy'),
(8666,16,-8618.88,711.997,96.7248,0,0,'Lil Timmy'),
(8666,17,-8614.67,709.545,96.7549,0,0,'Lil Timmy'),
(8666,18,-8606.13,711.345,96.7382,0,0,'Lil Timmy'),
(8666,19,-8598.07,712.945,96.6746,0,0,'Lil Timmy'),
(8666,20,-8588.25,706.887,97.0168,0,0,'Lil Timmy'),
(8666,21,-8566.09,678.512,97.0168,0,0,'Lil Timmy'),
(8666,22,-8561.86,674.735,97.0168,0,0,'Lil Timmy'),
(8666,23,-8556.46,676.784,97.0168,0,0,'Lil Timmy'),
(8666,24,-8542.79,686.774,97.6239,0,0,'Lil Timmy'),
(8666,25,-8532.769,688.506,97.661,0,0,'Lil Timmy'),
(8666,26,-8528.005,682.699,99.567,0,0,'Lil Timmy'),
(8666,27,-8522.24,670.618,102.794,0,0,'Lil Timmy'),
(8666,28,-8519.8,666.4,102.615,0,0,'Lil Timmy'),
(8666,29,-8512.94,656.648,100.901,0,0,'Lil Timmy'),
(8666,30,-8513.15,648.714,100.292,0,0,'Lil Timmy'),
(8666,31,-8518.18,642.361,100.092,0,0,'Lil Timmy'),
(8666,32,-8538.04,630.723,100.404,0,0,'Lil Timmy'),
(8666,33,-8554.03,617.81,102.053,0,0,'Lil Timmy'),
(8666,34,-8564.5,613.48,102.435,0,0,'Lil Timmy'),
(8666,35,-8576.12,601.799,103.26,0,0,'Lil Timmy'),
(8666,36,-8582.44,589.572,103.691,0,0,'Lil Timmy'),
(8666,37,-8586.68,575.605,102.985,0,0,'Lil Timmy'),
(8666,38,-8585.96,565.941,102.26,0,0,'Lil Timmy'),
(8666,39,-8578.9,545.988,101.779,0,0,'Lil Timmy'),
(8666,40,-8581.73,541.012,102.09,0,0,'Lil Timmy'),
(8666,41,-8590.09,533.912,104.76,0,0,'Lil Timmy'),
(8666,42,-8598.32,527.164,106.399,0,0,'Lil Timmy'),
(8666,43,-8605.67,520.882,105.748,0,0,'Lil Timmy'),
(8666,44,-8610.26,515.735,103.79,0,0,'Lil Timmy'),
(8666,45,-8613.43,514.684,103.401,0,0,'Lil Timmy'),
(8666,46,-8618.8,518.794,103.068,0,0,'Lil Timmy'),
(8666,47,-8635.17,535.152,99.9833,0,0,'Lil Timmy'),
(8666,48,-8647.39,546.721,97.8568,0,0,'Lil Timmy'),
(8666,49,-8655.78,552.938,96.9435,0,0,'Lil Timmy'),
(8666,50,-8671.86,552.874,97.2037,0,0,'Lil Timmy'),
(8666,51,-8679.66,549.654,97.5031,0,0,'Lil Timmy'),
(8666,52,-8689.63,540.268,97.828,0,0,'Lil Timmy'),
(8666,53,-8698.98,530.295,97.7173,0,0,'Lil Timmy'),
(8666,54,-8712.64,520.242,97.2398,0,0,'Lil Timmy'),
(8666,55,-8715.24,521.571,97.4039,0,0,'Lil Timmy'),
(8666,56,-8720.77,528.729,99.1496,0,0,'Lil Timmy'),
(8666,57,-8729.84,539.87,101.105,0,0,'Lil Timmy'),
(8666,58,-8735.95,547.101,100.845,0,0,'Lil Timmy'),
(8666,59,-8745.79,557.737,97.7107,0,0,'Lil Timmy'),
(8666,60,-8746.01,564.915,97.4001,0,0,'Lil Timmy'),
(8666,61,-8729.92,581.294,97.6775,0,0,'Lil Timmy'),
(8666,62,-8719.58,591.033,98.4713,0,0,'Lil Timmy'),
(8666,63,-8712.04,594.001,98.6079,0,0,'Lil Timmy'),
(8666,64,-8707.26,600.676,98.9982,0,0,'Lil Timmy'),
(8666,65,-8704.46,616.407,100.215,0,0,'Lil Timmy'),
(8666,66,-8705.6,629.078,100.477,0,0,'Lil Timmy'),
(8666,67,-8708.67,645.787,99.9994,0,0,'Lil Timmy'),
(8666,68,-8716.46,666.585,98.8681,0,0,'Lil Timmy'),
(8666,69,-8724.09,676.482,98.6317,0,0,'Lil Timmy'),
(8666,70,-8728.54,684.167,98.7324,0,0,'Lil Timmy'),
(8666,71,-8733.47,695.151,98.723,0,0,'Lil Timmy'),
(8666,72,-8743.6,709.876,98.2678,0,0,'Lil Timmy'),
(8666,73,-8741.08,714.561,98.9815,0,0,'Lil Timmy'),
(8666,74,-8734.46,720.119,101.647,0,0,'Lil Timmy'),
(8666,75,-8726.79,726.231,100.924,0,0,'Lil Timmy'),
(8666,76,-8718.09,733.687,97.9511,0,0,'Lil Timmy'),
(8666,77,-8716.42,737.269,97.7782,0,0,'Lil Timmy'),
(8666,78,-8721.01,746.752,97.9693,0,0,'Lil Timmy'),
(8666,79,-8730.96,759.107,98.1572,0,0,'Lil Timmy'),
(8666,80,-8731.99,769.385,98.0161,0,0,'Lil Timmy'),
(8666,81,-8724.64,778.108,98.0604,0,0,'Lil Timmy'),
(8666,82,-8717.55,792.762,97.1197,0,0,'Lil Timmy'),
(8666,83,-8728.3,817.744,96.9777,0,0,'Lil Timmy'),
(8666,84,-8726.79,830.504,96.3102,0,0,'Lil Timmy'),
(8666,85,-8723.42,841.35,96.0764,0,0,'Lil Timmy'),
(8666,86,-8709.57,857.779,96.978,0,0,'Lil Timmy'),
(8666,87,-8692.38,870.557,97.0284,0,0,'Lil Timmy'),
(8666,88,-8679.35,880.974,97.0167,0,0,'Lil Timmy'),
(8666,89,-8661.22,896.239,97.5968,0,0,'Lil Timmy'),
(8666,90,-8643.7,912.233,98.9288,0,0,'Lil Timmy'),
(8666,91,-8634.58,918.926,99.3551,0,0,'Lil Timmy');

-- --------------------------------------------------------End Lil' Timmy-----------------------------------------------------------------------------------------------
-- --------------------------------------------------------Sewer Beast--------------------------------------------------------------------------------------------------

UPDATE `creature` SET `spawntimesecs` = 87180 WHERE `guid` in (86300,86301);
DELETE FROM `creature` WHERE `guid` in (300492,300493,300494,300495);
INSERT INTO `creature` (`guid`,`id1`,`id2`,`id3`,`map`,`zoneId`,`areaId`,`spawnMask`,`phaseMask`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`currentwaypoint`,`curhealth`,`curmana`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`,`ScriptName`,`VerifiedBuild`) VALUES
(300492,3581,0,0,0,0,0,1,1,0,-8479.075,709.373,85.894,3.7941,87180,0,0,17720,0,0,0,0,0,'',0),
(300493,3581,0,0,0,0,0,1,1,0,-8648.995,927.668,85.894,3.854,87180,0,0,17720,0,0,0,0,0,'',0),
(300494,3581,0,0,0,0,0,1,1,0,-8860.171,965.54,85.893,5.484,87180,0,0,17720,0,0,0,0,0,'',0),
(300495,3581,0,0,0,0,0,1,1,0,-8906.125,709.376,85.892,0.7132,87180,0,0,17720,0,0,0,0,0,'',0);

DELETE FROM `pool_creature` WHERE `pool_entry` = 86300;
INSERT INTO `pool_creature` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(86300,86300,0,'Sewer Beast (86300)'),
(86301,86300,0,'Sewer Beast (86301)'),
(300492,86300,0,'Sewer Beast (300492)'),
(300493,86300,0,'Sewer Beast (300493)'),
(300494,86300,0,'Sewer Beast (300494)'),
(300495,86300,0,'Sewer Beast (300495)');

DELETE FROM `pool_template` WHERE `entry` = 86300;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES
(86300,1,'Sewer Beast Pool');

-- -------------------------------------------------End Sewer Beast--------------------------------------------------------------------------------------------------------
-- ------------------------------------------------Underwater Construction Worker------------------------------------------------------------------------------------------

DELETE FROM `creature` WHERE `guid` = 85178;  -- Remove the underwater construction worker; WOTLK expansion removed them
DELETE FROM `creature_addon` WHERE `guid` = 85178;
DELETE FROM `waypoint_data` WHERE `id` = 851780;
DELETE FROM `waypoint_scripts` WHERE `id` in (334,335);

-- ------------------------------------------------ End Underwater Construction Worker---------------------------------------------------------------------------------------
-- -------------------------------------------------Defias Prisoner Escort---------------------------------------------------------------------------------------------------

DELETE FROM smart_scripts WHERE `entryorguid` = 37063;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(37063,0,0,0,38,0,100,0,1,0,0,0,0,29,0,50,0,0,0,0,12,2,0,0,0,0,0,0,0,'Stormwind City Guard - On Data Set - Set Follow'),
(37063,0,1,0,38,0,100,0,2,0,0,0,0,29,0,160,0,0,0,0,12,2,0,0,0,0,0,0,0,'Stormwind City Guard - On Data Set - Set Follow'),
(37063,0,2,0,38,0,100,0,3,0,0,0,0,29,0,200,0,0,0,0,12,2,0,0,0,0,0,0,0,'Stormwind City Guard - On Data Set - Set Follow'),
(37063,0,3,0,38,0,100,0,4,0,0,0,0,29,0,310,0,0,0,0,12,2,0,0,0,0,0,0,0,'Stormwind City Guard - On Data Set - Set Follow');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_03_27_20' WHERE sql_rev = '1648089119541675100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
