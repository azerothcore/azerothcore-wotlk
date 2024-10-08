/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80039
 Source Host           : localhost:3306
 Source Schema         : acore_auth

 Target Server Type    : MySQL
 Target Server Version : 80039
 File Encoding         : 65001

 Date: 08/10/2024 15:01:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account_gm_log
-- ----------------------------
DROP TABLE IF EXISTS `account_gm_log`;
CREATE TABLE `account_gm_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `player` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `account` int NOT NULL,
  `command` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `position` varchar(96) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `selected` varchar(96) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `realmId` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `account`(`account`) USING BTREE,
  INDEX `player`(`player`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3355 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of account_gm_log
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
