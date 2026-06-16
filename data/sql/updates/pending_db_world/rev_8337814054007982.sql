-- Create creature_multispawn table for multi-ID spawning
CREATE TABLE IF NOT EXISTS `creature_multispawn` (
  `spawnId` int unsigned NOT NULL COMMENT 'creature.guid',
  `entry` int unsigned NOT NULL COMMENT 'creature_template.entry',
  PRIMARY KEY (`spawnId`, `entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Additional creature entries for multi-ID spawning';

-- Migrate id2 and id3 entries
DELETE FROM `creature_multispawn`;
INSERT IGNORE INTO `creature_multispawn` (`spawnId`, `entry`)
SELECT `guid`, `id2` FROM `creature` WHERE `id2` != 0
UNION ALL
SELECT `guid`, `id3` FROM `creature` WHERE `id3` != 0;

-- Drop old index before column rename
ALTER TABLE `creature` DROP INDEX `idx_id`;

-- Rename id1 -> id
ALTER TABLE `creature` CHANGE COLUMN `id1` `id` int unsigned NOT NULL DEFAULT 0 COMMENT 'Creature Identifier';

-- Drop id2, id3
ALTER TABLE `creature` DROP COLUMN `id2`, DROP COLUMN `id3`;

-- Recreate index on renamed column
ALTER TABLE `creature` ADD INDEX `idx_id` (`id`);
