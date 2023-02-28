-- DB update 2023_01_04_01 -> 2023_01_04_02
--
DELETE FROM `gameobject` WHERE `id` IN (181278, 181556, 181557, 181569) AND `map` IN (555, 556, 558) AND `guid` IN (21567,21568,21569,21570,21571,21572,21911,21912,61346,61347,61348,61350,61355,61356,61357,61388,61393,61415,61416,61417,61418,61886,61898,61899,61901,61908,61958,63196);

SET @GUID := 105022; -- 161
SET @POOL := 13335; -- 34
SET @POOLMOTHER := 8332; -- 21

DELETE FROM `gameobject` WHERE `id` IN (181278, 181556, 181557, 181569) AND `map` IN (555, 556, 558) AND `guid` BETWEEN @GUID+0 AND @GUID+160;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
-- AUCHENAI CRYPTS
-- Adamantite Group 1
(@GUID+0 , 181556, 558, 3790, 3790, 3, 1, 173.916, 17.9607, -1.26987, 6.00393, 0, 0, -0.139173, 0.990268, 86400, 255, 1, '', 46741),
(@GUID+3 , 181556, 558, 3790, 3790, 3, 1, 119.337, 12.9238, -1.99939, 0.523598, 0, 0, 0.258819, 0.965926, 86400, 255, 1, '', 46741),
(@GUID+6 , 181556, 558, 3790, 3790, 3, 1, 231.433, -16.9698, 2.86235, 3.63029, 0, 0, -0.970295, 0.241925, 86400, 255, 1, '', 46741),
(@GUID+9 , 181556, 558, 3790, 3790, 3, 1, 213.983, -2.98043, 27.1587, 0.663223, 0, 0, 0.325567, 0.945519, 86400, 255, 1, '', 46741),
(@GUID+12, 181556, 558, 3790, 3790, 3, 1, 177.472, -9.88348, -0.765356, 6.10865, 0, 0, -0.0871553, 0.996195, 86400, 255, 1, '', 46741),
(@GUID+15, 181556, 558, 3790, 3790, 3, 1, 245.748, -182.614, 30.4494, 4.13643, 0, 0, -0.878817, 0.47716, 86400, 255, 1, '', 46741),
-- Rich Adamantite
(@GUID+1 , 181569, 558, 3790, 3790, 3, 1, 173.916, 17.9607, -1.26987, 6.00393, 0, 0, -0.139173, 0.990268, 86400, 255, 1, '', 46741),
(@GUID+4 , 181569, 558, 3790, 3790, 3, 1, 119.337, 12.9238, -1.99939, 0.523598, 0, 0, 0.258819, 0.965926, 86400, 255, 1, '', 46741),
(@GUID+7 , 181569, 558, 3790, 3790, 3, 1, 231.433, -16.9698, 2.86235, 3.63029, 0, 0, -0.970295, 0.241925, 86400, 255, 1, '', 46741),
(@GUID+10, 181569, 558, 3790, 3790, 3, 1, 213.983, -2.98043, 27.1587, 0.663223, 0, 0, 0.325567, 0.945519, 86400, 255, 1, '', 46741),
(@GUID+13, 181569, 558, 3790, 3790, 3, 1, 177.472, -9.88348, -0.765356, 6.10865, 0, 0, -0.0871553, 0.996195, 86400, 255, 1, '', 46741),
(@GUID+16, 181569, 558, 3790, 3790, 3, 1, 245.748, -182.614, 30.4494, 4.13643, 0, 0, -0.878817, 0.47716, 86400, 255, 1, '', 46741),
-- Khorium
(@GUID+2 , 181557, 558, 3790, 3790, 3, 1, 173.916, 17.9607, -1.26987, 6.00393, 0, 0, -0.139173, 0.990268, 86400, 255, 1, '', 46741),
(@GUID+5 , 181557, 558, 3790, 3790, 3, 1, 119.337, 12.9238, -1.99939, 0.523598, 0, 0, 0.258819, 0.965926, 86400, 255, 1, '', 46741),
(@GUID+8 , 181557, 558, 3790, 3790, 3, 1, 231.433, -16.9698, 2.86235, 3.63029, 0, 0, -0.970295, 0.241925, 86400, 255, 1, '', 46741),
(@GUID+11, 181557, 558, 3790, 3790, 3, 1, 213.983, -2.98043, 27.1587, 0.663223, 0, 0, 0.325567, 0.945519, 86400, 255, 1, '', 46741),
(@GUID+14, 181557, 558, 3790, 3790, 3, 1, 177.472, -9.88348, -0.765356, 6.10865, 0, 0, -0.0871553, 0.996195, 86400, 255, 1, '', 46741),
(@GUID+17, 181557, 558, 3790, 3790, 3, 1, 245.748, -182.614, 30.4494, 4.13643, 0, 0, -0.878817, 0.47716, 86400, 255, 1, '', 46741),
-- Adamantite Group 2
(@GUID+18, 181556, 558, 3790, 3790, 3, 1, -153.854, -290.526, 24.5789, 5.42797, 0, 0, -0.414693, 0.909961, 86400, 255, 1, '', 46741),
(@GUID+21, 181556, 558, 3790, 3790, 3, 1, 93.3528, -393.116, 27.1238, 5.2709, 0, 0, -0.484809, 0.87462, 86400, 255, 1, '', 46741),
(@GUID+24, 181556, 558, 3790, 3790, 3, 1, -154.215, -256.825, 24.384, 5.14872, 0, 0, -0.537299, 0.843392, 86400, 255, 1, '', 46741),
(@GUID+27, 181556, 558, 3790, 3790, 3, 1, -133.902, -287.211, 25.8914, 1.23918, 0, 0, 0.580703, 0.814116, 86400, 255, 1, '', 46741),
-- Rich Adamantite
(@GUID+19, 181569, 558, 3790, 3790, 3, 1, -153.854, -290.526, 24.5789, 5.42797, 0, 0, -0.414693, 0.909961, 86400, 255, 1, '', 46741),
(@GUID+22, 181569, 558, 3790, 3790, 3, 1, 93.3528, -393.116, 27.1238, 5.2709, 0, 0, -0.484809, 0.87462, 86400, 255, 1, '', 46741),
(@GUID+25, 181569, 558, 3790, 3790, 3, 1, -154.215, -256.825, 24.384, 5.14872, 0, 0, -0.537299, 0.843392, 86400, 255, 1, '', 46741),
(@GUID+28, 181569, 558, 3790, 3790, 3, 1, -133.902, -287.211, 25.8914, 1.23918, 0, 0, 0.580703, 0.814116, 86400, 255, 1, '', 46741),
-- Khorium
(@GUID+20, 181557, 558, 3790, 3790, 3, 1, -153.854, -290.526, 24.5789, 5.42797, 0, 0, -0.414693, 0.909961, 86400, 255, 1, '', 46741),
(@GUID+23, 181557, 558, 3790, 3790, 3, 1, 93.3528, -393.116, 27.1238, 5.2709, 0, 0, -0.484809, 0.87462, 86400, 255, 1, '', 46741),
(@GUID+26, 181557, 558, 3790, 3790, 3, 1, -154.215, -256.825, 24.384, 5.14872, 0, 0, -0.537299, 0.843392, 86400, 255, 1, '', 46741),
(@GUID+29, 181557, 558, 3790, 3790, 3, 1, -133.902, -287.211, 25.8914, 1.23918, 0, 0, 0.580703, 0.814116, 86400, 255, 1, '', 46741),
-- Lichen Group 1
(@GUID+30, 181278, 558, 3790, 3790, 3, 1, 94.1284, -41.6325, 4.26136, 2.53072, 0, 0, 0.953716, 0.300708, 86400, 255, 1, '', 46741),
(@GUID+31, 181278, 558, 3790, 3790, 3, 1, 142.376, 42.363, 4.26119, 3.94445, 0, 0, -0.920505, 0.390732, 86400, 255, 1, '', 46741),
(@GUID+32, 181278, 558, 3790, 3790, 3, 1, 81.3718, 39.9704, 4.26169, 2.46091, 0, 0, 0.942641, 0.333808, 86400, 255, 1, '', 46741),
(@GUID+33, 181278, 558, 3790, 3790, 3, 1, 147.044, -17.3046, 7.97811, 5.14872, 0, 0, -0.537299, 0.843392, 86400, 255, 1, '', 46741),
-- Lichen Group 2
(@GUID+34, 181278, 558, 3790, 3790, 3, 1, 228.891, -161.939, 26.5913, 5.09636, 0, 0, -0.559193, 0.829038, 86400, 255, 1, '', 46741),
(@GUID+35, 181278, 558, 3790, 3790, 3, 1, 227.291, 19.9092, -0.064963, 2.37364, 0, 0, 0.927183, 0.374608, 86400, 255, 1, '', 46741),
(@GUID+36, 181278, 558, 3790, 3790, 3, 1, 238.11, -21.5713, -0.103546, 1.97222, 0, 0, 0.833885, 0.551938, 86400, 255, 1, '', 46741),
-- Lichen Group 3
(@GUID+37, 181278, 558, 3790, 3790, 3, 1, -125.759, -306.731, 26.8307, 4.88692, 0, 0, -0.642787, 0.766045, 86400, 255, 1, '', 46741),
(@GUID+38, 181278, 558, 3790, 3790, 3, 1, -131.895, -251.102, 26.4101, 1.71042, 0, 0, 0.754709, 0.656059, 86400, 255, 1, '', 46741),
(@GUID+39, 181278, 558, 3790, 3790, 3, 1, -170.729, -270.22, 31.6304, 4.60767, 0, 0, -0.743144, 0.669131, 86400, 255, 1, '', 46741),
-- Lichen Group 4
(@GUID+40, 181278, 558, 3790, 3790, 3, 1, 11.4308, -382.646, 19.4112, -2.60053, 0, 0, 0, 1, 86400, 255, 1, '', 0),
(@GUID+41, 181278, 558, 3790, 3790, 3, 1, -57.6584, -360.292, 26.6024, 5.58505, 0, 0, -0.34202, 0.939693, 86400, 255, 1, '', 46741),
(@GUID+42, 181278, 558, 3790, 3790, 3, 1, -18.5816, -360.279, 26.5888, 3.85718, 0, 0, -0.936671, 0.35021, 86400, 255, 1, '', 46741),
(@GUID+43, 181278, 558, 3790, 3790, 3, 1, 31.0407, -359.303, 26.5985, 5.61996, 0, 0, -0.325567, 0.945519, 86400, 255, 1, '', 46741),
(@GUID+44, 181278, 558, 3790, 3790, 3, 1, -51.5901, -414.033, 26.5885, 3.75246, 0, 0, -0.953716, 0.300708, 86400, 255, 1, '', 46741),
(@GUID+45, 181278, 558, 3790, 3790, 3, 1, 29.3026, -409.006, 26.5865, 5.42797, 0, 0, -0.414693, 0.909961, 86400, 255, 1, '', 46741),
-- SETHEKK HALLS
-- ORE GROUP 1
(@GUID+46, 181556, 556, 3791, 3791, 3, 1, -59.9727, 84.91, 1.11623, 2.84488, 0, 0, 0.989016, 0.147811, 86400, 255, 1, '', 47187),
(@GUID+49, 181556, 556, 3791, 3791, 3, 1, -84.1449, 83.7513, 1.94966, 2.33874, 0, 0, 0.920505, 0.390732, 86400, 255, 1, '', 47187),
(@GUID+52, 181556, 556, 3791, 3791, 3, 1, 57.1795, 115.444, -3.00431, 2.87979, 0, 0, 0.991445, 0.130528, 86400, 255, 1, '', 47187),
(@GUID+55, 181556, 556, 3791, 3791, 3, 1, -114.993, 103.73, 2.62569, 5.77704, 0, 0, -0.25038, 0.968148, 86400, 255, 1, '', 47187),
(@GUID+58, 181556, 556, 3791, 3791, 3, 1, 24.3, 114.706, 0.058363, 4.69494, 0, 0, -0.71325, 0.70091, 86400, 255, 1, '', 47187),
(@GUID+61, 181556, 556, 3791, 3791, 3, 1, 103.381, 105.561, 2.53604, 4.15388, 0, 0, -0.874619, 0.48481, 86400, 255, 1, '', 47187),
-- Rich Adamantite
(@GUID+47, 181569, 556, 3791, 3791, 3, 1, -59.9727, 84.91, 1.11623, 2.84488, 0, 0, 0.989016, 0.147811, 86400, 255, 1, '', 47187),
(@GUID+50, 181569, 556, 3791, 3791, 3, 1, -84.1449, 83.7513, 1.94966, 2.33874, 0, 0, 0.920505, 0.390732, 86400, 255, 1, '', 47187),
(@GUID+53, 181569, 556, 3791, 3791, 3, 1, 57.1795, 115.444, -3.00431, 2.87979, 0, 0, 0.991445, 0.130528, 86400, 255, 1, '', 47187),
(@GUID+56, 181569, 556, 3791, 3791, 3, 1, -114.993, 103.73, 2.62569, 5.77704, 0, 0, -0.25038, 0.968148, 86400, 255, 1, '', 47187),
(@GUID+59, 181569, 556, 3791, 3791, 3, 1, 24.3, 114.706, 0.058363, 4.69494, 0, 0, -0.71325, 0.70091, 86400, 255, 1, '', 47187),
(@GUID+62, 181569, 556, 3791, 3791, 3, 1, 103.381, 105.561, 2.53604, 4.15388, 0, 0, -0.874619, 0.48481, 86400, 255, 1, '', 47187),
-- Khorium
(@GUID+48, 181557, 556, 3791, 3791, 3, 1, -59.9727, 84.91, 1.11623, 2.84488, 0, 0, 0.989016, 0.147811, 86400, 255, 1, '', 47187),
(@GUID+51, 181557, 556, 3791, 3791, 3, 1, -84.1449, 83.7513, 1.94966, 2.33874, 0, 0, 0.920505, 0.390732, 86400, 255, 1, '', 47187),
(@GUID+54, 181557, 556, 3791, 3791, 3, 1, 57.1795, 115.444, -3.00431, 2.87979, 0, 0, 0.991445, 0.130528, 86400, 255, 1, '', 47187),
(@GUID+57, 181557, 556, 3791, 3791, 3, 1, -114.993, 103.73, 2.62569, 5.77704, 0, 0, -0.25038, 0.968148, 86400, 255, 1, '', 47187),
(@GUID+60, 181557, 556, 3791, 3791, 3, 1, 24.3, 114.706, 0.058363, 4.69494, 0, 0, -0.71325, 0.70091, 86400, 255, 1, '', 47187),
(@GUID+63, 181557, 556, 3791, 3791, 3, 1, 103.381, 105.561, 2.53604, 4.15388, 0, 0, -0.874619, 0.48481, 86400, 255, 1, '', 47187),
-- ORE GROUP 2
(@GUID+64, 181556, 556, 3791, 3791, 3, 1, -194.833, 339.823, 25.4777, 1.95477, 0, 0, 0.829038, 0.559193, 86400, 255, 1, '', 47187),
(@GUID+67, 181556, 556, 3791, 3791, 3, 1, -233.406, 200.359, 1.84191, 0.558504, 0, 0, 0.275637, 0.961262, 86400, 255, 1, '', 47187),
(@GUID+70, 181556, 556, 3791, 3791, 3, 1, -228.518, 199.721, 24.8284, 4.60767, 0, 0, -0.743144, 0.669131, 86400, 255, 1, '', 47187),
(@GUID+73, 181556, 556, 3791, 3791, 3, 1, -230.139, 291.997, 32.156, 1.65806, 0, 0, 0.737277, 0.675591, 86400, 255, 1, '', 47187),
(@GUID+76, 181556, 556, 3791, 3791, 3, 1, -221.732, 151.383, 1.69546, 1.5708, 0, 0, 0.707107, 0.707107, 86400, 255, 1, '', 47187),
(@GUID+79, 181556, 556, 3791, 3791, 3, 1, -196.522, 294.837, 30.829, 4.85202, 0, 0, -0.656058, 0.75471, 86400, 255, 1, '', 47187),
(@GUID+82, 181556, 556, 3791, 3791, 3, 1, -80.9439, 307.453, 24.743, 2.84488, 0, 0, 0.989016, 0.147811, 86400, 255, 1, '', 47187),
(@GUID+85, 181556, 556, 3791, 3791, 3, 1, -100.66, 273.158, 23.1322, 3.56047, 0, 0, -0.978148, 0.207912, 86400, 255, 1, '', 47187),
-- Rich Adamantite
(@GUID+65, 181569, 556, 3791, 3791, 3, 1, -194.833, 339.823, 25.4777, 1.95477, 0, 0, 0.829038, 0.559193, 86400, 255, 1, '', 47187),
(@GUID+68, 181569, 556, 3791, 3791, 3, 1, -233.406, 200.359, 1.84191, 0.558504, 0, 0, 0.275637, 0.961262, 86400, 255, 1, '', 47187),
(@GUID+71, 181569, 556, 3791, 3791, 3, 1, -228.518, 199.721, 24.8284, 4.60767, 0, 0, -0.743144, 0.669131, 86400, 255, 1, '', 47187),
(@GUID+74, 181569, 556, 3791, 3791, 3, 1, -230.139, 291.997, 32.156, 1.65806, 0, 0, 0.737277, 0.675591, 86400, 255, 1, '', 47187),
(@GUID+77, 181569, 556, 3791, 3791, 3, 1, -221.732, 151.383, 1.69546, 1.5708, 0, 0, 0.707107, 0.707107, 86400, 255, 1, '', 47187),
(@GUID+80, 181569, 556, 3791, 3791, 3, 1, -196.522, 294.837, 30.829, 4.85202, 0, 0, -0.656058, 0.75471, 86400, 255, 1, '', 47187),
(@GUID+83, 181569, 556, 3791, 3791, 3, 1, -80.9439, 307.453, 24.743, 2.84488, 0, 0, 0.989016, 0.147811, 86400, 255, 1, '', 47187),
(@GUID+86, 181569, 556, 3791, 3791, 3, 1, -100.66, 273.158, 23.1322, 3.56047, 0, 0, -0.978148, 0.207912, 86400, 255, 1, '', 47187),
-- Khorium
(@GUID+66, 181557, 556, 3791, 3791, 3, 1, -194.833, 339.823, 25.4777, 1.95477, 0, 0, 0.829038, 0.559193, 86400, 255, 1, '', 47187),
(@GUID+69, 181557, 556, 3791, 3791, 3, 1, -233.406, 200.359, 1.84191, 0.558504, 0, 0, 0.275637, 0.961262, 86400, 255, 1, '', 47187),
(@GUID+72, 181557, 556, 3791, 3791, 3, 1, -228.518, 199.721, 24.8284, 4.60767, 0, 0, -0.743144, 0.669131, 86400, 255, 1, '', 47187),
(@GUID+75, 181557, 556, 3791, 3791, 3, 1, -230.139, 291.997, 32.156, 1.65806, 0, 0, 0.737277, 0.675591, 86400, 255, 1, '', 47187),
(@GUID+78, 181557, 556, 3791, 3791, 3, 1, -221.732, 151.383, 1.69546, 1.5708, 0, 0, 0.707107, 0.707107, 86400, 255, 1, '', 47187),
(@GUID+81, 181557, 556, 3791, 3791, 3, 1, -196.522, 294.837, 30.829, 4.85202, 0, 0, -0.656058, 0.75471, 86400, 255, 1, '', 47187),
(@GUID+84, 181557, 556, 3791, 3791, 3, 1, -80.9439, 307.453, 24.743, 2.84488, 0, 0, 0.989016, 0.147811, 86400, 255, 1, '', 47187),
(@GUID+87, 181557, 556, 3791, 3791, 3, 1, -100.66, 273.158, 23.1322, 3.56047, 0, 0, -0.978148, 0.207912, 86400, 255, 1, '', 47187),
-- LICHEN GROUP 1
(@GUID+88, 181278, 556, 3791, 3791, 3, 1, 7.98955, 112.229, 0.348708, 4.4855, 0, 0, -0.782608, 0.622515, 86400, 255, 1, '', 47187),
(@GUID+89, 181278, 556, 3791, 3791, 3, 1, 87.8129, 116.028, 0.353684, 0.59341, 0, 0, 0.292371, 0.956305, 86400, 255, 1, '', 47187),
-- LICHEN GROUP 2
(@GUID+90, 181278, 556, 3791, 3791, 3, 1, -63.2795, 178.564, 0.01084, 1.25664, 0, 0, 0.587785, 0.809017, 86400, 255, 1, '', 47187),
(@GUID+91, 181278, 556, 3791, 3791, 3, 1, -91.2256, 110.526, 0.005229, 2.63544, 0, 0, 0.968147, 0.250381, 86400, 255, 1, '', 47187),
(@GUID+92, 181278, 556, 3791, 3791, 3, 1, -75.1794, 75.9373, 0.006448, 4.83456, 0, 0, -0.66262, 0.748956, 86400, 255, 1, '', 47187),
-- LICHEN GROUP 3
(@GUID+93, 181278, 556, 3791, 3791, 3, 1, -279.839, 193.427, 0.057562, 1.88495, 0, 0, 0.809016, 0.587786, 86400, 255, 1, '', 47187),
(@GUID+94, 181278, 556, 3791, 3791, 3, 1, -246.083, 147.564, 0.062782, 1.76278, 0, 0, 0.771625, 0.636078, 86400, 255, 1, '', 47187),
(@GUID+95, 181278, 556, 3791, 3791, 3, 1, -237.488, 203.8, -0.051845, 1.85005, 0, 0, 0.798635, 0.601815, 86400, 255, 1, '', 47187),
-- LICHEN GROUP 4
(@GUID+96, 181278, 556, 3791, 3791, 3, 1, -200.026, 351.062, 26.6361, 5.61996, 0, 0, -0.325567, 0.945519, 86400, 255, 1, '', 47187),
(@GUID+97, 181278, 556, 3791, 3791, 3, 1, -175.854, 340.07, 27.4297, 6.16101, 0, 0, -0.0610485, 0.998135, 86400, 255, 1, '', 47187),
(@GUID+98, 181278, 556, 3791, 3791, 3, 1, -190.816, 273.533, 26.7324, 5.5676, 0, 0, -0.350207, 0.936672, 86400, 255, 1, '', 47187),
(@GUID+99, 181278, 556, 3791, 3791, 3, 1, -242.4, 351.192, 26.7369, 5.74214, 0, 0, -0.267238, 0.963631, 86400, 255, 1, '', 47187),
-- LICHEN GROUP 5
(@GUID+100, 181278, 556, 3791, 3791, 3, 1, -99.0857, 314.553, 26.552, 2.42601, 0, 0, 0.936672, 0.350207, 86400, 255, 1, '', 47187),
(@GUID+101, 181278, 556, 3791, 3791, 3, 1, -74.5162, 270.936, 26.7079, 2.91469, 0, 0, 0.993571, 0.113208, 86400, 255, 1, '', 47187),
(@GUID+102, 181278, 556, 3791, 3791, 3, 1, -117.02, 260.386, 26.8177, 3.24635, 0, 0, -0.998629, 0.0523532, 86400, 255, 1, '', 47187),
(@GUID+103, 181278, 556, 3791, 3791, 3, 1, -58.4746, 314.138, 27.3705, 5.34071, 0, 0, -0.45399, 0.891007, 86400, 255, 1, '', 47187),
-- SHADOW LABYRINTH
-- ORE GROUP 1
(@GUID+104, 181556, 555, 3789, 3789, 3, 1, -444.706, -134.04, 9.70979, 2.87979, 0, 0, 0.991445, 0.130528, 86400, 255, 1, '', 47187),
(@GUID+107, 181556, 555, 3789, 3789, 3, 1, -280.173, -288.205, 15.7102, 1.51844, 0, 0, 0.688354, 0.725374, 86400, 255, 1, '', 47187),
(@GUID+110, 181556, 555, 3789, 3789, 3, 1, -413.967, -148.752, 12.0902, 1.71042, 0, 0, 0.754709, 0.656059, 86400, 255, 1, '', 47187),
(@GUID+113, 181556, 555, 3789, 3789, 3, 1, -461.452, -168.93, 21.1669, 3.61284, 0, 0, -0.972369, 0.233448, 86400, 255, 1, '', 47187),
(@GUID+116, 181556, 555, 3789, 3789, 3, 1, -343.013, -289.625, 18.6538, 3.927, 0, 0, -0.923879, 0.382686, 86400, 255, 1, '', 47187),
-- Rich Adamantite
(@GUID+105, 181569, 555, 3789, 3789, 3, 1, -444.706, -134.04, 9.70979, 2.87979, 0, 0, 0.991445, 0.130528, 86400, 255, 1, '', 47187),
(@GUID+108, 181569, 555, 3789, 3789, 3, 1, -280.173, -288.205, 15.7102, 1.51844, 0, 0, 0.688354, 0.725374, 86400, 255, 1, '', 47187),
(@GUID+111, 181569, 555, 3789, 3789, 3, 1, -413.967, -148.752, 12.0902, 1.71042, 0, 0, 0.754709, 0.656059, 86400, 255, 1, '', 47187),
(@GUID+114, 181569, 555, 3789, 3789, 3, 1, -461.452, -168.93, 21.1669, 3.61284, 0, 0, -0.972369, 0.233448, 86400, 255, 1, '', 47187),
(@GUID+117, 181569, 555, 3789, 3789, 3, 1, -343.013, -289.625, 18.6538, 3.927, 0, 0, -0.923879, 0.382686, 86400, 255, 1, '', 47187),
-- Khorium
(@GUID+106, 181557, 555, 3789, 3789, 3, 1, -444.706, -134.04, 9.70979, 2.87979, 0, 0, 0.991445, 0.130528, 86400, 255, 1, '', 47187),
(@GUID+109, 181557, 555, 3789, 3789, 3, 1, -280.173, -288.205, 15.7102, 1.51844, 0, 0, 0.688354, 0.725374, 86400, 255, 1, '', 47187),
(@GUID+112, 181557, 555, 3789, 3789, 3, 1, -413.967, -148.752, 12.0902, 1.71042, 0, 0, 0.754709, 0.656059, 86400, 255, 1, '', 47187),
(@GUID+115, 181557, 555, 3789, 3789, 3, 1, -461.452, -168.93, 21.1669, 3.61284, 0, 0, -0.972369, 0.233448, 86400, 255, 1, '', 47187),
(@GUID+118, 181557, 555, 3789, 3789, 3, 1, -343.013, -289.625, 18.6538, 3.927, 0, 0, -0.923879, 0.382686, 86400, 255, 1, '', 47187),
-- ORE GROUP 2
(@GUID+119, 181556, 555, 3789, 3789, 3, 1, -67.3891, 37.0473, 1.74518, -1.22173, 0, 0, 0.573576, -0.819152, 86400, 255, 1, '', 0),
(@GUID+122, 181556, 555, 3789, 3789, 3, 1, -352.19, -60.7045, 17.7109, 5.75959, 0, 0, -0.258819, 0.965926, 86400, 255, 1, '', 47187),
(@GUID+125, 181556, 555, 3789, 3789, 3, 1, -235.529, 17.4544, 14.6202, 3.01941, 0, 0, 0.998135, 0.0610518, 86400, 255, 1, '', 47187),
(@GUID+128, 181556, 555, 3789, 3789, 3, 1, -362.041, -24.6519, 16.788, 1.83259, 0, 0, 0.793353, 0.608762, 86400, 255, 1, '', 47187),
(@GUID+131, 181556, 555, 3789, 3789, 3, 1, -234.062, -97.6057, 15.5083, 0.750491, 0, 0, 0.366501, 0.930418, 86400, 255, 1, '', 47187),
-- Rich Adamantite
(@GUID+120, 181569, 555, 3789, 3789, 3, 1, -67.3891, 37.0473, 1.74518, -1.22173, 0, 0, 0.573576, -0.819152, 86400, 255, 1, '', 0),
(@GUID+123, 181569, 555, 3789, 3789, 3, 1, -352.19, -60.7045, 17.7109, 5.75959, 0, 0, -0.258819, 0.965926, 86400, 255, 1, '', 47187),
(@GUID+126, 181569, 555, 3789, 3789, 3, 1, -235.529, 17.4544, 14.6202, 3.01941, 0, 0, 0.998135, 0.0610518, 86400, 255, 1, '', 47187),
(@GUID+129, 181569, 555, 3789, 3789, 3, 1, -362.041, -24.6519, 16.788, 1.83259, 0, 0, 0.793353, 0.608762, 86400, 255, 1, '', 47187),
(@GUID+132, 181569, 555, 3789, 3789, 3, 1, -234.062, -97.6057, 15.5083, 0.750491, 0, 0, 0.366501, 0.930418, 86400, 255, 1, '', 47187),
-- Khorium
(@GUID+121, 181557, 555, 3789, 3789, 3, 1, -67.3891, 37.0473, 1.74518, -1.22173, 0, 0, 0.573576, -0.819152, 86400, 255, 1, '', 0),
(@GUID+124, 181557, 555, 3789, 3789, 3, 1, -352.19, -60.7045, 17.7109, 5.75959, 0, 0, -0.258819, 0.965926, 86400, 255, 1, '', 47187),
(@GUID+127, 181557, 555, 3789, 3789, 3, 1, -235.529, 17.4544, 14.6202, 3.01941, 0, 0, 0.998135, 0.0610518, 86400, 255, 1, '', 47187),
(@GUID+130, 181557, 555, 3789, 3789, 3, 1, -362.041, -24.6519, 16.788, 1.83259, 0, 0, 0.793353, 0.608762, 86400, 255, 1, '', 47187),
(@GUID+133, 181557, 555, 3789, 3789, 3, 1, -234.062, -97.6057, 15.5083, 0.750491, 0, 0, 0.366501, 0.930418, 86400, 255, 1, '', 47187),
-- LICHEN GROUP 1
(@GUID+134, 181278, 555, 3789, 3789, 3, 1, -94.8835, 11.1668, -1.12819, 2.28638, 0, 0, 0.909961, 0.414694, 86400, 255, 1, '', 47187),
(@GUID+135, 181278, 555, 3789, 3789, 3, 1, -77.7761, -44.3547, -1.12827, 1.71042, 0, 0, 0.754709, 0.656059, 86400, 255, 1, '', 47187),
(@GUID+136, 181278, 555, 3789, 3789, 3, 1, -34.7484, -90.9532, -1.1283, 3.17653, 0, 0, -0.999847, 0.0174693, 86400, 255, 1, '', 47187),
(@GUID+137, 181278, 555, 3789, 3789, 3, 1, -89.5791, -84.7791, -1.1283, 5.58505, 0, 0, -0.34202, 0.939693, 86400, 255, 1, '', 47187),
-- LICHEN GROUP 2
(@GUID+138, 181278, 555, 3789, 3789, 3, 1, -169.086, 5.50827, 8.07305, 2.60054, 0, 0, 0.96363, 0.267238, 86400, 255, 1, '', 0),
(@GUID+139, 181278, 555, 3789, 3789, 3, 1, -142.808, 4.1791, 8.07297, 5.23599, 0, 0, -0.5, 0.866025, 86400, 255, 1, '', 47187),
(@GUID+140, 181278, 555, 3789, 3789, 3, 1, -145.144, -71.5597, 8.06785, 0.506145, 0, 0, 0.25038, 0.968148, 86400, 255, 1, '', 47187),
(@GUID+141, 181278, 555, 3789, 3789, 3, 1, -161.71, -14.5394, 8.0731, 4.57276, 0, 0, -0.754709, 0.656059, 86400, 255, 1, '', 47187),
(@GUID+142, 181278, 555, 3789, 3789, 3, 1, -170.012, -70.4493, 8.06785, 3.38594, 0, 0, -0.992546, 0.12187, 86400, 255, 1, '', 47187),
(@GUID+143, 181278, 555, 3789, 3789, 3, 1, -153.173, -52.8355, 8.07305, 3.4034, 0, 0, -0.991445, 0.130528, 86400, 255, 1, '', 47187),
-- LICHEN GROUP 3
(@GUID+144, 181278, 555, 3789, 3789, 3, 1, -267.485, -79.3793, 8.07292, 5.88176, 0, 0, -0.199368, 0.979925, 86400, 255, 1, '', 47187),
(@GUID+145, 181278, 555, 3789, 3789, 3, 1, -269.214, -0.495546, 8.07293, 2.35619, 0, 0, 0.92388, 0.382683, 86400, 255, 1, '', 47187),
(@GUID+146, 181278, 555, 3789, 3789, 3, 1, -292.68, 19.5516, 8.07305, 0.0174525, 0, 0, 0.00872612, 0.999962, 86400, 255, 1, '', 47187),
(@GUID+147, 181278, 555, 3789, 3789, 3, 1, -284.108, -102.021, 8.07298, 5.46288, 0, 0, -0.398748, 0.91706, 86400, 255, 1, '', 47187),
-- LICHEN GROUP 4
(@GUID+148, 181278, 555, 3789, 3789, 3, 1, -411.712, -203.084, 12.7605, 2.26893, 0, 0, 0.906307, 0.422619, 86400, 255, 1, '', 47187),
(@GUID+149, 181278, 555, 3789, 3789, 3, 1, -442.793, -123.579, 13.2556, 4.45059, 0, 0, -0.793353, 0.608762, 86400, 255, 1, '', 47187),
(@GUID+150, 181278, 555, 3789, 3789, 3, 1, -457.128, -195.439, 12.6891, 4.95674, 0, 0, -0.615661, 0.788011, 86400, 255, 1, '', 47187),
-- LICHEN GROUP 5
(@GUID+151, 181278, 555, 3789, 3789, 3, 1, -286.216, -240.003, 12.6827, 2.28638, 0, 0, 0.909961, 0.414693, 86400, 255, 1, '', 0),
(@GUID+152, 181278, 555, 3789, 3789, 3, 1, -329.27, -303.466, 25.1034, 4.4855, 0, 0, -0.782608, 0.622515, 86400, 255, 1, '', 47187),
(@GUID+153, 181278, 555, 3789, 3789, 3, 1, -298.782, -304.974, 25.183, 5.11382, 0, 0, -0.551936, 0.833886, 86400, 255, 1, '', 47187),
(@GUID+154, 181278, 555, 3789, 3789, 3, 1, -326.735, -244.62, 12.6846, 4.59022, 0, 0, -0.748956, 0.66262, 86400, 255, 1, '', 47187),
-- LICHEN GROUP 6
(@GUID+155, 181278, 555, 3789, 3789, 3, 1, -139.013, -396.985, 17.08, 2.82743, 0, 0, 0.987688, 0.156436, 86400, 255, 1, '', 47187),
(@GUID+156, 181278, 555, 3789, 3789, 3, 1, -170.229, -386.925, 17.0808, 5.14872, 0, 0, -0.537299, 0.843392, 86400, 255, 1, '', 47187),
(@GUID+157, 181278, 555, 3789, 3789, 3, 1, -170.759, -350.168, 17.0826, 4.64258, 0, 0, -0.731354, 0.681998, 86400, 255, 1, '', 47187),
(@GUID+158, 181278, 555, 3789, 3789, 3, 1, -137.353, -406.701, 17.08, 3.68265, 0, 0, -0.96363, 0.267241, 86400, 255, 1, '', 47187),
(@GUID+159, 181278, 555, 3789, 3789, 3, 1, -139.072, -443.655, 17.0795, 0.087266, 0, 0, 0.0436192, 0.999048, 86400, 255, 1, '', 47187),
(@GUID+160, 181278, 555, 3789, 3789, 3, 1, -174.217, -435.155, 17.0785, 2.28638, 0, 0, 0.909961, 0.414694, 86400, 255, 1, '', 47187);

DELETE FROM `pool_template` WHERE `description` LIKE '%Auchenai Crypts%' AND `entry` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+5;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOLMOTHER+0, 1, 'Auchenai Crypts - Ores - Group 1'),
(@POOLMOTHER+1, 1, 'Auchenai Crypts - Ores - Group 2'),
(@POOLMOTHER+2, 1, 'Auchenai Crypts - Ancient Lichen - Group 1'),
(@POOLMOTHER+3, 1, 'Auchenai Crypts - Ancient Lichen - Group 2'),
(@POOLMOTHER+4, 1, 'Auchenai Crypts - Ancient Lichen - Group 3'),
(@POOLMOTHER+5, 1, 'Auchenai Crypts - Ancient Lichen - Group 4');

DELETE FROM `pool_template` WHERE `description` LIKE '%Sethekk Halls%' AND `entry` BETWEEN @POOLMOTHER+6 AND @POOLMOTHER+12;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOLMOTHER+6 , 1, 'Sethekk Halls - Ores - Group 1'),
(@POOLMOTHER+7 , 1, 'Sethekk Halls - Ores - Group 2'),
(@POOLMOTHER+8 , 1, 'Sethekk Halls - Ancient Lichen - Group 1'),
(@POOLMOTHER+9 , 1, 'Sethekk Halls - Ancient Lichen - Group 2'),
(@POOLMOTHER+10, 1, 'Sethekk Halls - Ancient Lichen - Group 3'),
(@POOLMOTHER+11, 1, 'Sethekk Halls - Ancient Lichen - Group 4'),
(@POOLMOTHER+12, 1, 'Sethekk Halls - Ancient Lichen - Group 5');

DELETE FROM `pool_template` WHERE `description` LIKE '%Shadow Labyrinth%' AND `entry` BETWEEN @POOLMOTHER+13 AND @POOLMOTHER+20;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOLMOTHER+13, 1, 'Shadow Labyrinth - Ores - Group 1'),
(@POOLMOTHER+14, 1, 'Shadow Labyrinth - Ores - Group 2'),
(@POOLMOTHER+15, 1, 'Shadow Labyrinth - Ancient Lichen - Group 1'),
(@POOLMOTHER+16, 1, 'Shadow Labyrinth - Ancient Lichen - Group 2'),
(@POOLMOTHER+17, 1, 'Shadow Labyrinth - Ancient Lichen - Group 3'),
(@POOLMOTHER+18, 1, 'Shadow Labyrinth - Ancient Lichen - Group 4'),
(@POOLMOTHER+19, 1, 'Shadow Labyrinth - Ancient Lichen - Group 5'),
(@POOLMOTHER+20, 1, 'Shadow Labyrinth - Ancient Lichen - Group 6');

DELETE FROM `pool_gameobject` WHERE `description`='Ancient Lichen - Auchenai Crypts' AND `guid` BETWEEN @GUID+30 AND @GUID+45 AND `pool_entry` BETWEEN @POOLMOTHER+2 AND @POOLMOTHER+5;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GUID+30, @POOLMOTHER+2, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+31, @POOLMOTHER+2, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+32, @POOLMOTHER+2, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+33, @POOLMOTHER+2, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+34, @POOLMOTHER+3, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+35, @POOLMOTHER+3, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+36, @POOLMOTHER+3, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+37, @POOLMOTHER+4, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+38, @POOLMOTHER+4, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+39, @POOLMOTHER+4, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+40, @POOLMOTHER+5, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+41, @POOLMOTHER+5, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+42, @POOLMOTHER+5, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+43, @POOLMOTHER+5, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+44, @POOLMOTHER+5, 0, 'Ancient Lichen - Auchenai Crypts'),
(@GUID+45, @POOLMOTHER+5, 0, 'Ancient Lichen - Auchenai Crypts');

DELETE FROM `pool_gameobject` WHERE `description`='Ancient Lichen - Sethekk Halls' AND `guid` BETWEEN @GUID+88 AND @GUID+103 AND `pool_entry` BETWEEN @POOLMOTHER+8 AND @POOLMOTHER+12;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GUID+88 , @POOLMOTHER+8 , 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+89 , @POOLMOTHER+8 , 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+90 , @POOLMOTHER+9 , 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+91 , @POOLMOTHER+9 , 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+92 , @POOLMOTHER+9 , 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+93 , @POOLMOTHER+10, 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+94 , @POOLMOTHER+10, 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+95 , @POOLMOTHER+10, 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+96 , @POOLMOTHER+11, 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+97 , @POOLMOTHER+11, 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+98 , @POOLMOTHER+11, 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+99 , @POOLMOTHER+11, 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+100, @POOLMOTHER+12, 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+101, @POOLMOTHER+12, 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+102, @POOLMOTHER+12, 0, 'Ancient Lichen - Sethekk Halls'),
(@GUID+103, @POOLMOTHER+12, 0, 'Ancient Lichen - Sethekk Halls');

DELETE FROM `pool_gameobject` WHERE `description`='Ancient Lichen - Shadow Labyrinth' AND `guid` BETWEEN @GUID+134 AND @GUID+160 AND `pool_entry` BETWEEN @POOLMOTHER+15 AND @POOLMOTHER+20;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GUID+134, @POOLMOTHER+15, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+135, @POOLMOTHER+15, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+136, @POOLMOTHER+15, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+137, @POOLMOTHER+15, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+138, @POOLMOTHER+16, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+139, @POOLMOTHER+16, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+140, @POOLMOTHER+16, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+141, @POOLMOTHER+16, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+142, @POOLMOTHER+16, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+143, @POOLMOTHER+16, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+144, @POOLMOTHER+17, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+145, @POOLMOTHER+17, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+146, @POOLMOTHER+17, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+147, @POOLMOTHER+17, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+148, @POOLMOTHER+18, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+149, @POOLMOTHER+18, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+150, @POOLMOTHER+18, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+151, @POOLMOTHER+19, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+152, @POOLMOTHER+19, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+153, @POOLMOTHER+19, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+154, @POOLMOTHER+19, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+155, @POOLMOTHER+20, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+156, @POOLMOTHER+20, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+157, @POOLMOTHER+20, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+158, @POOLMOTHER+20, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+159, @POOLMOTHER+20, 0, 'Ancient Lichen - Shadow Labyrinth'),
(@GUID+160, @POOLMOTHER+20, 0, 'Ancient Lichen - Shadow Labyrinth');

DELETE FROM `pool_gameobject` WHERE `description`='Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein' AND `guid` BETWEEN @GUID+0 AND @GUID+29 AND `pool_entry` BETWEEN @POOL+0 AND @POOL+9;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GUID+0 , @POOL+0, 0 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+3 , @POOL+1, 0 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+6 , @POOL+2, 0 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+9 , @POOL+3, 0 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+12, @POOL+4, 0 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+15, @POOL+5, 0 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+1 , @POOL+0, 40, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+4 , @POOL+1, 40, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+7 , @POOL+2, 40, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+10, @POOL+3, 40, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+13, @POOL+4, 40, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+16, @POOL+5, 40, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+2 , @POOL+0, 5 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+5 , @POOL+1, 5 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+8 , @POOL+2, 5 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+11, @POOL+3, 5 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+14, @POOL+4, 5 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+17, @POOL+5, 5 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+18, @POOL+6, 0 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+21, @POOL+7, 0 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+24, @POOL+8, 0 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+27, @POOL+9, 0 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+19, @POOL+6, 40, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+22, @POOL+7, 40, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+25, @POOL+8, 40, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+28, @POOL+9, 40, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+20, @POOL+6, 5 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+23, @POOL+7, 5 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+26, @POOL+8, 5 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+29, @POOL+9, 5 , 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein');

DELETE FROM `pool_template` WHERE `description`='Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein' AND `entry` BETWEEN @POOL+0 AND @POOL+9;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL+0, 1, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+1, 1, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+2, 1, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+3, 1, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+4, 1, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+5, 1, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+6, 1, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+7, 1, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+8, 1, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+9, 1, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein');

DELETE FROM `pool_pool` WHERE `description` LIKE '%Auchenai Crypts%' AND `pool_id` BETWEEN @POOL+0 AND @POOL+9 AND `mother_pool` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+1;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES
(@POOL+0, @POOLMOTHER+0, 0, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+1, @POOLMOTHER+0, 0, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+2, @POOLMOTHER+0, 0, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+3, @POOLMOTHER+0, 0, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+4, @POOLMOTHER+0, 0, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+5, @POOLMOTHER+0, 0, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+6, @POOLMOTHER+1, 0, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+7, @POOLMOTHER+1, 0, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+8, @POOLMOTHER+1, 0, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+9, @POOLMOTHER+1, 0, 'Auchenai Crypts - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2');

DELETE FROM `pool_gameobject` WHERE `description`='Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein' AND `guid` BETWEEN @GUID+46 AND @GUID+87 AND `pool_entry` BETWEEN @POOL+10 AND @POOL+23;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GUID+46, @POOL+10, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+49, @POOL+11, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+52, @POOL+12, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+55, @POOL+13, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+58, @POOL+14, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+61, @POOL+15, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+47, @POOL+10, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+50, @POOL+11, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+53, @POOL+12, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+56, @POOL+13, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+59, @POOL+14, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+62, @POOL+15, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+48, @POOL+10, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+51, @POOL+11, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+54, @POOL+12, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+57, @POOL+13, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+60, @POOL+14, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+63, @POOL+15, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+64, @POOL+16, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+67, @POOL+17, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+70, @POOL+18, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+73, @POOL+19, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+76, @POOL+20, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+79, @POOL+21, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+82, @POOL+22, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+85, @POOL+23, 0 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+65, @POOL+16, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+68, @POOL+17, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+71, @POOL+18, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+74, @POOL+19, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+77, @POOL+20, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+80, @POOL+21, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+83, @POOL+22, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+86, @POOL+23, 40, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+66, @POOL+16, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+69, @POOL+17, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+72, @POOL+18, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+75, @POOL+19, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+78, @POOL+20, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+81, @POOL+21, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+84, @POOL+22, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+87, @POOL+23, 5 , 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein');

DELETE FROM `pool_template` WHERE `description`='Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein' AND `entry` BETWEEN @POOL+10 AND @POOL+23;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL+10, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+11, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+12, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+13, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+14, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+15, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+16, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+17, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+18, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+19, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+20, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+21, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+22, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+23, 1, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein');

DELETE FROM `pool_pool` WHERE `description` LIKE '%Sethekk Halls%' AND `pool_id` BETWEEN @POOL+10 AND @POOL+23 AND `mother_pool` BETWEEN @POOLMOTHER+6 AND @POOLMOTHER+7;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES
(@POOL+10, @POOLMOTHER+6, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+11, @POOLMOTHER+6, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+12, @POOLMOTHER+6, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+13, @POOLMOTHER+6, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+14, @POOLMOTHER+6, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+15, @POOLMOTHER+6, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+16, @POOLMOTHER+7, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+17, @POOLMOTHER+7, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+18, @POOLMOTHER+7, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+19, @POOLMOTHER+7, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+20, @POOLMOTHER+7, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+21, @POOLMOTHER+7, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+22, @POOLMOTHER+7, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+23, @POOLMOTHER+7, 0, 'Sethekk Halls - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2');

DELETE FROM `pool_gameobject` WHERE `description`='Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein' AND `guid` BETWEEN @GUID+104 AND @GUID+133 AND `pool_entry` BETWEEN @POOL+24 AND @POOL+33;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GUID+104, @POOL+24, 0 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+107, @POOL+25, 0 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+110, @POOL+26, 0 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+113, @POOL+27, 0 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+116, @POOL+28, 0 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+105, @POOL+24, 40, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+108, @POOL+25, 40, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+111, @POOL+26, 40, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+114, @POOL+27, 40, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+117, @POOL+28, 40, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+106, @POOL+24, 5 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+109, @POOL+25, 5 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+112, @POOL+26, 5 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+115, @POOL+27, 5 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+118, @POOL+28, 5 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+119, @POOL+29, 0 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+122, @POOL+30, 0 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+125, @POOL+31, 0 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+128, @POOL+32, 0 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+131, @POOL+33, 0 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+120, @POOL+29, 40, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+123, @POOL+30, 40, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+126, @POOL+31, 40, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+129, @POOL+32, 40, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+132, @POOL+33, 40, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+121, @POOL+29, 5 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+124, @POOL+30, 5 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+127, @POOL+31, 5 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+130, @POOL+32, 5 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@GUID+133, @POOL+33, 5 , 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein');

DELETE FROM `pool_template` WHERE `description`='Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein' AND `entry` BETWEEN @POOL+24 AND @POOL+33;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL+24, 1, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+25, 1, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+26, 1, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+27, 1, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+28, 1, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+29, 1, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+30, 1, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+31, 1, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+32, 1, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+33, 1, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein');

DELETE FROM `pool_pool` WHERE `description` LIKE '%Shadow Labyrinth%' AND `pool_id` BETWEEN @POOL+24 AND @POOL+33 AND `mother_pool` BETWEEN @POOLMOTHER+13 AND @POOLMOTHER+14;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES
(@POOL+24, @POOLMOTHER+13, 0, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+25, @POOLMOTHER+13, 0, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+26, @POOLMOTHER+13, 0, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+27, @POOLMOTHER+13, 0, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+28, @POOLMOTHER+13, 0, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+29, @POOLMOTHER+14, 0, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+30, @POOLMOTHER+14, 0, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+31, @POOLMOTHER+14, 0, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+32, @POOLMOTHER+14, 0, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+33, @POOLMOTHER+14, 0, 'Shadow Labyrinth - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2');
