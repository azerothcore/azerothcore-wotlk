/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80039
 Source Host           : localhost:3306
 Source Schema         : acore_characters

 Target Server Type    : MySQL
 Target Server Version : 80039
 File Encoding         : 65001

 Date: 08/10/2024 15:05:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for server_menu_teleportlist
-- ----------------------------
DROP TABLE IF EXISTS `server_menu_teleportlist`;
CREATE TABLE `server_menu_teleportlist`  (
  `id` int UNSIGNED NOT NULL COMMENT 'id',
  `gossip_menu` int UNSIGNED NOT NULL COMMENT 'gossip_menu',
  `faction` int UNSIGNED NOT NULL COMMENT 'faction',
  `cost` int UNSIGNED NOT NULL COMMENT 'cost',
  `name_RU` char(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name_EN` char(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `map` smallint UNSIGNED NOT NULL DEFAULT 0 COMMENT 'map',
  `position_x` float NOT NULL DEFAULT 0,
  `position_y` float NOT NULL DEFAULT 0,
  `position_z` float NOT NULL DEFAULT 0,
  `orientation` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`name_RU`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'server_menu_teleportlist' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of server_menu_teleportlist
-- ----------------------------
INSERT INTO `server_menu_teleportlist` VALUES (118, 8, 3, 0, 'Азжол-Неруб(72-80)', 'Azjol-Nerub(72-80)', 571, 3686.19, 2162.38, 36.42, 2.62);
INSERT INTO `server_menu_teleportlist` VALUES (60, 3, 3, 0, 'Азшара(45-55)', 'Azshara(45-55)', 1, 3117.12, -4387.97, 92.41, 5.49);
INSERT INTO `server_menu_teleportlist` VALUES (35, 2, 3, 0, 'Альтератксие горы(30-40)', 'Alterac Mountains(30-40)', 0, 275.04, -652.04, 130.8, 0.5);
INSERT INTO `server_menu_teleportlist` VALUES (121, 8, 3, 0, 'Аметистовая крепость(75-80)', 'Violet Hold(75-80)', 571, 5696.72, 507.39, 653.5, 4.03);
INSERT INTO `server_menu_teleportlist` VALUES (119, 8, 3, 0, 'Ан\'кахет: Старое Королевство(73-80)', 'Ahn\'kahet: The Old Kingdom(73-80)', 571, 3648.49, 2050.63, 2.3, 4.35);
INSERT INTO `server_menu_teleportlist` VALUES (133, 9, 3, 0, 'Ан\'Кираж(60-63)', 'Ahn\'Qiraj(60-63)', 1, -8240.08, 1991.31, 129.1, 0.94);
INSERT INTO `server_menu_teleportlist` VALUES (154, 21, 3, 0, 'Арена Гурубаши', 'Arena Gurubashi', 0, -13228.9, 226.44, 32.8, 1.09);
INSERT INTO `server_menu_teleportlist` VALUES (113, 7, 3, 0, 'Аркатрац(68-73)', 'The Arcatraz(68-73)', 530, 3307.7, 1343.13, 506.07, 5.05);
INSERT INTO `server_menu_teleportlist` VALUES (104, 7, 3, 0, 'Аукенайские гробницы(65-73)', 'Auchenai Crypts(65-73)', 530, -3361.69, 5209.65, -100.5, 1.57);
INSERT INTO `server_menu_teleportlist` VALUES (99, 7, 3, 0, 'Бастионы Адского Пламени(59-73)', 'Hellfire Ramparts(59-73)', 530, -358.2, 3066.02, -14.6, 1.96);
INSERT INTO `server_menu_teleportlist` VALUES (39, 2, 3, 0, 'Бесплодные Земли(44-48)', 'Badlands(44-48)', 0, -6763.39, -3129.3, 241.89, 4.06);
INSERT INTO `server_menu_teleportlist` VALUES (32, 2, 3, 0, 'Болотина(20-30)', 'Wetlands(20-30)', 0, -3517.75, -913.4, 9.37, 2.6);
INSERT INTO `server_menu_teleportlist` VALUES (37, 2, 3, 0, 'Болото печали(35-45)', 'Swamp Of Sorrows(35-45)', 0, -10368.6, -2731.3, 22.16, 5.29);
INSERT INTO `server_menu_teleportlist` VALUES (72, 5, 3, 0, 'Борейская Тундра(68-72)', 'Borean Tundra68-72)', 571, 3256.57, 5278.22, 41.4, 0.43);
INSERT INTO `server_menu_teleportlist` VALUES (107, 7, 3, 0, 'Ботаника(67-73)', 'The Botanica(67-73)', 530, 3404.54, 1489.95, 183.34, 5.61);
INSERT INTO `server_menu_teleportlist` VALUES (124, 8, 3, 0, 'Вершина Утгард(79-80)', 'Utgarde Pinnacle(79-80)', 571, 1256.55, -4856.96, 216.1, 3.24);
INSERT INTO `server_menu_teleportlist` VALUES (137, 9, 3, 0, 'Вершина Хиджала(70-73)', 'Hyjal Summit(70-73)', 1, -8174.4, -4176.73, -166.23, 1.02);
INSERT INTO `server_menu_teleportlist` VALUES (98, 6, 3, 0, 'Вершина Черной Горы(57-60)', 'Blackrock Spire(57-60)', 0, -7527.1, -1225.38, 286.3, 5.21);
INSERT INTO `server_menu_teleportlist` VALUES (40, 2, 3, 0, 'Внутренние Земли(45-50)', 'The Hinterlands(45-50)', 0, 112.4, -3929.73, 136.86, 0.98);
INSERT INTO `server_menu_teleportlist` VALUES (2, 0, 3, 0, 'Восточные королевства', 'Eastern Kingdoms', 0, 0, 0, 0.5, 0);
INSERT INTO `server_menu_teleportlist` VALUES (44, 2, 3, 0, 'Восточные Чумные Земли(53-60)', 'Eastern Plaguelands(53-60)', 0, 2280.63, -5275.04, 82.52, 4.74);
INSERT INTO `server_menu_teleportlist` VALUES (41, 2, 3, 0, 'Выжженные Земли(45-55)', 'The Blasted Lands(45-55)', 0, -11184.7, -3019.31, 7.8, 3.2);
INSERT INTO `server_menu_teleportlist` VALUES (97, 6, 3, 0, 'Глубины Черной Горы(53-60)', 'Blackrock Depths(53-60)', 0, -7183.06, -915.69, 166, 5.21);
INSERT INTO `server_menu_teleportlist` VALUES (88, 6, 3, 0, 'Гномреган(26-36)', 'Gnomeregan(26-36)', 90, -335.68, -0.77, -152.3, 5.86);
INSERT INTO `server_menu_teleportlist` VALUES (103, 7, 3, 0, 'Гробницы Маны(64-73)', 'Mana Tombs(64-73)', 530, -3105.01, 4947.91, -100.9, 6.11);
INSERT INTO `server_menu_teleportlist` VALUES (79, 5, 3, 0, 'Грозовая Гряда(77-80)', 'Storm Peaks(77-80)', 571, 7588.38, -1316.44, 942.5, 2.3);
INSERT INTO `server_menu_teleportlist` VALUES (16, 1, 1, 0, 'Громовой утес', 'Thunder Bluff', 1, -1266.05, 69.55, 127.96, 1.28);
INSERT INTO `server_menu_teleportlist` VALUES (122, 8, 3, 0, 'Гундрак(76-80)', 'Gundrak(76-80)', 571, 6953.25, -4419.39, 450.6, 0.8);
INSERT INTO `server_menu_teleportlist` VALUES (20, 1, 3, 0, 'Даларан', 'Dalaran', 571, 5830.71, 479.55, 658.73, 1.56);
INSERT INTO `server_menu_teleportlist` VALUES (12, 1, 2, 0, 'Дарнас', 'Darnassus', 1, 9869.91, 2493.58, 1316.38, 2.78);
INSERT INTO `server_menu_teleportlist` VALUES (71, 4, 3, 0, 'Долина Призрачной Луны(67-70)', 'Shadowmoon Valley(67-70)', 530, -3681.01, 2350.76, 77.09, 4.25);
INSERT INTO `server_menu_teleportlist` VALUES (74, 5, 3, 0, 'Драконий Погост(71-74)', 'Dragonblight(71-74)', 571, 3545.8, 282.56, 46.2, 4.83);
INSERT INTO `server_menu_teleportlist` VALUES (27, 2, 3, 0, 'Дун Морог(1-10)', 'Dun Morogh(1-10)', 0, -5603.75, -482.7, 397.49, 5.23);
INSERT INTO `server_menu_teleportlist` VALUES (50, 3, 3, 0, 'Дуратор(1-10)', 'Duratar(1-10)', 1, 228.97, -4741.87, 10.61, 0.41);
INSERT INTO `server_menu_teleportlist` VALUES (156, 21, 3, 0, 'Дуэль зона', 'Duel Zone', 1, 6507.63, -4276.87, 663.7, 1.53);
INSERT INTO `server_menu_teleportlist` VALUES (93, 6, 3, 0, 'Забытый Город(44-54)', 'Dire Maul(44-54)', 1, -3824.4, 1250.22, 160.77, 3.15);
INSERT INTO `server_menu_teleportlist` VALUES (131, 8, 3, 0, 'Залы Отражений(79-80)', 'Halls of Reflection(79-80)', 571, 5635.65, 2050.58, 798.56, 4.59);
INSERT INTO `server_menu_teleportlist` VALUES (66, 4, 3, 0, 'Зангартопь(60-64)', 'Zangarmarsh (60-64)', 530, -205.58, 5397.79, 23.31, 3.61);
INSERT INTO `server_menu_teleportlist` VALUES (43, 2, 3, 0, 'Западные Чумные Земли(51-58)', 'Western Plaquelands(51-58)', 0, 1743.68, -1723.85, 60.17, 5.23);
INSERT INTO `server_menu_teleportlist` VALUES (29, 2, 3, 0, 'Западный край(10-20)', 'Westfall(10-20)', 0, -10684.9, 1033.63, 33.04, 6.07);
INSERT INTO `server_menu_teleportlist` VALUES (4, 0, 3, 0, 'Запределье', 'Northrend', 0, 0, 0, 0.5, 0);
INSERT INTO `server_menu_teleportlist` VALUES (157, 99, 3, 0, 'Запрет Дуэли -> Дуэль зона', 'Disable Duel -> Duel Zone', 1, 6507.63, -4276.87, 663.7, 1.53);
INSERT INTO `server_menu_teleportlist` VALUES (96, 6, 3, 0, 'Затонувший Храм(52-60)', 'Sunken Temple(52-60)', 0, -10196.8, -3989.89, -103.9, 6.02);
INSERT INTO `server_menu_teleportlist` VALUES (63, 3, 3, 0, 'Зимние ключи(53-60)', 'Winterspring(53-60)', 1, 6658.56, -4553.47, 718.52, 5.18);
INSERT INTO `server_menu_teleportlist` VALUES (138, 9, 3, 0, 'Змеиное святилище(70-73)', 'Serpentshrine Cavern(70-73)', 530, 797.9, 6864.8, -65.4, 0.03);
INSERT INTO `server_menu_teleportlist` VALUES (139, 9, 3, 0, 'Зул\'Аман(70-73)', 'Zul\'Aman(70-73)', 530, 6852.14, -7954.61, 170.2, 4.71);
INSERT INTO `server_menu_teleportlist` VALUES (132, 9, 3, 0, 'Зул\'Гуруб(57-63)', 'Zul\'Gurub(57-63)', 0, -11916.2, -1207.15, 92.3, 4.71);
INSERT INTO `server_menu_teleportlist` VALUES (76, 5, 3, 0, 'Зул\'Драк(74-77)', 'Zul\'Drak(74-77)', 571, 5744.41, -2916.72, 286.77, 5.16);
INSERT INTO `server_menu_teleportlist` VALUES (94, 6, 3, 0, 'Зул\'Фаррак(46-56)', 'Zul\'Farrak(46-56)', 1, -6807.28, -2890.89, 9.39, 0.02);
INSERT INTO `server_menu_teleportlist` VALUES (146, 10, 3, 0, 'Испытание крестоносца(80-83)', 'Trial of the Crusader(80-83)', 571, 8515.92, 728.52, 558.3, 1.59);
INSERT INTO `server_menu_teleportlist` VALUES (125, 8, 3, 0, 'Испытание чемпиона(79-80)', 'Trial of the Champion(79-80)', 571, 8584.35, 792.45, 558.73, 3.17);
INSERT INTO `server_menu_teleportlist` VALUES (3, 0, 3, 0, 'Калимдор', 'Outland', 0, 0, 0, 0.5, 0);
INSERT INTO `server_menu_teleportlist` VALUES (140, 9, 3, 0, 'Каражан(70-73)', 'Karazhan(70-73)', 0, -11118.9, -2010.32, 47.1, 0.64);
INSERT INTO `server_menu_teleportlist` VALUES (158, 0, 3, 0, 'Кастом локации', 'Custom Location', 0, 0, 0, 0, 0);
INSERT INTO `server_menu_teleportlist` VALUES (6, 0, 3, 0, 'Классические подземелья', 'Classic Dungeons', 0, 0, 0, 0.5, 0);
INSERT INTO `server_menu_teleportlist` VALUES (53, 3, 3, 0, 'Когтистые Горы(15-27)', 'Stonetalon Mountains(15-27)', 1, 1574.89, 1031.56, 137.95, 3.8);
INSERT INTO `server_menu_teleportlist` VALUES (30, 2, 3, 0, 'Красногорье(15-25)', 'Redridge Mountains(15-25)', 0, -9447.79, -2270.85, 72.33, 0.3);
INSERT INTO `server_menu_teleportlist` VALUES (62, 3, 3, 0, 'Кратер Ун\'Горо(48-55)', 'Un\'Goro Crater(48-55)', 1, -6291.54, -1158.61, -257.63, 0.45);
INSERT INTO `server_menu_teleportlist` VALUES (141, 9, 3, 0, 'Крепость Бурь(70-73)', 'Tempest Keep(70-73)', 530, 3088.23, 1388.82, 185.2, 4.59);
INSERT INTO `server_menu_teleportlist` VALUES (120, 8, 3, 0, 'Крепость Драк\'Тарон(74-80)', 'Drak\'Tharon Keep(74-80)', 571, 4774.54, -2030, 229.9, 1.59);
INSERT INTO `server_menu_teleportlist` VALUES (85, 6, 3, 0, 'Крепость Темного Клыка(18-26)', 'Shadowfang Keep(18-26)', 0, -234.67, 1561.63, 77.4, 1.24);
INSERT INTO `server_menu_teleportlist` VALUES (116, 8, 3, 0, 'Крепость Утгард(69-80)', 'Utgarde Keep(69-80)', 571, 1216.74, -4866.2, 41.76, 0.31);
INSERT INTO `server_menu_teleportlist` VALUES (129, 8, 3, 0, 'Кузня Душ(79-80)', 'The Forge of Souls(79-80)', 571, 5635.65, 2050.58, 798.56, 4.59);
INSERT INTO `server_menu_teleportlist` VALUES (100, 7, 3, 0, 'Кузня Крови(61-73)', 'The Blood Furnace(61-73)', 530, -293.68, 3150.24, 32.06, 2.19);
INSERT INTO `server_menu_teleportlist` VALUES (91, 6, 3, 0, 'Курганы Иглошкурых(37-47)', 'Razorfen Downs(37-47)', 1, -4657.15, -2519.23, 81.56, 4.27);
INSERT INTO `server_menu_teleportlist` VALUES (89, 6, 3, 0, 'Лабиринты Иглошкурых(32-42)', 'Razorfen Kraul(32-42)', 1, -4467.76, -1669.56, 82.4, 1.04);
INSERT INTO `server_menu_teleportlist` VALUES (80, 5, 3, 0, 'Ледяная Корона(77-80)', 'Icecrown(77-80)', 571, 7399.76, 2381.28, 386.4, 1.6);
INSERT INTO `server_menu_teleportlist` VALUES (67, 4, 3, 0, 'Лес Тероккар(62-65)', 'Terokkar Forest(62-65)', 530, -2266.22, 4244.72, 1.98, 3.68);
INSERT INTO `server_menu_teleportlist` VALUES (78, 5, 3, 0, 'Лес Хрустальной Песни(77-80)', 'Crystalsong Forest(77-80)', 571, 5145.7, -594.99, 170.3, 1.26);
INSERT INTO `server_menu_teleportlist` VALUES (22, 2, 3, 0, 'Леса Вечной Песни(1-10)', 'Eversong Woods(1-10)', 530, 9024.37, -6682.54, 17.4, 3.14);
INSERT INTO `server_menu_teleportlist` VALUES (142, 9, 3, 0, 'Логово Груула(70-73)', 'Gruul\'s Lair(70-73)', 530, 3544.74, 5090.56, 3.51, 5.65);
INSERT INTO `server_menu_teleportlist` VALUES (134, 9, 3, 0, 'Логово Крыла Тьмы(60-63)', 'Blackwing Lair(60-63)', 229, 166.67, -474.84, 116.9, 6.26);
INSERT INTO `server_menu_teleportlist` VALUES (143, 9, 3, 0, 'Логово Магтеридона(70-73)', 'Magtheridon\'s Lair(70-73)', 530, -314.59, 3090.23, -116.4, 5.19);
INSERT INTO `server_menu_teleportlist` VALUES (28, 2, 3, 0, 'Лок Модан(10-20)', 'Lock Modan(10-20)', 0, -5405.85, -2894.14, 342.48, 5.48);
INSERT INTO `server_menu_teleportlist` VALUES (18, 1, 1, 0, 'Луносвет', 'Silvermoon city', 530, 9730.14, -7443.94, 14.07, 3.92);
INSERT INTO `server_menu_teleportlist` VALUES (90, 6, 3, 0, 'Мародон(36-46)', 'Maraudon(36-46)', 1, -1422.21, 2908.76, 137.91, 1.61);
INSERT INTO `server_menu_teleportlist` VALUES (83, 6, 3, 0, 'Мертвые Копи(15-25)', 'The Deadmines(15-25)', 0, -11208, 1669.55, 25.15, 1.61);
INSERT INTO `server_menu_teleportlist` VALUES (108, 7, 3, 0, 'Механар(67-73)', 'The Mechanar(67-73)', 530, 2872.84, 1555.55, 252.7, 3.86);
INSERT INTO `server_menu_teleportlist` VALUES (51, 3, 3, 0, 'Мулгор(1-10)', 'Murgore(1-10)', 1, -2473.87, -501.22, -8.92, 0.65);
INSERT INTO `server_menu_teleportlist` VALUES (34, 2, 3, 0, 'Нагорье Арати(30-40)', 'Arathi Highlands(30-40)', 0, -1581.44, -2704.06, 35.92, 0.49);
INSERT INTO `server_menu_teleportlist` VALUES (68, 4, 3, 0, 'Награнд(64-67)', 'Nagrand(64-67)', 530, -1610.84, 7733.62, -16.77, 1.33);
INSERT INTO `server_menu_teleportlist` VALUES (147, 10, 3, 0, 'Наксрамас(80-83)', 'Naxxramas(80-83)', 571, 3668.71, -1262.45, 243.7, 4.78);
INSERT INTO `server_menu_teleportlist` VALUES (117, 8, 3, 0, 'Нексус(71-80)', 'The Nexus(71-80)', 571, 3883.37, 6984.42, 73.85, 0.06);
INSERT INTO `server_menu_teleportlist` VALUES (87, 6, 3, 0, 'Непроглядная Пучина(22-32)', 'Blackfathom Deeps(22-32)', 1, 4248.33, 740.11, -25.11, 1.37);
INSERT INTO `server_menu_teleportlist` VALUES (102, 7, 3, 0, 'Нижетопь(63-73)', 'The Underbog(63-73)', 530, 780.46, 6761.61, -72.04, 4.83);
INSERT INTO `server_menu_teleportlist` VALUES (77, 5, 3, 0, 'Низина Шолазар(76-78)', 'Sholazar Basin(76-78)', 571, 5413.43, 4574.79, -128.85, 3.52);
INSERT INTO `server_menu_teleportlist` VALUES (5, 0, 3, 0, 'Нордскол', 'Kalimdor', 0, 0, 0, 0.5, 0);
INSERT INTO `server_menu_teleportlist` VALUES (148, 10, 3, 0, 'Обсидиановое святилище(80-83)', 'The Obsidian Sanctum(80-83)', 571, 3456.86, 262.51, -113.01, 3.26);
INSERT INTO `server_menu_teleportlist` VALUES (82, 6, 3, 0, 'Огненная Пропасть(15-25)', 'Ragefire Chasm(15-25)', 1, 1812.09, -4411.89, -17.71, 5.22);
INSERT INTO `server_menu_teleportlist` VALUES (135, 9, 3, 0, 'Огненные Недра(60-63)', 'Molten Core(60-63)', 0, -7515.43, -1044.7, 182.31, 5.3);
INSERT INTO `server_menu_teleportlist` VALUES (155, 21, 3, 0, 'Озеро Ледяных Оков', 'Wintergrasp', 571, 5049.01, 2846.84, 393.1, 6.21);
INSERT INTO `server_menu_teleportlist` VALUES (81, 5, 3, 0, 'Озеро Ледяных Оков(77-80)', 'Wintergrasp(77-80)', 571, 4607.07, 2846.23, 397.4, 0.23);
INSERT INTO `server_menu_teleportlist` VALUES (149, 10, 3, 0, 'Око вечности(80-83)', 'The Eye of Eternity(80-83)', 571, 3861.73, 6988.84, 152.6, 5.78);
INSERT INTO `server_menu_teleportlist` VALUES (126, 8, 3, 0, 'Окулус(79-80)', 'The Oculus(79-80)', 571, 3881.69, 6985.03, 106.83, 3.2);
INSERT INTO `server_menu_teleportlist` VALUES (15, 1, 1, 0, 'Оргриммар', 'Orgrimmar', 1, 1439.15, -4421.69, 26, 3.3);
INSERT INTO `server_menu_teleportlist` VALUES (61, 3, 3, 0, 'Осквернный Лес(48-55)', 'Felwood(48-55)', 1, 3898.8, -1283.32, 221.02, 6.24);
INSERT INTO `server_menu_teleportlist` VALUES (45, 2, 3, 0, 'Остров Кель\'Данас(70)', 'Isle of Quel\'Danas(70)', 530, 12888.8, -6931.74, 4.31, 3.5);
INSERT INTO `server_menu_teleportlist` VALUES (48, 3, 3, 0, 'Остров Кровавой Дымки(10-20)', 'Bloodmyst Isle(10-20)', 530, -2095.69, -11841.1, 51.66, 6.19);
INSERT INTO `server_menu_teleportlist` VALUES (46, 3, 3, 0, 'Остров Лазурной Дымки(1-10)', 'Azuremyst Isle(1-10)', 530, -4192.62, -12576.7, 37.26, 1.6);
INSERT INTO `server_menu_teleportlist` VALUES (69, 4, 3, 0, 'Острогорье(65-68)', 'Blade\'s Edge Mountains(65-68)', 530, 2029.75, 6232.06, 134, 1.3);
INSERT INTO `server_menu_teleportlist` VALUES (127, 8, 3, 0, 'Очищение Стратхольма(79-80)', 'The Culling of Stratholme(79-80)', 1, -8754.67, -4451.06, -199.1, 4.47);
INSERT INTO `server_menu_teleportlist` VALUES (109, 7, 3, 0, 'Паровое подземелье(67-73)', 'The Steamvault(67-73)', 530, 817.1, 6931.11, -79.7, 1.56);
INSERT INTO `server_menu_teleportlist` VALUES (21, 0, 3, 0, 'ПвП Зоны', 'PvP Zone', 0, 0, 0, 0.5, 0);
INSERT INTO `server_menu_teleportlist` VALUES (84, 6, 3, 0, 'Пещеры Стенаний(17-27)', 'Wailing Caverns(17-27)', 1, -737.3, -2218.65, 17.44, 2.73);
INSERT INTO `server_menu_teleportlist` VALUES (144, 9, 3, 0, 'Плато Солнечного Колодца(70-73)', 'Sunwell Plateau(70-73)', 530, 12565.4, -6774.86, 15.1, 3.14);
INSERT INTO `server_menu_teleportlist` VALUES (17, 1, 1, 0, 'Подгород', 'Undercity', 0, 1630.94, 240.15, -42.6, 3.13);
INSERT INTO `server_menu_teleportlist` VALUES (7, 0, 3, 0, 'Подземелья бк', 'BC Dungeons', 0, 0, 0, 0.5, 0);
INSERT INTO `server_menu_teleportlist` VALUES (8, 0, 3, 0, 'Подземелья лич кинг', 'Wrath Dungeons', 0, 0, 0, 0.5, 0);
INSERT INTO `server_menu_teleportlist` VALUES (65, 4, 3, 0, 'Полуостров Адского Пламени(58-63)', 'Hellfire Peninsula(58-63)', 530, -207.33, 2035.92, 96.97, 1.59);
INSERT INTO `server_menu_teleportlist` VALUES (33, 2, 3, 0, 'Предгорья Хилсбрада(20-30)', 'Hillsbrad Foothills(20-30)', 0, -385.8, -787.95, 55.17, 1.03);
INSERT INTO `server_menu_teleportlist` VALUES (24, 2, 3, 0, 'Призрачные Земли(10-20)', 'Ghostlands(10-20)', 530, 7595.72, -6819.6, 84.88, 2.56);
INSERT INTO `server_menu_teleportlist` VALUES (105, 7, 3, 0, 'Прошлое Хиджала(66-73)', 'Hyjal Past(66-73)', 1, -8177.89, -4181.22, -167, 0.91);
INSERT INTO `server_menu_teleportlist` VALUES (70, 4, 3, 0, 'Пустоверть(67-70)', 'Netherstorm(67-70)', 530, 3271.19, 3811.61, 143.66, 3.44);
INSERT INTO `server_menu_teleportlist` VALUES (56, 3, 3, 0, 'Пустоши(30-40)', 'Desolace(30-40)', 1, -656.05, 1510.12, 88.88, 3.29);
INSERT INTO `server_menu_teleportlist` VALUES (42, 2, 3, 0, 'Пылающие Степи(50-58)', 'Burning Steppes(50-58)', 0, -7979.77, -2105.71, 128.42, 5.1);
INSERT INTO `server_menu_teleportlist` VALUES (57, 3, 3, 0, 'Пылевые Топи(35-45)', 'Dustwallow Marsh(35-45)', 1, -3350.12, -3064.85, 33.54, 5.12);
INSERT INTO `server_menu_teleportlist` VALUES (110, 7, 3, 0, 'Разрушенные Залы(67-73)', 'The Shattered Halls(67-73)', 530, -306.14, 3058.15, -2, 1.71);
INSERT INTO `server_menu_teleportlist` VALUES (73, 5, 3, 0, 'Ревущий Фьорд(68-72)', 'Howling Fjord(68-72)', 571, 1264.94, -4144.6, 142.2, 1.84);
INSERT INTO `server_menu_teleportlist` VALUES (160, 158, 3, 0, 'Рейд Монастырь', 'Raid Monastery', 44, 151.77, 12.7, 18, 4.68);
INSERT INTO `server_menu_teleportlist` VALUES (9, 0, 3, 0, 'Рейдовые телепорты(57-73)', 'Raid Teleports(57-73)', 0, 0, 0, 0.5, 0);
INSERT INTO `server_menu_teleportlist` VALUES (10, 0, 3, 0, 'Рейдовые телепорты(80)', 'Raid Teleports(80)', 0, 0, 0, 0.5, 0);
INSERT INTO `server_menu_teleportlist` VALUES (150, 10, 3, 0, 'Рубиновое святилище(80-83)', 'The Ruby Sanctum(80-83)', 571, 3599.28, 198.61, -113.7, 5.31);
INSERT INTO `server_menu_teleportlist` VALUES (136, 9, 3, 0, 'Руины Ан\'Киража(60-63)', 'Ruins of Ahn\'Qiraj(60-63)', 1, -8406.32, 1498.11, 26.1, 2.52);
INSERT INTO `server_menu_teleportlist` VALUES (75, 5, 3, 0, 'Седые Холмы(73-75)', 'Grizzly Hills(73-75)', 571, 3693.11, -2970.51, 237.1, 2.71);
INSERT INTO `server_menu_teleportlist` VALUES (25, 2, 3, 0, 'Серебрянный Бор(10-20)', 'Silverpine Forest(10-20)', 0, 505.12, 1504.63, 125.31, 1.78);
INSERT INTO `server_menu_teleportlist` VALUES (111, 7, 3, 0, 'Сетеккские Залы(67-73)', 'Sethekk Halls(67-73)', 530, -3361.49, 4666.4, -100.5, 4.71);
INSERT INTO `server_menu_teleportlist` VALUES (64, 3, 3, 0, 'Силитус(55-60)', 'Silithus(55-60)', 1, -6815.25, 730.01, 41.45, 2.39);
INSERT INTO `server_menu_teleportlist` VALUES (151, 10, 3, 0, 'Склеп Аркавона(80-83)', 'Vault of Archavon(80-83)', 571, 5474.62, 2840.5, 418.7, 6.26);
INSERT INTO `server_menu_teleportlist` VALUES (13, 1, 2, 0, 'Стальгорн', 'Ironforge', 0, -4913.41, -961.13, 501.99, 1.35);
INSERT INTO `server_menu_teleportlist` VALUES (106, 7, 3, 0, 'Старые предгорья Хилсбрада(66-73)', 'Old Hillsbrad Foothills(66-73)', 1, -8387.34, -4062.92, -208, 0.12);
INSERT INTO `server_menu_teleportlist` VALUES (52, 3, 3, 0, 'Степи(10-25)', 'The Barrens(10-25)', 1, -575.77, -2652.44, 96.14, 0.006);
INSERT INTO `server_menu_teleportlist` VALUES (1, 0, 3, 0, 'Столицы', 'Capital Cities', 0, 0, 0, 0.5, 0);
INSERT INTO `server_menu_teleportlist` VALUES (95, 6, 3, 0, 'Стратхольм(48-58)', 'Stratholme(48-58)', 0, 3342.58, -3379.76, 145.3, 6.23);
INSERT INTO `server_menu_teleportlist` VALUES (59, 3, 3, 0, 'Танарис(40-50)', 'Tanaris Desert(40-50)', 1, -6940.91, -3725.69, 49.44, 3.11);
INSERT INTO `server_menu_teleportlist` VALUES (47, 3, 3, 0, 'Тельдрассил(1-10)', 'Teldrassil(1-10)', 1, 9879.34, 900.07, 1308.81, 3.12);
INSERT INTO `server_menu_teleportlist` VALUES (49, 3, 3, 0, 'Темные берега(10-20)', 'Darkshore(10-20)', 1, 6463.25, 683.98, 9.43, 4.33);
INSERT INTO `server_menu_teleportlist` VALUES (112, 7, 3, 0, 'Темный Лабиринт(67-73)', 'Shadow Labyrinth(67-73)', 530, -3535.05, 4942.85, -100.8, 3.15);
INSERT INTO `server_menu_teleportlist` VALUES (31, 2, 3, 0, 'Темполесье(18-30)', 'Duskwood(18-30)', 0, -10530.7, -1281.91, 39.36, 1.56);
INSERT INTO `server_menu_teleportlist` VALUES (36, 2, 3, 0, 'Тернистая Долина(30-40)', 'Stranglethorn Vale(30-40)', 0, -11921.7, -59.54, 40.23, 3.73);
INSERT INTO `server_menu_teleportlist` VALUES (114, 7, 3, 0, 'Терраса Магистров(68-73)', 'Magisters\' Terrace(68-73)', 530, 12888.9, -7324.54, 66.1, 4.35);
INSERT INTO `server_menu_teleportlist` VALUES (23, 2, 3, 0, 'Тирисфальские Леса(1-10)', 'Tirisfal Glades(1-10)', 0, 2268.67, 313.05, 34.62, 4.05);
INSERT INTO `server_menu_teleportlist` VALUES (38, 2, 3, 0, 'Тлеющее Ущелье(43-50)', 'Searing Gorge(43-50)', 0, -6670.66, -1217.2, 241.94, 3.04);
INSERT INTO `server_menu_teleportlist` VALUES (55, 3, 3, 0, 'Тысяча Игл(25-35)', 'Thousand Needles(25-35)', 1, -5375.52, -2509.19, -39.93, 2.41);
INSERT INTO `server_menu_teleportlist` VALUES (86, 6, 3, 0, 'Тюрьма(22-32)', 'The Stockade(22-32)', 0, -8777.45, 836.05, 94.06, 0.64);
INSERT INTO `server_menu_teleportlist` VALUES (101, 7, 3, 0, 'Узилище(62-73)', 'The Slave Pens(62-73)', 530, 718.32, 6995.66, -72.56, 1.25);
INSERT INTO `server_menu_teleportlist` VALUES (92, 6, 3, 0, 'Ульдаман(42-52)', 'Uldaman(42-52)', 0, -6071.37, -2955.15, 210.3, 0.01);
INSERT INTO `server_menu_teleportlist` VALUES (152, 10, 3, 0, 'Ульдуар(80-83)', 'Ulduar(80-83)', 571, 9327.34, -1111.5, 1245.2, 6.24);
INSERT INTO `server_menu_teleportlist` VALUES (159, 158, 3, 0, 'Фарм зона', 'Farm Zone', 0, -4175.44, -1400.91, 200.5, 0.03);
INSERT INTO `server_menu_teleportlist` VALUES (58, 3, 3, 0, 'Фералас(40-50)', 'Feralas(40-50)', 1, -4808.31, 1040.51, 104.27, 2.9);
INSERT INTO `server_menu_teleportlist` VALUES (153, 10, 3, 0, 'Цитадель Ледяной Короны(80-83)', 'Icecrown Citadel(80-83)', 571, 5791.7, 2072.01, 636.2, 3.57);
INSERT INTO `server_menu_teleportlist` VALUES (115, 7, 3, 0, 'Черные Топи(68-73)', 'The Black Morass(68-73)', 1, -8746.54, -4212.32, -208.99, 2.07);
INSERT INTO `server_menu_teleportlist` VALUES (145, 9, 3, 0, 'Черный храм(70-73)', 'Black Temple(70-73)', 530, -3641.93, 317.09, 34.95, 3.08);
INSERT INTO `server_menu_teleportlist` VALUES (123, 8, 3, 0, 'Чертоги Камня(77-80)', 'Halls of Stone(77-80)', 571, 8922.27, -1004.08, 1040.01, 1.58);
INSERT INTO `server_menu_teleportlist` VALUES (128, 8, 3, 0, 'Чертоги Молний(79-80)', 'Halls of Lightning(79-80)', 571, 9124.66, -1329.18, 1061.62, 5.53);
INSERT INTO `server_menu_teleportlist` VALUES (19, 1, 3, 0, 'Шаттрат', 'Shattrath', 530, -1881.91, 5374.42, -11.92, 1.23);
INSERT INTO `server_menu_teleportlist` VALUES (11, 1, 2, 0, 'Штормград', 'Stormwind', 0, -8925.56, 543.9, 94.5, 3.8);
INSERT INTO `server_menu_teleportlist` VALUES (14, 1, 2, 0, 'Эксодар', 'Exodar', 530, -3879.4, -11628.4, -137.18, 1.84);
INSERT INTO `server_menu_teleportlist` VALUES (26, 2, 3, 0, 'Элвиннский Лес(1-10)', 'Elwynn Forest(1-10)', 0, -9449.05, 64.83, 56.62, 3.07);
INSERT INTO `server_menu_teleportlist` VALUES (130, 8, 3, 0, 'Яма Сарона(79-80)', 'Pit of Saron(79-80)', 571, 5635.65, 2050.58, 798.56, 4.59);
INSERT INTO `server_menu_teleportlist` VALUES (54, 3, 3, 0, 'Ясеневый лес(18-30)', 'Ashenvale Forest(18-30)', 1, 1919.77, -2169.67, 95.18, 6.14);

SET FOREIGN_KEY_CHECKS = 1;
