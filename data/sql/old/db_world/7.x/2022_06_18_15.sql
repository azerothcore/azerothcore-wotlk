-- DB update 2022_06_18_14 -> 2022_06_18_15
--
-- Mulgore 10618 Gameobjects that need removed before Mulgore can be rebuilt
DELETE FROM `gameobject` WHERE `guid` IN (18442, 18443, 18444, 18445, 18446, 18447, 18448, 18449, 18450, 18451, 18452, 18453, 18454, 18455, 85767, 85772, 85882, 85883);

-- This includes the pools, but there are none

-- All Mulgore Battered Chest Gameobjects (106318) that exist
SET @OGUID := 9838;

DELETE FROM `gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+40;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
-- 0-3
(@OGUID+0, 106318, 1, 215, 0, 1, 1, -1057.6275634765625, 465.5982666015625, 23.50528907775878906, 2.024578809738159179, 0, 0, 0.848047256469726562, 0.529920578002929687, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
(@OGUID+1, 106318, 1, 215, 0, 1, 1, -1075.2293701171875, 542.53753662109375, 49.8483428955078125, 4.031712055206298828, 0, 0, -0.90258502960205078, 0.430511653423309326, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
(@OGUID+2, 106318, 1, 215, 0, 1, 1, -1161.16845703125, 529.53985595703125, 28.19378280639648437, 5.235987663269042968, 0, 0, -0.5, 0.866025388240814208, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
(@OGUID+3, 106318, 1, 215, 0, 1, 1, -998.08270263671875, 589.4744873046875, 81.93946075439453125, 2.530723094940185546, 0, 0, 0.953716278076171875, 0.300707906484603881, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
-- 4-7
(@OGUID+4, 106318, 1, 215, 0, 1, 1, -546.70684814453125, 72.729278564453125, 52.28420257568359375, 0.802850961685180664, 0, 0, 0.390730857849121093, 0.920504987239837646, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
(@OGUID+5, 106318, 1, 215, 0, 1, 1, -657.78033447265625, 193.8148956298828125, 46.80418014526367187, 0.506144583225250244, 0, 0, 0.250379562377929687, 0.968147754669189453, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
(@OGUID+6, 106318, 1, 215, 0, 1, 1, -715.582275390625, 163.0640716552734375, 43.65098953247070312, 1.256635904312133789, 0, 0, 0.587784767150878906, 0.809017360210418701, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
(@OGUID+7, 106318, 1, 215, 215, 1, 1, -631.74151611328125, 111.4527664184570312, 17.11371040344238281, 1.082102894783020019, 0, 0, 0.51503753662109375, 0.857167601585388183, 360, 255, 1, 0), -- 106318 (Area: 215 - Difficulty: 0)
-- 8-9
(@OGUID+8, 106318, 1, 215, 0, 1, 1, -826.25250244140625, -36.7276496887207031, -13.1952342987060546, 3.926995515823364257, 0, 0, -0.92387866973876953, 0.38268551230430603, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
(@OGUID+9, 106318, 1, 215, 215, 1, 1, -798.07769775390625, -9.66634082794189453, -13.128173828125, 4.136432647705078125, 0, 0, -0.87881660461425781, 0.477159708738327026, 360, 255, 1, 0), -- 106318 (Area: 215 - Difficulty: 0)
-- 10-13
(@OGUID+10, 106318, 1, 215, 819, 1, 1, -591.3314208984375, -681.55999755859375, 27.44317245483398437, 5.427974700927734375, 0, 0, -0.41469287872314453, 0.909961462020874023, 360, 255, 1, 0), -- 106318 (Area: 819 - Difficulty: 0)
(@OGUID+11, 106318, 1, 215, 819, 1, 1, -665.03692626953125, -787.12469482421875, 43.61326980590820312, 1.431168079376220703, 0, 0, 0.656058311462402343, 0.754710197448730468, 360, 255, 1, 0), -- 106318 (Area: 819 - Difficulty: 0)
(@OGUID+12, 106318, 1, 215, 819, 1, 1, -779.68829345703125, -866.58966064453125, 25.97847366333007812, 3.9793548583984375, 0, 0, -0.9135446548461914, 0.406738430261611938, 360, 255, 1, 0), -- 106318 (Area: 819 - Difficulty: 0)
(@OGUID+13, 106318, 1, 215, 819, 1, 1, -824.10137939453125, -780.58660888671875, -2.71320295333862304, 4.276057243347167968, 0, 0, -0.84339141845703125, 0.537299633026123046, 360, 255, 1, 0), -- 106318 (Area: 819 - Difficulty: 0)
-- 14-17
(@OGUID+14, 106318, 1, 215, 360, 1, 1, -1568.312255859375, -1081.0145263671875, 103.8672866821289062, 3.857182979583740234, 0, 0, -0.93667125701904296, 0.350209832191467285, 360, 255, 1, 0), -- 106318 (Area: 360 - Difficulty: 0)
(@OGUID+15, 106318, 1, 215, 360, 1, 1, -1585.0709228515625, -1151.2315673828125, 104.118377685546875, 0.122172988951206207, 0, 0, 0.061048507690429687, 0.998134791851043701, 360, 255, 1, 0), -- 106318 (Area: 360 - Difficulty: 0)
(@OGUID+16, 106318, 1, 215, 360, 1, 1, -1672.001708984375, -1324.0699462890625, 132.7880859375, 1.343901276588439941, 0, 0, 0.622513771057128906, 0.78260880708694458, 360, 255, 1, 0), -- 106318 (Area: 360 - Difficulty: 0)
(@OGUID+17, 106318, 1, 215, 360, 1, 1, -1681.0875244140625, -1218.5963134765625, 127.4188613891601562, 0.453785061836242675, 0, 0, 0.224950790405273437, 0.974370121955871582, 360, 255, 1, 0), -- 106318 (Area: 360 - Difficulty: 0)
-- 18-19
(@OGUID+18, 106318, 1, 215, 0, 1, 1, -1889.326416015625, -1096.98095703125, 90.32932281494140625, 2.809975385665893554, 0, 0, 0.986285209655761718, 0.165049895644187927, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
(@OGUID+19, 106318, 1, 215, 360, 1, 1, -1925.3721923828125, -1050.7725830078125, 44.04982376098632812, 5.462882041931152343, 0, 0, -0.39874839782714843, 0.917060375213623046, 360, 255, 1, 0), -- 106318 (Area: 360 - Difficulty: 0)
-- 20-23
(@OGUID+20, 106318, 1, 215, 821, 1, 1, -2625.284423828125, -1390.2613525390625, 24.50350379943847656, 5.724681377410888671, 0, 0, -0.27563667297363281, 0.961261868476867675, 360, 255, 1, 0), -- 106318 (Area: 821 - Difficulty: 0)
(@OGUID+21, 106318, 1, 215, 821, 1, 1, -2635.93505859375, -1249.2003173828125, 13.64171695709228515, 2.251473426818847656, 0, 0, 0.902585029602050781, 0.430511653423309326, 360, 255, 1, 0), -- 106318 (Area: 821 - Difficulty: 0)
(@OGUID+22, 106318, 1, 215, 821, 1, 1, -2643.494873046875, -1320.986328125, 12.12032413482666015, 0.907570242881774902, 0, 0, 0.438370704650878906, 0.898794233798980712, 360, 255, 1, 0), -- 106318 (Area: 821 - Difficulty: 0)
(@OGUID+23, 106318, 1, 215, 821, 1, 1, -2716.833740234375, -1188.42822265625, 16.78433990478515625, 5.078907966613769531, 0, 0, -0.56640625, 0.824126183986663818, 360, 255, 1, 0), -- 106318 (Area: 821 - Difficulty: 0)
-- 24-25
(@OGUID+24, 106318, 1, 215, 0, 1, 1, -2777.55859375, -691.963134765625, 7.008191108703613281, 3.385940074920654296, 0, 0, -0.99254608154296875, 0.121869951486587524, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
(@OGUID+25, 106318, 1, 215, 0, 1, 1, -2782.115478515625, -707.653564453125, 6.424570083618164062, 2.687806606292724609, 0, 0, 0.974370002746582031, 0.224951311945915222, 180, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
-- 26-27
(@OGUID+26, 106318, 1, 215, 0, 1, 1, -2742.504150390625, -445.18304443359375, -3.45379900932312011, 0.122172988951206207, 0, 0, 0.061048507690429687, 0.998134791851043701, 180, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
(@OGUID+27, 106318, 1, 215, 0, 1, 1, -2750.028564453125, -430.93402099609375, -2.93078994750976562, 2.949595451354980468, 0, 0, 0.995395660400390625, 0.095851235091686248, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
-- 28-29
(@OGUID+28, 106318, 1, 215, 0, 1, 1, -2402.0634765625, 233.6727142333984375, 49.24333953857421875, 2.809975385665893554, 0, 0, 0.986285209655761718, 0.165049895644187927, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
(@OGUID+29, 106318, 1, 215, 0, 1, 1, -2413.068359375, 221.974609375, 48.83074951171875, 4.956737518310546875, 0, 0, -0.61566066741943359, 0.788011372089385986, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
-- 30-33
(@OGUID+30, 106318, 1, 215, 818, 1, 1, -2352.908447265625, 457.480377197265625, 57.6083984375, 3.630291461944580078, 0, 0, -0.97029495239257812, 0.241925001144409179, 360, 255, 1, 0), -- 106318 (Area: 818 - Difficulty: 0)
(@OGUID+31, 106318, 1, 215, 818, 1, 1, -2358.603271484375, 379.66888427734375, 64.85495758056640625, 3.43830275535583496, 0, 0, -0.98901557922363281, 0.147811368107795715, 360, 255, 1, 0), -- 106318 (Area: 818 - Difficulty: 0)
(@OGUID+32, 106318, 1, 215, 818, 1, 1, -2388.364990234375, 444.8865966796875, 75.9410400390625, 1.151916384696960449, 0, 0, 0.544638633728027343, 0.838670849800109863, 360, 255, 1, 0), -- 106318 (Area: 818 - Difficulty: 0)
(@OGUID+33, 106318, 1, 215, 818, 1, 1, -2445.70751953125, 438.708526611328125, 61.7602691650390625, 0.541050612926483154, 0, 0, 0.267237663269042968, 0.96363067626953125, 360, 255, 1, 0), -- 106318 (Area: 818 - Difficulty: 0)
-- 34-35
(@OGUID+34, 106318, 1, 215, 404, 1, 1, -1893.6497802734375, 353.875457763671875, 107.3605728149414062, 5.672322273254394531, 0, 0, -0.3007049560546875, 0.953717231750488281, 360, 255, 1, 0), -- 106318 (Area: 404 - Difficulty: 0)
(@OGUID+35, 106318, 1, 215, 404, 1, 1, -1896.4586181640625, 340.1953125, 105.6117172241210937, 1.291541695594787597, 0, 0, 0.60181427001953125, 0.798636078834533691, 360, 255, 1, 0), -- 106318 (Area: 404 - Difficulty: 0)
-- 36-37
(@OGUID+36, 106318, 1, 215, 0, 1, 1, -1708.905517578125, 433.57623291015625, 96.52761077880859375, 2.967041015625, 0, 0, 0.996193885803222656, 0.087165042757987976, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
(@OGUID+37, 106318, 1, 215, 0, 1, 1, -1734.919189453125, 420.683441162109375, 97.20781707763671875, 0.27925160527229309, 0, 0, 0.139172554016113281, 0.990268170833587646, 360, 255, 1, 0), -- 106318 (Area: 0 - Difficulty: 0)
-- 38-40
(@OGUID+38, 106318, 1, 215, 224, 1, 1, -1912.48876953125, -712.5831298828125, 3.573940992355346679, 0.174532130360603332, 0, 0, 0.087155342102050781, 0.996194720268249511, 360, 255, 1, 0), -- 106318 (Area: 224 - Difficulty: 0)
(@OGUID+39, 106318, 1, 215, 224, 1, 1, -1922.71533203125, -692.86309814453125, 2.616070032119750976, 6.195919513702392578, 0, 0, -0.04361915588378906, 0.999048233032226562, 360, 255, 1, 0), -- 106318 (Area: 224 - Difficulty: 0)
(@OGUID+40, 106318, 1, 215, 224, 1, 1, -1931.8563232421875, -715.7557373046875, 3.48775792121887207, 6.073746204376220703, 0, 0, -0.10452842712402343, 0.994521915912628173, 360, 255, 1, 0); -- 106318 (Area: 224 - Difficulty: 0)

DELETE FROM `pool_gameobject` WHERE `guid` BETWEEN @OGUID+0 AND @OGUID+40;
DELETE FROM `pool_template` WHERE `entry` BETWEEN 433 AND 446;

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(433, 1, 'Mulgore NW Harpies, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+0, 433, 0, 'Mulgore NW Harpies Chest 1 of 4'),
(@OGUID+1, 433, 0, 'Mulgore NW Harpies Chest 2 of 4'),
(@OGUID+2, 433, 0, 'Mulgore NW Harpies Chest 3 of 4'),
(@OGUID+3, 433, 0, 'Mulgore NW Harpies Chest 4 of 4');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(434, 1, 'Mulgore N Harpies, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+4, 434, 0, 'Mulgore N Harpies Chest 1 of 4'),
(@OGUID+5, 434, 0, 'Mulgore N Harpies Chest 2 of 4'),
(@OGUID+6, 434, 0, 'Mulgore N Harpies Chest 3 of 4'),
(@OGUID+7, 434, 0, 'Mulgore N Harpies Chest 4 of 4');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(435, 1, 'Wildmane Water Well, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+8, 435, 0, 'Mulgore Wildmane Water Well Chest 1 of 2'),
(@OGUID+9, 435, 0, 'Mulgore Wildmane Water Well Chest 2 of 2');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(436, 1, 'Mulgore NE Harpies, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+10, 436, 0, 'Mulgore NE Harpies Chest 1 of 4'),
(@OGUID+11, 436, 0, 'Mulgore NE Harpies Chest 2 of 4'),
(@OGUID+12, 436, 0, 'Mulgore NE Harpies Chest 3 of 4'),
(@OGUID+13, 436, 0, 'Mulgore NE Harpies Chest 4 of 4');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(437, 1, 'Mulgore Venture Co Cave Inside, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+14, 437, 0, 'Mulgore Venture Co Cave Inside Chest 1 of 4'),
(@OGUID+15, 437, 0, 'Mulgore Venture Co Cave Inside Chest 2 of 4'),
(@OGUID+16, 437, 0, 'Mulgore Venture Co Cave Inside Chest 3 of 4'),
(@OGUID+17, 437, 0, 'Mulgore Venture Co Cave Inside Chest 4 of 4');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(438, 1, 'Mulgore Venture Co Cave Outside, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+18, 438, 0, 'Mulgore Venture Co Cave Outside Chest 1 of 2'),
(@OGUID+19, 438, 0, 'Mulgore Venture Co Cave Outside Chest 2 of 2');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(439, 1, 'Mulgore SE Harpies, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+20, 439, 0, 'Mulgore SE Harpies Chest 1 of 4'),
(@OGUID+21, 439, 0, 'Mulgore SE Harpies Chest 2 of 4'),
(@OGUID+22, 439, 0, 'Mulgore SE Harpies Chest 3 of 4'),
(@OGUID+23, 439, 0, 'Mulgore SE Harpies Chest 4 of 4');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(440, 1, 'Mulgore East Palemane Gnoll Camp, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+24, 440, 0, 'Mulgore East Palemane Gnoll Camp Chest 1 of 2'),
(@OGUID+25, 440, 0, 'Mulgore East Palemane Gnoll Camp Chest 2 of 2');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(441, 1, 'Mulgore West Palemane Gnoll Camp, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+26, 441, 0, 'Mulgore West Palemane Gnoll Camp Chest 1 of 2'),
(@OGUID+27, 441, 0, 'Mulgore West Palemane Gnoll Camp Chest 2 of 2');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(442, 1, 'Mulgore Gnolls Outside Cave Camp, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+28, 442, 0, 'Mulgore Gnolls Outside Cave Camp Chest 1 of 2'),
(@OGUID+29, 442, 0, 'Mulgore Gnolls Outside Cave Camp Chest 2 of 2');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(443, 1, 'Mulgore Gnoll Cave, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+30, 443, 0, 'Mulgore Gnoll Cave Chest 1 of 4'),
(@OGUID+31, 443, 0, 'Mulgore Gnoll Cave Chest 2 of 4'),
(@OGUID+32, 443, 0, 'Mulgore Gnoll Cave Chest 3 of 4'),
(@OGUID+33, 443, 0, 'Mulgore Gnoll Cave Chest 4 of 4');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(444, 1, 'Mulgore Dwarven Camp, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+34, 444, 0, 'Mulgore Dwarven Camp Chest 1 of 2'),
(@OGUID+35, 444, 0, 'Mulgore Dwarven Camp Chest 2 of 2');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(445, 1, 'Mulgore Western Harpies, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+36, 445, 0, 'Mulgore Western Harpies Chest 1 of 2'),
(@OGUID+37, 445, 0, 'Mulgore Western Harpies Chest 2 of 2');

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(446, 1, 'Mulgore Venture Co Caravan, Battered Chest 106318');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+38, 446, 0, 'Mulgore Venture Co Caravan Chest 1 of 3'),
(@OGUID+39, 446, 0, 'Mulgore Venture Co Caravan Chest 2 of 3'),
(@OGUID+40, 446, 0, 'Mulgore Venture Co Caravan Chest 3 of 3');
