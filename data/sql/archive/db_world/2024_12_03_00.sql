-- DB update 2024_12_02_05 -> 2024_12_03_00
DELETE FROM `spell_script_names` WHERE `spell_id`=51000;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (51000, 'spell_hos_dark_matter_size');

DELETE FROM `spell_script_names` WHERE `spell_id`=51001;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (51001, 'spell_hos_dark_matter');

DELETE FROM `script_waypoint` WHERE `entry` IN (28070);
INSERT INTO `script_waypoint` (`entry`, `pointid`, `location_x`, `location_y`, `location_z`, `waittime`, `point_comment`) 
VALUES 
(28070, 1, 1064.12, 474.883, 207.721, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 2, 1045.25, 471.345, 208.611, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 3, 1022.27, 458.81, 207.72, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 4, 995.493, 432.994, 207.413, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 5, 982.247, 421.768, 205.994, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 6, 977.403, 420.578, 205.994, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 7, 968.479, 421.992, 205.994, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 8, 959.337, 420.403, 205.994, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 9, 949.226, 413.964, 205.994, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 10, 944.901, 401.561, 205.994, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 11, 943.739, 394.289, 205.994, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 12, 943.949, 383.505, 206.696, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 13, 942.623, 378.852, 207.423, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 14, 937.271, 373.627, 207.422, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 15, 926.094, 362.071, 203.706, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 16, 897.082, 332.612, 203.706, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 17, 916.701, 352.318, 203.706, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 18, 946.597, 383.533, 205.994, 2000, 'Brann Bronzebeard - Halls of Stone'),
(28070, 19, 973.525, 379.987, 205.994, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 20, 982.317, 390.587, 205.994, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 21, 984.925, 406.454, 205.994, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 22, 999.096, 433.512, 207.412, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 23, 1023.27, 457.194, 207.719, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 24, 1046.27, 479.728, 207.748, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 25, 1064.12, 474.883, 207.721, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 26, 1047.91, 521.103, 207.719, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 27, 1048.57, 622.492, 207.719, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 28, 1048.86, 662.867, 201.672, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 29, 1105.7, 662.475, 202.871, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 30, 1121.44, 662.366, 196.235, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 31, 1138.58, 632.499, 196.235, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 32, 1164.78, 637.113, 196.294, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 33, 1199.88, 667.139, 196.242, 2000, 'Brann Bronzebeard - Halls of Stone'),
(28070, 34, 1202.49, 667.226, 196.243, 2000, 'Brann Bronzebeard - Halls of Stone'),
(28070, 35, 1230.13, 666.967, 189.607, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 36, 1256.34, 666.921, 189.611, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 37, 1282.12, 666.744, 189.607, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 38, 1307.56, 666.938, 189.607, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 39, 1306.05, 666.85, 189.607, 0, 'Brann Bronzebeard - Halls of Stone'),
(28070, 40, 1307.56, 666.938, 189.607, 0, 'Brann Bronzebeard - Halls of Stone');
