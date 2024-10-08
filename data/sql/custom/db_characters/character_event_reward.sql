/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.1.2_3306
 Source Server Type    : MySQL
 Source Server Version : 80039
 Source Host           : 192.168.1.2:3306
 Source Schema         : acore_characters

 Target Server Type    : MySQL
 Target Server Version : 80039
 File Encoding         : 65001

 Date: 08/10/2024 15:29:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for character_event_reward
-- ----------------------------
DROP TABLE IF EXISTS `character_event_reward`;
CREATE TABLE `character_event_reward`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `guid` int NOT NULL DEFAULT 0,
  `name` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `honor` int NOT NULL DEFAULT 0,
  `arena` int NOT NULL DEFAULT 0,
  `exp` int NOT NULL DEFAULT 0,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 804 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

SET FOREIGN_KEY_CHECKS = 1;
