-- DB update 2026_11_03_00 -> 2026_11_26_00
--
CREATE TABLE IF NOT EXISTS `character_pet_autocast` (
  `guid` int unsigned NOT NULL DEFAULT '0' COMMENT 'Character Global Unique Identifier',
  `entry` int unsigned NOT NULL DEFAULT '0' COMMENT 'Creature entry of the summoned pet',
  `spell` int unsigned NOT NULL DEFAULT '0' COMMENT 'Spell Identifier',
  `active` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '1 = autocasting, 0 = not',
  PRIMARY KEY (`guid`, `entry`, `spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Autocast state a player set on a temporary pet';
