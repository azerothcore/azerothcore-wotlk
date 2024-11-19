-- DB update 2024_04_14_03 -> 2024_04_18_00
--
SET @CGUID := 139263;
SET @OGUID := 100514;

DELETE FROM `creature` WHERE `map` = 530 AND `id1` IN (23559, 23560, 23565, 23705, 23716, 23718, 23724, 23745, 23746, 23747, 23748, 23761, 23762, 23764, 23766, 23858, 24851, 25145);
INSERT INTO `creature` (`guid`, `id1`, `map`, `zoneId`, `areaId`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
(@CGUID+0 , 23559, 530, 3433, 3508, 0, 6774.67, -7608.4, 128.699, 4.67748, 120, 0, 0, 53788, 1, NULL),
(@CGUID+1 , 23560, 530, 3433, 3507, 1, 6737, -7611.17, 125.946, 0.174533, 120, 0, 0, 53788, 1, 'SAI Target'),
(@CGUID+2 , 23565, 530, 3433, 3517, 0, 6797.45, -7537.86, 126.264, 3.35103, 120, 0, 0, 53788, 1, NULL),
(@CGUID+3 , 23705, 530, 3433, 3508, 1, 6770.6, -7614.27, 128.68, 5.75959, 120, 0, 0, 53788, 1, NULL),
(@CGUID+4 , 23705, 530, 3433, 3508, 1, 6761.84, -7667.97, 126.544, 2.35619, 120, 0, 0, 53788, 1, NULL),
(@CGUID+5 , 23705, 530, 3433, 3507, 1, 6745.69, -7636.87, 127.306, 5.84685, 120, 0, 0, 53788, 1, NULL),
(@CGUID+6 , 23705, 530, 3433, 3507, 1, 6772.59, -7553.14, 127.129, 3.87463, 120, 0, 0, 53788, 1, NULL),
(@CGUID+7 , 23705, 530, 3433, 3507, 1, 6729.76, -7549.41, 130.142, 2.18166, 120, 0, 0, 53788, 1, NULL),
(@CGUID+8 , 23716, 530, 3433, 3508, 1, 6782.92, -7642.17, 127.904, 2.77507, 120, 0, 0, 53788, 1, NULL),
(@CGUID+9 , 23716, 530, 3433, 3507, 1, 6737.85, -7577.82, 126.802, 0.942478, 120, 0, 0, 53788, 1, NULL),
(@CGUID+10, 23718, 530, 3433, 3507, 0, 6743.72, -7553.35, 126.19, 3.1765, 120, 0, 0, 53788, 1, 'GUID SAI'),
(@CGUID+11, 23724, 530, 3433, 3507, 1, 6742.99, -7615.56, 126.164, 2.56007, 120, 0, 0, 53788, 1, NULL),
(@CGUID+12, 23745, 530, 3433, 3508, 1, 6774.4, -7640.2, 127.616, 1.3374, 120, 0, 0, 53788, 1, 'GUID SAI'),
(@CGUID+13, 23746, 530, 3433, 3517, 0, 6743.56, -7532.4, 136.939, 2.60054, 120, 0, 0, 53788, 1, NULL),
(@CGUID+14, 23746, 530, 3433, 3517, 0, 6733.52, -7507.14, 135.088, 1.81514, 120, 0, 0, 53788, 1, NULL),
(@CGUID+15, 23746, 530, 3433, 3517, 0, 6743.83, -7522.06, 136.811, 3.7001, 120, 0, 0, 53788, 1, NULL),
(@CGUID+16, 23746, 530, 3433, 3517, 0, 6753.8, -7541.53, 126.229, 0.942478, 120, 0, 0, 53788, 1, NULL),
(@CGUID+17, 23746, 530, 3433, 3517, 0, 6761.36, -7557.16, 126.312, 4.15388, 120, 0, 0, 53788, 1, NULL),
(@CGUID+18, 23746, 530, 3433, 3517, 0, 6753.51, -7533.31, 127.201, 1.71042, 120, 0, 0, 53788, 1, NULL),
(@CGUID+19, 23746, 530, 3433, 3517, 0, 6756.32, -7550.76, 126.23, 3.42085, 120, 0, 0, 53788, 1, NULL),
(@CGUID+20, 23746, 530, 3433, 3517, 0, 6757.07, -7519.97, 127.057, 4.97419, 120, 0, 0, 53788, 1, NULL),
(@CGUID+21, 23746, 530, 3433, 3517, 0, 6745.09, -7510.54, 130.061, 2.00713, 120, 0, 0, 53788, 1, NULL),
(@CGUID+22, 23746, 530, 3433, 3517, 0, 6740.8, -7517.56, 137.634, 1.72788, 120, 0, 0, 53788, 1, NULL),
(@CGUID+23, 23746, 530, 3433, 3517, 0, 6763.38, -7548.29, 126.205, 5.20108, 120, 0, 0, 53788, 1, NULL),
(@CGUID+24, 23746, 530, 3433, 3517, 0, 6751.23, -7520.55, 130.214, 1.44862, 120, 0, 0, 53788, 1, NULL),
(@CGUID+25, 23746, 530, 3433, 3517, 0, 6743.7, -7546.71, 130.952, 1.09956, 120, 0, 0, 53788, 1, NULL),
(@CGUID+26, 23746, 530, 3433, 3517, 0, 6737.25, -7542.65, 136.438, 5.61996, 120, 0, 0, 53788, 1, NULL),
(@CGUID+27, 23746, 530, 3433, 3517, 0, 6730.89, -7531.32, 150.091, 6.07375, 120, 0, 0, 53788, 1, NULL),
(@CGUID+28, 23746, 530, 3433, 3517, 0, 6729.94, -7528.34, 156.399, 5.74213, 120, 0, 0, 53788, 1, NULL),
(@CGUID+29, 23746, 530, 3433, 3517, 0, 6738.28, -7537.18, 139.049, 5.68977, 120, 0, 0, 53788, 1, 'SAI Target'),
(@CGUID+30, 23746, 530, 3433, 3517, 0, 6751.98, -7555.14, 126.243, 6.10865, 120, 0, 0, 53788, 1, NULL),
(@CGUID+31, 23746, 530, 3433, 3517, 0, 6738.07, -7528.8, 143.086, 4.24115, 120, 0, 0, 53788, 1, NULL),
(@CGUID+32, 23746, 530, 3433, 3517, 0, 6744.29, -7538.55, 140.056, 5.28835, 120, 0, 0, 53788, 1, NULL),
(@CGUID+33, 23746, 530, 3433, 3517, 0, 6731.42, -7530.94, 150.013, 0.0872665, 120, 0, 0, 53788, 1, NULL),
(@CGUID+34, 23746, 530, 3433, 3517, 0, 6733.69, -7525.79, 149, 4.5204, 120, 0, 0, 53788, 1, NULL),
(@CGUID+35, 23746, 530, 3433, 3517, 0, 6730.87, -7533.37, 148.853, 4.88692, 120, 0, 0, 53788, 1, NULL),
(@CGUID+36, 23746, 530, 3433, 3517, 0, 6749.51, -7544.93, 128.156, 3.26377, 120, 0, 0, 53788, 1, NULL),
(@CGUID+37, 23746, 530, 3433, 3517, 0, 6731.82, -7530.35, 150.132, 4.72984, 120, 0, 0, 53788, 1, NULL),
(@CGUID+38, 23746, 530, 3433, 3517, 0, 6750.13, -7556.32, 126.232, 5.18363, 120, 0, 0, 53788, 1, NULL),
(@CGUID+39, 23746, 530, 3433, 3517, 0, 6733.28, -7528.4, 149.419, 2.05949, 120, 0, 0, 53788, 1, NULL),
(@CGUID+40, 23746, 530, 3433, 3517, 0, 6733.18, -7524.16, 149.411, 6.05629, 120, 0, 0, 53788, 1, NULL),
(@CGUID+41, 23746, 530, 3433, 3517, 0, 6762.9, -7566.96, 126.934, 5.96903, 120, 0, 0, 53788, 1, NULL),
(@CGUID+42, 23746, 530, 3433, 3517, 0, 6729.14, -7529.51, 157.446, 1.06465, 120, 0, 0, 53788, 1, NULL),
(@CGUID+43, 23746, 530, 3433, 3517, 0, 6723.32, -7534.91, 149.18, 1.36136, 120, 0, 0, 53788, 1, NULL),
(@CGUID+44, 23746, 530, 3433, 3517, 0, 6747.82, -7574.27, 127.372, 1.95477, 120, 0, 0, 53788, 1, NULL),
(@CGUID+45, 23746, 530, 3433, 3517, 0, 6736.1, -7547.67, 130.127, 2.37365, 120, 0, 0, 53788, 1, NULL),
(@CGUID+46, 23746, 530, 3433, 3517, 0, 6749.38, -7565.68, 126.488, 5.02655, 120, 0, 0, 53788, 1, NULL),
(@CGUID+47, 23746, 530, 3433, 3517, 0, 6736.17, -7557.46, 141.281, 1.98968, 120, 0, 0, 53788, 1, NULL),
(@CGUID+48, 23746, 530, 3433, 3517, 0, 6734.16, -7543.62, 136.616, 5.23599, 120, 0, 0, 53788, 1, NULL),
(@CGUID+49, 23746, 530, 3433, 3517, 0, 6723.14, -7545.02, 136.988, 4.59022, 120, 0, 0, 53788, 1, NULL),
(@CGUID+50, 23746, 530, 3433, 3517, 0, 6735.06, -7563.1, 127.515, 0.174533, 120, 0, 0, 53788, 1, NULL),
(@CGUID+51, 23746, 530, 3433, 3517, 0, 6729.54, -7541.35, 140.015, 4.57276, 120, 0, 0, 53788, 1, NULL),
(@CGUID+52, 23746, 530, 3433, 3517, 0, 6729.03, -7534.51, 149.191, 0.0872665, 120, 0, 0, 53788, 1, NULL),
(@CGUID+53, 23746, 530, 3433, 3517, 0, 6719.13, -7530.59, 149.696, 4.38078, 120, 0, 0, 53788, 1, NULL),
(@CGUID+54, 23746, 530, 3433, 3517, 0, 6743.28, -7565.82, 126.624, 3.63028, 120, 0, 0, 53788, 1, NULL),
(@CGUID+55, 23746, 530, 3433, 3517, 0, 6726.72, -7538.98, 143.007, 1.22173, 120, 0, 0, 53788, 1, NULL),
(@CGUID+56, 23746, 530, 3433, 3517, 0, 6728.03, -7547.98, 134.706, 4.11898, 120, 0, 0, 53788, 1, NULL),
(@CGUID+57, 23746, 530, 3433, 3517, 0, 6739.92, -7552.51, 126.553, 5.67232, 120, 0, 0, 53788, 1, NULL),
(@CGUID+58, 23746, 530, 3433, 3517, 0, 6737.62, -7570.73, 127.227, 1.0472, 120, 0, 0, 53788, 1, NULL),
(@CGUID+59, 23746, 530, 3433, 3517, 0, 6717.89, -7548.41, 130.347, 6.00393, 120, 0, 0, 53788, 1, NULL),
(@CGUID+60, 23746, 530, 3433, 3517, 0, 6720.03, -7550.59, 144.775, 6.21337, 120, 0, 0, 53788, 1, NULL),
(@CGUID+61, 23746, 530, 3433, 3517, 0, 6711.27, -7539.66, 136.643, 5.74213, 120, 0, 0, 53788, 1, NULL),
(@CGUID+62, 23746, 530, 3433, 3517, 0, 6710.25, -7548.35, 131.092, 2.6529, 120, 0, 0, 53788, 1, NULL),
(@CGUID+63, 23747, 530, 3433, 3507, 0, 6767.38, -7574.12, 127.04, 1.55334, 120, 0, 0, 53788, 1, NULL),
(@CGUID+64, 23747, 530, 3433, 3507, 0, 6771.96, -7556.53, 127.058, 1.37184, 120, 0, 0, 53788, 1, NULL),
(@CGUID+65, 23748, 530, 3433, 3517, 0, 6788.49, -7539.9, 126.109, 3.38594, 120, 0, 0, 53788, 1, 'GUID SAI'),
(@CGUID+66, 23761, 530, 3433, 3508, 1, 6769.81, -7616.67, 128.49, 0.697258, 120, 0, 0, 53788, 1, 'GUID SAI'),
(@CGUID+67, 23762, 530, 3433, 3507, 1, 6736.026, -7558.7544, 126.89935, 1.48352, 120, 0, 0, 53788, 1, 'GUID SAI, SAI Target'),
(@CGUID+68, 23764, 530, 3433, 3507, 1, 6740.1978, -7559.655, 126.451454, 1.972222, 120, 0, 0, 53788, 1, 'GUID SAI, SAI Target'),
(@CGUID+69, 23766, 530, 3433, 3507, 1, 6742.55, -7556.7, 126.212, 2.21112, 120, 0, 0, 53788, 1, 'GUID SAI'),
(@CGUID+70, 23858, 530, 3433, 3508, 1, 6764.49, -7610.38, 128.548, 5.41052, 120, 0, 0, 53788, 1, 'GUID SAI'),
(@CGUID+71, 24851, 530, 3433, 3508, 0, 6789.3, -7750.54, 126.815, 1.02974, 120, 0, 0, 53788, 1, NULL),
(@CGUID+72, 25145, 530, 3433, 3517, 1, 6793.5, -7555.5, 126.474, 3.71755, 120, 0, 0, 53788, 1, NULL),
(@CGUID+73, 25145, 530, 3433, 3517, 1, 6795.15, -7589.81, 127.622, 4.13643, 120, 0, 0, 53788, 1, NULL),
(@CGUID+74, 25145, 530, 3433, 3508, 1, 6786.62, -7619.71, 128.33, 6.17847, 120, 0, 0, 53788, 1, NULL),
(@CGUID+75, 25145, 530, 3433, 3508, 1, 6807.31, -7690.35, 130.621, 0.453786, 120, 0, 0, 53788, 1, NULL),
(@CGUID+76, 25145, 530, 3433, 3508, 1, 6779.61, -7651.7, 127.412, 5.14872, 120, 0, 0, 53788, 1, NULL),
(@CGUID+77, 25145, 530, 3433, 3508, 1, 6811.6, -7721, 125.959, 4.50295, 120, 0, 0, 53788, 1, NULL),
(@CGUID+78, 25145, 530, 3433, 3508, 1, 6770.12, -7687.2, 127.809, 0.500069, 120, 0, 0, 53788, 1, NULL),
(@CGUID+79, 25145, 530, 3433, 3508, 1, 6833.79, -7744.13, 124.765, 0.436332, 120, 0, 0, 53788, 1, NULL),
(@CGUID+80, 25145, 530, 3433, 3508, 1, 6871.87, -7751.06, 126.638, 2.07694, 120, 0, 0, 53788, 1, NULL),
(@CGUID+81, 25145, 530, 3433, 3508, 1, 6782.69, -7739.66, 126.344, 0.314159, 120, 0, 0, 53788, 1, NULL),
(@CGUID+82, 25145, 530, 3433, 3508, 1, 6838.43, -7786.18, 130.069, 1.53589, 120, 0, 0, 53788, 1, NULL),
(@CGUID+83, 25145, 530, 3433, 3508, 1, 6858.05, -7786.21, 130.118, 1.37881, 120, 0, 0, 53788, 1, NULL),
(@CGUID+84, 25145, 530, 3433, 3508, 1, 6813.94, -7772.28, 127.331, 6.23083, 120, 0, 0, 53788, 1, NULL),
(@CGUID+85, 25145, 530, 3433, 3508, 1, 6802.71, -7761.1, 126.991, 0.663225, 120, 0, 0, 53788, 1, NULL),
(@CGUID+86, 25145, 530, 3433, 3508, 1, 6815.57, -7795.29, 132.311, 1.09956, 120, 0, 0, 53788, 1, NULL),
(@CGUID+87, 25145, 530, 3433, 3508, 1, 6776.12, -7762.38, 128.772, 0.523599, 120, 0, 0, 53788, 1, NULL),
(@CGUID+88, 25145, 530, 3433, 3508, 1, 6835.44, -7798.48, 134.436, 2.18166, 120, 0, 0, 53788, 1, NULL),
(@CGUID+89, 25145, 530, 3433, 3508, 1, 6784.56, -7772.55, 142.828, 0.925025, 120, 0, 0, 53788, 1, NULL),
(@CGUID+90, 25145, 530, 3433, 3508, 1, 6764.31, -7791.43, 151.763, 1.58825, 120, 0, 0, 53788, 1, NULL),
(@CGUID+91, 25145, 530, 3433, 3507, 1, 6741.47, -7630.29, 126.71, 0.0523599, 120, 0, 0, 53788, 1, NULL),
(@CGUID+92, 25145, 530, 3433, 3507, 1, 6738.16, -7604.25, 126.653, 0.261799, 120, 0, 0, 53788, 1, NULL),
(@CGUID+93, 25145, 530, 3433, 3507, 1, 6728.52, -7572.14, 127.364, 0.401426, 120, 0, 0, 53788, 1, NULL),
(@CGUID+94, 25145, 530, 3433, 3507, 1, 6756.51, -7545.18, 126.2, 5.09636, 120, 0, 0, 53788, 1, NULL);

DELETE FROM `gameobject` WHERE `map` = 530 AND `id` IN (184858, 184863, 186251, 186280, 186284, 186285, 186286, 186302, 186307);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`, `Comment`) VALUES
(@OGUID+0 , 186251, 530, 3433, 3508, 6820.08, -7781.74, 129.512, 3.94445, 0.00621271, -0.0257998, -0.920135, 0.3907, 120, 255, 1, 53788, NULL),
(@OGUID+1 , 184858, 530, 3433, 3517, 6786.55, -7541.54, 126.109, 1.72787, 0, 0, 0.760406, 0.649449, 120, 255, 1, 53788, NULL),
(@OGUID+2 , 184858, 530, 3433, 3517, 6784.78, -7538.15, 126.109, 2.14675, 0, 0, 0.878817, 0.47716, 120, 255, 1, 53788, NULL),
(@OGUID+3 , 184858, 530, 3433, 3508, 6779.51, -7581.32, 127.825, 6.17847, 0, 0, -0.0523357, 0.99863, 120, 255, 1, 53788, NULL),
(@OGUID+4 , 184863, 530, 3433, 3517, 6799.52, -7541.11, 126.285, 1.83259, 0, 0, 0.793353, 0.608762, 120, 255, 1, 53788, NULL),
(@OGUID+5 , 184863, 530, 3433, 3517, 6797.52, -7541.51, 126.193, 0.436332, 0, 0, 0.216439, 0.976296, 120, 255, 1, 53788, NULL),
(@OGUID+6 , 186280, 530, 3433, 3517, 6797.61, -7541.46, 127.133, 3.10665, 0, 0, 0.999847, 0.0174693, 120, 255, 1, 53788, NULL),
(@OGUID+7 , 186280, 530, 3433, 3517, 6801.36, -7539.01, 127.896, 2.30383, 0, 0, 0.913545, 0.406738, 120, 255, 1, 53788, NULL),
(@OGUID+8 , 186280, 530, 3433, 3517, 6795.77, -7542.83, 126.128, 6.12611, 0, 0, -0.0784588, 0.996917, 120, 255, 1, 53788, NULL),
(@OGUID+9 , 186280, 530, 3433, 3508, 6773.67, -7583.76, 128.447, 2.11185, 0, 0, 0.870356, 0.492424, 120, 255, 1, 53788, NULL),
(@OGUID+10, 186280, 530, 3433, 3508, 6773.77, -7584.46, 128.462, 1.93731, 0, 0, 0.824125, 0.566408, 120, 255, 1, 53788, NULL),
(@OGUID+11, 186280, 530, 3433, 3508, 6773.4, -7584.54, 128.457, 2.9845, 0, 0, 0.996917, 0.0784664, 120, 255, 1, 53788, NULL),
(@OGUID+12, 186280, 530, 3433, 3508, 6773.33, -7584.19, 128.458, 3.05433, 0, 0, 0.999048, 0.0436193, 120, 255, 1, 53788, NULL),
(@OGUID+13, 186280, 530, 3433, 3508, 6773.7, -7584.08, 128.443, 1.78023, 0, 0, 0.777145, 0.629321, 120, 255, 1, 53788, NULL),
(@OGUID+14, 186280, 530, 3433, 3508, 6773.27, -7583.85, 128.459, 0.0174525, 0, 0, 0.00872612, 0.999962, 120, 255, 1, 53788, NULL),
(@OGUID+15, 186280, 530, 3433, 3507, 6735.68, -7556.51, 126.664, 3.17653, 0, 0, -0.999847, 0.0174693, 120, 255, 1, 53788, NULL),
(@OGUID+16, 186280, 530, 3433, 3507, 6736.88, -7555.64, 126.613, 6.12611, 0, 0, -0.0784588, 0.996917, 120, 255, 1, 53788, NULL),
(@OGUID+17, 186280, 530, 3433, 3507, 6737.26, -7555.16, 126.591, 6.14356, 0, 0, -0.0697556, 0.997564, 120, 255, 1, 53788, NULL),
(@OGUID+18, 186280, 530, 3433, 3507, 6736.73, -7555.26, 126.607, 3.80482, 0, 0, -0.945518, 0.325568, 120, 255, 1, 53788, NULL),
(@OGUID+19, 186280, 530, 3433, 3507, 6737.19, -7555.53, 126.602, 4.55531, 0, 0, -0.760406, 0.649449, 120, 255, 1, 53788, NULL),
(@OGUID+20, 186284, 530, 3433, 3508, 6781.96, -7641.6, 127.324, 2.51327, 0, 0, 0.951056, 0.309017, 120, 255, 1, 53788, NULL),
(@OGUID+21, 186284, 530, 3433, 3508, 6771.65, -7615.08, 127.931, 3.73501, 0, 0, -0.956305, 0.292372, 120, 255, 1, 53788, NULL),
(@OGUID+22, 186284, 530, 3433, 3507, 6747.19, -7637.35, 126.625, 4.50295, 0, 0, -0.777145, 0.629321, 120, 255, 1, 53788, NULL),
(@OGUID+23, 186284, 530, 3433, 3507, 6738.87, -7577.17, 126.101, 0.331611, 0, 0, 0.165047, 0.986286, 120, 255, 1, 53788, NULL),
(@OGUID+24, 186284, 530, 3433, 3507, 6771.76, -7553.98, 126.278, 5.75959, 0, 0, -0.258819, 0.965926, 120, 255, 1, 53788, NULL),
(@OGUID+25, 186284, 530, 3433, 3507, 6730.02, -7547.91, 129.268, 1.98967, 0, 0, 0.83867, 0.54464, 120, 255, 1, 53788, NULL),
(@OGUID+26, 186285, 530, 3433, 3507, 6714.2, -7544.62, 130.047, 3.17653, 0, 0, -0.999847, 0.0174693, 120, 255, 1, 53788, NULL),
(@OGUID+27, 186285, 530, 3433, 3507, 6728.64, -7530.09, 158.158, 4.17134, 0, 0, -0.870356, 0.492424, 120, 255, 1, 53788, NULL),
(@OGUID+28, 186286, 530, 3433, 3507, 6723.6, -7542.17, 139.718, 1.88495, 0, 0, 0.809016, 0.587786, 120, 255, 1, 53788, NULL),
(@OGUID+29, 186286, 530, 3433, 3507, 6725.8, -7530.72, 129.99, 2.68781, 0, 0, 0.97437, 0.224951, 120, 255, 1, 53788, NULL),
(@OGUID+30, 186286, 530, 3433, 3507, 6743.65, -7520.94, 130.603, 2.32129, 0, 0, 0.91706, 0.39875, 120, 255, 1, 53788, NULL),
(@OGUID+31, 186302, 530, 3433, 3517, 6786.58, -7541.63, 126.109, 0.628317, 0, 0, 0.309016, 0.951057, 120, 255, 1, 53788, NULL),
(@OGUID+32, 186302, 530, 3433, 3508, 6779.59, -7581.29, 127.815, 0.95993, 0, 0, 0.461748, 0.887011, 120, 255, 1, 53788, NULL),
(@OGUID+33, 186302, 530, 3433, 3508, 6773.51, -7584.16, 128.391, 3.35105, 0, 0, -0.994521, 0.104536, 120, 255, 1, 53788, NULL),
(@OGUID+34, 186302, 530, 3433, 3507, 6737.07, -7555.36, 126.601, 1.8675, 0, 0, 0.803857, 0.594823, 120, 255, 1, 53788, NULL),
(@OGUID+35, 186307, 530, 3433, 3517, 6785.49, -7539.38, 126.901, 0.418879, 0, 0, 0.207911, 0.978148, 120, 255, 1, 53788, NULL),
(@OGUID+36, 186307, 530, 3433, 3517, 6785.73, -7539.49, 126.109, 4.71239, 0, 0, -0.707107, 0.707107, 120, 255, 1, 53788, NULL);

DELETE FROM `creature_addon` WHERE `guid` IN (2070, 94484);
DELETE FROM `waypoint_data` WHERE `id` IN (20700, 944840);
DELETE FROM `waypoint_scripts` WHERE `id` IN (451, 452, 453, 454);

DELETE FROM `creature_template_addon` WHERE `entry` IN (23705, 23716);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(23705, 0, 0, 7, 0, 0, 0, ''),
(23716, 0, 0, 7, 0, 0, 0, '');

DELETE FROM `creature_equip_template` WHERE `CreatureID` = 23761;
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(23761, 1, 2558, 0, 0, 53788);

DELETE FROM `creature_text` WHERE `CreatureID` IN (23718, 23560, 23748, 23764, 23762, 23766);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `BroadcastTextId`, `Text`, `Type`, `Emote`, `comment`) VALUES
(23718, 0, 0, 22204, 'Well, helllooo there, pretty thing...', 12, 2, 'Mack to Ameenah'),
(23718, 0, 1, 22215, 'Well now, what vision of loveliness is this?', 12, 2, 'Mack to Ameenah'),
(23718, 0, 2, 22216, 'Ahh, my precious Ameenah! How wonderful to see you again.', 12, 2, 'Mack to Ameenah'),
(23718, 1, 0, 22205, 'Playing hard to get today, I see.... Very well, perhaps I\'ll find you in a better mood later.', 12, 1, 'Mack to Ameenah'),
(23718, 1, 1, 22209, 'Whatever you say, princess. But yer simply postponing the inevitable....', 12, 1, 'Mack to Ameenah'),
(23718, 1, 2, 22210, 'Now why would ya wanna go an\' break poor Mack\'s heart? When I return, I\'ll pray ye\'ve changed yer way of thinkin\'....', 12, 1, 'Mack to Ameenah'),
(23718, 1, 3, 22211, 'Yer wearin down, princess. I can sense it!', 12, 1, 'Mack to Ameenah'),
(23718, 2, 0, 22206, 'Hmm, don\'t mind if I do!', 12, 0, 'Mack'),
(23718, 2, 1, 22218, 'Mmm, nuthin a little lubrication won\'t fix!', 12, 0, 'Mack'),
(23718, 2, 2, 22219, 'Never drink before 5 o\'clock, momma used to say. Well, momma, it\'s bound to be 5 o\'clock somewhere!', 12, 0, 'Mack'),
(23718, 2, 3, 22217, 'Hrmph. I never liked her anyway....', 12, 0, 'Mack'),
(23718, 3, 0, 22220, '<cough> Ugh...', 12, 0, 'Mack'),
(23718, 3, 1, 22221, 'Whooo! Like daddy used to say, just makin room fer more! Heh.', 12, 0, 'Mack'),
(23718, 3, 2, 22222, 'Ooohh. Somethin\'s not agreein\' with the tummy today...', 12, 0, 'Mack'),
(23718, 4, 0, 22223, 'Hmmm, p\'rhaps I\'ll rest these old bones for a bit.', 12, 0, 'Mack'),
(23560, 0, 0, 22207, 'Not now, Mack. I be in no mood for your drunken pawing. Off with ya!', 12, 274, 'Ameenah to Mack'),
(23560, 0, 1, 22212, 'Beat it, Mack! Else I\'ll have Budd cook ya fer my hounds....', 12, 274, 'Ameenah to Mack'),
(23560, 0, 2, 22213, 'There be nuthin\' here to drink, Mack. Away with ya!', 12, 274, 'Ameenah to Mack'),
(23560, 0, 3, 22214, 'Go jump in the lake, won\'t ya Mack? I smelled ya before I saw ya....', 12, 274, 'Ameenah to Mack'),
(23748, 0, 0, 22252, 'Turgore! Get up and help me unload, you lazy peon!', 12, 60, 'Kurzel to Turgore'),
(23748, 1, 0, 22253, 'Useless orc! Just you wait, one day I\'ll drop somethin in yer grog that you\'ll NEVER wake up from....', 12, 0, 'Kurzel to Turgore'),
(23764, 0, 0, 22254, 'Say, Brend, why is it that you never make eyes at me?', 12, 396, 'Marge to Brend'),
(23764, 1, 0, 22265, 'Say, Brend, whisper me somethin\' sweet, will ya?', 12, 0, 'Marge to Brend'),
(23764, 3, 0, 22258, 'Oohhhh. How dare you!', 12, 5, 'Marge to Brend'),
(23764, 4, 0, 22259, 'Let that be a lesson to ya....', 12, 0, 'Marge to Brend'),
(23764, 2, 0, 22266, 'But Brend, yer always drinkin\'!', 12, 0, 'Marge to Brend'),
(23764, 5, 0, 22267, 'Filthy orc!', 12, 0, 'Marge to Morgom'),
(23762, 0, 0, 22255, 'Well, Marge, I\'ve actually been looking for a way to tell you this....', 12, 1, 'Brend to Marge'),
(23762, 1, 0, 22256, 'Try as I might, I can\'t seem to drink you pretty!', 12, 1, 'Brend to Marge'),
(23762, 2, 0, 22268, 'Lissen Marge, I thought I told ya never to bother me when I be drinkin\'....', 12, 396, 'Brend to Marge'),
(23762, 3, 0, 22269, 'Hey Morgom, looks like Margie here be needin\' some attention. What\'dya say?', 12, 0, 'Brend to Morgom'),
(23766, 0, 0, 22270, 'Zug Zug!', 12, 0, 'Morgom');

DELETE FROM `creature_addon` WHERE (`guid` = @CGUID+2);
INSERT INTO `creature_addon` (`guid`, `bytes1`, `bytes2`, `auras`) VALUES
(@CGUID+2, 3, 1, '32951');

-- Pathing for Budd's Bodyguard Entry: 25145
SET @NPC := @CGUID+73;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6795.15,-7589.807,127.6219,2.216568231582641601,60000,0,0,100,0),
(@PATH,2,6795.15,-7589.807,127.6219,3.141592741012573242,60000,0,0,100,0),
(@PATH,3,6795.15,-7589.807,127.6219,6.248278617858886718,60000,0,0,100,0),
(@PATH,4,6795.15,-7589.807,127.6219,4.136430263519287109,60000,0,0,100,0);
-- 0x20449C4240188E4000003A0002F9A064 .go xyz 6795.15 -7589.807 127.6219

-- Pathing for Budd's Bodyguard Entry: 25145
SET @NPC := @CGUID+78;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=6787.902,`position_y`=-7683.4673,`position_z`=128.29967 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6787.902,-7683.4673,128.29967,NULL,10000,0,0,100,0),
(@PATH,2,6770.124,-7687.202,127.80886,NULL,0,0,0,100,0),
(@PATH,3,6753.694,-7696.1216,127.648926,NULL,0,0,0,100,0),
(@PATH,4,6775.1753,-7696.5415,127.78203,NULL,0,0,0,100,0),
(@PATH,5,6790.143,-7693.9673,127.870865,NULL,10000,0,0,100,0),
(@PATH,6,6775.1753,-7696.5415,127.78203,NULL,0,0,0,100,0),
(@PATH,7,6753.694,-7696.1216,127.648926,NULL,0,0,0,100,0),
(@PATH,8,6770.124,-7687.202,127.80886,NULL,0,0,0,100,0);
-- 0x20449C4240188E4000003A0000F9A062 .go xyz 6787.902 -7683.4673 128.29967

-- Pathing for Budd's Bodyguard Entry: 25145
SET @NPC := @CGUID+91;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=6744.1895,`position_y`=-7633.3774,`position_z`=126.5975 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6744.1895,-7633.3774,126.5975,NULL,15000,0,0,100,0),
(@PATH,2,6740.213,-7623.264,126.56966,NULL,0,0,0,100,0),
(@PATH,3,6741.154,-7621.1943,126.42206,NULL,15000,0,0,100,0),
(@PATH,4,6741.474,-7630.288,126.70975,NULL,0,0,0,100,0),
(@PATH,5,6741.474,-7630.288,126.70975,0.05235987901687622,60000,0,0,100,0);
-- 0x20449C4240188E4000003A0001F9A064 .go xyz 6744.1895 -7633.3774 126.5975

-- Pathing for Budd Nedreck Entry: 23559
SET @NPC := @CGUID+0;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,13,6774.665,-7608.3994,128.69945,4.677482128143310546,120000,0,0,100,0),
(@PATH,1,6780.8516,-7603.673,128.42677,NULL,0,0,0,100,0),
(@PATH,2,6784.799,-7594.7554,127.74554,NULL,0,0,0,100,0),
(@PATH,3,6788.038,-7582.694,126.88881,NULL,0,0,0,100,0),
(@PATH,4,6790.448,-7581.604,126.94719,NULL,0,0,0,100,0),
(@PATH,5,6784.936,-7614.9307,128.61794,NULL,0,0,0,100,0),
(@PATH,6,6785.526,-7622.941,128.2771,NULL,0,0,0,100,0),
(@PATH,7,6788.5684,-7623.8213,127.672455,NULL,0,0,0,100,0),
(@PATH,8,6788.5684,-7623.8213,127.672455,5.375614166259765625,30000,0,0,100,0),
(@PATH,9,6756.0806,-7623.6147,127.02387,NULL,0,0,0,100,0),
(@PATH,10,6768.783,-7620.2544,128.21086,NULL,0,0,0,100,0),
(@PATH,11,6782.1997,-7618.389,128.70926,NULL,0,0,0,100,0),
(@PATH,12,6774.665,-7608.3994,128.69945,NULL,0,0,0,100,0);
-- 0x20449C42401701C000003A000079A062 .go xyz 6780.8516 -7603.673 128.42677

-- Pathing for Overworked Nag Entry: 23747
SET @NPC := 139326;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6774.903,-7567.4263,127.545204,NULL,0,0,0,100,0),
(@PATH,2,6771.029,-7561.1504,127.1642,NULL,0,0,0,100,0),
(@PATH,3,6771.9604,-7556.53,127.05771,NULL,180000,0,0,100,0),
(@PATH,4,6777.2173,-7568.1,127.57065,NULL,0,0,0,100,0),
(@PATH,5,6779.196,-7573.2007,128.0896,NULL,0,0,0,100,0),
(@PATH,6,6779.196,-7573.2007,128.0896,6.108652114868164062,240000,0,0,100,0);
-- 0x20449C42401730C000003A000079A064 .go xyz 6774.903 -7567.4263 127.545204

-- Pathing for Overworked Nag Entry: 23747
SET @NPC := 139327;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6756.9644,-7570.461,127.0629,NULL,0,0,0,100,0),
(@PATH,2,6754.189,-7573.991,127.25931,NULL,0,0,0,100,0),
(@PATH,3,6758.559,-7566.889,126.6951,NULL,120000,0,0,100,0),
(@PATH,4,6766.457,-7568.1543,127.057495,NULL,0,0,0,100,0),
(@PATH,5,6767.385,-7574.116,127.04041,NULL,0,0,0,100,0),
(@PATH,6,6767.385,-7574.116,127.04041,1.553343057632446289,150000,0,0,100,0);

DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 23718);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(23718, 1, 2716, 0, 0, 57888);

/*
	Scripted Pathing
*/
-- Pathing for Mack Entry: 23718
SET @NPC := 139273;
SET @PATH := (@NPC * 10);
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6752.6504,-7560.3726,126.15855,NULL,0,0,0,100,0),
(@PATH,2,6755.828,-7584.8135,127.33693,NULL,0,0,0,100,0),
(@PATH,3,6748.864,-7601.5347,127.00935,NULL,0,0,0,100,0),
(@PATH,4,6742.1353,-7608.194,126.093445,NULL,19400,0,0,100,0), -- Talk to Ameenah
(@PATH,5,6745.817,-7600.8325,126.54117,NULL,0,0,0,100,0),
(@PATH,6,6753.718,-7588.0425,127.563095,NULL,0,0,0,100,0),
(@PATH,7,6771.875,-7584.8584,127.290146,NULL,12960,0,0,100,0), -- Get Drink
(@PATH,8,6769.5576,-7577.0537,127.32736,NULL,0,0,0,100,0),
(@PATH,9,6770.5884,-7568.6104,127.41217,NULL,0,0,0,100,0),
(@PATH,10,6762.0464,-7555.414,126.224945,NULL,0,0,0,100,0),
(@PATH,11,6754.4546,-7549.847,126.13906,NULL,22670,0,0,100,0), -- Drink
(@PATH,12,6754.4546,-7549.847,126.13906,2.477182865142822265,11350,0,0,100,0), -- Cheer
(@PATH,13,6743.7188,-7553.3457,126.19035,NULL,0,0,0,100,0),
(@PATH,14,6743.7188,-7553.3457,126.19035,3.176499128341674804,0,0,0,100,0);
-- 0x20449C424017298000003A000079A064 .go xyz 6752.6504 -7560.3726 126.15855

-- Pathing for Mack Entry: 23718
SET @NPC := 139273;
SET @PATH := (@NPC * 10) + 1;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6725.964,-7561.686,128.34082,NULL,9570,0,0,100,0), -- Sleep
(@PATH,2,6725.964,-7561.686,128.34082,0.279252678155899047,120000,0,0,100,0),
(@PATH,3,6743.7188,-7553.3457,126.19035,NULL,0,0,0,100,0),
(@PATH,4,6743.7188,-7553.3457,126.19035,3.176499128341674804,0,0,0,100,0);
-- 0x20449C424017298000003A000079A064 .go xyz 6743.7188 -7553.3457 126.19035

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 23718);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -139273);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-139273, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Respawn - Set Event Phase 1'),
(-139273, 0, 1, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Path Any Finished - Set Event Phase 1'),
(-139273, 0, 2, 0, 1, 1, 100, 0, 180000, 240000, 180000, 240000, 0, 0, 87, 2371800, 2371801, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Out of Combat - Run Random Script (Phase 1)'),
(-139273, 0, 3, 0, 1, 1, 100, 0, 6400, 20000, 6400, 20000, 0, 0, 10, 11, 21, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Out of Combat - Play Random Emote (11, 21) (Phase 1)'),
(-139273, 0, 4, 0, 108, 0, 100, 0, 4, 1392730, 0, 0, 0, 0, 80, 2371802, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Point 4 of Path 1392730 Reached - Run Script'),
(-139273, 0, 5, 0, 108, 0, 100, 0, 7, 1392730, 0, 0, 0, 0, 80, 2371803, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Point 7 of Path 1392730 Reached - Run Script'),
(-139273, 0, 6, 0, 108, 0, 100, 0, 11, 1392730, 0, 0, 0, 0, 80, 2371804, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Point 11 of Path 1392730 Reached - Run Script'),
(-139273, 0, 7, 0, 108, 0, 100, 0, 1, 1392731, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Point 1 of Path 1392731 Reached - Say Line 4'),
(-139273, 0, 8, 0, 108, 0, 100, 0, 2, 1392731, 0, 0, 0, 0, 80, 2371805, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - On Point 2 of Path 1392731 Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2371800, 2371801));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2371800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1392730, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Start Waypoint Path 1392730'),
(2371800, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Set Event Phase 0'),
(2371801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1392731, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Start Waypoint Path 1392731'),
(2371801, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Set Event Phase 0');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2371802);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2371802, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Say Line 0'),
(2371802, 9, 1, 0, 0, 0, 100, 0, 6400, 6400, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 139264, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Say Line 0 (Ameenah)'),
(2371802, 9, 2, 0, 0, 0, 100, 0, 6400, 6400, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Say Line 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2371803);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2371803, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 69, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Set Emote State 69'),
(2371803, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Say Line 2'),
(2371803, 9, 2, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Set Emote State 0'),
(2371803, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 124, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Load Equipment Id 1'),
(2371803, 9, 4, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Play Emote 92');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2371804);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2371804, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Play Emote 92'),
(2371804, 9, 1, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Play Emote 92'),
(2371804, 9, 2, 0, 0, 0, 100, 0, 8100, 8100, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Play Emote 92'),
(2371804, 9, 3, 0, 0, 0, 100, 0, 11300, 11300, 0, 0, 0, 0, 11, 42333, 0, 0, 0, 0, 0, 10, 139292, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Cast \'Throw Torch\''),
(2371804, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 124, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Load Equipment Id 0'),
(2371804, 9, 5, 0, 0, 0, 100, 0, 6480, 6480, 0, 0, 0, 0, 5, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Play Emote 4');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2371805);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2371805, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 32951, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Cast \'Sleeping Sleep\''),
(2371805, 9, 1, 0, 0, 0, 100, 0, 120000, 120000, 0, 0, 0, 0, 28, 32951, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mack - Actionlist - Remove Aura \'Sleeping Sleep\'');

-- Pathing for Kurzel Entry: 23748
SET @NPC := 139328;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6779.769,-7582.8804,127.5619,NULL,0,0,0,100,0),
(@PATH,2,6779.769,-7582.8804,127.5619,1.48352980613708496,1600,0,0,100,0),
(@PATH,3,6779.769,-7582.8804,127.5619,1.797689080238342285,9700,0,0,100,0), -- Pick Up Bags
(@PATH,4,6785.543,-7576.1157,127.56975,NULL,0,0,0,100,0),
(@PATH,5,6791.7485,-7543.877,126.10916,NULL,0,0,0,100,0),
(@PATH,6,6788.494,-7539.904,126.10916,NULL,0,0,0,100,0),
(@PATH,7,6788.494,-7539.904,126.10916,3.385938644409179687,24250,0,0,100,0), -- Leave Bags
(@PATH,8,6785.9644,-7574.473,127.53085,NULL,0,0,0,100,0);

-- Pathing for Kurzel Entry: 23748
SET @NPC := 139328;
SET @PATH := (@NPC * 10) + 1;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6779.9116,-7582.924,127.540245,NULL,0,0,0,100,0),
(@PATH,2,6779.9116,-7582.924,127.540245,1.48352980613708496,1600,0,0,100,0),
(@PATH,3,6779.9116,-7582.924,127.540245,1.797689080238342285,9700,0,0,100,0), -- Pick Up Bags
(@PATH,4,6785.543,-7576.1157,127.56975,NULL,0,0,0,100,0),
(@PATH,5,6791.7485,-7543.877,126.10916,NULL,0,0,0,100,0),
(@PATH,6,6788.494,-7539.904,126.10916,NULL,0,0,0,100,0),
(@PATH,7,6788.494,-7539.904,126.10916,3.385938644409179687,24250,0,0,100,0), -- Leave Bags
(@PATH,8,6796,-7535.8457,126.11561,NULL,0,0,0,100,0),
(@PATH,9,6796,-7535.8457,126.11561,4.852015495300292968,6400,0,0,100,0), -- Kick
(@PATH,10,6789.434,-7551.1094,126.23186,NULL,0,0,0,100,0),
(@PATH,11,6786.1133,-7575.298,127.538246,NULL,0,0,0,100,0);
-- 0x20449C424017310000003A000079A062 .go xyz 6779.9116 -7582.924 127.540245

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 23748);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -139328);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-139328, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 87, 2374800, 2374801, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - On Respawn - Start Random Path'),
(-139328, 0, 1, 0, 108, 0, 100, 0, 3, 0, 0, 0, 0, 0, 80, 2374802, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - On Point 3 of Path Any Reached - Run Script \'Pick Up Bags\''),
(-139328, 0, 2, 0, 108, 0, 100, 0, 7, 0, 0, 0, 0, 0, 80, 2374803, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - On Point 7 of Path Any Reached - Run Script \'Drop-Off Bags\''),
(-139328, 0, 3, 0, 108, 0, 100, 0, 9, 1393281, 0, 0, 0, 0, 80, 2374804, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - On Point 9 of Path 1393281 Reached - Run Script \'Kick Turgore\''),
(-139328, 0, 4, 0, 109, 0, 100, 0, 0, 0, 0, 0, 0, 0, 87, 2374800, 2374801, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - On Path Finished - Start Random Path');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` IN (2374800, 2374801));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2374800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1393280, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - Actionlist - Start Random Path'),
(2374801, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1393281, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - Actionlist - Start Random Path');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2374802);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2374802, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - Actionlist - Set Flag Standstate Kneel'),
(2374802, 9, 1, 0, 0, 0, 100, 0, 3250, 3250, 0, 0, 0, 0, 124, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - Actionlist - Load Equipment Id 1'),
(2374802, 9, 2, 0, 0, 0, 100, 0, 6450, 6450, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - Actionlist - Remove FlagStandstate Kneel');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2374803);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2374803, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - Actionlist - Set Flag Standstate Kneel'),
(2374803, 9, 1, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 124, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - Actionlist - Load Equipment Id 0'),
(2374803, 9, 2, 0, 0, 0, 100, 0, 21000, 21000, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - Actionlist - Remove FlagStandstate Kneel');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2374804);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2374804, 9, 0, 0, 0, 0, 100, 0, 400, 400, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - Actionlist - Say Line 0'),
(2374804, 9, 1, 0, 0, 0, 100, 0, 6000, 6000, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kurzel - Actionlist - Say Line 1');

-- Pathing for Garg Entry: 23745
SET @NPC := 139275;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id` BETWEEN @PATH AND @PATH+3;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- Go Path
(@PATH+0,1,6768.6436,-7638.577,127.382996,NULL,0,0,0,100,0),
(@PATH+0,2,6762.757,-7665.549,126.44116,NULL,14545,0,0,100,0), -- Kick
-- Return Paths
(@PATH+1,1,6762.757,-7665.549,126.44116,NULL,0,0,0,100,0),
(@PATH+1,2,6772.7305,-7667.0645,126.102066,NULL,0,0,0,100,0),
(@PATH+1,3,6774.489,-7663.8013,126.18675,NULL,8050,0,0,100,0), -- Fish
(@PATH+1,4,6774.404,-7640.1978,127.615875,NULL,0,0,0,100,0),
(@PATH+1,5,6774.364,-7632.2266,127.38222,NULL,0,0,0,100,0),
(@PATH+1,6,6774.364,-7632.2266,127.38222,4.014257431030273437,25900,0,0,100,0), -- Eat
(@PATH+2,1,6772.7305,-7667.0645,126.102066,NULL,0,0,0,100,0),
(@PATH+2,2,6774.489,-7663.8013,126.18675,NULL,8050,0,0,100,0), -- Fish
(@PATH+2,3,6771.4478,-7652.6304,127.296295,NULL,0,0,0,100,0),
(@PATH+2,4,6774.404,-7640.1978,127.615875,NULL,0,0,0,100,0),
(@PATH+2,5,6774.364,-7632.2266,127.38222,NULL,0,0,0,100,0),
(@PATH+2,6,6774.364,-7632.2266,127.38222,4.014257431030273437,25900,0,0,100,0), -- Eat
(@PATH+3,1,6774.489,-7663.8013,126.18675,NULL,8050,0,0,100,0), -- Fish
(@PATH+3,2,6771.4478,-7652.6304,127.296295,NULL,0,0,0,100,0),
(@PATH+3,3,6774.404,-7640.1978,127.615875,NULL,0,0,0,100,0),
(@PATH+3,4,6774.364,-7632.2266,127.38222,NULL,0,0,0,100,0),
(@PATH+3,5,6774.364,-7632.2266,127.38222,4.014257431030273437,25900,0,0,100,0); -- Eat
-- 0x20449C424017304000003A000079A063 .go xyz 6762.757 -7665.549 126.44116

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 23745);
DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 23745);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(23745, 1, 2023, 0, 0, 53788), -- Spear
(23745, 2, 6228, 0, 0, 53788); -- Fish

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2374500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2374500, 9, 0, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 5, 60, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - Actionlist - Play Emote 60'),
(2374500, 9, 1, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 5, 71, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - Actionlist - Play Emote 71'),
(2374500, 9, 2, 0, 0, 0, 100, 0, 8050, 8050, 0, 0, 0, 0, 233, 1392751, 1392753, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - Actionlist - Start Random Path');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2374501);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2374501, 9, 0, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 5, 36, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - Actionlist - Play Emote 36'),
(2374501, 9, 1, 0, 0, 0, 100, 0, 3200, 3200, 0, 0, 0, 0, 124, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - Actionlist - Load Equipment Id 2 (Fish)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2374502);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2374502, 9, 0, 0, 0, 0, 100, 0, 1200, 1200, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - Actionlist - Play Emote 92'),
(2374502, 9, 1, 0, 0, 0, 100, 0, 6450, 6450, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - Actionlist - Play Emote 92'),
(2374502, 9, 2, 0, 0, 0, 100, 0, 9700, 9700, 0, 0, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - Actionlist - Play Emote 92'),
(2374502, 9, 3, 0, 0, 0, 100, 0, 9700, 9700, 0, 0, 0, 0, 124, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - Actionlist - Load Equipment Id 1 (Spear)'),
(2374502, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1392750, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - Actionlist - Start Path');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -139275);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-139275, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1392750, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - On Respawn - Start Path'),
(-139275, 0, 1, 0, 109, 0, 100, 0, 0, 1392750, 0, 0, 0, 0, 80, 2374500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - On Path Initial Path Finished - Run Script \'Kick Troll\''),
(-139275, 0, 2, 0, 108, 0, 100, 0, 3, 1392751, 0, 0, 0, 0, 80, 2374501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - On Point Reached - Run Script \'Catch Fish\''),
(-139275, 0, 3, 0, 108, 0, 100, 0, 2, 1392752, 0, 0, 0, 0, 80, 2374501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - On Point Reached - Run Script \'Catch Fish\''),
(-139275, 0, 4, 0, 108, 0, 100, 0, 1, 1392753, 0, 0, 0, 0, 80, 2374501, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - On Point Reached - Run Script \'Catch Fish\''),
(-139275, 0, 5, 0, 109, 0, 100, 0, 0, 1392751, 0, 0, 0, 0, 80, 2374502, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - On Path Finished - Run Script \'Eat Fish and Restart Event\''),
(-139275, 0, 6, 0, 109, 0, 100, 0, 0, 1392752, 0, 0, 0, 0, 80, 2374502, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - On Path Finished - Run Script \'Eat Fish and Restart Event\''),
(-139275, 0, 7, 0, 109, 0, 100, 0, 0, 1392753, 0, 0, 0, 0, 80, 2374502, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Garg - On Path Finished - Run Script \'Eat Fish and Restart Event\'');

-- Pathing for Prigmon Entry: 23761
SET @NPC := 139329;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=6769.81,`position_y`=-7616.6704,`position_z`=128.4896 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6769.81,-7616.6704,128.4896,NULL,40600,0,0,100,0), -- EmoteState 133
(@PATH,2,6765.559,-7622.009,127.863716,NULL,0,0,0,100,0),
(@PATH,3,6747.774,-7635.6206,126.93343,NULL,40600,0,0,100,0); -- EmoteState 133
-- 0x20449C424017344000003A000079A064 .go xyz 6769.81 -7616.6704 128.4896

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 23761;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -139329);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-139329, 0, 0, 0, 108, 0, 100, 0, 1, 1393290, 0, 0, 0, 0, 80, 2376100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prigmon - On Point Reached - Run Script'),
(-139329, 0, 1, 0, 108, 0, 100, 0, 3, 1393290, 0, 0, 0, 0, 80, 2376100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prigmon - On Point Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2376100);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2376100, 9, 0, 0, 0, 0, 100, 0, 1700, 1700, 0, 0, 0, 0, 17, 133, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prigmon - Actionlist - Set Emote State 133'),
(2376100, 9, 1, 0, 0, 0, 100, 0, 29100, 29100, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prigmon - Actionlist - Set Emote State 0'),
(2376100, 9, 2, 0, 0, 0, 100, 0, 3240, 3240, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prigmon - Actionlist - Set Flag Standstate Kneel'),
(2376100, 9, 3, 0, 0, 0, 100, 0, 6450, 6450, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prigmon - Actionlist - Remove FlagStandstate Kneel');

-- Pathing for Donna Brascoe Entry: 23858
SET @NPC := 139333;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6771.347,-7607.2363,128.5081,NULL,0,0,0,100,0),
(@PATH,2,6771.347,-7607.2363,128.5081,2.897246599197387695,30000,0,0,100,0),
(@PATH,3,6762.7954,-7614.173,128.21152,NULL,0,0,0,100,0),
(@PATH,4,6757.339,-7613.1157,128.08092,NULL,0,0,0,100,0),
(@PATH,5,6757.339,-7613.1157,128.08092,0.575958669185638427,30000,0,0,100,0),
(@PATH,6,6764.669,-7612.788,128.36795,NULL,0,0,0,100,0),
(@PATH,7,6764.4897,-7610.385,128.54819,NULL,0,0,0,100,0),
(@PATH,8,6764.4897,-7610.385,128.54819,5.410520553588867187,60000,0,0,100,0);
-- 0x20449C4240174C8000003A000079A065 .go xyz 6771.347 -7607.2363 128.5081

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` = 23858);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -139333);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-139333, 0, 0, 0, 108, 0, 100, 0, 2, 1393330, 0, 0, 0, 0, 80, 2385800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Donna Brascoe - On Point 2 of Path 1393330 Reached - Run Script'),
(-139333, 0, 1, 0, 108, 0, 100, 0, 5, 1393330, 0, 0, 0, 0, 80, 2385800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Donna Brascoe - On Point 5 of Path 1393330 Reached - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2385800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2385800, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 17, 173, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Donna Brascoe - Actionlist - Set Emote State 173'),
(2385800, 9, 1, 0, 0, 0, 100, 0, 30000, 30000, 0, 0, 0, 0, 17, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Donna Brascoe - Actionlist - Set Emote State 0');

-- Pathing for Samir Entry: 23724
SET @NPC := 139274;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `wander_distance`=0,`MovementType`=2,`position_x`=6765.5796,`position_y`=-7632.0947,`position_z`=127.259575 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`visibilityDistanceType`,`auras`) VALUES (@NPC,@PATH,0,0,1,0,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6765.5796,-7632.0947,127.259575,NULL,0,0,0,100,0),
(@PATH,2,6765.5796,-7632.0947,127.259575,4.991641521453857421,24000,0,0,100,0),
(@PATH,3,6742.9854,-7615.5625,126.163506,NULL,24000,0,0,100,0),
(@PATH,4,6767.635,-7622.185,127.99035,NULL,0,0,0,100,0),
(@PATH,5,6787.145,-7619.097,128.1925,NULL,30000,0,0,100,0),
(@PATH,6,6765.5684,-7632.1235,127.25732,NULL,0,0,0,100,0),
(@PATH,7,6782.38,-7627.6665,128.41327,NULL,0,0,0,100,0);
-- 0x20449C4240172B0000003A000079A064 .go xyz 6765.5796 -7632.0947 127.259575

DELETE FROM `creature_equip_template` WHERE (`CreatureID` = 23764);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `ItemID2`, `ItemID3`, `VerifiedBuild`) VALUES
(23764, 1, 2717, 0, 0, 53788);

-- Pathing for Marge Entry: 23764
SET @NPC := 139331;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6707.7837,-7581.739,126.92148,NULL,0,1,0,100,0),
(@PATH,2,6706.914,-7601.817,125.75387,NULL,0,1,0,100,0),
(@PATH,3,6717.3823,-7607.291,126.25313,NULL,0,1,0,100,0),
(@PATH,4,6767.432,-7593.558,127.700195,NULL,0,1,0,100,0),
(@PATH,5,6771.6353,-7607.7554,128.52863,NULL,0,1,0,100,0),
(@PATH,6,6766.284,-7613.7754,128.30774,NULL,0,1,0,100,0),
(@PATH,7,6754.3076,-7614.549,127.613434,NULL,0,1,0,100,0),
(@PATH,8,6745.358,-7601.0747,126.58633,NULL,0,1,0,100,0),
(@PATH,9,6752.4004,-7585.6665,127.67639,NULL,0,1,0,100,0),
(@PATH,10,6766.2617,-7565.039,127.083145,NULL,0,1,0,100,0),
(@PATH,11,6785.4507,-7567.6406,126.813774,NULL,0,1,0,100,0),
(@PATH,12,6786.0024,-7585.2285,127.08642,NULL,0,1,0,100,0),
(@PATH,13,6769.0938,-7591.8647,127.65797,NULL,0,1,0,100,0),
(@PATH,14,6756.7524,-7583.4106,126.999275,NULL,0,1,0,100,0),
(@PATH,15,6744.7173,-7570.9653,126.96568,NULL,0,1,0,100,0),
(@PATH,16,6740.1978,-7559.655,126.451454,NULL,0,1,0,100,0); -- Throw Bottle
-- 0x20449C424017350000003A000079A065 .go xyz 6707.7837 -7581.739 126.92148

DELETE FROM `waypoint_data` WHERE `id`=@PATH+1;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH+1,1,6737.375,-7556.5435,126.62047,NULL,8100,0,0,100,0), -- Pick Up New Bottle
(@PATH+1,2,6740.1978,-7559.655,126.451454,NULL,0,0,0,100,0),
(@PATH+1,3,6740.0806,-7559.5254,126.45913,NULL,0,0,0,100,0),
(@PATH+1,4,6740.0806,-7559.5254,126.45913,1.972222089767456054,0,0,0,100,0);

-- Pathing for Brend Entry: 23762
SET @NPC := 139330;
SET @PATH := @NPC * 10;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`orientation`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,6745.162,-7592.8345,126.13598,NULL,0,1,0,100,0),
(@PATH,2,6754.219,-7617.1416,127.310326,NULL,0,1,0,100,0),
(@PATH,3,6771.998,-7623.348,128.08301,NULL,0,1,0,100,0),
(@PATH,4,6785.475,-7616.0693,128.53796,NULL,0,1,0,100,0),
(@PATH,5,6789.082,-7594.475,127.34944,NULL,0,1,0,100,0),
(@PATH,6,6789.169,-7580.259,127.03157,NULL,0,1,0,100,0),
(@PATH,7,6783.683,-7567.1753,126.75947,NULL,0,1,0,100,0),
(@PATH,8,6774.5586,-7560.7173,127.01713,NULL,0,1,0,100,0),
(@PATH,9,6759.7524,-7561.8696,126.23902,NULL,0,1,0,100,0),
(@PATH,10,6748.3784,-7577.643,127.507355,NULL,0,1,0,100,0),
(@PATH,11,6751.5986,-7612.553,127.2652,NULL,0,1,0,100,0),
(@PATH,12,6765.166,-7621.724,127.84164,NULL,0,1,0,100,0),
(@PATH,13,6783.303,-7611.415,128.59036,NULL,0,1,0,100,0),
(@PATH,14,6789.3887,-7579.3794,127.28639,NULL,0,1,0,100,0),
(@PATH,15,6777.856,-7558.4507,126.401634,NULL,0,1,0,100,0),
(@PATH,16,6750.376,-7561.012,126.14468,NULL,16000,1,0,100,0), -- Hit By Bottle (42333), StandState: 7 for 16s
(@PATH,17,6736.026,-7558.7544,126.89935,NULL,0,0,0,100,0),
(@PATH,18,6736.026,-7558.7544,126.89935,1.48352980613708496,0,0,0,100,0);
-- 0x20449C424017348000003A000079A063 .go xyz 6745.162 -7592.8345 126.13598

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE (`entry` IN (23762, 23764, 23766));
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -139331);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-139331, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - On Respawn - Set Event Phase 1'),
(-139331, 0, 1, 0, 1, 1, 100, 0, 120000, 180000, 120000, 180000, 0, 0, 80, 2376400, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - Out of Combat - Run Script (Phase 1)'),
(-139331, 0, 2, 0, 1, 1, 100, 0, 6400, 21600, 6400, 21600, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - Out of Combat - Play Emote 92 (Phase 1)'),
(-139331, 0, 3, 4, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 29, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - On Data Set 1 1 - Stop Follow'),
(-139331, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1393311, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - On Data Set 1 1 - Start Waypoint Path'),
(-139331, 0, 6, 0, 108, 0, 100, 0, 1, 1393311, 0, 0, 0, 0, 80, 2376401, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - On Point 1 of Path 1393311 Reached - Run Script \'Pick Up Bottle\''),
(-139331, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 124, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - On Data Set 1 1 - Load Equipment Id 0'),
(-139331, 0, 7, 0, 109, 0, 100, 0, 0, 1393311, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - On Path 1393311 Finished - Set Event Phase 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2376400);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2376400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - Actionlist - Set Event Phase 0'),
(2376400, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 10, 139330, 0, 0, 0, 0, 0, 0, 0, 'Marge - Actionlist - Set Event Phase 0 (Brend)'),
(2376400, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - Actionlist - Say Line 0'),
(2376400, 9, 3, 0, 0, 0, 100, 0, 5250, 5250, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 10, 139330, 0, 0, 0, 0, 0, 0, 0, 'Marge - Actionlist - Say Line 0 (Brend)'),
(2376400, 9, 4, 0, 0, 0, 100, 0, 8080, 8080, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 10, 139330, 0, 0, 0, 0, 0, 0, 0, 'Marge - Actionlist - Say Line 1 (Brend)'),
(2376400, 9, 5, 0, 0, 0, 100, 0, 2800, 2800, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - Actionlist - Say Line 3'),
(2376400, 9, 6, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 0, 0, 29, 10, 180, 0, 0, 0, 0, 10, 139330, 0, 0, 0, 0, 0, 0, 0, 'Marge - Actionlist - Start Follow Closest Creature \'Brend\''),
(2376400, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 232, 1393300, 0, 0, 0, 0, 0, 10, 139330, 0, 0, 0, 0, 0, 0, 0, 'Marge - Actionlist - Start Waypoint Path (Brend)');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -139330);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-139330, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brend - On Respawn - Set Event Phase 1'),
(-139330, 0, 1, 0, 1, 1, 100, 0, 6400, 21600, 6400, 21600, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brend - Out of Combat - Play Emote 92 (Phase 1)'),
(-139330, 0, 2, 0, 108, 0, 100, 0, 16, 1393300, 0, 0, 0, 0, 80, 2376200, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brend - On Point 16 of Path 1393300 Reached - Run Script \'Hit by Bottle\''),
(-139330, 0, 3, 0, 109, 0, 100, 0, 0, 1393300, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brend - On Path 1393300 Finished - Set Event Phase 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2376200);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2376200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 139331, 0, 0, 0, 0, 0, 0, 0, 'Brend - Actionlist - Set Data 1 1'),
(2376200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 86, 42333, 0, 10, 139331, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brend - Actionlist - Cross Cast \'Throw Torch\''),
(2376200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brend - Actionlist - Set Flag Standstate Dead'),
(2376200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 10, 139331, 0, 0, 0, 0, 0, 0, 0, 'Brend - Actionlist - Say Line 4 (Marge)'),
(2376200, 9, 4, 0, 0, 0, 100, 0, 16000, 16000, 0, 0, 0, 0, 91, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Brend - Actionlist - Remove FlagStandstate Dead');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` = 2376401);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2376401, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 90, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - Actionlist - Set Flag Standstate Kneel'),
(2376401, 9, 1, 0, 0, 0, 100, 0, 8100, 8100, 0, 0, 0, 0, 91, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - Actionlist - Remove FlagStandstate Kneel'),
(2376401, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 124, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Marge - Actionlist - Load Equipment Id 1');

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = -139332);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-139332, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morgom - On Respawn - Set Event Phase 1'),
(-139332, 0, 1, 0, 1, 1, 100, 0, 6400, 21600, 6400, 21600, 0, 0, 5, 92, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Morgom - Out of Combat - Play Emote 92 (Phase 1)');
