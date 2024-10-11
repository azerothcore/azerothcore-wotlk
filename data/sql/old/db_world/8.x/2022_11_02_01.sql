-- DB update 2022_11_02_00 -> 2022_11_02_01
-- Isle of Quel'Danas
DELETE FROM `gameobject` WHERE `guid` IN (75573,75574,75575,75570,75571,75572,13539,27743,27742,75582,75583,75584,75585,75586,75587,75579,75580,75581,75576,75577,75578);
DELETE FROM `pool_template` WHERE `entry` IN (2017,4870,4871,4872,4873,4874,4875);
DELETE FROM `pool_pool` WHERE `mother_pool`=2017;
DELETE FROM `pool_gameobject` WHERE `pool_entry` IN (4870,4871,4872,4873,4874,4875);

-- Ores
SET @GUID = 103803; -- 124
SET @POOLMOTHER = 8282; -- 7
SET @POOL = 13130; -- 62

DELETE FROM `pool_template` WHERE `description` LIKE '%Isle of Quel\'Danas - Rich Adamantite Deposit%' AND `entry` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+3;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOLMOTHER+0, 1, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 1'),
(@POOLMOTHER+1, 1, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 2'),
(@POOLMOTHER+2, 1, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 3'),
(@POOLMOTHER+3, 1, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 4');

DELETE FROM `pool_pool` WHERE `description` LIKE '%Isle of Quel\'Danas - Rich Adamantite Deposit%' AND `pool_id` BETWEEN @POOL+0 AND @POOL+72 AND `mother_pool` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+6;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES
(@POOL+0, @POOLMOTHER+0, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 1'),
(@POOL+1, @POOLMOTHER+0, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 1'),
(@POOL+2, @POOLMOTHER+0, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 1'),
(@POOL+3, @POOLMOTHER+0, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 1'),
(@POOL+4, @POOLMOTHER+0, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 1'),

(@POOL+5, @POOLMOTHER+1, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 2'),
(@POOL+6, @POOLMOTHER+1, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 2'),
(@POOL+7, @POOLMOTHER+1, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 2'),
(@POOL+8, @POOLMOTHER+1, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 2'),

(@POOL+9 , @POOLMOTHER+2, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 3'),
(@POOL+10, @POOLMOTHER+2, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 3'),
(@POOL+11, @POOLMOTHER+2, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 3'),
(@POOL+12, @POOLMOTHER+2, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 3'),
(@POOL+13, @POOLMOTHER+2, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 3'),

(@POOL+14, @POOLMOTHER+3, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 4'),
(@POOL+15, @POOLMOTHER+3, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 4'),
(@POOL+16, @POOLMOTHER+3, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 4'),
(@POOL+17, @POOLMOTHER+3, 0, 'Isle of Quel\'Danas - Rich Adamantite Deposit - Group 4');

DELETE FROM `pool_template` WHERE `description`='Isle of Quel\'Danas - Adamantite / Khorium / Rich' AND `entry` BETWEEN @POOL+0 AND @POOL+72;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOL+0 , 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+1 , 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+2 , 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+3 , 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+4 , 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+5 , 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+6 , 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+7 , 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+8 , 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+9 , 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+10, 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+11, 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+12, 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+13, 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+14, 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+15, 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+16, 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich'),
(@POOL+17, 1, 'Isle of Quel\'Danas - Adamantite / Khorium / Rich');

DELETE FROM `pool_gameobject` WHERE `description` LIKE '%Isle of Quel\'Danas%' AND `guid` BETWEEN @GUID+0 AND @GUID+53 AND `pool_entry` BETWEEN @POOL+0 AND @POOL+17;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(@GUID+0 , @POOL+0 , 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+3 , @POOL+1 , 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+6 , @POOL+2 , 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+9 , @POOL+3 , 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+12, @POOL+4 , 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+15, @POOL+5 , 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+18, @POOL+6 , 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+21, @POOL+7 , 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+24, @POOL+8 , 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+27, @POOL+9 , 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+30, @POOL+10, 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+33, @POOL+11, 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+36, @POOL+12, 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+39, @POOL+13, 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+42, @POOL+14, 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+45, @POOL+15, 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+48, @POOL+16, 0, 'Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+51, @POOL+17, 0, 'Adamantite Deposit - Isle of Quel\'Danas'),

(@GUID+1 , @POOL+0 , 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+4 , @POOL+1 , 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+7 , @POOL+2 , 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+10, @POOL+3 , 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+13, @POOL+4 , 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+16, @POOL+5 , 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+19, @POOL+6 , 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+22, @POOL+7 , 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+25, @POOL+8 , 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+28, @POOL+9 , 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+31, @POOL+10, 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+34, @POOL+11, 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+37, @POOL+12, 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+40, @POOL+13, 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+43, @POOL+14, 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+46, @POOL+15, 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+49, @POOL+16, 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),
(@GUID+52, @POOL+17, 4, 'Khorium for Rich Adamantite - Isle of Quel\'Danas'),

(@GUID+2 , @POOL+0 , 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+5 , @POOL+1 , 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+8 , @POOL+2 , 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+11, @POOL+3 , 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+14, @POOL+4 , 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+17, @POOL+5 , 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+20, @POOL+6 , 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+23, @POOL+7 , 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+26, @POOL+8 , 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+29, @POOL+9 , 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+32, @POOL+10, 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+35, @POOL+11, 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+38, @POOL+12, 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+41, @POOL+13, 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+44, @POOL+14, 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+47, @POOL+15, 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+50, @POOL+16, 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas'),
(@GUID+53, @POOL+17, 30, 'Rich Adamantite Deposit - Isle of Quel\'Danas');

DELETE FROM `gameobject` WHERE `map`=530 AND `ZoneId`=4080 AND `id` IN (181556, 181557, 181569) AND `guid` BETWEEN @GUID+0 AND @GUID+53;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(@GUID+0 , 181556, 530, 4080, 0, 1, 1, 12439.2, -6560.38, 8.40562, 4.55531, 0, 0, -0.760405, 0.649449, 90, 255, 1, '', 0),
(@GUID+3 , 181556, 530, 4080, 0, 1, 1, 12579.2, -6529.24, 3.68, 3.3571, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+6 , 181556, 530, 4080, 0, 1, 1, 12794.2, -6484.48, 2.82513, -1.90241, 0, 0, 0.814116, -0.580703, 90, 255, 1, '', 0),
(@GUID+9 , 181556, 530, 4080, 0, 1, 1, 12784.3, -6611.37, 4.4867, 0.488691, 0, 0, 0.241921, 0.970296, 90, 255, 1, '', 0),
(@GUID+12, 181556, 530, 4080, 0, 1, 1, 12843.7, -6753.46, 3.81772, 5.51524, 0, 0, -0.374606, 0.927184, 90, 255, 1, '', 0),
(@GUID+15, 181556, 530, 4080, 0, 1, 1, 12744.3, -6833.59, 9.05111, 0.226892, 0, 0, 0.113203, 0.993572, 90, 255, 1, '', 0),
(@GUID+18, 181556, 530, 4080, 0, 1, 1, 12657.4, -6998.76, 18.59, 4.5823, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+21, 181556, 530, 4080, 0, 1, 1, 12527.3, -6938.96, 19.906, 0.087266, 0, 0, 0.0436192, 0.999048, 90, 255, 1, '', 0),
(@GUID+24, 181556, 530, 4080, 0, 1, 1, 12449.8, -6883.67, 21.6143, 3.07177, 0, 0, 0.999391, 0.0349061, 90, 255, 1, '', 0),
(@GUID+27, 181556, 530, 4080, 0, 1, 1, 12668.8, -7320.17, 4.67212, -0.802851, 0, 0, 0.390731, -0.920505, 90, 255, 1, '', 0),
(@GUID+30, 181556, 530, 4080, 0, 1, 1, 12669.4, -7369.6, 3.43107, 2.77507, 0, 0, 0.983254, 0.182238, 90, 255, 1, '', 0),
(@GUID+33, 181556, 530, 4080, 0, 1, 1, 12579, -7351.96, -7.5, 3.7576, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+36, 181556, 530, 4080, 0, 1, 1, 12387.5, -7277.79, 7.13722, 2.23402, 0, 0, 0.898793, 0.438373, 90, 255, 1, '', 0),
(@GUID+39, 181556, 530, 4080, 0, 1, 1, 12298.7, -7281.93, 16.1219, 2.14675, 0, 0, 0.878817, 0.47716, 90, 255, 1, '', 0),
(@GUID+42, 181556, 530, 4080, 0, 1, 1, 12155.2, -7274.7, 4.08998, 0.226893, 0, 0, 0.113203, 0.993572, 90, 255, 1, '', 0),
(@GUID+45, 181556, 530, 4080, 0, 1, 1, 11921.5, -7250.44, 4.03, 1.4721, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+48, 181556, 530, 4080, 0, 1, 1, 11851.8, -7210.55, 9.72, 0.8163, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+51, 181556, 530, 4080, 0, 1, 1, 11666.1, -7135.6, 16.2156, 3.82227, 0, 0, -0.942641, 0.333808, 90, 255, 1, '', 0),
-- Khorium
(@GUID+1 , 181557, 530, 4080, 0, 1, 1, 12439.2, -6560.38, 8.40562, 4.55531, 0, 0, -0.760405, 0.649449, 90, 255, 1, '', 0),
(@GUID+4 , 181557, 530, 4080, 0, 1, 1, 12579.2, -6529.24, 3.68, 3.3571, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+7 , 181557, 530, 4080, 0, 1, 1, 12794.2, -6484.48, 2.82513, -1.90241, 0, 0, 0.814116, -0.580703, 90, 255, 1, '', 0),
(@GUID+10, 181557, 530, 4080, 0, 1, 1, 12784.3, -6611.37, 4.4867, 0.488691, 0, 0, 0.241921, 0.970296, 90, 255, 1, '', 0),
(@GUID+13, 181557, 530, 4080, 0, 1, 1, 12843.7, -6753.46, 3.81772, 5.51524, 0, 0, -0.374606, 0.927184, 90, 255, 1, '', 0),
(@GUID+16, 181557, 530, 4080, 0, 1, 1, 12744.3, -6833.59, 9.05111, 0.226892, 0, 0, 0.113203, 0.993572, 90, 255, 1, '', 0),
(@GUID+19, 181557, 530, 4080, 0, 1, 1, 12657.4, -6998.76, 18.59, 4.5823, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+22, 181557, 530, 4080, 0, 1, 1, 12527.3, -6938.96, 19.906, 0.087266, 0, 0, 0.0436192, 0.999048, 90, 255, 1, '', 0),
(@GUID+25, 181557, 530, 4080, 0, 1, 1, 12449.8, -6883.67, 21.6143, 3.07177, 0, 0, 0.999391, 0.0349061, 90, 255, 1, '', 0),
(@GUID+28, 181557, 530, 4080, 0, 1, 1, 12668.8, -7320.17, 4.67212, -0.802851, 0, 0, 0.390731, -0.920505, 90, 255, 1, '', 0),
(@GUID+31, 181557, 530, 4080, 0, 1, 1, 12669.4, -7369.6, 3.43107, 2.77507, 0, 0, 0.983254, 0.182238, 90, 255, 1, '', 0),
(@GUID+34, 181557, 530, 4080, 0, 1, 1, 12579, -7351.96, -7.5, 3.7576, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+37, 181557, 530, 4080, 0, 1, 1, 12387.5, -7277.79, 7.13722, 2.23402, 0, 0, 0.898793, 0.438373, 90, 255, 1, '', 0),
(@GUID+40, 181557, 530, 4080, 0, 1, 1, 12298.7, -7281.93, 16.1219, 2.14675, 0, 0, 0.878817, 0.47716, 90, 255, 1, '', 0),
(@GUID+43, 181557, 530, 4080, 0, 1, 1, 12155.2, -7274.7, 4.08998, 0.226893, 0, 0, 0.113203, 0.993572, 90, 255, 1, '', 0),
(@GUID+46, 181557, 530, 4080, 0, 1, 1, 11921.5, -7250.44, 4.03, 1.4721, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+49, 181557, 530, 4080, 0, 1, 1, 11851.8, -7210.55, 9.72, 0.8163, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+52, 181557, 530, 4080, 0, 1, 1, 11666.1, -7135.6, 16.2156, 3.82227, 0, 0, -0.942641, 0.333808, 90, 255, 1, '', 0),
-- Rich Adamantite Deposit
(@GUID+2 , 181569, 530, 4080, 0, 1, 1, 12439.2, -6560.38, 8.40562, 4.55531, 0, 0, -0.760405, 0.649449, 90, 255, 1, '', 0),
(@GUID+5 , 181569, 530, 4080, 0, 1, 1, 12579.2, -6529.24, 3.68, 3.3571, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+8 , 181569, 530, 4080, 0, 1, 1, 12794.2, -6484.48, 2.82513, -1.90241, 0, 0, 0.814116, -0.580703, 90, 255, 1, '', 0),
(@GUID+11, 181569, 530, 4080, 0, 1, 1, 12784.3, -6611.37, 4.4867, 0.488691, 0, 0, 0.241921, 0.970296, 90, 255, 1, '', 0),
(@GUID+14, 181569, 530, 4080, 0, 1, 1, 12843.7, -6753.46, 3.81772, 5.51524, 0, 0, -0.374606, 0.927184, 90, 255, 1, '', 0),
(@GUID+17, 181569, 530, 4080, 0, 1, 1, 12744.3, -6833.59, 9.05111, 0.226892, 0, 0, 0.113203, 0.993572, 90, 255, 1, '', 0),
(@GUID+20, 181569, 530, 4080, 0, 1, 1, 12657.4, -6998.76, 18.59, 4.5823, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+23, 181569, 530, 4080, 0, 1, 1, 12527.3, -6938.96, 19.906, 0.087266, 0, 0, 0.0436192, 0.999048, 90, 255, 1, '', 0),
(@GUID+26, 181569, 530, 4080, 0, 1, 1, 12449.8, -6883.67, 21.6143, 3.07177, 0, 0, 0.999391, 0.0349061, 90, 255, 1, '', 0),
(@GUID+29, 181569, 530, 4080, 0, 1, 1, 12668.8, -7320.17, 4.67212, -0.802851, 0, 0, 0.390731, -0.920505, 90, 255, 1, '', 0),
(@GUID+32, 181569, 530, 4080, 0, 1, 1, 12669.4, -7369.6, 3.43107, 2.77507, 0, 0, 0.983254, 0.182238, 90, 255, 1, '', 0),
(@GUID+35, 181569, 530, 4080, 0, 1, 1, 12579, -7351.96, -7.5, 3.7576, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+38, 181569, 530, 4080, 0, 1, 1, 12387.5, -7277.79, 7.13722, 2.23402, 0, 0, 0.898793, 0.438373, 90, 255, 1, '', 0),
(@GUID+41, 181569, 530, 4080, 0, 1, 1, 12298.7, -7281.93, 16.1219, 2.14675, 0, 0, 0.878817, 0.47716, 90, 255, 1, '', 0),
(@GUID+44, 181569, 530, 4080, 0, 1, 1, 12155.2, -7274.7, 4.08998, 0.226893, 0, 0, 0.113203, 0.993572, 90, 255, 1, '', 0),
(@GUID+47, 181569, 530, 4080, 0, 1, 1, 11921.5, -7250.44, 4.03, 1.4721, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+50, 181569, 530, 4080, 0, 1, 1, 11851.8, -7210.55, 9.72, 0.8163, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+53, 181569, 530, 4080, 0, 1, 1, 11666.1, -7135.6, 16.2156, 3.82227, 0, 0, -0.942641, 0.333808, 90, 255, 1, '', 0);

-- Herbs
SET @GUID = 103857; -- 124
SET @POOLMOTHER = 8286; -- 7

DELETE FROM `pool_template` WHERE `description` LIKE '%Isle of Quel\'Danas%' AND `entry` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+4;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(@POOLMOTHER+0, 7, 'Isle of Quel\'Danas - Mana Thistle - Group 1'),
(@POOLMOTHER+1, 7, 'Isle of Quel\'Danas - Mana Thistle - Group 2'),
(@POOLMOTHER+2, 7, 'Isle of Quel\'Danas - Mana Thistle - Group 3'),
(@POOLMOTHER+3, 7, 'Isle of Quel\'Danas - Mana Thistle - Group 4'),
(@POOLMOTHER+4, 7, 'Isle of Quel\'Danas - Nightmare Vine');

DELETE FROM `pool_gameobject` WHERE `description` LIKE '%Isle of Quel\'Danas%' AND `pool_entry` BETWEEN @POOLMOTHER+0 AND @POOLMOTHER+4;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES
-- GROUP 1
(@GUID+0, @POOLMOTHER+0, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(@GUID+1, @POOLMOTHER+0, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(@GUID+2, @POOLMOTHER+0, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(27591 , @POOLMOTHER+0, 0, 'Mana Thistle - Isle of Quel\'Danas'),
-- GROUP 2
(@GUID+3, @POOLMOTHER+1, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(@GUID+4, @POOLMOTHER+1, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(23985 , @POOLMOTHER+1, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(@GUID+5, @POOLMOTHER+1, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(@GUID+6, @POOLMOTHER+1, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(@GUID+7, @POOLMOTHER+1, 0, 'Mana Thistle - Isle of Quel\'Danas'),
-- GROUP 3
(@GUID+8, @POOLMOTHER+2, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(@GUID+9, @POOLMOTHER+2, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(@GUID+10, @POOLMOTHER+2, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(@GUID+11, @POOLMOTHER+2, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(@GUID+12, @POOLMOTHER+2, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(@GUID+13, @POOLMOTHER+2, 0, 'Mana Thistle - Isle of Quel\'Danas'),
-- GROUP 4
(@GUID+14, @POOLMOTHER+3, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(@GUID+15, @POOLMOTHER+3, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(@GUID+16, @POOLMOTHER+3, 0, 'Mana Thistle - Isle of Quel\'Danas'),
(27617 , @POOLMOTHER+3, 0, 'Mana Thistle - Isle of Quel\'Danas'),
-- GROUP 5
(@GUID+17, @POOLMOTHER+4, 0, 'Nightmare Vine - Isle of Quel\'Danas'),
(@GUID+18, @POOLMOTHER+4, 0, 'Nightmare Vine - Isle of Quel\'Danas'),
(27592 , @POOLMOTHER+4, 0, 'Nightmare Vine - Isle of Quel\'Danas'),
(@GUID+19, @POOLMOTHER+4, 0, 'Nightmare Vine - Isle of Quel\'Danas');

DELETE FROM `gameobject` WHERE `ZoneId`=4080 AND `map`=530 AND `id` IN (181280, 181281) AND `guid` BETWEEN @GUID+0 AND @GUID+19;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(@GUID+0 , 181281, 530, 4080, 0, 1, 1, 12481.6, -6463.23, 8, 1.6123, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+1 , 181281, 530, 4080, 0, 1, 1, 12537, -6509.81, 5.5, 2.6824, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+2 , 181281, 530, 4080, 0, 1, 1, 12589, -6439.65, 8.89884, 3.05433, 0, 0, 0.999048, 0.0436193, 90, 255, 1, '', 0),
(@GUID+3 , 181281, 530, 4080, 0, 1, 1, 12668.2, -6866.72, 4.9949, 3.28124, 0, 0, -0.997563, 0.0697661, 90, 255, 1, '', 0),
(@GUID+4 , 181281, 530, 4080, 0, 1, 1, 12599.2, -6872.46, 5.33, 5.2043, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+5 , 181281, 530, 4080, 0, 1, 1, 12714.5, -6958.97, 16.75, 2.4986, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+6 , 181281, 530, 4080, 0, 1, 1, 12668.9, -7047.05, 21.1201, 4.5204, 0, 0, -0.771625, 0.636078, 90, 255, 1, '', 0),
(@GUID+7 , 181281, 530, 4080, 0, 1, 1, 12695.7, -7066.04, 19.2946, 2.63544, 0, 0, 0.968147, 0.250381, 90, 255, 1, '', 0),
(@GUID+8 , 181281, 530, 4080, 0, 1, 1, 12656.8, -7361.54, 4.33, 5.436, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+9 , 181281, 530, 4080, 0, 1, 1, 12669.5, -7421.55, 2.85874, 0.645772, 0, 0, 0.317305, 0.948324, 90, 255, 1, '', 0),
(@GUID+10, 181281, 530, 4080, 0, 1, 1, 12478.2, -7364.87, 2.8825, 4.29351, 0, 0, -0.83867, 0.54464, 90, 255, 1, '', 0),
(@GUID+11, 181281, 530, 4080, 0, 1, 1, 12479.3, -7268.38, 4.83, 6.1154, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+12, 181281, 530, 4080, 0, 1, 1, 12426.1, -7298.33, 1.93, 4.5564, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+13, 181281, 530, 4080, 0, 1, 1, 12330.4, -7352.54, 2.83294, -0.977383, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+14, 181281, 530, 4080, 0, 1, 1, 12020.1, -7295, 8.71, 4.5564, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+15, 181281, 530, 4080, 0, 1, 1, 11946.8, -7295, 2.21, 1.4148, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+16, 181281, 530, 4080, 0, 1, 1, 11818.5, -7233.01, 6.7881, 4.43314, 0, 0, -0.798635, 0.601815, 90, 255, 1, '', 0),
(@GUID+17, 181280, 530, 4080, 0, 1, 1, 11722.8, -7105.36, 24.47, 2.5693, 0, 0, 0, 0, 90, 255, 1, '', 0),
(@GUID+18, 181280, 530, 4080, 0, 1, 1, 11660.1, -7063.5, 10.4082, 2.79252, 0, 0, 0.984807, 0.173652, 90, 255, 1, '', 0),
(@GUID+19, 181280, 530, 4080, 0, 1, 1, 11702.8, -7005.54, 21.78, 1.3362, 0, 0, 0, 0, 90, 255, 1, '', 0);

UPDATE `gameobject` SET `ZoneId`=4080 WHERE `guid` IN (27592, 27617, 23985, 27591);
