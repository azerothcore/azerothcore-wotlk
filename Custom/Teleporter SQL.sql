-- ----------------------------
-- Table structure for `eluna_teleporter`
-- ----------------------------
DROP TABLE IF EXISTS `eluna_teleporter`;
CREATE TABLE `eluna_teleporter` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `parent` int(5) NOT NULL DEFAULT '0',
  `type` int(1) NOT NULL DEFAULT '1',
  `faction` int(2) NOT NULL DEFAULT '-1',
  `icon` int(2) NOT NULL DEFAULT '0',
  `name` char(255) NOT NULL DEFAULT '',
  `map` int(5) DEFAULT NULL,
  `x` decimal(10,3) DEFAULT NULL,
  `y` decimal(10,3) DEFAULT NULL,
  `z` decimal(10,3) DEFAULT NULL,
  `o` decimal(10,3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of eluna_teleporter
-- ----------------------------
INSERT INTO `eluna_teleporter` (id, parent, type, faction, icon, name, map, x, y, z, o) VALUES 
('1', '0', '1', '1', '0', 'Horde Cities', null, null, null, null, null),
('2', '0', '1', '0', '0', 'Alliance Cities', null, null, null, null, null),
('3', '0', '1', '-1', '0', 'Outlands Locations', null, null, null, null, null),
('4', '0', '1', '-1', '0', 'Northrend Locations', null, null, null, null, null),
('5', '0', '1', '-1', '0', 'PvP Locations', null, null, null, null, null),
('6', '1', '2', '1', '2', 'Orgrimmar', '1', '1503.000', '-4415.500', '22.000', '0.000'),
('7', '1', '2', '1', '2', 'Undercity', '0', '1831.000', '238.500', '61.600', '0.000'),
('8', '1', '2', '1', '2', 'Thunderbluff', '1', '-1278.000', '122.000', '132.000', '0.000'),
('9', '1', '2', '1', '2', 'Silvermoon', '530', '9484.000', '-7294.000', '15.000', '0.000'),
('10', '2', '2', '0', '2', 'Stormwind', '0', '-8905.000', '560.000', '94.000', '0.660'),
('11', '2', '2', '0', '2', 'Ironforge', '0', '-4795.000', '-1117.000', '499.000', '0.000'),
('12', '2', '2', '0', '2', 'Darnassus', '1', '9952.000', '2280.500', '1342.000', '1.600'),
('13', '2', '2', '0', '2', 'The Exodar', '530', '-3863.000', '-11736.000', '-106.000', '2.000'),
('14', '3', '2', '-1', '2', 'Blade\'s Edge Mountains', '530', '1481.000', '6829.000', '107.000', '6.000'),
('15', '3', '2', '-1', '2', 'Hellfire Peninsula', '530', '-249.000', '947.000', '85.000', '2.000'),
('16', '3', '2', '-1', '2', 'Nagrand', '530', '-1769.000', '7150.000', '-9.000', '2.000'),
('17', '3', '2', '-1', '2', 'Netherstorm', '530', '3043.000', '3645.000', '143.000', '2.000'),
('18', '3', '2', '-1', '2', 'Shadowmoon Valley', '530', '-3034.000', '2937.000', '87.000', '5.000'),
('19', '3', '2', '-1', '2', 'Terokkar Forest', '530', '-1942.000', '4689.000', '-2.000', '5.000'),
('20', '3', '2', '-1', '2', 'Zangarmarsh', '530', '-217.000', '5488.000', '23.000', '2.000'),
('21', '3', '2', '-1', '2', 'Shattrath', '530', '-1822.000', '5417.000', '1.000', '3.000'),
('22', '4', '2', '-1', '2', 'Borean Tundra', '571', '3230.000', '5279.000', '47.000', '3.000'),
('23', '4', '2', '-1', '2', 'Crystalsong Forest', '571', '5732.000', '1016.000', '175.000', '3.600'),
('24', '4', '2', '-1', '2', 'Dragonblight', '571', '3547.000', '274.000', '46.000', '1.600'),
('25', '4', '2', '-1', '2', 'Grizzly Hills', '571', '3759.000', '-2672.000', '177.000', '3.000'),
('26', '4', '2', '-1', '2', 'Howling Fjord', '571', '772.000', '-2905.000', '7.000', '5.000'),
('27', '4', '2', '-1', '2', 'Icecrown Glaicer', '571', '8517.000', '676.000', '559.000', '4.700'),
('28', '4', '2', '-1', '2', 'Sholazar Basin', '571', '5571.000', '5739.000', '-75.000', '2.000'),
('29', '4', '2', '-1', '2', 'Storm Peaks', '571', '6121.000', '-1025.000', '409.000', '4.700'),
('30', '4', '2', '-1', '2', 'Wintergrasp', '571', '5135.000', '2840.000', '408.000', '3.000'),
('31', '4', '2', '-1', '2', 'Zul\'Drak', '571', '5761.000', '-3547.000', '387.000', '5.000'),
('32', '4', '2', '-1', '2', 'Dalaran', '571', '5826.000', '470.000', '659.000', '1.400'),
('33', '4', '2', '-1', '2', 'Argent Tournament', '571', '8385.92', '793.193', '547.293', '1.820647'),
('34', '5', '2', '-1', '2', 'Gurubashi Arena', '0', '-13229.000', '226.000', '33.000', '1.000'),
('35', '5', '2', '-1', '2', 'Dire Maul Arena', '1', '-3669.000', '1094.000', '160.000', '3.000'),
('36', '5', '2', '-1', '2', 'Nagrand Arena', '530', '-1983.000', '6562.000', '12.000', '2.000'),
('37', '5', '2', '-1', '2', 'Blade\'s Edge Arena', '530', '2910.000', '5976.000', '2.000', '4.000');

-- Dungeons - Classic ID 80 - 99
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('80', '0', '1', '-1', '0', 'Dungeons Classic', null, null, null, null, null);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (82, 80, 2, -1, 2, 'Stratholme', 1, -8648.95, -4387.76, -207.95, 3.5049);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (83, 80, 2, -1, 2, 'Wailing Caverns', 1, -722.53, -2226.30, 16.94, 2.71);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (84, 80, 2, -1, 2, 'Deathmines', 0, -11212.04, 1658.58, 25.67, 1.45);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (85, 80, 2, -1, 2, 'Shadowfang Keep', 0, -254.47, 1524.68, 76.89, 1.56);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (86, 80, 2, -1, 2, 'Blackrockdepths', 1, 4254.58, 664.74, -29.04, 1.97);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (87, 80, 2, -1, 2, 'Razorfen Kraul', 1, -4484.04, -1739.40, 86.47, 1.23);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (88, 80, 2, -1, 2, 'Razorfen Depths', 1, -4645.08, -2470.85, 85.53, 4.39);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (89, 80, 2, -1, 2, 'Scarlet Monastery', 0, 42843.89, -693.74, 139.32, 5.11);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (90, 80, 2, -1, 2, 'Uldaman', 1, -6119.70, -2957.30, 204.11, 0.03);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (92, 80, 2, -1, 2, 'Mauradon', 1, -1433.33, 2955.34, 96.21, 4.82);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (93, 80, 2, -1, 2, 'Sunken Temple', 1, -10346.92, -3851.90, -43.41, 6.09);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (94, 80, 2, -1, 2, 'Duesterbruch', 1, -3982.47, 1127.79, 161.02, 0.05);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (95, 80, 2, -1, 2, 'Scholomance', 0, 1219.01, -2604.66, 85.61, 0.50);

-- Dungeons - TBC ID 100 - 149
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('100', '0', '1', '-1', '0', 'Dungeons TBC', null, null, null, null, null);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (101, 100, 2, -1, 2, 'Magisters Terrace', 585, 7.09000, -0.45000, -2.80000, 0.05000);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (102, 100, 2, -1, 2, 'Hellfirecitadell', 530, -305.816223, 3056.401611, -2.473183, 2.01);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (103, 100, 2, -1, 2, 'Coilfang Reservoir', 530, 517.288025, 6976.279785, 32.007198, 0.0);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (104, 100, 2, -1, 2, 'Caverns of Time', 1, -8173.66, -4746.36, 33.8423, 4.93989);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (105, 100, 2, -1, 2, 'Auchidoun', 530, -3332.999512, 4923.144531, -101.360608, 2.326011);

-- Dungeons - WOTLK ID 150 - 199
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('150', '0', '1', '-1', '0', 'Dungeons WOTLK', null, null, null, null, null);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (151, 150, 2, -1, 2, 'Halls of Lightning', 571, 9105.72, -1319.86, 1058.39, 5.6502);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (152, 150, 2, -1, 2, 'Utgarde Tower', 571, 1256.96, -4852.94, 215.55, 3.447);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (153, 150, 2, -1, 2, 'Halls of Stone', 571, 8922.45, -1012.96, 1039.59, 1.563);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (155, 150, 2, -1, 2, 'Violet Citadel', 571, 5705.19, 517.96, 649.78, 4.0307);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (157, 150, 2, -1, 2, 'AhnKahet', 571, 3700.87, 2152.58, 36.044, 3.5956);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (158, 150, 2, -1, 2, 'Azjol Nerub', 571, 3700.87, 2152.58, 36.044, 3.5956);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (160, 150, 2, -1, 2, 'Utgarde Keep', 571, 1206.94, -4868.05, 41.249,0.2804);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (161, 150, 2, -1, 2, 'Utgarde Castle', 571, 1206.94, -4868.05, 41.249,0.2804);

-- Raids Classic ID 200 - 249
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('200', '0', '1', '-1', '0', 'Raids Classic', null, null, null, null, null);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('201', '200', '2', '-1', '2', 'Onyxia', 1, -4707.44, -3726.82, 54.6723, 3.8);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('202', '200', '2', '-1', '2', 'Molten Core', 230, 1121.451172, -454.316772, -101.329536, 3.5);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('203', '200', '2', '-1', '2', 'Blackwing Lair', 469, -7665.55, -1102.49, 400.679, 0.0);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (204, 200, 2, -1, 2, 'RuinsAhn Qiraj', 1, -8409.032227, 1498.830933, 27.361542, 2.497567);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (205, 200, 2, -1, 2, 'Temple of Ahn Qiraj', 1, -8245.837891, 1983.736206, 129.071686, 0.936195);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (206, 200, 2, -1, 2, 'Zul Gurub', 0, -11916.7, -1212.82, 92.2868, 4.6095);

-- Raids TBC ID 250 - 299
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('250', '0', '1', '-1', '0', 'Raids TBC', null, null, null, null, null);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (251, 250, 2, -1, 2, 'Karazhan', 0, -11118.8, -2010.84, 47.0807, 0.0);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (252, 250, 2, -1, 2, 'Gruul', 530, 3539.007568, 5082.357910, 1.691071, 0.0);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (253, 250, 2, -1, 2, 'The Eye', 530, 3089.579346, 1399.046509, 187.653458, 4.794070);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (255, 250, 2, -1, 2, 'Black Temple', 530, -3610.719482, 324.987579, 37.400028, 3.282981);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (256, 250, 2, -1, 2, 'Sun Well', 580, -1790.650024, 925.669983, 15.150000, 3.10000);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (257, 250, 2, -1, 2, 'Eye of Eternity', 571, 3860.62, 6989.15, 152.042, 5.74598);

-- Raids WOTLK 300 - 350
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('300', '0', '1', '-1', '0', 'Raids WOTLK', null, null, null, null, null);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (301, 300, 2, -1, 2, 'Naxxramas', 571, 3668.711182, -1262.581665, 243.519424, 4.785000);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (302, 300, 2, -1, 2, 'Obsidian Sanctum', 571, 3483.54, 265.605, -120.144, 3.23879);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (303, 300, 2, -1, 2, 'Archavons Vault', 571, 5406.72, 2816.98, 418.675 , 1.06982);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (304, 300, 2, -1, 2, 'Ulduar', 571, 9019.79, -1111.28, 1165.28, 6.26597);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (305, 300, 2, -1, 2, 'ICC', 571, 5796.23475, 2074.461182, 636.065002, 3.577486);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (306, 300, 2, -1, 2, 'Obsidian Sanctum', 571, 3483.54, 265.605, -120.144, 3.23879);

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Custom additions
-- Starter locations Level 1 -80 (ID 401 - 410)
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (400, 0, 1, -1, 2, 'Level Areas', null, null, null, null, null);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (401, 400, 1, -1, 2, 'Ashzara Crater 1 - 80', 37, 131.000, 1012.000, 295.000, 5.000);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (402, 401, 2, -1, 2, 'Startcamp', 37, 131.000, 1012.000, 295.000, 5.000);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (403, 401, 2, -1, 2, 'Level 15 - 20', 37, -117.003, 850.815, 294.579, 5.58488);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (404, 401, 2, -1, 2, 'Level 35', 37, 147.987, 269.417, 273.524, 1.22673);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (405, 401, 2, -1, 2, 'Level 40 - 45', 37, 902.614, 154.535, 285.419, 3.56091);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (406, 401, 2, -1, 2, 'Level 45', 37, 865.102, 438.741, 281.501, 3.79633);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (407, 401, 2, -1, 2, 'Profession trainers', 37, 43.9049, 1172.42, 367.342, 2.56045);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (408, 401, 2, -1, 2, 'Level 50 - 70', 37, 896.217, 142.282, 285.359, 4.09048);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (409, 401, 2, -1, 2, 'Level 70', 37, 1035.75, 216.876, 367.189, 4.26867);

-- Starter locations Level 81 - 130 (ID 410 - 419)
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (410, 400, 1, -1, 2, 'Hyjal 81 - 130', null, null, null, null, null);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (411, 410, 2, -1, 2, 'Hyjal Start', 1, 4625.877, -3840.538, 943.76, 1.145);

-- Starter locations Level 130 - 160 (ID 420 - 429)
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (420, 400, 1, -1, 2, 'Strathholme Outside 130 - 160', null, null, null, null, null);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (421, 420, 2, -1, 2, 'Strathholme Start', 329, 3138.68, -3710.41, 133.63, 4.43518);

-- Custom Locations ID 500 - 599
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('500', '0', '1', '-1', '2', 'Custom Locations', null, null, null, null, null);

-- Hinterland BG ID 600 - 699
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('600', '0', '1', '-1', '2', 'Hinterland BG', null, null, null, null, null);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (601, 600, 2, 1, 2, 'Hinterland Outdoor BG Horde', 0, -581.244, -4577.71, 10.2148, 0.5484);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (602, 600, 2, 0, 2, 'Hinterland Outdoor BG Alliance', 0, -17.7433, -4635.11, 12.933, 2.42161);

-- Custom Dungeons ID 700 - 799
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES ('700', '0', '1', '-1', '2', 'Custom Dungeons', null, null, null, null, null);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (701, 700, 2, -1, 2, 'Nexus - Level 100', 571, 3876.24, 6985, 75.68, 0.01);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (702, 700, 2, -1, 2, 'The Oculus - Level 100', 571, 3780.6, 6955.63, 104.89, 0.3676);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (703, 700, 2, -1, 2, 'Gundrak - Level 130', 571, 6936.08, -4436.54, 450.51, 0.7698);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (156, 150, 2, -1, 2, 'DrakTharon  - Level 130', 571, 4774.32, -2036.68, 229.38, 1.567);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (704, 700, 2, -1, 2, 'Auchenai Crypts - Level 160', 530, -3362.535645, 5220.6640, -101.04, 1.48);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (705, 700, 2, -1, 2, 'Zul`Farrak - Level 190', 1, -6839.39, -2911.03, 8.87, 0.41);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (706, 700, 2, -1, 2, 'Zul Aman - Level 220', 530, 6846.95, -7954.5, 170.028, 4.61501);
INSERT INTO `eluna_teleporter` (`id`, `parent`, `type`, `faction`, `icon`, `name`, `map`, `x`, `y`, `z`, `o`) VALUES (707, 700, 2, -1, 2, 'Karazhan - Level 250', 0, -11118.8, -2010.84, 47.0807, 0.0);




