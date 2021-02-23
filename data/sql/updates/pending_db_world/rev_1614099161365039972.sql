INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1614099161365039972');

-- Update from TC commit f188b0d647c19820ce1e36923f0c72082b8512c5

UPDATE `creature_template` SET `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` IN (2454,14751,15090,15429,15492,15528,15696,15698,15700,15704,15707,15708,15745,15904,15910,15948,15958,15963,16143,16180,16230,16238,16254,16298,16299,16336,16338,16379,16380,16382,16383,16384,16386,16394,16395,16396,16398,16401,16479,16484,16490,16493,16495,16534,16604,16702,16744,16787,16859,16914,17001,17003,17023,17041,17048,17049,17050,17051,17067,17077,17144,17167,17206,17220,17231,17234,17248,17262,17265,17293,17299,17318,17359,17379,17391,17392,17393,17410,17426,17452,17453,17473,17495,17499,17500,17503,17524,17532,17591,17603,17611,17612,17654,17681,17702,17705,17707,17715,17716,17719,17720,17836,17837,17853,17875,17879,17880,17881,17918,17976,17987,17989,18039,18075,18076,18109,18152,18161,18182,18186,18194,18204,18208,18209,18225,18235,18236,18242,18337,18372,18396,18398,18399,18400,18401,18402,18423,18441,18442,18443,18448,18458,18462,18491,18494,18496,18533,18544,18628,18648,18659,18677,18683,18685,18686,18687,18693,18694,18698,18734,18735,18736,18737,18766,18782,18795,18823,18824,18825,18826,18838,18839,18847,18888,18904,18989,18994,18995,19441,19464,19480,19523,19524,19579,19580,19592,19594,19599,19616,19647,19675,19703,19719,19757,19774,19777,19842,19862,19863,19864,19869,19870,19878,19919,19920,19922,19949,19953,19956,19958,19962,19963,19964,19965,19966,19967,19968,19969,19970,19971,19972,20029,20075,20078,20083,20086,20101,20114,20117,20137,20143,20145,20149,20150,20151,20152,20163,20199,20209,20229,20287,20335,20398,20399,20402,20403,20417,20427,20440,20486,20488,20489,20490,20491,20492,20493,20518,20552,20554,20555,20556,20603,20605,20608,20618,20669,20709,20746,20752,20787,20799,20889,20905,20931,20995,21005,21009,21029,21041,21044,21051,21057,21078,21079,21093,21109,21119,21120,21129,21130,21131,21132,21134,21138,21139,21155,21161,21181,21183,21185,21196,21205,21207,21210,21211,21241,21250,21255,21258,21264,21265,21275,21288,21289,21290,21294,21306,21307,21308,21312,21319,21322,21323,21331,21335,21336,21340,21351,21353,21373,21375,21409,21410,21425,21430,21435,21456,21457,21458,21459,21464,21468,21470,21488,21498,21504,21514,21628,21632,21636,21641,21658,21686,21687,21699,21703,21706,21708,21710,21731,21735,21738,21739,21740,21741,21753,21754,21756,21759,21760,21767,21768,21776,21778,21779,21780,21798,21853,21861,21894,21922,21925,21926,21945,21946,21947,21949,21960,21961,21968,21969,21976,21978,21992,21995,21998,22000,22005,22009,22014,22022,22038,22064,22077,22085,22102,22121,22122,22197,22205,22224,22228,22232,22233,22235,22240,22246,22258,22259,22260,22263,22267,22273,22285,22318,22333,22338,22339,22357,22369,22372,22381,22408,22438,22439,22449,22452,22459,22473,22496,22992,22993,22994,23002,23291);

UPDATE `creature_template` SET `BaseAttackTime` = 2000, `RangeAttackTime` = 2000 WHERE `entry` IN (128,314,329,353,450,462,575,584,648,649,650,651,652,653,659,723,758,775,947,954,1000,1001,1063,1066,1154,1155,1156,1174,1175,1177,1187,1203,1204,1222,1225,1233,1260,1262,1266,1365,1380,1399,1425,1475,1494,1503,1533,1574,1575,1685,1686,1687,1722,1723,1724,1755,1786,1792,1799,1800,1837,1838,1839,1840,1841,1843,1844,1851,1871,1885,1897,1946,1981,2045,2056,2149,2158,2160,2188,2191,2258,2275,2283,2433,2453,2523,2528,2531,2598,2601,2604,2605,2638,2662,2667,2675,2678,2683,2707,2744,2749,2751,2754,2755,2763,2776,2779,2794,2801,2853,2876,2880,2881,2887,2915,2919,2937,2942,2946,2983,2992,3253,3257,3289,3295,3395,3451,3454,3455,3475,3533,3545,3569,3573,3579,3582,3617,3619,3672,3694,3773,3792,3799,3836,3843,3844,3872,3879,3895,3896,3898,3899,3900,3904,3906,3907,3911,3912,3913,3990,3998,4001,4002,4033,4068,4071,4207,4263,4264,4342,4355,4358,4360,4377,4386,4391,4392,4396,4398,4399,4402,4405,4411,4413,4425,4445,4449,4473,4476,4490,4497,4504,4509,4660,4724,4785,4795,4842,4947,4972,5044,5045,5046,5097,5194,5196,5197,5345,5349,5352,5354,5402,5409,5432,5433,5435,5436,5437,5438,5439,5440,5444,5446,5448,5449,5666,5671,5745,5764,5780,5809,5827,5847,5848,5864,5865,5874,5879,5893,5894,5895,5912,5919,5921,5922,5926,5927,5934,5935,5950,5981,6012,6013,6016,6021,6066,6069,6070,6109,6110,6111,6123,6124,6180,6209,6225,6226,6227,6231,6238,6268,6386,6388,6390,6489,6490,6492,6549,6550,6646,6647,6648,6649,6650,6652,6748,6866,6909,6911,6913,6932,7016,7073,7074,7091,7209,7226,7229,7266,7276,7286,7293,7319,7340,7356,7360,7364,7365,7367,7398,7399,7400,7401,7403,7411,7412,7413,7415,7423,7424,7425,7464,7465,7467,7468,7469,7483,7486,7487,7527,7664,7729,7734,7735,7738,7750,7767,7772,7779,7785,7786,7805,7809,7844,7845,7848,7895,7899,7901,7902,7915,7918,8001,8024,8025,8055,8075,8116,8117,8121,8122,8149,8156,8179,8201,8203,8204,8207,8208,8212,8213,8215,8217,8280,8283,8297,8300,8301,8303,8317,8324,8337,8387,8388,8389,8391,8392,8394,8421,8437,8438,8440,8443,8446,8478,8497,8504,8510,8578,8608,8616,8656,8657,8658,8889,8924,8933,8976,8980,8981,8999,9027,9032,9095,9136,9217,9218,9219,9241,9260,9263,9264,9266,9299,9398,9436,9437,9438,9439,9441,9442,9443,9445,9453,9456,9457,9458,9461,9477,9521,9522,9527,9538,9539,9546,9596,9598,9601,9602,9605,9621,9682,9687,9688,9689,9708,9716,9717,9718,9736,9876,10040,10041,10076,10077,10196,10200,10202,10217,10220,10221,10257,10261,10263,10268,10290,10296,10340,10359,10370,10373,10374,10375,10376,10497,10538,10581,10584,10601,10602,10641,10643,10717,10719,10737,10776,10800,10809,10813,10817,10821,10822,10823,10825,10827,10836,10882,10925,10930,10936,10937,10938,10939,10943,10944,10945,10946,10947,10948,10950,10951,10952,10988,10996,11018,11054,11073,11075,11076,11077,11078,11099,11100,11101,11111,11120,11121,11141,11143,11256,11262,11277,11278,11279,11281,11284,11285,11286,11287,11441,11444,11445,11446,11447,11448,11450,11466,11467,11484,11496,11497,11498,11521,11560,11583,11627,11672,11688,11690,11702,11713,11714,11815,11857,11876,11886,11887,11920,11937,11983,12017,12037,12116,12124,12125,12126,12128,12129,12140,12141,12143,12148,12151,12180,12208,12237,12265,12319,12320,12321,12339,12352,12356,12357,12369,12381,12382,12416,12420,12422,12435,12457,12458,12459,12460,12461,12463,12464,12465,12467,12468,12557,12580,12581,12739,12799,12805,12806,12860,12876,12900,12904,12918,12921,12923,12924,12925,12936,12937,12938,12940,12976,12977,13036,13136,13156,13160,13279,13301,13431,13432,13444,13696,13736,13738,13739,13740,13741,13742,13976,13996,14022,14023,14024,14025,14081,14121,14221,14223,14225,14226,14227,14228,14229,14233,14241,14242,14262,14263,14264,14268,14269,14275,14281,14321,14322,14323,14324,14325,14326,14337,14338,14340,14342,14345,14351,14353,14372,14385,14386,14389,14396,14397,14401,14429,14445,14448,14452,14454,14456,14457,14461,14462,14464,14471,14474,14475,14482,14483,14485,14486,14488,14489,14490,14491,14494,14500,14502,14503,14504,14506,14511,14512,14513,14514,14516,14518,14519,14520,14521,14524,14525,14526,14530,14533,14534,14535,14538,14564,14568,14603,14604,14638,14639,14640,14662,14663,14664,14666,14668,14884,14888,14965,14987,15009,15041,15047,15068,15084,15101,15112,15117,15122,15138,15146,15163,15193,15195,15197,15198,15199,15204,15206,15207,15208,15209,15211,15212,15220,15224,15229,15260,15261,15302,15307,15353,15354,15362,15363,15477,15508,15515,15556,15557,15558,15560,15563,15572,15574,15575,15577,15585,15587,15588,15593,15596,15598,15600,15603,15606,15667,15718,15739,15852,15853,15854,15857,15858,15859,15862,15868,15984,16016,16033,16059,16062,16097,16101,16102,16119,16157,16158,16179,16290,16361,16365,16368,16381,16387,16409,16446,16448,16449,16453,16494,16775,16809,16939,17085,17427,17461,17464,17465,17521,17536,17671,17695,17839,17955,17995,17996,18046,18050,18051,18055,18056,18177,18185,18298,18432,18434,18530,18554,18603,18604,18605,18607,18609,18610,18611,18612,18613,18614,18617,18618,18619,18621,18674,18728,19055,19241,19274,19305,19419,19420,19477,19556,19597,19604,19833,19884,19885,19886,19887,19888,19889,19890,19891,19892,19893,19894,19895,19897,19900,19902,19903,19904,19952,20001,20002,20157,20160,20164,20165,20168,20169,20173,20174,20175,20177,20179,20180,20181,20183,20184,20187,20188,20190,20191,20192,20193,20208,20477,20479,20494,20496,20565,20566,20567,20568,20574,20576,20577,20579,20580,20581,20582,20583,20584,20586,20587,20588,20589,20590,20591,20593,20594,20595,20596,20597,20599,20623,20626,20682,20741,20744,20749,20918,20927,21027,21104,21123,21124,21156,21271,21444,21645,21646,21723,21724,21788,21789,21790,21817,21821,21823,21841,21842,21843,22026,22162,22163,22164,22169,22171,22172,22257,22322,22337,22466,22924,22932,22938,22981,22997,23053,23140,23149,23370,23489,23786,24818,26943,27340,28034,28035,29256,29273,29360,29388,29438,29444,30264,31383,31900,32877,34127,36566,36572,37546,40281,40312);

-- Import vanilla creature attack speeds from vmangos, there might be duplicates in the entries above and below

UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=314; -- 'Eliza' BaseAttackTime was 1341
UPDATE `creature_template` SET `BaseAttackTime`=0 WHERE `entry`=364; -- 'Slime' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=450; -- 'Defias Renegade Mage' BaseAttackTime was 1780
UPDATE `creature_template` SET `BaseAttackTime`=1960 WHERE `entry`=460; -- 'Alamar Grimm' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=462; -- 'Vultros' BaseAttackTime was 1458
UPDATE `creature_template` SET `BaseAttackTime`=1720 WHERE `entry`=541; -- 'Riding Gryphon' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=575; -- 'Fire Elemental' BaseAttackTime was 1490
UPDATE `creature_template` SET `BaseAttackTime`=2800 WHERE `entry`=584; -- 'Kazon' BaseAttackTime was 1425
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=603; -- 'Grimtooth' BaseAttackTime was 1166
UPDATE `creature_template` SET `BaseAttackTime`=1970 WHERE `entry`=706; -- 'Frostmane Troll Whelp' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1960 WHERE `entry`=714; -- 'Talin Keeneye' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1325 WHERE `entry`=763; -- 'Lost One Chieftain' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=775; -- 'Kurzen's Agent' BaseAttackTime was 1610
UPDATE `creature_template` SET `BaseAttackTime`=1960 WHERE `entry`=786; -- 'Grelin Whitebeard' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1960 WHERE `entry`=808; -- 'Grik'nir the Cold' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=818; -- 'Mai'Zoth' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1960 WHERE `entry`=836; -- 'Durnan Furcutter' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1960 WHERE `entry`=837; -- 'Branstock Khalder' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1960 WHERE `entry`=944; -- 'Marryk Nurribit' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=947; -- 'Rohh the Silent' BaseAttackTime was 1425
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=954; -- 'Kat Sampson' BaseAttackTime was 1840
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1001; -- 'Watcher Hutchins' BaseAttackTime was 1810
UPDATE `creature_template` SET `BaseAttackTime`=1175 WHERE `entry`=1047; -- 'Red Scalebane' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1166 WHERE `entry`=1048; -- 'Scalebane Lieutenant' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1141 WHERE `entry`=1049; -- 'Wyrmkin Firebrand' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1158 WHERE `entry`=1050; -- 'Scalebane Royal Guard' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=1054; -- 'Dark Iron Demolitionist' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1900 WHERE `entry`=1133; -- 'Starving Winter Wolf' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=1154; -- 'Marek Ironheart' BaseAttackTime was 1860
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=1155; -- 'Kelt Thomasin' BaseAttackTime was 1860
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=1156; -- 'Vyrin Swiftwind' BaseAttackTime was 1860
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1174; -- 'Tunnel Rat Geomancer' BaseAttackTime was 1860
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1175; -- 'Tunnel Rat Digger' BaseAttackTime was 1860
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1177; -- 'Tunnel Rat Surveyor' BaseAttackTime was 1860
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=1187; -- 'Daryl the Youngling' BaseAttackTime was 1860
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1203; -- 'Watcher Sarys' BaseAttackTime was 1660
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1204; -- 'Watcher Corwin' BaseAttackTime was 1630
UPDATE `creature_template` SET `BaseAttackTime`=1466 WHERE `entry`=1210; -- 'Chok'sul' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1222; -- 'Dark Iron Sapper' BaseAttackTime was 1810
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1225; -- 'Ol' Sooty' BaseAttackTime was 1538
UPDATE `creature_template` SET `BaseAttackTime`=1980 WHERE `entry`=1354; -- 'Apprentice Soren' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=1364; -- 'Balgaras the Foul' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1380; -- 'Saean' BaseAttackTime was 1880
UPDATE `creature_template` SET `BaseAttackTime`=1441 WHERE `entry`=1398; -- 'Boss Galgosh' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1425; -- 'Grizlak' BaseAttackTime was 1525
UPDATE `creature_template` SET `BaseAttackTime`=1570 WHERE `entry`=1514; -- 'Mokk the Savage' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1533; -- 'Tormented Spirit' BaseAttackTime was 1575
UPDATE `creature_template` SET `BaseAttackTime`=1275 WHERE `entry`=1552; -- 'Scale Belly' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1685; -- 'Xandar Goodbeard' BaseAttackTime was 1860
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1686; -- 'Irene Sureshot' BaseAttackTime was 1860
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1687; -- 'Cliff Hadin' BaseAttackTime was 1860
UPDATE `creature_template` SET `BaseAttackTime`=1910 WHERE `entry`=1700; -- 'Paxton Ganter' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1755; -- 'Marzon the Silent Blade' BaseAttackTime was 1710
UPDATE `creature_template` SET `BaseAttackTime`=1166 WHERE `entry`=1836; -- 'Scarlet Cavalier' BaseAttackTime was 2400
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=1843; -- 'Foreman Jerris' BaseAttackTime was 1133
UPDATE `creature_template` SET `BaseAttackTime`=2400 WHERE `entry`=1844; -- 'Foreman Marcrid' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=1847; -- 'Foulmane' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1166 WHERE `entry`=1850; -- 'Putridius' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1871; -- 'Eliza's Guard' BaseAttackTime was 1740
UPDATE `creature_template` SET `BaseAttackTime`=1541 WHERE `entry`=1892; -- 'Moonrage Watcher' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1466 WHERE `entry`=1920; -- 'Dalaran Spellscribe' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1466 WHERE `entry`=1944; -- 'Rot Hide Bruiser' BaseAttackTime was 3200
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1946; -- 'Lillith Nefara' BaseAttackTime was 1860
UPDATE `creature_template` SET `BaseAttackTime`=1840 WHERE `entry`=1960; -- 'Pilot Hammerfoot' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1574 WHERE `entry`=1964; -- 'Treant' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=1981; -- 'Dark Iron Ambusher' BaseAttackTime was 1890
UPDATE `creature_template` SET `BaseAttackTime`=1760 WHERE `entry`=2044; -- 'Forlorn Spirit' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2056; -- 'Ravenclaw Apparition' BaseAttackTime was 1770
UPDATE `creature_template` SET `BaseAttackTime`=1508 WHERE `entry`=2060; -- 'Councilman Smithers' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1516 WHERE `entry`=2061; -- 'Councilman Thatcher' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1508 WHERE `entry`=2062; -- 'Councilman Hendricks' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1541 WHERE `entry`=2063; -- 'Councilman Wilhelm' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1541 WHERE `entry`=2064; -- 'Councilman Hartin' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1541 WHERE `entry`=2065; -- 'Councilman Cooper' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1541 WHERE `entry`=2066; -- 'Councilman Higarth' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1541 WHERE `entry`=2067; -- 'Councilman Brunswick' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1508 WHERE `entry`=2068; -- 'Lord Mayor Morrison' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1491 WHERE `entry`=2106; -- 'Apothecary Berard' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1408 WHERE `entry`=2108; -- 'Garneg Charskull' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1575 WHERE `entry`=2166; -- 'Oakenscowl' BaseAttackTime was 2700
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2191; -- 'Licillin' BaseAttackTime was 1525
UPDATE `creature_template` SET `BaseAttackTime`=1450 WHERE `entry`=2192; -- 'Firecaller Radison' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1720 WHERE `entry`=2224; -- 'Wind Rider' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=2257; -- 'Mug'thol' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1300 WHERE `entry`=2275; -- 'Enraged Stanley' BaseAttackTime was 1770
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=2287; -- 'Crushridge Warmonger' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1350 WHERE `entry`=2304; -- 'Captain Ironhill' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=2416; -- 'Crushridge Plunderer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=2417; -- 'Grel'borg the Miser' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=2420; -- 'Targ' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2433; -- 'Helcular's Remains' BaseAttackTime was 1258
UPDATE `creature_template` SET `BaseAttackTime`=1358 WHERE `entry`=2452; -- 'Skhowl' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2454; -- 'Skeletal Fiend (Enraged Form)' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2475; -- 'Sloth' BaseAttackTime was 1700
UPDATE `creature_template` SET `BaseAttackTime`=1475 WHERE `entry`=2476; -- 'Large Loch Crocolisk' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1466 WHERE `entry`=2477; -- 'Gradok' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1466 WHERE `entry`=2478; -- 'Haren Swifthoof' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2479; -- 'Sludge' BaseAttackTime was 1700
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2502; -- '"Shaky" Phillipe' BaseAttackTime was 2400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2528; -- 'Mountaineer Haggil' BaseAttackTime was 1710
UPDATE `creature_template` SET `BaseAttackTime`=1860 WHERE `entry`=2540; -- 'Dalaran Serpent' BaseAttackTime was 1000
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=2584; -- 'Stromgarde Defender' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=2588; -- 'Syndicate Prowler' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2598; -- 'Darbel Montrose' BaseAttackTime was 1325
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=2606; -- 'Nimar the Slayer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1266 WHERE `entry`=2607; -- 'Prince Galen Trollbane' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2624; -- 'Gazban' BaseAttackTime was 1600
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=2641; -- 'Vilebranch Headhunter' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1250 WHERE `entry`=2642; -- 'Vilebranch Shadowcaster' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=2643; -- 'Vilebranch Berserker' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=2648; -- 'Vilebranch Aman'zasi Guard' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2667; -- 'Ward of Laze' BaseAttackTime was 1640
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2675; -- 'Explosive Sheep' BaseAttackTime was 1710
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2678; -- 'Mechanical Dragonling' BaseAttackTime was 1540
UPDATE `creature_template` SET `BaseAttackTime`=1300 WHERE `entry`=2726; -- 'Scorched Guardian' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=2748; -- 'Archaedas' BaseAttackTime was 2600
UPDATE `creature_template` SET `BaseAttackTime`=1275 WHERE `entry`=2752; -- 'Rumbler' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2753; -- 'Barnabus' BaseAttackTime was 1600
UPDATE `creature_template` SET `BaseAttackTime`=1216 WHERE `entry`=2757; -- 'Blacklash' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1241 WHERE `entry`=2759; -- 'Hematus' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2779; -- 'Prince Nazjak' BaseAttackTime was 1283
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=2780; -- 'Caretaker Nevlin' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=2781; -- 'Caretaker Weston' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=2782; -- 'Caretaker Alaric' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=2783; -- 'Marez Cowl' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1000 WHERE `entry`=2850; -- 'Broken Tooth' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=2892; -- 'Stonevault Seer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2919; -- 'Fam'retor Guardian' BaseAttackTime was 1560
UPDATE `creature_template` SET `BaseAttackTime`=1358 WHERE `entry`=2932; -- 'Magregan Deepshadow' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2937; -- 'Dagun the Ravenous' BaseAttackTime was 1258
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2983; -- 'The Plains Vision' BaseAttackTime was 1940
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=2992; -- 'Healing Ward V' BaseAttackTime was 1680
UPDATE `creature_template` SET `BaseAttackTime`=1420 WHERE `entry`=3094; -- 'Unseen' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=3257; -- 'Ishamuhale' BaseAttackTime was 1820
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=3295; -- 'Sludge Beast' BaseAttackTime was 1450
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=3395; -- 'Verog the Dervish' BaseAttackTime was 1810
UPDATE `creature_template` SET `BaseAttackTime`=1820 WHERE `entry`=3417; -- 'Living Flame' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=3451; -- 'Pilot Wizzlecrank' BaseAttackTime was 1860
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=3454; -- 'Cannoneer Smythe' BaseAttackTime was 1810
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=3455; -- 'Cannoneer Whessan' BaseAttackTime was 1810
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=3475; -- 'Echeyakee' BaseAttackTime was 1538
UPDATE `creature_template` SET `BaseAttackTime`=1525 WHERE `entry`=3532; -- 'Pyrewood Leatherworker' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1550 WHERE `entry`=3535; -- 'Blackmoss the Fetid' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=3545; -- 'Claude Erksine' BaseAttackTime was 1610
UPDATE `creature_template` SET `BaseAttackTime`=1720 WHERE `entry`=3574; -- 'Riding Bat' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=3672; -- 'Boahn' BaseAttackTime was 1475
UPDATE `creature_template` SET `BaseAttackTime`=1760 WHERE `entry`=3722; -- 'Mystlash Flayer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1450 WHERE `entry`=3735; -- 'Apothecary Falthis' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=3799; -- 'Severed Druid' BaseAttackTime was 1710
UPDATE `creature_template` SET `BaseAttackTime`=1720 WHERE `entry`=3837; -- 'Riding Hippogryph' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=3844; -- 'Healing Ward IV' BaseAttackTime was 1770
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4004; -- 'Windshear Overlord' BaseAttackTime was 1600
UPDATE `creature_template` SET `BaseAttackTime`=1450 WHERE `entry`=4015; -- 'Pridewing Patriarch' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4049; -- 'Seereth Stonebreak' BaseAttackTime was 1750
UPDATE `creature_template` SET `BaseAttackTime`=1425 WHERE `entry`=4056; -- 'Mirkfallon Keeper' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=4066; -- 'Nal'taszar' BaseAttackTime was 2600
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4068; -- 'Serpent Messenger' BaseAttackTime was 1910
UPDATE `creature_template` SET `BaseAttackTime`=1350 WHERE `entry`=4132; -- 'Silithid Ravager' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4263; -- 'Deepmoss Hatchling' BaseAttackTime was 1870
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4264; -- 'Deepmoss Matriarch' BaseAttackTime was 1770
UPDATE `creature_template` SET `BaseAttackTime`=1275 WHERE `entry`=4339; -- 'Brimgore' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4342; -- 'Drywallow Vicejaw' BaseAttackTime was 1650
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4355; -- 'Bloodfen Scytheclaw' BaseAttackTime was 1640
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4358; -- 'Mirefin Puddlejumper' BaseAttackTime was 1610
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4360; -- 'Mirefin Warrior' BaseAttackTime was 1610
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=4364; -- 'Strashaz Warrior' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=4366; -- 'Strashaz Serpent Guard' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1141 WHERE `entry`=4368; -- 'Strashaz Myrmidon' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1141 WHERE `entry`=4370; -- 'Strashaz Sorceress' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1158 WHERE `entry`=4371; -- 'Strashaz Siren' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1141 WHERE `entry`=4374; -- 'Strashaz Hydra' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4386; -- 'Withervine Bark Ripper' BaseAttackTime was 1610
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4396; -- 'Mudrock Tortoise' BaseAttackTime was 1640
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4398; -- 'Mudrock Burrower' BaseAttackTime was 1620
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4399; -- 'Mudrock Borer' BaseAttackTime was 1590
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4400; -- 'Mudrock Snapjaw' BaseAttackTime was 1600
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4402; -- 'Muckshell Snapclaw' BaseAttackTime was 1530
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4405; -- 'Muckshell Razorclaw' BaseAttackTime was 1510
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4411; -- 'Darkfang Lurker' BaseAttackTime was 1650
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4413; -- 'Darkfang Spider' BaseAttackTime was 1650
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4425; -- 'Blind Hunter' BaseAttackTime was 1383
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=4468; -- 'Jade Sludge' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4504; -- 'Frostmaw' BaseAttackTime was 1610
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4509; -- 'Sargath' BaseAttackTime was 1810
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4795; -- 'Force of Nature' BaseAttackTime was 1850
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=4847; -- 'Shadowforge Relic Hunter' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=4848; -- 'Shadowforge Darkcaster' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=4849; -- 'Shadowforge Archaeologist' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=4853; -- 'Stonevault Geomancer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1275 WHERE `entry`=4854; -- 'Grimlok' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=4855; -- 'Stonevault Brawler' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=4857; -- 'Stone Keeper' BaseAttackTime was 2800
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=4860; -- 'Stone Steward' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4947; -- 'Theramore Lieutenant' BaseAttackTime was 1490
UPDATE `creature_template` SET `BaseAttackTime`=1670 WHERE `entry`=4971; -- 'Slim's Friend' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=4972; -- 'Kagoro' BaseAttackTime was 1610
UPDATE `creature_template` SET `BaseAttackTime`=1760 WHERE `entry`=4977; -- 'Murkshallow Softshell' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=5097; -- 'Lupine Delusion' BaseAttackTime was 1466
UPDATE `creature_template` SET `BaseAttackTime`=1158 WHERE `entry`=5312; -- 'Lethlas' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1266 WHERE `entry`=5343; -- 'Lady Szallah' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=5349; -- 'Arash-ethis' BaseAttackTime was 1241
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=5350; -- 'Qirot' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=5352; -- 'Old Grizzlegut' BaseAttackTime was 1291
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=5357; -- 'Land Walker' BaseAttackTime was 2600
UPDATE `creature_template` SET `BaseAttackTime`=1266 WHERE `entry`=5358; -- 'Cliff Giant' BaseAttackTime was 2700
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=5432; -- 'Giant Surf Glider' BaseAttackTime was 1241
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=5435; -- 'Sand Shark' BaseAttackTime was 1541
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=5466; -- 'Coast Strider' BaseAttackTime was 2600
UPDATE `creature_template` SET `BaseAttackTime`=1266 WHERE `entry`=5467; -- 'Deep Dweller' BaseAttackTime was 2500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=5666; -- 'Gunther's Visage' BaseAttackTime was 1480
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=5780; -- 'Cloned Ectoplasm' BaseAttackTime was 1491
UPDATE `creature_template` SET `BaseAttackTime`=1550 WHERE `entry`=5785; -- 'Sister Hatelash' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1575 WHERE `entry`=5808; -- 'Warlord Kolkanis' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2500 WHERE `entry`=5809; -- 'Watch Commander Zalaphil' BaseAttackTime was 1575
UPDATE `creature_template` SET `BaseAttackTime`=2700 WHERE `entry`=5827; -- 'Brontus' BaseAttackTime was 1425
UPDATE `creature_template` SET `BaseAttackTime`=1300 WHERE `entry`=5828; -- 'Humar the Pridelord' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1266 WHERE `entry`=5833; -- 'Margol the Rager' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=5847; -- 'Heggin Stonewhisker' BaseAttackTime was 1450
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=5848; -- 'Malgin Barleybrew' BaseAttackTime was 1441
UPDATE `creature_template` SET `BaseAttackTime`=1425 WHERE `entry`=5851; -- 'Captain Gerogg Hammertoe' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=5865; -- 'Dishu' BaseAttackTime was 1525
UPDATE `creature_template` SET `BaseAttackTime`=1408 WHERE `entry`=5915; -- 'Brother Ravenoak' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=5934; -- 'Heartrazor' BaseAttackTime was 1383
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=5935; -- 'Ironeye the Invincible' BaseAttackTime was 1341
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=5981; -- 'Portal Seeker' BaseAttackTime was 1420
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6021; -- 'Boar Spirit' BaseAttackTime was 1441
UPDATE `creature_template` SET `BaseAttackTime`=1760 WHERE `entry`=6047; -- 'Aqua Guardian' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6071; -- 'Legion Hound' BaseAttackTime was 1700
UPDATE `creature_template` SET `BaseAttackTime`=1860 WHERE `entry`=6113; -- 'Vejrek' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6123; -- 'Dark Iron Spy' BaseAttackTime was 1900
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6124; -- 'Captain Beld' BaseAttackTime was 1860
UPDATE `creature_template` SET `BaseAttackTime`=1175 WHERE `entry`=6134; -- 'Lord Arkkoroc' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1216 WHERE `entry`=6140; -- 'Hetaera' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=6144; -- 'Son of Arkkoroc' BaseAttackTime was 2800
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=6215; -- 'Chomper' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1760 WHERE `entry`=6221; -- 'Addled Leper' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6225; -- 'Mechano-Tank' BaseAttackTime was 1333
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6226; -- 'Mechano-Flamewalker' BaseAttackTime was 1333
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6227; -- 'Mechano-Frostwalker' BaseAttackTime was 1333
UPDATE `creature_template` SET `BaseAttackTime`=1358 WHERE `entry`=6228; -- 'Dark Iron Ambassador' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6238; -- 'Big Will' BaseAttackTime was 1620
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6239; -- 'Cyclonian' BaseAttackTime was 1300
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6240; -- 'Affray Challenger' BaseAttackTime was 1750
UPDATE `creature_template` SET `BaseAttackTime`=1960 WHERE `entry`=6376; -- 'Wren Darkspring' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6390; -- 'Ulag the Cleaver' BaseAttackTime was 1910
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6490; -- 'Azshir the Sleepless' BaseAttackTime was 1341
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6550; -- 'Mana Surge' BaseAttackTime was 1610
UPDATE `creature_template` SET `BaseAttackTime`=1850 WHERE `entry`=6577; -- 'Bingles Blastenheimer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1233 WHERE `entry`=6581; -- 'Ravasaur Matriarch' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1175 WHERE `entry`=6583; -- 'Gruff' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6649; -- 'Lady Sesspira' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6650; -- 'General Fangferror' BaseAttackTime was 1225
UPDATE `creature_template` SET `BaseAttackTime`=1740 WHERE `entry`=6729; -- 'Morridune' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=6733; -- 'Stonevault Basher' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=6866; -- 'Defias Bodyguard' BaseAttackTime was 1890
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=6867; -- 'Tracking Hound' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1890 WHERE `entry`=6886; -- 'Onin MacHammar' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1510 WHERE `entry`=7011; -- 'Earthen Rocksmasher' BaseAttackTime was 2700
UPDATE `creature_template` SET `BaseAttackTime`=1510 WHERE `entry`=7012; -- 'Earthen Sculptor' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=7016; -- 'Lady Vespira' BaseAttackTime was 1466
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=7023; -- 'Obsidian Sentinel' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1266 WHERE `entry`=7030; -- 'Shadowforge Geologist' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1520 WHERE `entry`=7076; -- 'Earthen Guardian' BaseAttackTime was 2300
UPDATE `creature_template` SET `BaseAttackTime`=1510 WHERE `entry`=7077; -- 'Earthen Hallshaper' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1466 WHERE `entry`=7170; -- 'Thragomm' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1410 WHERE `entry`=7172; -- 'Lore Keeper of Norgannon' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=7206; -- 'Ancient Stone Keeper' BaseAttackTime was 2800
UPDATE `creature_template` SET `BaseAttackTime`=1550 WHERE `entry`=7228; -- 'Ironaya' BaseAttackTime was 2900
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=7267; -- 'Chief Ukorz Sandscalp' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1275 WHERE `entry`=7273; -- 'Gahz'rilla' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1266 WHERE `entry`=7275; -- 'Shadowpriest Sezz'ziz' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=7290; -- 'Shadowforge Sharpshooter' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1000 WHERE `entry`=7291; -- 'Galgann Firehammer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1510 WHERE `entry`=7309; -- 'Earthen Custodian' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=7319; -- 'Lady Sathrah' BaseAttackTime was 1880
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=7320; -- 'Stonevault Mauler' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=7321; -- 'Stonevault Flameweaver' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1650 WHERE `entry`=7349; -- 'Tomb Fiend' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1358 WHERE `entry`=7351; -- 'Tomb Reaver' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1200 WHERE `entry`=7354; -- 'Ragglesnout' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1325 WHERE `entry`=7355; -- 'Tuten'kash' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=7360; -- 'Dun Garok Soldier' BaseAttackTime was 1710
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=7361; -- 'Grubbis' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1510 WHERE `entry`=7396; -- 'Earthen Stonebreaker' BaseAttackTime was 2700
UPDATE `creature_template` SET `BaseAttackTime`=1510 WHERE `entry`=7397; -- 'Earthen Stonecarver' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=7527; -- 'Goblin Land Mine' BaseAttackTime was 1580
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=7729; -- 'Spirit of Kirith' BaseAttackTime was 1460
UPDATE `creature_template` SET `BaseAttackTime`=1760 WHERE `entry`=7768; -- 'Witherbark Bloodling' BaseAttackTime was 1000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=7772; -- 'Kalin Windflight' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=1580 WHERE `entry`=7787; -- 'Sandfury Slave' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1560 WHERE `entry`=7788; -- 'Sandfury Drudge' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=7796; -- 'Nekrum Gutchewer' BaseAttackTime was 2500
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=7797; -- 'Ruuzlu' BaseAttackTime was 2600
UPDATE `creature_template` SET `BaseAttackTime`=1510 WHERE `entry`=7808; -- 'Marauding Owlbeast' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=7809; -- 'Vilebranch Ambusher' BaseAttackTime was 1520
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=7846; -- 'Teremus the Devourer' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2500 WHERE `entry`=7848; -- 'Lurking Feral Scar' BaseAttackTime was 1520
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=7918; -- 'Stone Watcher of Norgannon' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=7995; -- 'Vile Priestess Hexx' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1450 WHERE `entry`=8017; -- 'Sen'jin Guardian' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1690 WHERE `entry`=8035; -- 'Dark Iron Land Mine' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8055; -- 'Thelsamar Mountaineer' BaseAttackTime was 1610
UPDATE `creature_template` SET `BaseAttackTime`=1710 WHERE `entry`=8118; -- 'Lillian Singh' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8204; -- 'Soriid the Devourer' BaseAttackTime was 1233
UPDATE `creature_template` SET `BaseAttackTime`=1233 WHERE `entry`=8205; -- 'Haarka the Ravenous' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8213; -- 'Ironback' BaseAttackTime was 1216
UPDATE `creature_template` SET `BaseAttackTime`=1216 WHERE `entry`=8214; -- 'Jalinde Summerdrake' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2600 WHERE `entry`=8215; -- 'Grimungous' BaseAttackTime was 1233
UPDATE `creature_template` SET `BaseAttackTime`=1275 WHERE `entry`=8218; -- 'Witherheart the Stalker' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1250 WHERE `entry`=8296; -- 'Mojo the Twisted' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8297; -- 'Magronos the Unyielding' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=1191 WHERE `entry`=8298; -- 'Akubar the Seer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1300 WHERE `entry`=8300; -- 'Ravage' BaseAttackTime was 1216
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8301; -- 'Clack the Reaver' BaseAttackTime was 1208
UPDATE `creature_template` SET `BaseAttackTime`=1241 WHERE `entry`=8302; -- 'Deatheye' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8317; -- 'Atal'ai Deathwalker's Spirit' BaseAttackTime was 1258
UPDATE `creature_template` SET `BaseAttackTime`=1730 WHERE `entry`=8320; -- 'Sprok' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1460 WHERE `entry`=8338; -- 'Dark Iron Marksman' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8391; -- 'Lathoric the Black' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8392; -- 'Pilot Xiggs Fuselighter' BaseAttackTime was 1560
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8437; -- 'Hakkari Minion' BaseAttackTime was 1550
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8438; -- 'Hakkari Bloodkeeper' BaseAttackTime was 1258
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8440; -- 'Shade of Hakkar' BaseAttackTime was 1666
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8446; -- 'Xiggs Fuselighter's Flyingmachine' BaseAttackTime was 1560
UPDATE `creature_template` SET `BaseAttackTime`=1216 WHERE `entry`=8480; -- 'Kalaran the Deceiver' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8497; -- 'Nightmare Suppressor' BaseAttackTime was 1258
UPDATE `creature_template` SET `BaseAttackTime`=1550 WHERE `entry`=8503; -- 'Gibblewilt' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8504; -- 'Dark Iron Sentry' BaseAttackTime was 1258
UPDATE `creature_template` SET `BaseAttackTime`=1250 WHERE `entry`=8660; -- 'The Evalcharr' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=8756; -- 'Raytaf' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=8757; -- 'Shahiar' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=8758; -- 'Zaman' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1570 WHERE `entry`=8876; -- 'Sandfury Acolyte' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1560 WHERE `entry`=8877; -- 'Sandfury Zealot' BaseAttackTime was 2400
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=8923; -- 'Panzor the Invincible' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2800 WHERE `entry`=8924; -- 'The Behemoth' BaseAttackTime was 1233
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8932; -- 'Borer Beetle' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=8933; -- 'Cave Creeper' BaseAttackTime was 1480
UPDATE `creature_template` SET `BaseAttackTime`=1800 WHERE `entry`=9027; -- 'Gorosh the Dervish' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=2400 WHERE `entry`=9032; -- 'Hedrum the Creeper' BaseAttackTime was 1208
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9217; -- 'Spirestone Lord Magus' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9218; -- 'Spirestone Battle Lord' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9219; -- 'Spirestone Butcher' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=1300 WHERE `entry`=9236; -- 'Shadow Hunter Vosh'gajin' BaseAttackTime was 800
UPDATE `creature_template` SET `BaseAttackTime`=1333 WHERE `entry`=9237; -- 'War Master Voone' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9241; -- 'Smolderthorn Headhunter' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9260; -- 'Firebrand Legionnaire' BaseAttackTime was 1166
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9263; -- 'Firebrand Dreadweaver' BaseAttackTime was 1166
UPDATE `creature_template` SET `BaseAttackTime`=1300 WHERE `entry`=9264; -- 'Firebrand Pyromancer' BaseAttackTime was 1158
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9266; -- 'Smolderthorn Witch Doctor' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9299; -- 'Gaeriyan' BaseAttackTime was 1440
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9398; -- 'Twilight's Hammer Executioner' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9437; -- 'Dark Keeper Vorfalk' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9445; -- 'Dark Guard' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=9448; -- 'Scarlet Praetorian' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=9451; -- 'Scarlet Archmage' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9453; -- 'Aquementas' BaseAttackTime was 1470
UPDATE `creature_template` SET `BaseAttackTime`=2400 WHERE `entry`=9456; -- 'Warlord Krom'zar' BaseAttackTime was 1770
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9457; -- 'Horde Defender' BaseAttackTime was 1830
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9458; -- 'Horde Axe Thrower' BaseAttackTime was 1850
UPDATE `creature_template` SET `BaseAttackTime`=2500 WHERE `entry`=9462; -- 'Chieftain Bloodmaw' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1530 WHERE `entry`=9498; -- 'Gorishi Grub' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1200 WHERE `entry`=9520; -- 'Grark Lorkrub' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9522; -- 'Blackrock Ambusher' BaseAttackTime was 1191
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9568; -- 'Overlord Wyrmthalak' BaseAttackTime was 800
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9596; -- 'Bannok Grimaxe' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=1200 WHERE `entry`=9604; -- 'Gorgon'och' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2600 WHERE `entry`=9605; -- 'Blackrock Raider' BaseAttackTime was 1420
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=9708; -- 'Burning Imp' BaseAttackTime was 1490
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9716; -- 'Bloodaxe Warmonger' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9717; -- 'Bloodaxe Summoner' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=9736; -- 'Quartermaster Zigris' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=1200 WHERE `entry`=10077; -- 'Deathmaw' BaseAttackTime was 1208
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=10078; -- 'Terrorspark' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=10120; -- 'Vault Warder' BaseAttackTime was 2500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10184; -- 'Onyxia' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=10197; -- 'Mezzir the Howler' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=10198; -- 'Kashoch the Reaver' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1158 WHERE `entry`=10199; -- 'Grizzle Snowpaw' BaseAttackTime was 2800
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=10200; -- 'Rak'shiri' BaseAttackTime was 1667
UPDATE `creature_template` SET `BaseAttackTime`=1141 WHERE `entry`=10201; -- 'Lady Hederine' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1100 WHERE `entry`=10220; -- 'Halycon' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10221; -- 'Bloodaxe Worg Pup' BaseAttackTime was 1490
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10257; -- 'Bijou' BaseAttackTime was 1191
UPDATE `creature_template` SET `BaseAttackTime`=2600 WHERE `entry`=10264; -- 'Solakar Flamewreath' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10268; -- 'Gizrul the Slavener' BaseAttackTime was 1166
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10340; -- 'Vaelastrasz the Red' BaseAttackTime was 1158
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10359; -- 'Sri'skulk' BaseAttackTime was 1541
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=10374; -- 'Spire Spider' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=10376; -- 'Crystal Fang' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=1420 WHERE `entry`=10388; -- 'Spiteful Phantom' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1410 WHERE `entry`=10389; -- 'Wrath Phantom' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=3000 WHERE `entry`=10506; -- 'Kirtonos the Herald' BaseAttackTime was 1600
UPDATE `creature_template` SET `BaseAttackTime`=1450 WHERE `entry`=10559; -- 'Lady Vespia' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=250 WHERE `entry`=10577; -- 'Crypt Scarab' BaseAttackTime was 200
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10579; -- 'Kirtonos the Herald (Spell Visual)' BaseAttackTime was 1600
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10581; -- 'Young Arikara' BaseAttackTime was 1508
UPDATE `creature_template` SET `BaseAttackTime`=3200 WHERE `entry`=10584; -- 'Urok Doomhowl' BaseAttackTime was 1166
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=10596; -- 'Mother Smolderweb' BaseAttackTime was 1100
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10601; -- 'Urok Enforcer' BaseAttackTime was 1208
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10602; -- 'Urok Ogre Magus' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=1425 WHERE `entry`=10642; -- 'Eck'alom' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10643; -- 'Mugglefin' BaseAttackTime was 1450
UPDATE `creature_template` SET `BaseAttackTime`=1350 WHERE `entry`=10647; -- 'Prince Raze' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2600 WHERE `entry`=10680; -- 'Summoned Blackhand Dreadweaver' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10717; -- 'Temporal Parasite' BaseAttackTime was 1440
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10719; -- 'Herald of Thrall' BaseAttackTime was 1510
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10720; -- 'Galak Assassin' BaseAttackTime was 1700
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=10737; -- 'Shy-Rotam' BaseAttackTime was 1538
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=10802; -- 'Hitah'ya the Keeper' BaseAttackTime was 2600
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10817; -- 'Duggan Wildhammer' BaseAttackTime was 1191
UPDATE `creature_template` SET `BaseAttackTime`=1175 WHERE `entry`=10826; -- 'Lord Darkscythe' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1158 WHERE `entry`=10828; -- 'High General Abbendis' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1700 WHERE `entry`=10836; -- 'Farmer Dalson' BaseAttackTime was 1450
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10882; -- 'Arikara' BaseAttackTime was 1441
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=10925; -- 'Rotting Worm' BaseAttackTime was 1450
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10930; -- 'Dargh Trueaim' BaseAttackTime was 1760
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10936; -- 'Joseph Redpath' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=1600 WHERE `entry`=10943; -- 'Decrepit Guardian' BaseAttackTime was 1216
UPDATE `creature_template` SET `BaseAttackTime`=1460 WHERE `entry`=10955; -- 'Summoned Water Elemental' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1410 WHERE `entry`=10985; -- 'Ice Giant' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=3000 WHERE `entry`=10988; -- 'Kodo Spirit' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=1410 WHERE `entry`=10989; -- 'Blizzard Elemental' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10991; -- 'Wildpaw Gnoll' BaseAttackTime was 1420
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=10996; -- 'Fallen Hero' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=11027; -- 'Illusory Wraith' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1141 WHERE `entry`=11058; -- 'Fras Siabi' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11075; -- 'Cauldron Lord Bilemaw' BaseAttackTime was 1480
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11076; -- 'Cauldron Lord Razarch' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11077; -- 'Cauldron Lord Malvinious' BaseAttackTime was 1460
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11078; -- 'Cauldron Lord Soulwrath' BaseAttackTime was 1440
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=11082; -- 'Stratholme Courier' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11099; -- 'Argent Guard' BaseAttackTime was 1460
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11120; -- 'Crimson Hammersmith' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11141; -- 'Spirit of Trey Lightforge' BaseAttackTime was 1233
UPDATE `creature_template` SET `BaseAttackTime`=1191 WHERE `entry`=11142; -- 'Undead Postman' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11256; -- 'Manifestation of Water' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11262; -- 'Onyxian Whelp' BaseAttackTime was 1216
UPDATE `creature_template` SET `BaseAttackTime`=1166 WHERE `entry`=11439; -- 'Illusion of Jandice Barov' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2500 WHERE `entry`=11441; -- 'Gordok Brute' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11444; -- 'Gordok Mage-Lord' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11445; -- 'Gordok Captain' BaseAttackTime was 1158
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11446; -- 'Gordok Spirit' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11466; -- 'Highborne Summoner' BaseAttackTime was 1216
UPDATE `creature_template` SET `BaseAttackTime`=1600 WHERE `entry`=11467; -- 'Tsu'zee' BaseAttackTime was 1166
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11484; -- 'Residual Monstrosity' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11496; -- 'Immol'thar' BaseAttackTime was 1158
UPDATE `creature_template` SET `BaseAttackTime`=3000 WHERE `entry`=11521; -- 'Kodo Apparition' BaseAttackTime was 1640
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11583; -- 'Nefarian' BaseAttackTime was 1020
UPDATE `creature_template` SET `BaseAttackTime`=1410 WHERE `entry`=11623; -- 'Scourge Summoning Crystal' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11672; -- 'Core Rager' BaseAttackTime was 1333
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11677; -- 'Taskmaster Snivvle' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11690; -- 'Gnarlpine Instigator' BaseAttackTime was 1930
UPDATE `creature_template` SET `BaseAttackTime`=2100 WHERE `entry`=11699; -- 'Varian Wrynn' BaseAttackTime was 800
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11702; -- 'Arin'sor' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11714; -- 'Marosh the Devious' BaseAttackTime was 1810
UPDATE `creature_template` SET `BaseAttackTime`=1870 WHERE `entry`=11836; -- 'Captured Rabid Thistle Bear' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11857; -- 'Makaba Flathoof' BaseAttackTime was 1760
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11876; -- 'Demon Spirit' BaseAttackTime was 1650
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11886; -- 'Mercutio Filthgorger' BaseAttackTime was 1440
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11887; -- 'Crypt Robber' BaseAttackTime was 1420
UPDATE `creature_template` SET `BaseAttackTime`=1175 WHERE `entry`=11898; -- 'Crusader Lord Valdelmar' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11937; -- 'Demon Portal Guardian' BaseAttackTime was 1630
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11946; -- 'Drek'Thar' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11949; -- 'Captain Balinda Stonehearth' BaseAttackTime was 2400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11981; -- 'Flamegor' BaseAttackTime was 1300
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11983; -- 'Firemaw' BaseAttackTime was 1466
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=11998; -- 'Frostwolf Herald' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12116; -- 'Priestess of Elune' BaseAttackTime was 1666
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12128; -- 'Crimson Elite' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12129; -- 'Onyxian Warder' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=1860 WHERE `entry`=12138; -- 'Lunaclaw' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12140; -- 'Guardian of Elune' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12143; -- 'Son of Flame' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=1880 WHERE `entry`=12144; -- 'Lunaclaw Spirit' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1530 WHERE `entry`=12204; -- 'Spitelash Raider' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1520 WHERE `entry`=12205; -- 'Spitelash Witch' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=12257; -- 'Mechanical Yeti' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1420 WHERE `entry`=12261; -- 'Infected Mossflayer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=12265; -- 'Lava Spawn' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12339; -- 'Demetria' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12352; -- 'Scarlet Trooper' BaseAttackTime was 1430
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12369; -- 'Lord Kragaru' BaseAttackTime was 1630
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12381; -- 'Ley Sprite' BaseAttackTime was 1430
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12382; -- 'Mana Sprite' BaseAttackTime was 1440
UPDATE `creature_template` SET `BaseAttackTime`=1800 WHERE `entry`=12397; -- 'Lord Kazzak' BaseAttackTime was 800
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12416; -- 'Blackwing Legionnaire' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12420; -- 'Blackwing Mage' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12422; -- 'Death Talon Dragonspawn' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12435; -- 'Razorgore the Untamed' BaseAttackTime was 1450
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12457; -- 'Blackwing Spellbinder' BaseAttackTime was 1091
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12458; -- 'Blackwing Taskmaster' BaseAttackTime was 1158
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12459; -- 'Blackwing Warlock' BaseAttackTime was 1091
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12460; -- 'Death Talon Wyrmguard' BaseAttackTime was 1083
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12461; -- 'Death Talon Overseer' BaseAttackTime was 1091
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12463; -- 'Death Talon Flamescale' BaseAttackTime was 1091
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12464; -- 'Death Talon Seether' BaseAttackTime was 1091
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12465; -- 'Death Talon Wyrmkin' BaseAttackTime was 1091
UPDATE `creature_template` SET `BaseAttackTime`=2400 WHERE `entry`=12467; -- 'Death Talon Captain' BaseAttackTime was 1091
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12468; -- 'Death Talon Hatcher' BaseAttackTime was 1141
UPDATE `creature_template` SET `BaseAttackTime`=1141 WHERE `entry`=12496; -- 'Dreamtracker' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1158 WHERE `entry`=12497; -- 'Dreamroarer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12557; -- 'Grethok the Controller' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12580; -- 'Reginald Windsor' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12581; -- 'Mercutio' BaseAttackTime was 1990
UPDATE `creature_template` SET `BaseAttackTime`=1960 WHERE `entry`=12738; -- 'Nori Pridedrift' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=12788; -- 'Legionnaire Teena' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=12789; -- 'Blood Guard Hini'wana' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=12790; -- 'Advisor Willington' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=12791; -- 'Chieftain Earthbind' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1460 WHERE `entry`=12794; -- 'Stone Guard Zarg' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1410 WHERE `entry`=12795; -- 'First Sergeant Hola'mahi' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1460 WHERE `entry`=12796; -- 'Raider Bork' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=12797; -- 'Grunt Korf' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=12798; -- 'Grunt Bek'rah' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12799; -- 'Sergeant Ba'sha' BaseAttackTime was 1460
UPDATE `creature_template` SET `BaseAttackTime`=1166 WHERE `entry`=12800; -- 'Chimaerok' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=12801; -- 'Arcane Chimaerok' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1166 WHERE `entry`=12802; -- 'Chimaerok Devourer' BaseAttackTime was 1200
UPDATE `creature_template` SET `BaseAttackTime`=1158 WHERE `entry`=12803; -- 'Lord Lakmaeran' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12805; -- 'Officer Areyn' BaseAttackTime was 1460
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12860; -- 'Duriel Moonfire' BaseAttackTime was 1710
UPDATE `creature_template` SET `BaseAttackTime`=1341 WHERE `entry`=12865; -- 'Ambassador Malcin' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1158 WHERE `entry`=12898; -- 'Phantim Illusion' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12900; -- 'Somnus' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12921; -- 'Enraged Foulweald' BaseAttackTime was 1770
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12923; -- 'Injured Soldier' BaseAttackTime was 1570
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12924; -- 'Badly Injured Soldier' BaseAttackTime was 1550
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12925; -- 'Critically Injured Soldier' BaseAttackTime was 1530
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12936; -- 'Badly Injured Alliance Soldier' BaseAttackTime was 1570
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12937; -- 'Critically Injured Alliance Soldier' BaseAttackTime was 1510
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12938; -- 'Injured Alliance Soldier' BaseAttackTime was 1580
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12940; -- 'Vorsha the Lasher' BaseAttackTime was 1760
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12976; -- 'Kolkar Waylayer' BaseAttackTime was 1620
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=12977; -- 'Kolkar Ambusher' BaseAttackTime was 1610
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13020; -- 'Vaelastrasz the Corrupt' BaseAttackTime was 1600
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=13036; -- 'Gordok Mastiff' BaseAttackTime was 1460
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13088; -- 'Masha Swiftcut' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13136; -- 'Hive'Ashi Drone' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13139; -- 'Commander Randolph' BaseAttackTime was 1141
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=13160; -- 'Carrion Swarmer' BaseAttackTime was 1450
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13178; -- 'War Rider' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13256; -- 'Lokholar the Ice Lord' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=1175 WHERE `entry`=13278; -- 'Duke Hydraxis' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13297; -- 'Lieutenant Stouthandle' BaseAttackTime was 1166
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13300; -- 'Lieutenant Mancuso' BaseAttackTime was 1158
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13316; -- 'Coldmine Peon' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=1200 WHERE `entry`=13322; -- 'Hydraxian Honor Guard' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13328; -- 'Seasoned Guardian' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13331; -- 'Veteran Defender' BaseAttackTime was 1380
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13332; -- 'Veteran Guardian' BaseAttackTime was 1380
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13421; -- 'Champion Guardian' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=13422; -- 'Champion Defender' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13431; -- 'Whulwert Copperpinch' BaseAttackTime was 1710
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13432; -- 'Seersa Copperpinch' BaseAttackTime was 1710
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13441; -- 'Frostwolf Wolf Rider Commander' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13444; -- 'Greatfather Winter' BaseAttackTime was 1710
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=13516; -- 'Frostwolf Outrunner' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=13517; -- 'Seasoned Outrunner' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=13518; -- 'Veteran Outrunner' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=13519; -- 'Champion Outrunner' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=13520; -- 'Stormpike Ranger' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=13521; -- 'Seasoned Ranger' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=13522; -- 'Veteran Ranger' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=13523; -- 'Champion Ranger' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2800 WHERE `entry`=13535; -- 'Veteran Coldmine Guard' BaseAttackTime was 1200
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13538; -- 'Veteran Coldmine Surveyor' BaseAttackTime was 1200
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13540; -- 'Seasoned Irondeep Explorer' BaseAttackTime was 1191
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13541; -- 'Veteran Irondeep Explorer' BaseAttackTime was 1208
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13542; -- 'Champion Irondeep Explorer' BaseAttackTime was 1191
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13543; -- 'Seasoned Irondeep Raider' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13544; -- 'Veteran Irondeep Raider' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13545; -- 'Champion Irondeep Raider' BaseAttackTime was 1208
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13552; -- 'Seasoned Irondeep Guard' BaseAttackTime was 1225
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13553; -- 'Veteran Irondeep Guard' BaseAttackTime was 1200
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13555; -- 'Seasoned Irondeep Surveyor' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13556; -- 'Veteran Irondeep Surveyor' BaseAttackTime was 1225
UPDATE `creature_template` SET `BaseAttackTime`=1375 WHERE `entry`=13602; -- 'The Abominable Greench' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13616; -- 'Frostwolf Stable Master' BaseAttackTime was 1158
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13959; -- 'Alterac Yeti' BaseAttackTime was 1166
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13976; -- 'Tortured Drake' BaseAttackTime was 1666
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=13996; -- 'Blackwing Technician' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14020; -- 'Chromaggus' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14022; -- 'Corrupted Red Whelp' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14023; -- 'Corrupted Green Whelp' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14024; -- 'Corrupted Blue Whelp' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14025; -- 'Corrupted Bronze Whelp' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=1208 WHERE `entry`=14061; -- 'Phase Lasher (Fire)' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1208 WHERE `entry`=14062; -- 'Phase Lasher (Nature)' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1208 WHERE `entry`=14063; -- 'Phase Lasher (Arcane)' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14081; -- 'Demon Portal' BaseAttackTime was 1630
UPDATE `creature_template` SET `BaseAttackTime`=2300 WHERE `entry`=14101; -- 'Enraged Felguard' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14121; -- 'Deeprun Diver' BaseAttackTime was 1810
UPDATE `creature_template` SET `BaseAttackTime`=1208 WHERE `entry`=14184; -- 'Phase Lasher (Frost)' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1358 WHERE `entry`=14222; -- 'Araga' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14223; -- 'Cranky Benj' BaseAttackTime was 1383
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14227; -- 'Hissperak' BaseAttackTime was 1341
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14228; -- 'Giggler' BaseAttackTime was 1366
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14233; -- 'Ripscale' BaseAttackTime was 1325
UPDATE `creature_template` SET `BaseAttackTime`=1291 WHERE `entry`=14235; -- 'The Rot' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1258 WHERE `entry`=14236; -- 'Lord Angler' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1300 WHERE `entry`=14237; -- 'Oozeworm' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=14261; -- 'Blue Drakonid' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14262; -- 'Green Drakonid' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14264; -- 'Red Drakonid' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=14265; -- 'Black Drakonid' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1450 WHERE `entry`=14267; -- 'Emogg the Crusher' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14268; -- 'Lord Condar' BaseAttackTime was 1483
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14269; -- 'Seeker Aqualon' BaseAttackTime was 1450
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=14276; -- 'Scargil' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14281; -- 'Jimmy the Bleeder' BaseAttackTime was 1450
UPDATE `creature_template` SET `BaseAttackTime`=1970 WHERE `entry`=14305; -- 'Human Orphan' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14321; -- 'Guard Fengus' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14322; -- 'Stomper Kreeg' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14323; -- 'Guard Slip'kik' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14324; -- 'Cho'Rush the Observer' BaseAttackTime was 1158
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14325; -- 'Captain Kromcrush' BaseAttackTime was 1141
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14326; -- 'Guard Mol'dar' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14337; -- 'Field Repair Bot 74A' BaseAttackTime was 1510
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14338; -- 'Knot Thimblejack' BaseAttackTime was 1510
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14344; -- 'Mongress' BaseAttackTime was 1250
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14345; -- 'The Ongar' BaseAttackTime was 1225
UPDATE `creature_template` SET `BaseAttackTime`=1158 WHERE `entry`=14348; -- 'Earthcaller Franzahl' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14353; -- 'Mizzle the Crafty' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2800 WHERE `entry`=14372; -- 'Winterfall Ambusher' BaseAttackTime was 1450
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14386; -- 'Wandering Eye of Kilrogg' BaseAttackTime was 1440
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14401; -- 'Master Elemental Shaper Krixix' BaseAttackTime was 1158
UPDATE `creature_template` SET `BaseAttackTime`=1441 WHERE `entry`=14424; -- 'Mirelow' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1750 WHERE `entry`=14435; -- 'Prince Thunderaan' BaseAttackTime was 800
UPDATE `creature_template` SET `BaseAttackTime`=1970 WHERE `entry`=14444; -- 'Orcish Orphan' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14445; -- 'Lord Captain Wyrmak' BaseAttackTime was 1258
UPDATE `creature_template` SET `BaseAttackTime`=1275 WHERE `entry`=14446; -- 'Fingat' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1291 WHERE `entry`=14447; -- 'Gilmorian' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2700 WHERE `entry`=14448; -- 'Molt Thorn' BaseAttackTime was 1291
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14456; -- 'Blackwing Guardsman' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=1216 WHERE `entry`=14467; -- 'Kroshius' BaseAttackTime was 3000
UPDATE `creature_template` SET `BaseAttackTime`=1175 WHERE `entry`=14472; -- 'Gretheer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1166 WHERE `entry`=14477; -- 'Grubthor' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1158 WHERE `entry`=14478; -- 'Huricanian' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=14479; -- 'Twilight Lord Everun' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1910 WHERE `entry`=14481; -- 'Emmithue Smails' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14484; -- 'Injured Peasant' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14485; -- 'Plagued Peasant' BaseAttackTime was 1490
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14489; -- 'Scourge Archer' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14494; -- 'Eris Havenfire' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14500; -- 'J'eevee' BaseAttackTime was 1430
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14503; -- 'The Cleaner' BaseAttackTime was 1166
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14515; -- 'High Priestess Arlokk' BaseAttackTime was 1100
UPDATE `creature_template` SET `BaseAttackTime`=1175 WHERE `entry`=14531; -- 'Artorius the Amiable' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14535; -- 'Artorius the Doombringer' BaseAttackTime was 1183
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14538; -- 'Precious the Devourer' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14564; -- 'Terrordale Spirit' BaseAttackTime was 1420
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14601; -- 'Ebonroc' BaseAttackTime was 1100
UPDATE `creature_template` SET `BaseAttackTime`=1000 WHERE `entry`=14605; -- 'Bone Construct' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14668; -- 'Corrupted Infernal' BaseAttackTime was 1420
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=14697; -- 'Lumbering Horror' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1410 WHERE `entry`=14732; -- 'PvP CTF Credit Marker' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1520 WHERE `entry`=14748; -- 'Vilebranch Kidnapper' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14751; -- 'Frostwolf Battle Standard' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14767; -- 'Tower Point Marshal' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14768; -- 'East Frostwolf Marshal' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14862; -- 'Emissary Roman'khan' BaseAttackTime was 780
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14884; -- 'Parasitic Serpent' BaseAttackTime was 1008
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14888; -- 'Lethon' BaseAttackTime was 1075
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14890; -- 'Taerar' BaseAttackTime was 1000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14943; -- 'Guse's War Rider' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14944; -- 'Jeztor's War Rider' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14945; -- 'Mulverick's War Rider' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14946; -- 'Slidore's Gryphon' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14947; -- 'Ichman's Gryphon' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14948; -- 'Vipore's Gryphon' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=1000 WHERE `entry`=14965; -- 'Frenzied Bloodseeker Bat' BaseAttackTime was 1440
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14986; -- 'Shade of Jin'do' BaseAttackTime was 950
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=14987; -- 'Powerful Healing Ward' BaseAttackTime was 1430
UPDATE `creature_template` SET `BaseAttackTime`=1600 WHERE `entry`=14988; -- 'Ohgan' BaseAttackTime was 1200
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15009; -- 'Voodoo Spirit' BaseAttackTime was 1666
UPDATE `creature_template` SET `BaseAttackTime`=1460 WHERE `entry`=15011; -- 'Wagner Hammerstrike' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1460 WHERE `entry`=15012; -- 'Javnir Nashak' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=15041; -- 'Spawn of Mar'li' BaseAttackTime was 1440
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15047; -- 'Gurubashi' BaseAttackTime was 1666
UPDATE `creature_template` SET `BaseAttackTime`=1600 WHERE `entry`=15068; -- 'Zulian Guardian' BaseAttackTime was 1440
UPDATE `creature_template` SET `BaseAttackTime`=2500 WHERE `entry`=15083; -- 'Hazza'rah' BaseAttackTime was 1300
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=15084; -- 'Renataki' BaseAttackTime was 1108
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15090; -- 'Swift Razzashi Raptor' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=1600 WHERE `entry`=15101; -- 'Zulian Prowler' BaseAttackTime was 1440
UPDATE `creature_template` SET `BaseAttackTime`=1410 WHERE `entry`=15113; -- 'Honored Hero' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15114; -- 'Gahz'ranka' BaseAttackTime was 1100
UPDATE `creature_template` SET `BaseAttackTime`=1410 WHERE `entry`=15115; -- 'Honored Ancestor' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15117; -- 'Chained Spirit' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=1440 WHERE `entry`=15136; -- 'Hammerfall Elite' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15146; -- 'Mad Voidwalker' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=3000 WHERE `entry`=15163; -- 'Nightmare Illusion' BaseAttackTime was 1410
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15193; -- 'The Banshee Queen' BaseAttackTime was 1666
UPDATE `creature_template` SET `BaseAttackTime`=3000 WHERE `entry`=15195; -- 'Wickerman Guardian' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15197; -- 'Darkcaller Yanka' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15199; -- 'Sergeant Hartman' BaseAttackTime was 1175
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15206; -- 'The Duke of Cynders' BaseAttackTime was 1133
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15208; -- 'The Duke of Shards' BaseAttackTime was 1133
UPDATE `creature_template` SET `BaseAttackTime`=1158 WHERE `entry`=15215; -- 'Mistress Natalia Mar'alith' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15220; -- 'The Duke of Zephyrs' BaseAttackTime was 1133
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15224; -- 'Dream Fog' BaseAttackTime was 1666
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15229; -- 'Vekniss Soldier' BaseAttackTime was 1667
UPDATE `creature_template` SET `BaseAttackTime`=1300 WHERE `entry`=15299; -- 'Viscidus' BaseAttackTime was 1750
UPDATE `creature_template` SET `BaseAttackTime`=1183 WHERE `entry`=15308; -- 'Twilight Prophet' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1739 WHERE `entry`=15309; -- 'Spoops' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15340; -- 'Moam' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15353; -- 'Katrina Shimmerstar' BaseAttackTime was 1710
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15354; -- 'Rachelle Gothena' BaseAttackTime was 1710
UPDATE `creature_template` SET `BaseAttackTime`=0 WHERE `entry`=15361; -- 'Murki' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15362; -- 'Malfurion Stormrage' BaseAttackTime was 1666
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15381; -- 'Anachronos the Ancient' BaseAttackTime was 1000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15429; -- 'Disgusting Oozeling' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=1200 WHERE `entry`=15443; -- 'Janela Stouthammer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1250 WHERE `entry`=15444; -- 'Arcanist Nozzlespring' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15462; -- 'Spitting Scarab' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15477; -- 'Herbalist Proudfeather' BaseAttackTime was 1231
UPDATE `creature_template` SET `BaseAttackTime`=1200 WHERE `entry`=15505; -- 'Canal Frenzy' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15508; -- 'Batrider Pele'keiki' BaseAttackTime was 1260
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15515; -- 'Skinner Jamani' BaseAttackTime was 1231
UPDATE `creature_template` SET `BaseAttackTime`=1200 WHERE `entry`=15516; -- 'Battleguard Sartura' BaseAttackTime was 144000
UPDATE `creature_template` SET `BaseAttackTime`=2700 WHERE `entry`=15517; -- 'Ouro' BaseAttackTime was 1750
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15521; -- 'Hive'Zara Hatchling' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15527; -- 'Mana Fiend' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15528; -- 'Healer Longrunner' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=1000 WHERE `entry`=15546; -- 'Hive'Zara Swarmer' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15549; -- 'Elder Morndeep' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1200 WHERE `entry`=15554; -- 'Number Two' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15555; -- 'Hive'Zara Larva' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15567; -- 'Elder Ironband' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15569; -- 'Elder Goldwell' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15570; -- 'Elder Primestone' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15573; -- 'Elder Ragetotem' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15578; -- 'Elder Wildmane' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15581; -- 'Elder Grimtotem' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15583; -- 'Elder Thunderhorn' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15584; -- 'Elder Skyseer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15586; -- 'Elder Dreamseer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15595; -- 'Elder Bladeleaf' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15598; -- 'Elder Bladeswift' BaseAttackTime was 1390
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15599; -- 'Elder Bladesing' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15601; -- 'Elder Starweave' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15604; -- 'Elder Morningdew' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15605; -- 'Elder Riversong' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1390 WHERE `entry`=15607; -- 'Elder Farwhisper' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=15612; -- 'Krug Skullsplit' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=15613; -- 'Merok Longstride' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=15615; -- 'Shadow Priestess Shai' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=15617; -- 'Orgrimmar Legion Axe Thrower' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15630; -- 'Spawn of Fankriss' BaseAttackTime was 1000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15667; -- 'Glob of Viscidus' BaseAttackTime was 1150
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15696; -- 'War Effort Recruit' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15698; -- 'Father Winter's Helper' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15700; -- 'Warlord Gorchuk' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15702; -- 'Senior Sergeant Taiga' BaseAttackTime was 1200
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15704; -- 'Senior Sergeant Kai'jin' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15707; -- 'Master Sergeant Fizzlebolt' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15708; -- 'Master Sergeant Maclure' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=1000 WHERE `entry`=15718; -- 'Ouro Scarab' BaseAttackTime was 1430
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15739; -- 'Thunder Bluff Commendation Officer' BaseAttackTime was 1216
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15740; -- 'Colossus of Zora' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15741; -- 'Colossus of Regal' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15742; -- 'Colossus of Ashi' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15743; -- 'Colossal Anubisath Warbringer' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15744; -- 'Imperial Qiraji Destroyer' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15745; -- 'Greatfather Winter's Helper' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15818; -- 'Lieutenant General Nokhor' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15852; -- 'Orgrimmar Elite Shieldguard' BaseAttackTime was 1420
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15853; -- 'Orgrimmar Elite Infantryman' BaseAttackTime was 1420
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15854; -- 'Orgrimmar Elite Cavalryman' BaseAttackTime was 1420
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15857; -- 'Stormwind Cavalryman' BaseAttackTime was 1460
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15858; -- 'Stormwind Infantryman' BaseAttackTime was 1460
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15859; -- 'Stormwind Archmage' BaseAttackTime was 1460
UPDATE `creature_template` SET `BaseAttackTime`=2700 WHERE `entry`=15860; -- 'Kaldorei Marksman' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15862; -- 'Ironforge Cavalryman' BaseAttackTime was 1420
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15866; -- 'High Commander Lynore Windstryke' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15868; -- 'Highlord Leoric Von Zeldig' BaseAttackTime was 1450
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15869; -- 'Malagav the Tactician' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15870; -- 'Duke August Foehammer' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=0 WHERE `entry`=15902; -- 'Giant Spotlight' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1300 WHERE `entry`=15903; -- 'Sergeant Carnes' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15904; -- 'Tentacle Portal' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15910; -- 'Giant Tentacle Portal' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=15928; -- 'Thaddius' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=15931; -- 'Grobbulus' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=15932; -- 'Gluth' BaseAttackTime was 1600
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=15936; -- 'Heigan the Unclean' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1750 WHERE `entry`=15953; -- 'Grand Widow Faerlina' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=15954; -- 'Noth the Plaguebringer' BaseAttackTime was 2400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15963; -- 'The Master's Eye' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=15964; -- 'Buru Egg Trigger' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=15974; -- 'Dread Creeper' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=15975; -- 'Carrion Spinner' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=15976; -- 'Venom Stalker' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=15978; -- 'Crypt Reaver' BaseAttackTime was 1200
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=15979; -- 'Tomb Horror' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=15980; -- 'Naxxramas Cultist' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=15981; -- 'Naxxramas Acolyte' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1600 WHERE `entry`=15984; -- 'Sartura's Royal Guard' BaseAttackTime was 1920
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=15989; -- 'Sapphiron' BaseAttackTime was 1800
UPDATE `creature_template` SET `BaseAttackTime`=1800 WHERE `entry`=15990; -- 'Kel'Thuzad' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16001; -- 'Aldris Fourclouds' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16002; -- 'Colara Dean' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16003; -- 'Deathguard Tor' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16004; -- 'Elenia Haydon' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16005; -- 'Lieutenant Jocryn Heldric' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16007; -- 'Orok Deathbane' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16008; -- 'Temma of the Wells' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16009; -- 'Tormek Stoneriver' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=16011; -- 'Loatheb' BaseAttackTime was 1250
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=16017; -- 'Patchwork Golem' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=16018; -- 'Bile Retcher' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16020; -- 'Mad Scientist' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=16021; -- 'Living Monstrosity' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16022; -- 'Surgical Assistant' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16024; -- 'Embalming Slime' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=16029; -- 'Sludge Belcher' BaseAttackTime was 2500
UPDATE `creature_template` SET `BaseAttackTime`=1200 WHERE `entry`=16042; -- 'Lord Valthalak' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=3000 WHERE `entry`=16057; -- 'Rotting Maggot' BaseAttackTime was 2500
UPDATE `creature_template` SET `BaseAttackTime`=1480 WHERE `entry`=16060; -- 'Gothik the Harvester' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1425 WHERE `entry`=16061; -- 'Instructor Razuvious' BaseAttackTime was 3500
UPDATE `creature_template` SET `BaseAttackTime`=2500 WHERE `entry`=16063; -- 'Sir Zeliek' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2500 WHERE `entry`=16064; -- 'Thane Korth'azz' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16065; -- 'Lady Blaumeux' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16098; -- 'Empyrean' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16105; -- 'Aristan Mottar' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16106; -- 'Evert Sorisam' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16107; -- 'Apothecary Staffron Lerent' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16108; -- 'Fenstad Argyle' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16109; -- 'Mara Rennick' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=16110; -- 'Annalise Lerent' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1810 WHERE `entry`=16112; -- 'Korfax' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1810 WHERE `entry`=16113; -- 'Father Inigo Montoy' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1250 WHERE `entry`=16114; -- 'Scarlet Commander Marjhan' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1810 WHERE `entry`=16115; -- 'Commander Eligor Dawnbringer' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1810 WHERE `entry`=16116; -- 'Archmage Angela Dosantos' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1100 WHERE `entry`=16118; -- 'Kormok' BaseAttackTime was 1600
UPDATE `creature_template` SET `BaseAttackTime`=1930 WHERE `entry`=16119; -- 'Bone Minion' BaseAttackTime was 1430
UPDATE `creature_template` SET `BaseAttackTime`=0 WHERE `entry`=16121; -- 'Mortar' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=16124; -- 'Unrelenting Trainee' BaseAttackTime was 1800
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16127; -- 'Spectral Trainee' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=16129; -- 'Shadow Fissure' BaseAttackTime was 5500
UPDATE `creature_template` SET `BaseAttackTime`=1810 WHERE `entry`=16131; -- 'Rohan the Assassin' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1810 WHERE `entry`=16132; -- 'Huntsman Leopold' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1810 WHERE `entry`=16133; -- 'Mataus the Wrathcaster' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1810 WHERE `entry`=16134; -- 'Rimblat Earthshatter' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1810 WHERE `entry`=16135; -- 'Rayne' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=16143; -- 'Shadow of Doom' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16149; -- 'Spectral Horse' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16156; -- 'Dark Touched Warrior' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16164; -- 'Shade of Naxxramas' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16165; -- 'Necro Knight' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1860 WHERE `entry`=16167; -- 'Bony Construct' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16168; -- 'Stoneskin Gargoyle' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16193; -- 'Skeletal Smith' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1600 WHERE `entry`=16216; -- 'Unholy Swords' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1289 WHERE `entry`=16226; -- 'Guard Didier' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=16232; -- 'Caravan Mule' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16236; -- 'Eye Stalk' BaseAttackTime was 1000
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=16241; -- 'Argent Recruiter' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16243; -- 'Plague Slime' BaseAttackTime was 1800
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16244; -- 'Infectious Ghoul' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16375; -- 'Sewage Slime' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16390; -- 'Deathchill Servant' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16447; -- 'Plagued Ghoul' BaseAttackTime was 1500
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=16474; -- 'Blizzard' BaseAttackTime was 3000
UPDATE `creature_template` SET `BaseAttackTime`=1350 WHERE `entry`=16478; -- 'Lieutenant Orrin' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=16479; -- 'Polymorph Clone' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16505; -- 'Naxxramas Follower' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16506; -- 'Naxxramas Worshipper' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16573; -- 'Crypt Guard' BaseAttackTime was 1000
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=16697; -- 'Void Zone' BaseAttackTime was 1000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16698; -- 'Corpse Scarab' BaseAttackTime was 1000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16783; -- 'Plague Slime (Blue)' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16784; -- 'Plague Slime (Red)' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16785; -- 'Plague Slime (Green)' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1400 WHERE `entry`=16786; -- 'Argent Quartermaster' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=16980; -- 'The Lich King' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=1150 WHERE `entry`=16998; -- 'Mr. Bigglesworth' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=17041; -- 'Orgrimmar Fireeater' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=17048; -- 'Ironforge Firebreather' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=17049; -- 'Darnassus Firebreather' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=17050; -- 'Thunder Bluff Fireeater' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=2000 WHERE `entry`=17051; -- 'Undercity Fireeater' BaseAttackTime was 1400
UPDATE `creature_template` SET `BaseAttackTime`=500 WHERE `entry`=17055; -- 'Maexxna Spiderling' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1289 WHERE `entry`=17209; -- 'William Kielar' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=0 WHERE `entry`=17286; -- 'Invisible Man' BaseAttackTime was 2000
UPDATE `creature_template` SET `BaseAttackTime`=1200 WHERE `entry`=17766; -- 'Horde Silithyst Sentinel' BaseAttackTime was 2000
