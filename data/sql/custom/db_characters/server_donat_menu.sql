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

 Date: 08/10/2024 15:05:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for server_donat_menu
-- ----------------------------
DROP TABLE IF EXISTS `server_donat_menu`;
CREATE TABLE `server_donat_menu`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `gossip_menu` int UNSIGNED NULL DEFAULT 0,
  `classID` int UNSIGNED NULL DEFAULT 0,
  `name_RU` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `name_EN` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `itemID` int NULL DEFAULT 0,
  `count` int UNSIGNED NOT NULL DEFAULT 1,
  `cost` int NULL DEFAULT 0,
  `discount` int NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of server_donat_menu
-- ----------------------------
INSERT INTO `server_donat_menu` VALUES (1, 0, 0, '|TInterface\\icons\\inv_helmet_30:17:17:-1:1|t А9 Сеты', '|TInterface\\icons\\inv_helmet_30:20:20:-1|t A9 Set', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (2, 0, 0, '|TInterface\\icons\\inv_jewelcrafting_crimsonspinel_02:17:17:-1:1|t А9 Шея', '|TInterface\\icons\\inv_jewelcrafting_crimsonspinel_02:17:17:-1:1|t A9 Neck', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (3, 0, 0, '|TInterface\\icons\\inv_jewelry_ring_48naxxramas:17:17:-1:1|t А9 Кольца', 'A|TInterface\\icons\\inv_jewelry_ring_48naxxramas:17:17:-1:1|t 9 Finger', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (4, 0, 0, '|TInterface\\icons\\inv_misc_cape_20:17:17:-1:1|t А9 Спина', '|TInterface\\icons\\inv_misc_cape_20:17:17:-1:1|t A9 Back', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (5, 0, 0, '|TInterface\\icons\\inv_belt_13:17:17:-1:1|t А9 Пояс', '|TInterface\\icons\\inv_belt_13:17:17:-1:1|t A9 Waist', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (6, 0, 0, '|TInterface\\icons\\inv_bracer_37:17:17:-1:1|t А9 Запястья', '|TInterface\\icons\\inv_bracer_37:17:17:-1:1|t A9 Wrists', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (7, 0, 0, '|TInterface\\icons\\inv_boots_cloth_01:17:17:-1:1|t А9 Ступни', '|TInterface\\icons\\inv_boots_cloth_01:17:17:-1:1|t A9 Feet', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (8, 0, 0, '|TInterface\\icons\\inv_helmet_24:17:17:-1:1|t Т11 Сеты', '|TInterface\\icons\\inv_helmet_24:17:17:-1:1|t T11 Set', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (9, 0, 0, '|TInterface\\icons\\inv_axe_09:17:17:-1:1|t Т11 Оружие', '|TInterface\\icons\\inv_axe_09:17:17:-1:1|t T11 Weapon', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (10, 0, 0, '|TInterface\\icons\\inv_jewelry_necklace_06:17:17:-1:1|t Т11 Шея', '|TInterface\\icons\\inv_jewelry_necklace_06:17:17:-1:1|t T11 Neck', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (11, 0, 0, '|TInterface\\icons\\inv_jewelry_ring_41:17:17:-1:1|t T11 Кольца', '|TInterface\\icons\\inv_jewelry_ring_41:17:17:-1:1|t T11 Finger', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (12, 0, 0, '|TInterface\\icons\\inv_misc_cape_naxxramas_03:17:17:-1:1|t T11 Спина', '|TInterface\\icons\\inv_misc_cape_naxxramas_03:17:17:-1:1|t T11 Back', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (13, 0, 0, '|TInterface\\icons\\inv_belt_46c:17:17:-1:1|t T11 Пояс', '|TInterface\\icons\\inv_belt_46c:17:17:-1:1|t T11 Waist', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (14, 0, 0, '|TInterface\\icons\\inv_bracer_02:17:17:-1:1|t T11 Запястья', '|TInterface\\icons\\inv_bracer_02:17:17:-1:1|t T11 Wrists', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (15, 0, 0, '|TInterface\\icons\\inv_boots_cloth_05:17:17:-1:1|t T11 Ступни', '|TInterface\\icons\\inv_boots_cloth_05:17:17:-1:1|t T11 Feet', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (16, 0, 0, '|TInterface\\icons\\inv_trinket_naxxramas05:17:17:-1:1|t T11 Аксессуар', '|TInterface\\icons\\inv_trinket_naxxramas05:17:17:-1:1|t T11 Trinket', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (17, 0, 0, '|TInterface\\icons\\inv_shirt_guildtabard_01:17:17:-1:1|t T11 Сумки | Рубашки | Герб.н', '|TInterface\\icons\\inv_shirt_guildtabard_01:17:17:-1:1|t T11 Bag | Shirt | Tabard', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (18, 17, 0, NULL, NULL, 21195, 1, 350, 0);
INSERT INTO `server_donat_menu` VALUES (19, 17, 0, NULL, NULL, 4501, 1, 350, 0);
INSERT INTO `server_donat_menu` VALUES (20, 17, 0, NULL, NULL, 21857, 1, 350, 0);
INSERT INTO `server_donat_menu` VALUES (21, 17, 0, NULL, NULL, 38059, 1, 350, 0);
INSERT INTO `server_donat_menu` VALUES (22, 17, 0, NULL, NULL, 930, 1, 350, 0);
INSERT INTO `server_donat_menu` VALUES (23, 17, 0, NULL, NULL, 44798, 1, 600, 0);
INSERT INTO `server_donat_menu` VALUES (24, 17, 0, NULL, NULL, 46105, 1, 600, 0);
INSERT INTO `server_donat_menu` VALUES (25, 17, 0, NULL, NULL, 46103, 1, 600, 0);
INSERT INTO `server_donat_menu` VALUES (26, 0, 0, '|TInterface\\icons\\Inv_inscription_armorscroll01:17:17:-1:1|t Опыт для ранга', '|TInterface\\icons\\Inv_inscription_armorscroll01:17:17:-1:1|t Experience for rank', 0, 1, 0, 0);
INSERT INTO `server_donat_menu` VALUES (27, 26, 0, '+100 опыта', '+100 exp', 1043, 1, 1, 0);
INSERT INTO `server_donat_menu` VALUES (28, 26, 0, '+1000 опыта', '+1000 exp', 35778, 1, 10, 0);
INSERT INTO `server_donat_menu` VALUES (29, 26, 0, '+5000 опыта', '+5000 exp', 842, 1, 50, 0);
INSERT INTO `server_donat_menu` VALUES (30, 26, 0, '+5000 опыта', '+5000 exp', 842, 5, 250, 0);
INSERT INTO `server_donat_menu` VALUES (31, 26, 0, '+5000 опыта', '+5000 exp', 842, 20, 1000, 0);

SET FOREIGN_KEY_CHECKS = 1;
