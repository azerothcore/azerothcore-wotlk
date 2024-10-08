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

 Date: 08/10/2024 15:03:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for character_transfer_points
-- ----------------------------
DROP TABLE IF EXISTS `character_transfer_points`;
CREATE TABLE `character_transfer_points`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `senderGuid` int NOT NULL DEFAULT 0,
  `senderName` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `receiverGuid` int NOT NULL DEFAULT 0,
  `reveiverName` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `amount` int NOT NULL DEFAULT 0,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2743 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of character_transfer_points
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
