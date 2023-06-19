--
SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for creature_template_outfits
-- ----------------------------
DROP TABLE IF EXISTS `creature_template_outfits`;
CREATE TABLE IF NOT EXISTS `creature_template_outfits` (
  `entry` int(10) unsigned NOT NULL,
  `race` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0 for male, 1 for female',
  `skin` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `face` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `hair` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `haircolor` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `facialhair` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `head` int(10) unsigned NOT NULL DEFAULT '0',
  `shoulders` int(10) unsigned NOT NULL DEFAULT '0',
  `body` int(10) unsigned NOT NULL DEFAULT '0',
  `chest` int(10) unsigned NOT NULL DEFAULT '0',
  `waist` int(10) unsigned NOT NULL DEFAULT '0',
  `legs` int(10) unsigned NOT NULL DEFAULT '0',
  `feet` int(10) unsigned NOT NULL DEFAULT '0',
  `wrists` int(10) unsigned NOT NULL DEFAULT '0',
  `hands` int(10) unsigned NOT NULL DEFAULT '0',
  `back` int(10) unsigned NOT NULL DEFAULT '0',
  `tabard` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records
-- ----------------------------
INSERT INTO `creature_template_outfits` VALUES
('70551', '2', '0', '0', '14', '9', '7', '5', '0', '0', '0', '0', '59194', '64674', '0', '36248', '0', '0', '0'),
('70552', '2', '0', '0', '14', '9', '7', '5', '0', '0', '0', '0', '59194', '64674', '0', '36248', '0', '0', '0');
