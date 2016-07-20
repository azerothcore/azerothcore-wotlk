/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50149
Source Host           : localhost:3306
Source Database       : world

Target Server Type    : MYSQL
Target Server Version : 50149
File Encoding         : 65001

Date: 2012-11-26 00:31:54
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `spell_group_stack_rules`
-- ----------------------------
DROP TABLE IF EXISTS `spell_group_stack_rules`;
CREATE TABLE `spell_group_stack_rules` (
  `group_id` int(11) unsigned NOT NULL DEFAULT '0',
  `stack_rule` tinyint(3) NOT NULL DEFAULT '0',
  `description` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of spell_group_stack_rules
-- ----------------------------
INSERT INTO `spell_group_stack_rules` VALUES ('1', '4', 'Group of Battle / Guardian Elixirs, stacking done with exclusive flags');
INSERT INTO `spell_group_stack_rules` VALUES ('1001', '8', 'Group of Food (Well Fed) and similar buffs');
INSERT INTO `spell_group_stack_rules` VALUES ('1002', '19', 'Group of blessings, warrior shouts (with HP increasing buffs), stack for different casters, effect exclusive COMBINED GROUP');
INSERT INTO `spell_group_stack_rules` VALUES ('1003', '17', 'Group of major Armor reducing debuffs');
INSERT INTO `spell_group_stack_rules` VALUES ('1004', '18', 'Group of minor Armor reducing debuffs (with hit reduce), can stack for different casters, effect exclusive with exclusive flags COMBINED GROUP');
INSERT INTO `spell_group_stack_rules` VALUES ('1005', '16', 'Group of haste, contains forced stronger buff (use flagged, only 2 spells)');
INSERT INTO `spell_group_stack_rules` VALUES ('1006', '17', 'Group of Melee Crit chance increase, effect exclusive');
INSERT INTO `spell_group_stack_rules` VALUES ('1007', '17', 'Group of Percent AP increase, effect exclusive');
INSERT INTO `spell_group_stack_rules` VALUES ('1008', '1', 'Group of Bleed damage increasing auras');
INSERT INTO `spell_group_stack_rules` VALUES ('1009', '17', 'Group of Spell crit chance buffs, effect exclusive');
INSERT INTO `spell_group_stack_rules` VALUES ('1010', '1', 'Group of Spell crit taken increase debuffs');
INSERT INTO `spell_group_stack_rules` VALUES ('1011', '1', 'Group of Spell power increasing buffs');
INSERT INTO `spell_group_stack_rules` VALUES ('1012', '17', 'Group of Melee, Range, spell haste buffs (with raid damage done), effect exclusive COMBINED GROUP');
INSERT INTO `spell_group_stack_rules` VALUES ('1013', '1', 'Group of Critical chance taken debuff (all types)');
INSERT INTO `spell_group_stack_rules` VALUES ('1014', '18', 'Group of Melee attack time increse debufs, can stack for different casters, effect exclusive');
INSERT INTO `spell_group_stack_rules` VALUES ('1015', '18', 'Group of chance to hit reduce debuffs, can stack for different casters, effect exclusive');
INSERT INTO `spell_group_stack_rules` VALUES ('1016', '8', 'Group of healing taken reduce debuffs');
INSERT INTO `spell_group_stack_rules` VALUES ('1017', '17', 'Group of AP reducing debuffs, effect exclusive');
INSERT INTO `spell_group_stack_rules` VALUES ('1018', '17', 'Group of STR + AGI increasing buffs, effect exclusive');
INSERT INTO `spell_group_stack_rules` VALUES ('1019', '17', 'Group of INT and/or SPIRIT increasing buffs, effect exclusive');
INSERT INTO `spell_group_stack_rules` VALUES ('1020', '1', 'Group of healing recived increasing buffs');
INSERT INTO `spell_group_stack_rules` VALUES ('1021', '1', 'Group of physical damage taken reducing buffs');
INSERT INTO `spell_group_stack_rules` VALUES ('1022', '17', 'Group of casting speed decreasing debuffs, effect exclusive');
INSERT INTO `spell_group_stack_rules` VALUES ('1023', '25', 'Group of Armor + attributes + resistance increasing buffs');
INSERT INTO `spell_group_stack_rules` VALUES ('1024', '1', 'Group of STA increasing buffs, effect exclusive');
INSERT INTO `spell_group_stack_rules` VALUES ('1025', '1', 'Group of shadow resistance increasing buffs');
INSERT INTO `spell_group_stack_rules` VALUES ('1026', '2', 'Group of Immolate / Unstable Affliction - never stack for same caster');
INSERT INTO `spell_group_stack_rules` VALUES ('1027', '8', 'Group of amplify / dampen magic - never stack');
INSERT INTO `spell_group_stack_rules` VALUES ('1028', '18', 'Group of Magic damage taken increasing debuffs, effect exclusive');
INSERT INTO `spell_group_stack_rules` VALUES ('1029', '8', 'Group of Apexis buffs, never stack\r\nApexis buffs, never stack');
INSERT INTO `spell_group_stack_rules` VALUES ('1030', '1', 'Group of Draenei heroic presence (2 different auras)');
INSERT INTO `spell_group_stack_rules` VALUES ('1031', '16', 'Group of Death Wish and DK Hysteria, effect exclusive');
INSERT INTO `spell_group_stack_rules` VALUES ('1032', '17', 'Group of Spell Haste Auras');
INSERT INTO `spell_group_stack_rules` VALUES ('1033', '1', 'Group of Howling Rage');
INSERT INTO `spell_group_stack_rules` VALUES ('1034', '1', 'Group of Thorns');
