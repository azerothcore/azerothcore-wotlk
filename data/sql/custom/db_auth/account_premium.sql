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

 Date: 08/10/2024 15:02:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account_premium
-- ----------------------------
DROP TABLE IF EXISTS `account_premium`;
CREATE TABLE `account_premium`  (
  `id` int NOT NULL DEFAULT 0 COMMENT 'Account id',
  `setdate` int NOT NULL DEFAULT 0,
  `unsetdate` int NOT NULL DEFAULT 0,
  `premium_type` tinyint UNSIGNED NOT NULL DEFAULT 1,
  `active` tinyint NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `active`(`active`) USING BTREE,
  INDEX `setdate`(`setdate`) USING BTREE,
  INDEX `unsetdate`(`unsetdate`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of account_premium
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
