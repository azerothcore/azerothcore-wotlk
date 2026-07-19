-- --------------------------------------------------------------------------------------------
-- Core feature: creature_hostile_override
-- --------------------------------------------------------------------------------------------
-- Whitelist of creature entry pairs allowed to attack each other despite mutually-neutral factions.
-- --------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `creature_hostile_override` (
  `AttackerEntry` int unsigned NOT NULL DEFAULT '0' COMMENT 'Entry of attacker',
  `TargetEntry` int unsigned NOT NULL DEFAULT '0' COMMENT 'Entry is allowed to attack',
  `Comment` varchar(255) NOT NULL DEFAULT '' COMMENT 'Comments',
  PRIMARY KEY (`AttackerEntry`, `TargetEntry`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Creature entry pairs allowed to attack despite mutually-neutral factions';
