-- DB update 2023_03_28_01 -> 2023_03_28_02
--
SET @OGUID := 105242;
SET @POOL := 13421;
SET @POOLMOTHER := 8354;

DELETE FROM `gameobject` WHERE `map`=545 AND `id` IN (181555, 181556, 181557, 181569, 181278, 181275, 181276, 181270);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`) VALUES
-- Felweed
(@OGUID+0 , 181270, 545, 3715, 3715, 3, 1, -205.817, -103.243, -7.75556, 3.49067, 0, 0, -0.984807, 0.173652, 86400, 255, 1, 47871),
(@OGUID+1 , 181270, 545, 3715, 3715, 3, 1, -64.5367, -152.412, -19.9231, 5.65487, 0, 0, -0.309016, 0.951057, 86400, 255, 1, 47871),
-- Ragveil
(@OGUID+2 , 181275, 545, 3715, 3715, 3, 1, 58.5667, -204.123, -22.6133, 3.3685, 0, 0, -0.993571, 0.113208, 86400, 255, 1, 47871),
(@OGUID+4 , 181275, 545, 3715, 3715, 3, 1, -310.216, -206.72, -7.75556, 4.90438, 0, 0, -0.636078, 0.771625, 86400, 255, 1, 47871),
-- Flame Cap
(@OGUID+3 , 181275, 545, 3715, 3715, 3, 1, 58.5667, -204.123, -22.6133, 3.3685, 0, 0, -0.993571, 0.113208, 86400, 255, 1, 47871),
(@OGUID+5 , 181275, 545, 3715, 3715, 3, 1, -310.216, -206.72, -7.75556, 4.90438, 0, 0, -0.636078, 0.771625, 86400, 255, 1, 47871),
-- Ancient Lichen Group 1
(@OGUID+6 , 181278, 545, 3715, 3715, 3, 1, 6.92143, -271.444, -18.8318, 1.72787, 0, 0, 0.760406, 0.649449, 86400, 255, 1, 47871),
(@OGUID+7 , 181278, 545, 3715, 3715, 3, 1, -49.1663, -143.161, -20.2431, 1.93731, 0, 0, 0.824125, 0.566408, 86400, 255, 1, 47871),
(@OGUID+8 , 181278, 545, 3715, 3715, 3, 1, 68.2781, -149.73, -19.6815, 0.95993, 0, 0, 0.461748, 0.887011, 86400, 255, 1, 47871),
-- Ancient Lichen Group 2
(@OGUID+9 , 181278, 545, 3715, 3715, 3, 1, -245.752, -163.171, -2.66641, 5.55015, 0, 0, -0.358368, 0.93358, 86400, 255, 1, 47871),
(@OGUID+10, 181278, 545, 3715, 3715, 3, 1, -220.607, -186.447, -5.3461, 4.92183, 0, 0, -0.62932, 0.777146, 86400, 255, 1, 47871),
(@OGUID+11, 181278, 545, 3715, 3715, 3, 1, -237.348, -182.727, -5.58116, 4.53786, 0, 0, -0.766044, 0.642789, 86400, 255, 1, 47871),
-- Ancient Lichen Group 3
(@OGUID+12, 181278, 545, 3715, 3715, 3, 1, -354.513, -136.025, -7.75556, 2.84488, 0, 0, 0.989016, 0.147811, 86400, 255, 1, 47871),
(@OGUID+13, 181278, 545, 3715, 3715, 3, 1, -313.275, -107.529, -7.75556, 5.60251, 0, 0, -0.333807, 0.942641, 86400, 255, 1, 47871),
(@OGUID+14, 181278, 545, 3715, 3715, 3, 1, -328.184, -180.729, -7.75556, 4.60767, 0, 0, -0.743144, 0.669131, 86400, 255, 1, 47871),
-- Ancient Lichen Group 4
(@OGUID+15, 181278, 545, 3715, 3715, 3, 1, -238.252, -133.886, -65.1628, 0.174532, 0, 0, 0.0871553, 0.996195, 86400, 255, 1, 47871),
(@OGUID+16, 181278, 545, 3715, 3715, 3, 1, -131.431, -328.561, -67.6411, 4.20625, 0, 0, -0.861629, 0.507539, 86400, 255, 1, 47871),
(@OGUID+17, 181278, 545, 3715, 3715, 3, 1, -271.318, -206.749, -67.6411, 0.942477, 0, 0, 0.45399, 0.891007, 86400, 255, 1, 47871),
-- Fel Iron Deposit Group 1
(@OGUID+18, 181555, 545, 3715, 3715, 3, 1, 44.922, -270.041, -21.8391, 0.575957, 0, 0, 0.284015, 0.95882, 86400, 255, 1, 47871),
(@OGUID+20, 181555, 545, 3715, 3715, 3, 1, 6.10486, -229.526, -22.172, 5.34071, 0, 0, -0.45399, 0.891007, 86400, 255, 1, 47871),
(@OGUID+22, 181555, 545, 3715, 3715, 3, 1, 86.1048, -183.557, -22.0548, 0.95993, 0, 0, 0.461748, 0.887011, 86400, 255, 1, 47871),
-- Khorium
(@OGUID+19, 181555, 545, 3715, 3715, 3, 1, 44.922, -270.041, -21.8391, 0.575957, 0, 0, 0.284015, 0.95882, 86400, 255, 1, 47871),
(@OGUID+21, 181555, 545, 3715, 3715, 3, 1, 6.10486, -229.526, -22.172, 5.34071, 0, 0, -0.45399, 0.891007, 86400, 255, 1, 47871),
(@OGUID+23, 181555, 545, 3715, 3715, 3, 1, 86.1048, -183.557, -22.0548, 0.95993, 0, 0, 0.461748, 0.887011, 86400, 255, 1, 47871),
-- Fel Iron Deposit Group 2
(@OGUID+24, 181555, 545, 3715, 3715, 3, 1, -363.759, -135.723, -7.75556, 3.68265, 0, 0, -0.96363, 0.267241, 86400, 255, 1, 47871),
(@OGUID+26, 181555, 545, 3715, 3715, 3, 1, -339.412, -196.926, -5.72056, 2.54818, 0, 0, 0.956305, 0.292372, 86400, 255, 1, 47871),
(@OGUID+28, 181555, 545, 3715, 3715, 3, 1, -200.885, -121.075, -6.02453, 0.750491, 0, 0, 0.366501, 0.930418, 86400, 255, 1, 47871),
-- Khorium
(@OGUID+25, 181555, 545, 3715, 3715, 3, 1, -363.759, -135.723, -7.75556, 3.68265, 0, 0, -0.96363, 0.267241, 86400, 255, 1, 47871),
(@OGUID+27, 181555, 545, 3715, 3715, 3, 1, -339.412, -196.926, -5.72056, 2.54818, 0, 0, 0.956305, 0.292372, 86400, 255, 1, 47871),
(@OGUID+29, 181555, 545, 3715, 3715, 3, 1, -200.885, -121.075, -6.02453, 0.750491, 0, 0, 0.366501, 0.930418, 86400, 255, 1, 47871),
-- Adamantite Deposit Group 1
(@OGUID+30, 181556, 545, 3715, 3715, 3, 1, -53.296, -175.588, -20.0281, 2.61799, 0, 0, 0.965925, 0.258821, 86400, 255, 1, 47871),
(@OGUID+33, 181556, 545, 3715, 3715, 3, 1, 4.75688, -278.016, -8.36647, 5.88176, 0, 0, -0.199368, 0.979925, 86400, 255, 1, 47871),
(@OGUID+36, 181556, 545, 3715, 3715, 3, 1, 84.6738, -148.302, -21.0814, 4.59022, 0, 0, -0.748956, 0.66262, 86400, 255, 1, 47871),
-- Rich Adamantite
(@OGUID+31, 181556, 545, 3715, 3715, 3, 1, -53.296, -175.588, -20.0281, 2.61799, 0, 0, 0.965925, 0.258821, 86400, 255, 1, 47871),
(@OGUID+34, 181556, 545, 3715, 3715, 3, 1, 4.75688, -278.016, -8.36647, 5.88176, 0, 0, -0.199368, 0.979925, 86400, 255, 1, 47871),
(@OGUID+37, 181556, 545, 3715, 3715, 3, 1, 84.6738, -148.302, -21.0814, 4.59022, 0, 0, -0.748956, 0.66262, 86400, 255, 1, 47871),
-- Khorium
(@OGUID+32, 181556, 545, 3715, 3715, 3, 1, -53.296, -175.588, -20.0281, 2.61799, 0, 0, 0.965925, 0.258821, 86400, 255, 1, 47871),
(@OGUID+35, 181556, 545, 3715, 3715, 3, 1, 4.75688, -278.016, -8.36647, 5.88176, 0, 0, -0.199368, 0.979925, 86400, 255, 1, 47871),
(@OGUID+38, 181556, 545, 3715, 3715, 3, 1, 84.6738, -148.302, -21.0814, 4.59022, 0, 0, -0.748956, 0.66262, 86400, 255, 1, 47871),
-- Adamantite Deposit Group 2
(@OGUID+39, 181556, 545, 3715, 3715, 3, 1, -388.828, -157.54, -7.75556, 5.32326, 0, 0, -0.461748, 0.887011, 86400, 255, 1, 47871),
(@OGUID+42, 181556, 545, 3715, 3715, 3, 1, -364.504, -85.856, -7.75556, 0.925024, 0, 0, 0.446198, 0.894935, 86400, 255, 1, 47871),
(@OGUID+45, 181556, 545, 3715, 3715, 3, 1, -287.925, -192.021, -7.75556, 6.14356, 0, 0, -0.0697556, 0.997564, 86400, 255, 1, 47871),
(@OGUID+48, 181556, 545, 3715, 3715, 3, 1, -262.357, -186.123, -7.60742, 3.927, 0, 0, -0.923879, 0.382686, 86400, 255, 1, 47871),
-- Rich Adamantite
(@OGUID+40, 181556, 545, 3715, 3715, 3, 1, -388.828, -157.54, -7.75556, 5.32326, 0, 0, -0.461748, 0.887011, 86400, 255, 1, 47871),
(@OGUID+43, 181556, 545, 3715, 3715, 3, 1, -364.504, -85.856, -7.75556, 0.925024, 0, 0, 0.446198, 0.894935, 86400, 255, 1, 47871),
(@OGUID+46, 181556, 545, 3715, 3715, 3, 1, -287.925, -192.021, -7.75556, 6.14356, 0, 0, -0.0697556, 0.997564, 86400, 255, 1, 47871),
(@OGUID+49, 181556, 545, 3715, 3715, 3, 1, -262.357, -186.123, -7.60742, 3.927, 0, 0, -0.923879, 0.382686, 86400, 255, 1, 47871),
-- Khorium
(@OGUID+41, 181556, 545, 3715, 3715, 3, 1, -388.828, -157.54, -7.75556, 5.32326, 0, 0, -0.461748, 0.887011, 86400, 255, 1, 47871),
(@OGUID+44, 181556, 545, 3715, 3715, 3, 1, -364.504, -85.856, -7.75556, 0.925024, 0, 0, 0.446198, 0.894935, 86400, 255, 1, 47871),
(@OGUID+47, 181556, 545, 3715, 3715, 3, 1, -287.925, -192.021, -7.75556, 6.14356, 0, 0, -0.0697556, 0.997564, 86400, 255, 1, 47871),
(@OGUID+50, 181556, 545, 3715, 3715, 3, 1, -262.357, -186.123, -7.60742, 3.927, 0, 0, -0.923879, 0.382686, 86400, 255, 1, 47871);

DELETE FROM `pool_template` WHERE `description` LIKE 'The Steamvault%' AND `entry` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+9;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOLMOTHER+0, 1, 'The Steamvault - Felweed'),
(@POOLMOTHER+1, 1, 'The Steamvault - Ragveil / Flame Cap'),
(@POOLMOTHER+2, 1, 'The Steamvault - Ancient Lichen - Group 1'),
(@POOLMOTHER+3, 1, 'The Steamvault - Ancient Lichen - Group 2'),
(@POOLMOTHER+4, 1, 'The Steamvault - Ancient Lichen - Group 3'),
(@POOLMOTHER+5, 1, 'The Steamvault - Ancient Lichen - Group 4'),
(@POOLMOTHER+6, 1, 'The Steamvault - Fel Iron - Group 1'),
(@POOLMOTHER+7, 1, 'The Steamvault - Fel Iron - Group 2'),
(@POOLMOTHER+8, 1, 'The Steamvault - Adamantite - Group 1'),
(@POOLMOTHER+9, 1, 'The Steamvault - Adamantite - Group 2');

DELETE FROM `pool_gameobject` WHERE `description`='Felweed - The Steamvault' AND `guid` BETWEEN @OGUID+0 AND @OGUID+1 AND `pool_entry` = @POOLMOTHER+0;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+0 , @POOLMOTHER+0, 0, 'Felweed - The Steamvault'),
(@OGUID+1 , @POOLMOTHER+0, 0, 'Felweed - The Steamvault');

DELETE FROM `pool_gameobject` WHERE `description`='Ancient Lichen - The Steamvault' AND `guid` BETWEEN @OGUID+6 AND @OGUID+17 AND `pool_entry` BETWEEN @POOLMOTHER+2 AND @POOLMOTHER+5;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+6 , @POOLMOTHER+2, 0, 'Ancient Lichen - The Steamvault'),
(@OGUID+7 , @POOLMOTHER+2, 0, 'Ancient Lichen - The Steamvault'),
(@OGUID+8 , @POOLMOTHER+2, 0, 'Ancient Lichen - The Steamvault'),
(@OGUID+9 , @POOLMOTHER+3, 0, 'Ancient Lichen - The Steamvault'),
(@OGUID+10, @POOLMOTHER+3, 0, 'Ancient Lichen - The Steamvault'),
(@OGUID+11, @POOLMOTHER+3, 0, 'Ancient Lichen - The Steamvault'),
(@OGUID+12, @POOLMOTHER+4, 0, 'Ancient Lichen - The Steamvault'),
(@OGUID+13, @POOLMOTHER+4, 0, 'Ancient Lichen - The Steamvault'),
(@OGUID+14, @POOLMOTHER+4, 0, 'Ancient Lichen - The Steamvault'),
(@OGUID+15, @POOLMOTHER+5, 0, 'Ancient Lichen - The Steamvault'),
(@OGUID+16, @POOLMOTHER+5, 0, 'Ancient Lichen - The Steamvault'),
(@OGUID+17, @POOLMOTHER+5, 0, 'Ancient Lichen - The Steamvault');

DELETE FROM `pool_template` WHERE `description` LIKE 'The Steamvault%' AND `entry` BETWEEN @POOL+0 AND @POOL+14;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL+0 , 1, 'The Steamvault - Ragveil / Flame Cap'),
(@POOL+1 , 1, 'The Steamvault - Ragveil / Flame Cap'),
(@POOL+2 , 1, 'The Steamvault - Fel Iron Deposit / Khorium Vein'),
(@POOL+3 , 1, 'The Steamvault - Fel Iron Deposit / Khorium Vein'),
(@POOL+4 , 1, 'The Steamvault - Fel Iron Deposit / Khorium Vein'),
(@POOL+5 , 1, 'The Steamvault - Fel Iron Deposit / Khorium Vein'),
(@POOL+6 , 1, 'The Steamvault - Fel Iron Deposit / Khorium Vein'),
(@POOL+7 , 1, 'The Steamvault - Fel Iron Deposit / Khorium Vein'),
(@POOL+8 , 1, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+9 , 1, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+10, 1, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+11, 1, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+12, 1, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+13, 1, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein'),
(@POOL+14, 1, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein');

DELETE FROM `pool_pool` WHERE `description` LIKE 'The Steamvault%' AND `pool_id` BETWEEN @POOL+0 AND @POOL+14 AND `mother_pool` BETWEEN @POOLMOTHER+1 AND @POOLMOTHER+9;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES
(@POOL+0 , @POOLMOTHER+1, 0, 'The Steamvault - Ragveil / Flame Cap'),
(@POOL+1 , @POOLMOTHER+1, 0, 'The Steamvault - Ragveil / Flame Cap'),
(@POOL+2 , @POOLMOTHER+6, 0, 'The Steamvault - Fel Iron Deposit / Khorium Vein - Group 1'),
(@POOL+3 , @POOLMOTHER+6, 0, 'The Steamvault - Fel Iron Deposit / Khorium Vein - Group 1'),
(@POOL+4 , @POOLMOTHER+6, 0, 'The Steamvault - Fel Iron Deposit / Khorium Vein - Group 1'),
(@POOL+5 , @POOLMOTHER+7, 0, 'The Steamvault - Fel Iron Deposit / Khorium Vein - Group 2'),
(@POOL+6 , @POOLMOTHER+7, 0, 'The Steamvault - Fel Iron Deposit / Khorium Vein - Group 2'),
(@POOL+7 , @POOLMOTHER+7, 0, 'The Steamvault - Fel Iron Deposit / Khorium Vein - Group 2'),
(@POOL+8 , @POOLMOTHER+8, 0, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+9 , @POOLMOTHER+8, 0, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+10, @POOLMOTHER+8, 0, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 1'),
(@POOL+11, @POOLMOTHER+9, 0, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+12, @POOLMOTHER+9, 0, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+13, @POOLMOTHER+9, 0, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2'),
(@POOL+14, @POOLMOTHER+9, 0, 'The Steamvault - Adamantite Deposit / Rich Adamantite Deposit / Khorium Vein - Group 2');

DELETE FROM `pool_gameobject` WHERE `description` LIKE 'The Steamvault%' AND `guid` BETWEEN @OGUID+2 AND @OGUID+50 AND `pool_entry` BETWEEN @POOL+0 AND @POOL+14;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@OGUID+2 , @POOL+0, 0 , 'The Steamvault - Ragveil'),
(@OGUID+4 , @POOL+0, 40, 'The Steamvault - Flame Cap'),
(@OGUID+3 , @POOL+1, 0 , 'The Steamvault - Ragveil'),
(@OGUID+5 , @POOL+1, 40, 'The Steamvault - Flame Cap'),
(@OGUID+18, @POOL+2, 0 , 'The Steamvault - Fel Iron Deposit'),
(@OGUID+20, @POOL+3, 0 , 'The Steamvault - Fel Iron Deposit'),
(@OGUID+22, @POOL+4, 0 , 'The Steamvault - Fel Iron Deposit'),
(@OGUID+19, @POOL+2, 5 , 'The Steamvault - Khorium for Fel Iron Deposit'),
(@OGUID+21, @POOL+3, 5 , 'The Steamvault - Khorium for Fel Iron Deposit'),
(@OGUID+23, @POOL+4, 5 , 'The Steamvault - Khorium for Fel Iron Deposit'),
(@OGUID+24, @POOL+5, 0 , 'The Steamvault - Fel Iron Deposit'),
(@OGUID+26, @POOL+6, 0 , 'The Steamvault - Fel Iron Deposit'),
(@OGUID+28, @POOL+7, 0 , 'The Steamvault - Fel Iron Deposit'),
(@OGUID+25, @POOL+5, 5 , 'The Steamvault - Khorium for Fel Iron Deposit'),
(@OGUID+27, @POOL+6, 5 , 'The Steamvault - Khorium for Fel Iron Deposit'),
(@OGUID+29, @POOL+7, 5 , 'The Steamvault - Khorium for Fel Iron Deposit'),
(@OGUID+30, @POOL+8 , 0 , 'The Steamvault - Adamantite Deposit'),
(@OGUID+33, @POOL+9 , 0 , 'The Steamvault - Adamantite Deposit'),
(@OGUID+36, @POOL+10, 0 , 'The Steamvault - Adamantite Deposit'),
(@OGUID+31, @POOL+8 , 40, 'The Steamvault - Rich Adamantite Deposit'),
(@OGUID+34, @POOL+9 , 40, 'The Steamvault - Rich Adamantite Deposit'),
(@OGUID+37, @POOL+10, 40, 'The Steamvault - Rich Adamantite Deposit'),
(@OGUID+32, @POOL+8 , 5 , 'The Steamvault - Khorium for Adamantite Deposit'),
(@OGUID+35, @POOL+9 , 5 , 'The Steamvault - Khorium for Adamantite Deposit'),
(@OGUID+38, @POOL+10, 5 , 'The Steamvault - Khorium for Adamantite Deposit'),
(@OGUID+39, @POOL+11, 0 , 'The Steamvault - Adamantite Deposit'),
(@OGUID+42, @POOL+12, 0 , 'The Steamvault - Adamantite Deposit'),
(@OGUID+45, @POOL+13, 0 , 'The Steamvault - Adamantite Deposit'),
(@OGUID+48, @POOL+14, 0 , 'The Steamvault - Adamantite Deposit'),
(@OGUID+40, @POOL+11, 40, 'The Steamvault - Rich Adamantite Deposit'),
(@OGUID+43, @POOL+12, 40, 'The Steamvault - Rich Adamantite Deposit'),
(@OGUID+46, @POOL+13, 40, 'The Steamvault - Rich Adamantite Deposit'),
(@OGUID+49, @POOL+14, 40, 'The Steamvault - Rich Adamantite Deposit'),
(@OGUID+41, @POOL+11, 5 , 'The Steamvault - Khorium for Adamantite Deposit'),
(@OGUID+44, @POOL+12, 5 , 'The Steamvault - Khorium for Adamantite Deposit'),
(@OGUID+47, @POOL+13, 5 , 'The Steamvault - Khorium for Adamantite Deposit'),
(@OGUID+50, @POOL+14, 5 , 'The Steamvault - Khorium for Adamantite Deposit');
