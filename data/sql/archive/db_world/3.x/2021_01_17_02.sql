-- DB update 2021_01_17_01 -> 2021_01_17_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_17_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_17_01 2021_01_17_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1607717075635849200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1607717075635849200');

-- Improve existing teleports
UPDATE `game_tele` SET `position_x`=1584.140259, `position_y`=240.308472, `position_z`=-52.153400, `orientation`=0.041793 WHERE `id`=1263; -- Undercity - Improve location
UPDATE `game_tele` SET `name`='JailOfficial' WHERE `id`=1424; -- Improve name
UPDATE `game_tele` SET `position_x`=-11069.698242, `position_y`=-1795.773193, `position_z`=53.731770, `orientation`=3.096410, `name`='KarazhanCrypts' WHERE `id`=233; -- Improve name and location
UPDATE `game_tele` SET `position_x`=319.134644, `position_y`=263.952881, `position_z`=53.274734, `orientation`=1.549760 WHERE `id`=241; -- Dalaran Crater - Improve location
UPDATE `game_tele` SET `position_x`=1629.848511, `position_y`=-4373.642090, `position_z`=31.557331, `orientation`=3.697617 WHERE  `id`=703; -- Orgirmmar - Improve location
UPDATE `game_tele` SET `name`='EmeraldDreamStatue' WHERE `id`=1426; -- Improve name
UPDATE `game_tele` SET `position_x`=2738.869629, `position_y`=-3320.932129, `position_z`=101.916855, `orientation`=0.366472, `name`='EmeraldDreamForest' WHERE `id`=1428; -- Emerald Dream - Improve name and location

-- Add new teleports
DELETE FROM `game_tele` WHERE `id` IN (1451, 1452, 1453, 1454, 1455, 1456, 1457, 1458, 1459, 1460, 1461, 1462, 1463, 1464, 1465, 1466, 1467, 1468, 1469, 1470, 1471, 1472, 1473, 1474, 1475, 1476, 1477, 1478, 1479, 1480, 1481, 1482, 1483, 1484, 1485, 1486, 1487, 1488, 1489);
INSERT INTO `game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES 
(1451, 1065.607666, -16.172640, 317.104980, 2.223340, 37, 'AzsharaAllianceEntrance'),
(1452, -123.070557, 856.829651, 298.237213, 5.522018, 37, 'AzsharaHordeEntrance'),
(1453, -98.015503, 149.835999, -40.382702, 3.176891, 35, 'JailAlliance'),
(1454, -11139.184570, -1742.442139, -29.736654, 3.176891, 0, 'JailHorde'),
(1455, -9479.0, 1783.0, 49.939999, 6.095650, 1, 'AhnQirajBacklands'),
(1456, -7347.615723, -642.264343, 294.575287, 0.405538, 0, 'BlackcharCaveInside'),
(1457, -7396.401367, -1070.177002, 589.390320, 0.099237, 469, 'BlackwingLairOutside'),
(1458, -1464.956299, 501.067108, 0, 2.940095, 36, 'DeadminesStrangePlace'),
(1459, 74.507805, 1184.508179, -119.551277, 2.904725, 369, 'DeeprunTramDeeprunDivers'),
(1460, -98.392342, 1216.833252, -122.163307, 1.483048, 369, 'DeeprunTramNessy'),
(1461, -33.273006, 1234.087402, -126.101425, 1.506608, 369, 'DeeprunTramUnderwaterLocation'),
(1462, -13693.50, 2806.300049, -1.595341, 1.650070, 0, 'GillijimsIsle'),
(1463, 3598.0, -4523.0, 198.864624, 2.618052, 533, 'NaxxramasOutside'),
(1464, -6376.910156, 1262.605957, 7.188310,2.235566, 0, 'NewmansLanding'),
(1465, -5313.676758, -2512.701904, 484.236389, 3.577543, 0, 'OrtellsHideoutDunMorogh'),
(1466, -202.557007, 1666.880005, 79.764099, 2.618052, 0, 'SilverpineForestShadowfangKeep'),
(1467, 3176.634277, -4039.275879, 105.463600, 3.309200, 329, 'StratholmeOutside'),
(1468, -7465.290039, -1080.306274, 896.780151, 5.761793, 0, 'TopOfBlackrockMountain'),
(1469, -3857.0, -3485.0, 579.640198, 3.309200, 0, 'WetlandsHiddenSpot'),
(1470, -12031.868164, -2583.706543, -29.647411, 2.995044, 309, 'ZulGurubAlterOfStorms'),
(1471, -12332.519531, -1859.805664, 130.321091, 2.995044, 0, 'ZulGurubStranglethornVale'),
(1472, -1849.535645, -4149.051758, 9.816202, 3.076676, 0, 'ArathiDwarvenFarm'),
(1473, -987.068237, 1579.951172, 53.671322, 3.053110, 0, 'Gilneas'),
(1474, 3638.476318, -3584.032715, 47.512455, 0.002514, 0, 'EasternPlaguelandsUnfinishedRegion'),
(1475, -4072.748291, -3380.438965, 372.381042, 2.856164, 0, 'GrimBatolWatchPost'),
(1476, 3611.443359, -2820.777100, 177.579300, 6.128125, 0, 'QuelThalas'),
(1477, 4296.039551, -2763.718018, 16.268044, 0.519620, 0, 'QuelThalasTower'),
(1478, -10750.512695, 2432.039307, 6.144441, 0.240715, 1, 'SilithusSouthernFarm'),
(1479, -9678.110352, 1530.109985, 19.302420, 0.240715, 1, 'SilithusUnfinishedRegion'),
(1480, -13008.0, -1619.404053, 143.737076, 5.879879, 0, 'StranglethornValeUnfinishedRegion'),
(1481, -9392.341797, -4855.909668, 300.757263, 0.591072, 0, 'TheForbiddingSeaIslands'),
(1482, 2231.971191, 2242.839111, 99.736877, 0.5, 0, 'TirisfalGladesUnfinishedRegion'),
(1483, -4031.919434, -1411.127197, 156.758270, 0.429314, 0, 'WetlandsDwarvenVillage'),
(1484, -7119.493164, -4114.494629, 461.938568, 2.522395, 0, 'BadlandsUnfinishedRegion'), 
(1485, 5475.992676, -3728.734131, 1593.443848, 5.802837, 1, 'HyjalBlizzardConstructionCo'),
(1486, 5430.490723, -2805.697266, 1463.441162, 3.898252, 1, 'HyjalCrater'),
(1487, 4857.473145, -1791.165527, 1156.655273, 4.799088, 1, 'HyjalCaveInside'),
(1488, 4822.816895, -1749.725098, 1162.031372, 5.478453, 1, 'HyjalCaveOutside'),
(1489, 5372.716309, -3378.710205, 1655.467529, 5.276584, 1, 'HyjalTheWorldTree');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
