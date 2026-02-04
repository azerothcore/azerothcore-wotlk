-- Recalculate quaternion rotation from orientation for unverified gameobjects
UPDATE `gameobject` SET `rotation2` = SIN(`orientation` / 2), `rotation3` = COS(`orientation` / 2) WHERE `rotation0` = 0 AND `rotation1` = 0 AND (`VerifiedBuild` IS NULL OR `VerifiedBuild` = 0);

-- Add transport parent_rotation values (from TrinityCore/UDB)
DELETE FROM `gameobject_addon` WHERE `guid` IN (14139,16760,16761,16871,20505,24055,24074,24075,25138,34057,35693,35694,55230,56744,56937,56954,56961,57132,57133,57140,57141,57799,57992,57993,57994,57995,57996,58299,58304,58305,58306,58310,58782,58824,58935,59160,59328,59336,59343,59350,59386,59762,59763,59764,59765,59766,59779,59780,59781,59782,59783,60421,60463,61053,65435,65436,65438,65439,65520,66717,67873,67874,67875,67876);
INSERT INTO `gameobject_addon` (`guid`,`parent_rotation0`,`parent_rotation1`,`parent_rotation2`,`parent_rotation3`,`invisibilityType`,`invisibilityValue`) VALUES
(14139,0,0,1,-0.0000000437114,0,0),
(16760,0,0,-0.378575,0.92557,0,0),
(16761,0,0,-0.378575,0.92557,0,0),
(16871,0,0,0.694658,0.71934,0,0),
(20505,0,0,-0.694658,0.71934,0,0),
(24055,0,0,-0.526214,0.850352,0,0),
(24074,0,0,-0.526214,0.850352,0,0),
(24075,0,0,-0.526214,0.850352,0,0),
(25138,0,0,0.45399,0.891007,0,0),
(34057,0,0,0.000000325841,1,0,0),
(35693,0,0,0.989651,0.143493,0,0),
(35694,0,0,0.989651,0.143493,0,0),
(55230,0,0,0.999048,0.0436193,0,0),
(56744,0,0,0.951057,0.309017,0,0),
(56937,0,0,0.951057,0.309017,0,0),
(56954,0,0,0.951057,0.309017,0,0),
(56961,0,0,0.999048,0.0436193,0,0),
(57132,-0.00276125,-0.00551835,-0.370553,0.928791,0,0),
(57133,0.00544418,-0.00290476,0.918772,0.394739,0,0),
(57140,-0.00276125,-0.00551835,-0.370553,0.928791,0,0),
(57141,0.00544418,-0.00290476,0.918772,0.394739,0,0),
(57799,0,0,0.999048,0.0436193,0,0),
(57992,0,0,-0.370557,0.92881,0,0),
(57993,0,0,-0.760406,0.649448,0,0),
(57994,0,0,0.915312,0.402747,0,0),
(57995,0,0,-0.748956,0.66262,0,0),
(57996,0,0,0.995805,0.0915015,0,0),
(58299,0,0,0.999048,0.0436193,0,0),
(58304,0,0,-0.263031,0.964787,0,0),
(58305,0,0,0.522499,0.85264,0,0),
(58306,0,0,0.996917,-0.0784592,0,0),
(58310,0,0,0.333807,0.942641,0,0),
(58782,0,0,0.333807,0.942641,0,0),
(58824,0,0,0.333807,0.942641,0,0),
(58935,0,0,0.932008,-0.362438,0,0),
(59160,0,0,0.99999,0.00436324,0,0),
(59328,0,0,0.99999,-0.00436333,0,0),
(59336,0,0,0.99999,-0.00436333,0,0),
(59343,0,0,0.99999,-0.00436333,0,0),
(59350,0,0,0.99999,-0.00436333,0,0),
(59386,0,0,0.99999,-0.00436333,0,0),
(59762,0,0,-0.370557,0.92881,0,0),
(59763,0,0,-0.760406,0.649448,0,0),
(59764,0,0,0.915312,0.402747,0,0),
(59765,0,0,-0.748956,0.66262,0,0),
(59766,0,0,0.995805,0.0915015,0,0),
(59779,0,0,-0.370557,0.92881,0,0),
(59780,0,0,-0.760406,0.649448,0,0),
(59781,0,0,0.915312,0.402747,0,0),
(59782,0,0,-0.748956,0.66262,0,0),
(59783,0,0,0.995805,0.0915015,0,0),
(60421,0,0,0.99999,0.00436324,0,0),
(60463,0,0,0.999048,0.0436193,0,0),
(61053,0,0,0.999048,0.0436193,0,0),
(65435,0,0,0.915312,0.402747,0,0),
(65436,0,0,0.99999,0.00436324,0,0),
(65438,0,0,0.915312,0.402747,0,0),
(65439,0,0,0.915312,0.402747,0,0),
(65520,0,0,0.99999,0.00436324,0,0),
(66717,0,0,0.999657,0.0261769,0,0),
(67873,-0.00276125,-0.00551835,-0.370553,0.928791,0,0),
(67874,0.00544418,-0.00290476,0.918772,0.394739,0,0),
(67875,-0.00276125,-0.00551835,-0.370553,0.928791,0,0),
(67876,0.00544418,-0.00290476,0.918772,0.394739,0,0);

-- Import explicit rotation values for gameobjects with X/Y rotation (from TrinityCore/mangos-UDB)
UPDATE `gameobject` SET `rotation0`=0.00661993, `rotation1`=-0.0256987, `rotation2`=-0.913849, `rotation3`=0.405186 WHERE `guid`=31;
UPDATE `gameobject` SET `rotation0`=0.0217795, `rotation1`=0.0566788, `rotation2`=-0.998154, `rotation3`=0.00154408 WHERE `guid`=39;
UPDATE `gameobject` SET `rotation0`=0, `rotation1`=-1, `rotation2`=0, `rotation3`=0 WHERE `guid`=256;
UPDATE `gameobject` SET `rotation0`=0.0647478, `rotation1`=0.0103159, `rotation2`=-0.996012, `rotation3`=0.0605139 WHERE `guid`=422;
UPDATE `gameobject` SET `rotation0`=-0.0371165, `rotation1`=-0.0287819, `rotation2`=-0.959991, `rotation3`=0.276066 WHERE `guid`=425;
UPDATE `gameobject` SET `rotation0`=0.0527701, `rotation1`=0.0327311, `rotation2`=-0.980893, `rotation3`=0.184371 WHERE `guid`=428;
UPDATE `gameobject` SET `rotation0`=-0.0392456, `rotation1`=0.0261564, `rotation2`=0.998886, `rotation3`=0.00146484 WHERE `guid`=1643;
UPDATE `gameobject` SET `rotation0`=-0.0232878, `rotation1`=-0.0147963, `rotation2`=-0.969871, `rotation3`=0.242053 WHERE `guid`=1692;
UPDATE `gameobject` SET `rotation0`=-0.0346627, `rotation1`=-0.0136871, `rotation2`=-0.999145, `rotation3`=0.0179256 WHERE `guid`=1733;
UPDATE `gameobject` SET `rotation0`=0.681389, `rotation1`=-0.188966, `rotation2`=0.68139, `rotation3`=0.188967 WHERE `guid`=5141;
UPDATE `gameobject` SET `rotation0`=-0.316432, `rotation1`=-0.0235138, `rotation2`=-0.945716, `rotation3`=0.0702803 WHERE `guid`=5193;
UPDATE `gameobject` SET `rotation0`=0.309975, `rotation1`=-0.635543, `rotation2`=0.309974, `rotation3`=0.635543 WHERE `guid`=5205;
UPDATE `gameobject` SET `rotation0`=0.00517035, `rotation1`=-0.0122805, `rotation2`=-0.933433, `rotation3`=0.358505 WHERE `guid`=5352;
UPDATE `gameobject` SET `rotation0`=0.61994, `rotation1`=-0.340111, `rotation2`=0.619939, `rotation3`=0.34011 WHERE `guid`=5382;
UPDATE `gameobject` SET `rotation0`=0.607692, `rotation1`=-0.361538, `rotation2`=0.607693, `rotation3`=0.361539 WHERE `guid`=5398;
UPDATE `gameobject` SET `rotation0`=0.607692, `rotation1`=-0.361538, `rotation2`=0.607693, `rotation3`=0.361539 WHERE `guid`=5405;
UPDATE `gameobject` SET `rotation0`=0.147016, `rotation1`=-0.691655, `rotation2`=0.147016, `rotation3`=0.691655 WHERE `guid`=5425;
UPDATE `gameobject` SET `rotation0`=0.0828447, `rotation1`=0.0300417, `rotation2`=0.870979, `rotation3`=0.483352 WHERE `guid`=5514;
UPDATE `gameobject` SET `rotation0`=0.241845, `rotation1`=0.664462, `rotation2`=0.664463, `rotation3`=0.241847 WHERE `guid`=6166;
UPDATE `gameobject` SET `rotation0`=-0.120005, `rotation1`=0.0474339, `rotation2`=-0.901711, `rotation3`=0.412634 WHERE `guid`=6771;
UPDATE `gameobject` SET `rotation0`=-0.0218129, `rotation1`=-0.0130854, `rotation2`=-0.999676, `rotation3`=0.00117086 WHERE `guid`=6896;
UPDATE `gameobject` SET `rotation0`=-0.00554562, `rotation1`=0.00270462, `rotation2`=-0.945506, `rotation3`=0.325546 WHERE `guid`=6943;
UPDATE `gameobject` SET `rotation0`=0.00311899, `rotation1`=0.0220261, `rotation2`=-0.998138, `rotation3`=0.0567872 WHERE `guid`=6997;
UPDATE `gameobject` SET `rotation0`=-0.000787735, `rotation1`=-0.0194941, `rotation2`=-0.911526, `rotation3`=0.41078 WHERE `guid`=7016;
UPDATE `gameobject` SET `rotation0`=0.0240598, `rotation1`=-0.0310163, `rotation2`=-0.946024, `rotation3`=0.321711 WHERE `guid`=7033;
UPDATE `gameobject` SET `rotation0`=-0.517355, `rotation1`=-0.209099, `rotation2`=-0.745465, `rotation3`=0.364559 WHERE `guid`=11584;
UPDATE `gameobject` SET `rotation0`=0, `rotation1`=0.173648, `rotation2`=-0.98106, `rotation3`=0.0858351 WHERE `guid`=12045;
UPDATE `gameobject` SET `rotation0`=-0.0702071, `rotation1`=0.0758209, `rotation2`=-0.969868, `rotation3`=0.220633 WHERE `guid`=12126;
UPDATE `gameobject` SET `rotation0`=0.0112896, `rotation1`=-0.0421324, `rotation2`=-0.965006, `rotation3`=0.258575 WHERE `guid`=12153;
UPDATE `gameobject` SET `rotation0`=-0.13007, `rotation1`=0.0567751, `rotation2`=0.989808, `rotation3`=0.0117644 WHERE `guid`=13380;
UPDATE `gameobject` SET `rotation0`=-0.108055, `rotation1`=-0.0132675, `rotation2`=-0.98861, `rotation3`=0.103913 WHERE `guid`=14140;
UPDATE `gameobject` SET `rotation0`=0.045383, `rotation1`=0.0708761, `rotation2`=-0.883594, `rotation3`=0.460629 WHERE `guid`=15274;
UPDATE `gameobject` SET `rotation0`=0.045383, `rotation1`=0.0708761, `rotation2`=-0.883594, `rotation3`=0.460629 WHERE `guid`=15366;
UPDATE `gameobject` SET `rotation0`=0.00190258, `rotation1`=-0.0435772, `rotation2`=-0.998096, `rotation3`=0.0435988 WHERE `guid`=15561;
UPDATE `gameobject` SET `rotation0`=0.185185, `rotation1`=-0.389885, `rotation2`=-0.900506, `rotation3`=0.0527745 WHERE `guid`=17928;
UPDATE `gameobject` SET `rotation0`=0.171708, `rotation1`=-0.056263, `rotation2`=0.382931, `rotation3`=0.905933 WHERE `guid`=21760;
UPDATE `gameobject` SET `rotation0`=-0.0308428, `rotation1`=-0.000134468, `rotation2`=-0.704017, `rotation3`=0.709513 WHERE `guid`=21768;
UPDATE `gameobject` SET `rotation0`=-0.0229378, `rotation1`=0.0318613, `rotation2`=-0.810947, `rotation3`=0.583801 WHERE `guid`=21774;
UPDATE `gameobject` SET `rotation0`=-0.0175047, `rotation1`=0.00414562, `rotation2`=0.0124769, `rotation3`=0.99976 WHERE `guid`=21775;
UPDATE `gameobject` SET `rotation0`=0.0281639, `rotation1`=-0.00794315, `rotation2`=0.739404, `rotation3`=0.672626 WHERE `guid`=21777;
UPDATE `gameobject` SET `rotation0`=0.0193486, `rotation1`=0.00251198, `rotation2`=0.558642, `rotation3`=0.829179 WHERE `guid`=21778;
UPDATE `gameobject` SET `rotation0`=-0.00526476, `rotation1`=-0.0032177, `rotation2`=0.972073, `rotation3`=0.234599 WHERE `guid`=22676;
UPDATE `gameobject` SET `rotation0`=-0.00144768, `rotation1`=-0.00599766, `rotation2`=0.521473, `rotation3`=0.853246 WHERE `guid`=22681;
UPDATE `gameobject` SET `rotation0`=-0.00425291, `rotation1`=-0.00447083, `rotation2`=0.878231, `rotation3`=0.478197 WHERE `guid`=22682;
UPDATE `gameobject` SET `rotation0`=0.0059185, `rotation1`=0.00174522, `rotation2`=-0.999668, `rotation3`=0.025011 WHERE `guid`=22683;
UPDATE `gameobject` SET `rotation0`=0.0133157, `rotation1`=-0.0566292, `rotation2`=-0.9983, `rotation3`=0.00370258 WHERE `guid`=23388;
UPDATE `gameobject` SET `rotation0`=-0.0218129, `rotation1`=0.0130854, `rotation2`=0.999676, `rotation3`=0.00117086 WHERE `guid`=24026;
UPDATE `gameobject` SET `rotation0`=-0.0425816, `rotation1`=-0.0586815, `rotation2`=0.995896, `rotation3`=0.0541643 WHERE `guid`=24222;
UPDATE `gameobject` SET `rotation0`=-0.0627699, `rotation1`=0.0825901, `rotation2`=-0.992224, `rotation3`=0.0687813 WHERE `guid`=24223;
UPDATE `gameobject` SET `rotation0`=0.00614643, `rotation1`=-0.000543594, `rotation2`=-0.921, `rotation3`=0.389515 WHERE `guid`=24716;
UPDATE `gameobject` SET `rotation0`=0.0057869, `rotation1`=-0.002141, `rotation2`=-0.786171, `rotation3`=0.617978 WHERE `guid`=24718;
UPDATE `gameobject` SET `rotation0`=-0.00567293, `rotation1`=-0.0024271, `rotation2`=0.995696, `rotation3`=0.0924729 WHERE `guid`=24719;
UPDATE `gameobject` SET `rotation0`=0.00611162, `rotation1`=0.000849724, `rotation2`=-0.98495, `rotation3`=0.172729 WHERE `guid`=24720;
UPDATE `gameobject` SET `rotation0`=0.00600815, `rotation1`=0.00140476, `rotation2`=-0.996615, `rotation3`=0.0819735 WHERE `guid`=24722;
UPDATE `gameobject` SET `rotation0`=-0.00526476, `rotation1`=-0.0032177, `rotation2`=0.972073, `rotation3`=0.234599 WHERE `guid`=24726;
UPDATE `gameobject` SET `rotation0`=0.00599813, `rotation1`=-0.00144768, `rotation2`=-0.853245, `rotation3`=0.521474 WHERE `guid`=24742;
UPDATE `gameobject` SET `rotation0`=0.00387716, `rotation1`=-0.00479984, `rotation2`=-0.359471, `rotation3`=0.933136 WHERE `guid`=24745;
UPDATE `gameobject` SET `rotation0`=-0.00043869, `rotation1`=0.00434017, `rotation2`=-0.994905, `rotation3`=0.100727 WHERE `guid`=24760;
UPDATE `gameobject` SET `rotation0`=0.0261407, `rotation1`=-0.0523176, `rotation2`=0.998287, `rotation3`=0.00148505 WHERE `guid`=24869;
UPDATE `gameobject` SET `rotation0`=0.101759, `rotation1`=0.00521469, `rotation2`=0.9523, `rotation3`=0.28765 WHERE `guid`=25120;
UPDATE `gameobject` SET `rotation0`=0.0778918, `rotation1`=-0.124165, `rotation2`=0.683997, `rotation3`=0.714607 WHERE `guid`=25256;
UPDATE `gameobject` SET `rotation0`=0.106593, `rotation1`=-0.075654, `rotation2`=0.960539, `rotation3`=0.245519 WHERE `guid`=25257;
UPDATE `gameobject` SET `rotation0`=-0.0218129, `rotation1`=0.0130854, `rotation2`=0.999676, `rotation3`=0.00117086 WHERE `guid`=25913;
UPDATE `gameobject` SET `rotation0`=-0.59733, `rotation1`=-0.208596, `rotation2`=-0.731095, `rotation3`=0.255313 WHERE `guid`=26628;
UPDATE `gameobject` SET `rotation0`=-0.042439, `rotation1`=0.0258846, `rotation2`=-0.934402, `rotation3`=0.352734 WHERE `guid`=26846;
UPDATE `gameobject` SET `rotation0`=0.0240598, `rotation1`=-0.0310163, `rotation2`=-0.946024, `rotation3`=0.321711 WHERE `guid`=31662;
UPDATE `gameobject` SET `rotation0`=-0.00346088, `rotation1`=0.00462914, `rotation2`=0.577754, `rotation3`=0.81619 WHERE `guid`=32331;
UPDATE `gameobject` SET `rotation0`=0.118706, `rotation1`=0.0711489, `rotation2`=-0.899253, `rotation3`=0.414959 WHERE `guid`=42485;
UPDATE `gameobject` SET `rotation0`=-0.0733967, `rotation1`=-0.0395975, `rotation2`=0.686763, `rotation3`=0.722082 WHERE `guid`=42854;
UPDATE `gameobject` SET `rotation0`=0.00646782, `rotation1`=0.00192738, `rotation2`=0.999939, `rotation3`=0.00874828 WHERE `guid`=42958;
UPDATE `gameobject` SET `rotation0`=0.0646195, `rotation1`=0.0148668, `rotation2`=-0.997768, `rotation3`=0.00783916 WHERE `guid`=42985;
UPDATE `gameobject` SET `rotation0`=0.0384789, `rotation1`=0.0146103, `rotation2`=-0.999125, `rotation3`=0.00748919 WHERE `guid`=43182;
UPDATE `gameobject` SET `rotation0`=0.0646195, `rotation1`=0.0148668, `rotation2`=-0.997768, `rotation3`=0.00783916 WHERE `guid`=43193;
UPDATE `gameobject` SET `rotation0`=-0.0566726, `rotation1`=0.0261345, `rotation2`=0.998049, `rotation3`=0.00195313 WHERE `guid`=45565;
UPDATE `gameobject` SET `rotation0`=0.00597954, `rotation1`=-0.0124331, `rotation2`=-0.991918, `rotation3`=0.126131 WHERE `guid`=48526;
UPDATE `gameobject` SET `rotation0`=-0.402262, `rotation1`=-0.303519, `rotation2`=-0.679092, `rotation3`=0.533756 WHERE `guid`=48529;
UPDATE `gameobject` SET `rotation0`=-0.0139608, `rotation1`=-0.0136299, `rotation2`=-0.952168, `rotation3`=0.304953 WHERE `guid`=48551;
UPDATE `gameobject` SET `rotation0`=0.0608597, `rotation1`=-0.0783129, `rotation2`=0.995057, `rotation3`=0.00495468 WHERE `guid`=50347;
UPDATE `gameobject` SET `rotation0`=0.0022459, `rotation1`=0.0019207, `rotation2`=-0.82254, `rotation3`=0.568699 WHERE `guid`=55040;
UPDATE `gameobject` SET `rotation0`=0.064477, `rotation1`=-0.0282221, `rotation2`=-0.982747, `rotation3`=0.171039 WHERE `guid`=55077;
UPDATE `gameobject` SET `rotation0`=-0.0520096, `rotation1`=-0.0134745, `rotation2`=0.22455, `rotation3`=0.97298 WHERE `guid`=55419;
UPDATE `gameobject` SET `rotation0`=-0.00342178, `rotation1`=-0.0196419, `rotation2`=0.583972, `rotation3`=0.811529 WHERE `guid`=56066;
UPDATE `gameobject` SET `rotation0`=0.0469356, `rotation1`=-0.0745831, `rotation2`=-0.287543, `rotation3`=0.953705 WHERE `guid`=56099;
UPDATE `gameobject` SET `rotation0`=0.0234499, `rotation1`=-0.0849457, `rotation2`=-0.550198, `rotation3`=0.830372 WHERE `guid`=56106;
UPDATE `gameobject` SET `rotation0`=0.00357676, `rotation1`=0.00249863, `rotation2`=0.984033, `rotation3`=0.177935 WHERE `guid`=56122;
UPDATE `gameobject` SET `rotation0`=0.0249286, `rotation1`=-0.0845232, `rotation2`=-0.535622, `rotation3`=0.839848 WHERE `guid`=56124;
UPDATE `gameobject` SET `rotation0`=-0.00971794, `rotation1`=-0.0320435, `rotation2`=-0.997552, `rotation3`=0.0613915 WHERE `guid`=56222;
UPDATE `gameobject` SET `rotation0`=-0.0123668, `rotation1`=-0.0872507, `rotation2`=-0.835673, `rotation3`=0.542111 WHERE `guid`=56223;
UPDATE `gameobject` SET `rotation0`=-0.017982, `rotation1`=0.0323582, `rotation2`=0.703278, `rotation3`=0.709951 WHERE `guid`=56243;
UPDATE `gameobject` SET `rotation0`=0.0828447, `rotation1`=0.0300417, `rotation2`=0.870979, `rotation3`=0.483352 WHERE `guid`=56294;
UPDATE `gameobject` SET `rotation0`=0.0170689, `rotation1`=-0.00339508, `rotation2`=-0.831343, `rotation3`=0.555488 WHERE `guid`=56583;
UPDATE `gameobject` SET `rotation0`=-0.00762081, `rotation1`=-0.0171156, `rotation2`=0.70084, `rotation3`=0.713072 WHERE `guid`=56656;
UPDATE `gameobject` SET `rotation0`=-0.0153003, `rotation1`=0.0108137, `rotation2`=-0.836097, `rotation3`=0.548262 WHERE `guid`=56657;
UPDATE `gameobject` SET `rotation0`=-0.00747776, `rotation1`=0.00981712, `rotation2`=-0.636003, `rotation3`=0.771587 WHERE `guid`=56707;
UPDATE `gameobject` SET `rotation0`=0.00858116, `rotation1`=0.000598907, `rotation2`=0.70708, `rotation3`=0.707081 WHERE `guid`=56709;
UPDATE `gameobject` SET `rotation0`=-0.00108576, `rotation1`=-0.00853348, `rotation2`=-0.831438, `rotation3`=0.555551 WHERE `guid`=56710;
UPDATE `gameobject` SET `rotation0`=0.0329785, `rotation1`=0.027854, `rotation2`=-0.492602, `rotation3`=0.869183 WHERE `guid`=57528;
UPDATE `gameobject` SET `rotation0`=0.0271997, `rotation1`=0.0176859, `rotation2`=-0.837915, `rotation3`=0.544835 WHERE `guid`=57532;
UPDATE `gameobject` SET `rotation0`=0.00369692, `rotation1`=0.0233622, `rotation2`=-0.494075, `rotation3`=0.869098 WHERE `guid`=57536;
UPDATE `gameobject` SET `rotation0`=-0.0176406, `rotation1`=0.0272284, `rotation2`=0.543453, `rotation3`=0.838812 WHERE `guid`=57540;
UPDATE `gameobject` SET `rotation0`=0.0267119, `rotation1`=0.0184145, `rotation2`=-0.822888, `rotation3`=0.567276 WHERE `guid`=57567;
UPDATE `gameobject` SET `rotation0`=0.0122328, `rotation1`=-0.0124474, `rotation2`=-0.713141, `rotation3`=0.700803 WHERE `guid`=57574;
UPDATE `gameobject` SET `rotation0`=-0.0184145, `rotation1`=0.0267115, `rotation2`=0.567276, `rotation3`=0.822888 WHERE `guid`=57576;
UPDATE `gameobject` SET `rotation0`=-0.0411167, `rotation1`=0.0145597, `rotation2`=-0.333488, `rotation3`=0.941745 WHERE `guid`=57631;
UPDATE `gameobject` SET `rotation0`=0.0780907, `rotation1`=0.0286131, `rotation2`=-0.38856, `rotation3`=0.917662 WHERE `guid`=57635;
UPDATE `gameobject` SET `rotation0`=-0.00915575, `rotation1`=0.0746326, `rotation2`=0.898921, `rotation3`=0.43161 WHERE `guid`=57768;
UPDATE `gameobject` SET `rotation0`=0.0133748, `rotation1`=0.0159645, `rotation2`=0.999181, `rotation3`=0.0346989 WHERE `guid`=57778;
UPDATE `gameobject` SET `rotation0`=0.997061, `rotation1`=-0.0563049, `rotation2`=-0.00894737, `rotation3`=0.0511718 WHERE `guid`=57781;
UPDATE `gameobject` SET `rotation0`=-0.00120354, `rotation1`=-0.0202312, `rotation2`=0.999186, `rotation3`=0.0348925 WHERE `guid`=57792;
UPDATE `gameobject` SET `rotation0`=-0.010067, `rotation1`=-0.0192642, `rotation2`=-0.544604, `rotation3`=0.838411 WHERE `guid`=57794;
UPDATE `gameobject` SET `rotation0`=0.0594649, `rotation1`=0.0722637, `rotation2`=-0.99546, `rotation3`=0.0173821 WHERE `guid`=57800;
UPDATE `gameobject` SET `rotation0`=-0.0636859, `rotation1`=0.0447683, `rotation2`=0.99641, `rotation3`=0.0332605 WHERE `guid`=57845;
UPDATE `gameobject` SET `rotation0`=-0.0478525, `rotation1`=-0.0228243, `rotation2`=-0.901316, `rotation3`=0.429906 WHERE `guid`=57849;
UPDATE `gameobject` SET `rotation0`=-0.0688047, `rotation1`=-0.0223722, `rotation2`=0.993367, `rotation3`=0.0893701 WHERE `guid`=57868;
UPDATE `gameobject` SET `rotation0`=0.00230885, `rotation1`=-0.134351, `rotation2`=0.609957, `rotation3`=0.780959 WHERE `guid`=57887;
UPDATE `gameobject` SET `rotation0`=-0.101412, `rotation1`=-0.0473404, `rotation2`=0.990035, `rotation3`=0.0854701 WHERE `guid`=57888;
UPDATE `gameobject` SET `rotation0`=-0.061111, `rotation1`=-0.0142727, `rotation2`=-0.950614, `rotation3`=0.303965 WHERE `guid`=57889;
UPDATE `gameobject` SET `rotation0`=-0.00625563, `rotation1`=0.00534725, `rotation2`=-0.79151, `rotation3`=0.611101 WHERE `guid`=57977;
UPDATE `gameobject` SET `rotation0`=-0.021769, `rotation1`=0.00458431, `rotation2`=-0.304047, `rotation3`=0.952397 WHERE `guid`=57978;
UPDATE `gameobject` SET `rotation0`=0.0169549, `rotation1`=0.00413513, `rotation2`=0.999241, `rotation3`=0.0348292 WHERE `guid`=57998;
UPDATE `gameobject` SET `rotation0`=-0.00625563, `rotation1`=0.00534725, `rotation2`=-0.79151, `rotation3`=0.611101 WHERE `guid`=58003;
UPDATE `gameobject` SET `rotation0`=-0.00561047, `rotation1`=0.00602055, `rotation2`=-0.855554, `rotation3`=0.517649 WHERE `guid`=58015;
UPDATE `gameobject` SET `rotation0`=-0.00700092, `rotation1`=0.00432682, `rotation2`=-0.688617, `rotation3`=0.725079 WHERE `guid`=58033;
UPDATE `gameobject` SET `rotation0`=-0.00797653, `rotation1`=0.00202751, `rotation2`=-0.439443, `rotation3`=0.898233 WHERE `guid`=58054;
UPDATE `gameobject` SET `rotation0`=-0.0053606, `rotation1`=-0.0215902, `rotation2`=0.940907, `rotation3`=0.337935 WHERE `guid`=58137;
UPDATE `gameobject` SET `rotation0`=-0.0053606, `rotation1`=-0.0215902, `rotation2`=0.940907, `rotation3`=0.337935 WHERE `guid`=58152;
UPDATE `gameobject` SET `rotation0`=-0.0053606, `rotation1`=-0.0215902, `rotation2`=0.940907, `rotation3`=0.337935 WHERE `guid`=58175;
UPDATE `gameobject` SET `rotation0`=-0.0190578, `rotation1`=-0.0114765, `rotation2`=0.426367, `rotation3`=0.904277 WHERE `guid`=58191;
UPDATE `gameobject` SET `rotation0`=-0.0190578, `rotation1`=-0.0114765, `rotation2`=0.426367, `rotation3`=0.904277 WHERE `guid`=58208;
UPDATE `gameobject` SET `rotation0`=-0.0215907, `rotation1`=0.0053606, `rotation2`=-0.337934, `rotation3`=0.940907 WHERE `guid`=58220;
UPDATE `gameobject` SET `rotation0`=-0.0213366, `rotation1`=0.00629711, `rotation2`=-0.378653, `rotation3`=0.925272 WHERE `guid`=58225;
UPDATE `gameobject` SET `rotation0`=0.0115876, `rotation1`=0.0149164, `rotation2`=-0.972156, `rotation3`=0.233574 WHERE `guid`=58300;
UPDATE `gameobject` SET `rotation0`=-0.013093, `rotation1`=0.0179844, `rotation2`=-0.863675, `rotation3`=0.503558 WHERE `guid`=58303;
UPDATE `gameobject` SET `rotation0`=-0.0203118, `rotation1`=-0.0571537, `rotation2`=0.737972, `rotation3`=0.6721 WHERE `guid`=58307;
UPDATE `gameobject` SET `rotation0`=-0.00221872, `rotation1`=-0.00375652, `rotation2`=0.788001, `rotation3`=0.615658 WHERE `guid`=58972;
UPDATE `gameobject` SET `rotation0`=0.0625529, `rotation1`=-0.00466824, `rotation2`=0.99803, `rotation3`=0.00142357 WHERE `guid`=59047;
UPDATE `gameobject` SET `rotation0`=0.0179548, `rotation1`=-0.00972557, `rotation2`=0.999791, `rotation3`=0 WHERE `guid`=59052;
UPDATE `gameobject` SET `rotation0`=-0.00726509, `rotation1`=0.0038681, `rotation2`=-0.640481, `rotation3`=0.76793 WHERE `guid`=59053;
UPDATE `gameobject` SET `rotation0`=-0.00820541, `rotation1`=-0.000640869, `rotation2`=-0.127568, `rotation3`=0.991796 WHERE `guid`=59089;
UPDATE `gameobject` SET `rotation0`=0.0214567, `rotation1`=-0.00587368, `rotation2`=0.997311, `rotation3`=0.0698328 WHERE `guid`=59092;
UPDATE `gameobject` SET `rotation0`=-0.0145078, `rotation1`=-0.00969982, `rotation2`=0.66255, `rotation3`=0.748814 WHERE `guid`=59750;
UPDATE `gameobject` SET `rotation0`=0.0100765, `rotation1`=-0.0142488, `rotation2`=-0.765911, `rotation3`=0.64271 WHERE `guid`=59757;
UPDATE `gameobject` SET `rotation0`=-0.00212193, `rotation1`=-0.0173225, `rotation2`=-0.134826, `rotation3`=0.990716 WHERE `guid`=59769;
UPDATE `gameobject` SET `rotation0`=0.010324, `rotation1`=-0.0140705, `rotation2`=-0.777019, `rotation3`=0.629236 WHERE `guid`=59787;
UPDATE `gameobject` SET `rotation0`=-0.00570679, `rotation1`=-0.019104, `rotation2`=0.484539, `rotation3`=0.874542 WHERE `guid`=59858;
UPDATE `gameobject` SET `rotation0`=0.000127792, `rotation1`=-0.0199375, `rotation2`=0.719059, `rotation3`=0.694663 WHERE `guid`=59873;
UPDATE `gameobject` SET `rotation0`=0.0949898, `rotation1`=-0.0109949, `rotation2`=-0.438946, `rotation3`=0.893411 WHERE `guid`=60059;
UPDATE `gameobject` SET `rotation0`=0.0462666, `rotation1`=0.00813198, `rotation2`=-0.997513, `rotation3`=0.0525493 WHERE `guid`=60356;
UPDATE `gameobject` SET `rotation0`=0.000655651, `rotation1`=-0.00431347, `rotation2`=-0.99862, `rotation3`=0.0523356 WHERE `guid`=60402;
UPDATE `gameobject` SET `rotation0`=-0.00369263, `rotation1`=0.0337515, `rotation2`=-0.998056, `rotation3`=0.0522552 WHERE `guid`=60422;
UPDATE `gameobject` SET `rotation0`=-0.0572481, `rotation1`=0.0493526, `rotation2`=0.957794, `rotation3`=0.27734 WHERE `guid`=60430;
UPDATE `gameobject` SET `rotation0`=-0.00782394, `rotation1`=0.00386524, `rotation2`=0.894899, `rotation3`=0.446183 WHERE `guid`=60434;
UPDATE `gameobject` SET `rotation0`=0.0450549, `rotation1`=-0.035512, `rotation2`=0.997688, `rotation3`=0.0364277 WHERE `guid`=60443;
UPDATE `gameobject` SET `rotation0`=0.0507827, `rotation1`=-0.00883389, `rotation2`=0.998049, `rotation3`=0.0352375 WHERE `guid`=60453;
UPDATE `gameobject` SET `rotation0`=0.0323796, `rotation1`=-0.00742626, `rotation2`=0.831214, `rotation3`=0.554959 WHERE `guid`=60466;
UPDATE `gameobject` SET `rotation0`=-0.00159168, `rotation1`=-0.0173798, `rotation2`=-0.165, `rotation3`=0.986139 WHERE `guid`=60505;
UPDATE `gameobject` SET `rotation0`=0.00299168, `rotation1`=0.00317574, `rotation2`=0.465605, `rotation3`=0.884982 WHERE `guid`=60512;
UPDATE `gameobject` SET `rotation0`=0.00376463, `rotation1`=-0.00488853, `rotation2`=-0.999977, `rotation3`=0.0027729 WHERE `guid`=60670;
UPDATE `gameobject` SET `rotation0`=-0.00823879, `rotation1`=0.00287342, `rotation2`=-0.358356, `rotation3`=0.933544 WHERE `guid`=60705;
UPDATE `gameobject` SET `rotation0`=0.0208797, `rotation1`=0.0497112, `rotation2`=-0.915771, `rotation3`=0.398067 WHERE `guid`=60758;
UPDATE `gameobject` SET `rotation0`=-0.0140252, `rotation1`=-0.0223131, `rotation2`=-0.931563, `rotation3`=0.362623 WHERE `guid`=60818;
UPDATE `gameobject` SET `rotation0`=-0.0140252, `rotation1`=-0.0223131, `rotation2`=-0.931563, `rotation3`=0.362623 WHERE `guid`=60869;
UPDATE `gameobject` SET `rotation0`=-0.0112252, `rotation1`=0.019206, `rotation2`=-0.90978, `rotation3`=0.414495 WHERE `guid`=61001;
UPDATE `gameobject` SET `rotation0`=-0.0112252, `rotation1`=0.019206, `rotation2`=-0.90978, `rotation3`=0.414495 WHERE `guid`=61006;
UPDATE `gameobject` SET `rotation0`=-0.0192065, `rotation1`=-0.0112247, `rotation2`=0.414494, `rotation3`=0.90978 WHERE `guid`=61028;
UPDATE `gameobject` SET `rotation0`=-0.0192065, `rotation1`=-0.0112247, `rotation2`=0.414494, `rotation3`=0.90978 WHERE `guid`=61058;
UPDATE `gameobject` SET `rotation0`=-0.0192556, `rotation1`=-0.0111418, `rotation2`=0.41052, `rotation3`=0.91158 WHERE `guid`=61067;
UPDATE `gameobject` SET `rotation0`=-0.0192556, `rotation1`=-0.0111418, `rotation2`=0.41052, `rotation3`=0.91158 WHERE `guid`=61091;
UPDATE `gameobject` SET `rotation0`=-0.0113096, `rotation1`=0.0191565, `rotation2`=-0.907963, `rotation3`=0.41846 WHERE `guid`=61117;
UPDATE `gameobject` SET `rotation0`=-0.0113096, `rotation1`=0.0191565, `rotation2`=-0.907963, `rotation3`=0.41846 WHERE `guid`=61128;
UPDATE `gameobject` SET `rotation0`=-0.00185108, `rotation1`=-0.0210752, `rotation2`=0.926908, `rotation3`=0.374693 WHERE `guid`=61143;
UPDATE `gameobject` SET `rotation0`=-0.00629711, `rotation1`=-0.0213366, `rotation2`=0.925271, `rotation3`=0.378654 WHERE `guid`=61166;
UPDATE `gameobject` SET `rotation0`=-0.0210757, `rotation1`=0.00185108, `rotation2`=-0.374691, `rotation3`=0.926908 WHERE `guid`=61207;
UPDATE `gameobject` SET `rotation0`=-0.0213366, `rotation1`=0.00629711, `rotation2`=-0.378653, `rotation3`=0.925272 WHERE `guid`=61214;
UPDATE `gameobject` SET `rotation0`=-0.0215907, `rotation1`=0.0053606, `rotation2`=-0.337933, `rotation3`=0.940907 WHERE `guid`=61236;
UPDATE `gameobject` SET `rotation0`=-0.0215907, `rotation1`=0.0053606, `rotation2`=-0.337933, `rotation3`=0.940907 WHERE `guid`=61242;
UPDATE `gameobject` SET `rotation0`=-0.0213432, `rotation1`=0.00627518, `rotation2`=-0.377692, `rotation3`=0.925664 WHERE `guid`=61244;
