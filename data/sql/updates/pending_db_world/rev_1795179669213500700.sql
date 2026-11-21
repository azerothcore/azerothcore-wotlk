--
-- Entries a spawn point can spawn as, with a relative weight each, the way `creature_template_model`
-- lists the displays of a template. A spawn with rows here rolls among them on every (re)spawn; the
-- rows are its whole roll, so its own `creature`.`id` / `gameobject`.`id` has to be one of them.
CREATE TABLE IF NOT EXISTS `creature_spawn_entry` (
  `guid` int unsigned NOT NULL COMMENT 'creature.guid',
  `Idx` tinyint unsigned NOT NULL DEFAULT 0,
  `entry` int unsigned NOT NULL COMMENT 'creature_template.entry',
  `Probability` float NOT NULL DEFAULT 1 COMMENT 'Relative weight; all 0 means equal odds',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`guid`, `Idx`),
  UNIQUE KEY `idx_guid_entry` (`guid`, `entry`),
  KEY `idx_entry` (`entry`),
  CONSTRAINT `creature_spawn_entry_chk_1` CHECK (`Probability` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Entries a creature spawn point can spawn as';

CREATE TABLE IF NOT EXISTS `gameobject_spawn_entry` (
  `guid` int unsigned NOT NULL COMMENT 'gameobject.guid',
  `Idx` tinyint unsigned NOT NULL DEFAULT 0,
  `entry` int unsigned NOT NULL COMMENT 'gameobject_template.entry',
  `Probability` float NOT NULL DEFAULT 1 COMMENT 'Relative weight; all 0 means equal odds',
  `VerifiedBuild` int DEFAULT NULL,
  PRIMARY KEY (`guid`, `Idx`),
  UNIQUE KEY `idx_guid_entry` (`guid`, `entry`),
  KEY `idx_entry` (`entry`),
  CONSTRAINT `gameobject_spawn_entry_chk_1` CHECK (`Probability` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Entries a gameobject spawn point can spawn as';

-- Spawn groups can set the entries of their members, as cMaNGOS spawn groups do: an entry is given to
-- `minCount` members first, then the rest is picked by `chance` (percent, 0 = equal odds among what is
-- left) while an entry stays under `maxCount` (0 = no limit). `spawn_group`.`chance` is the percent
-- chance a member spawns at all (0 = always), for groups of varying size.
CREATE TABLE IF NOT EXISTS `spawn_group_entry` (
  `groupId` int unsigned NOT NULL COMMENT 'spawn_group_template.groupId',
  `spawnType` tinyint unsigned NOT NULL COMMENT '0 = creature, 1 = gameobject',
  `entry` int unsigned NOT NULL COMMENT 'creature_template.entry or gameobject_template.entry',
  `minCount` int unsigned NOT NULL DEFAULT 0 COMMENT 'Members that take this entry before any random pick',
  `maxCount` int unsigned NOT NULL DEFAULT 0 COMMENT 'Members that can hold this entry at once, 0 = no limit',
  `chance` float NOT NULL DEFAULT 0 COMMENT 'Percent, 0 = equal odds among the entries left',
  PRIMARY KEY (`groupId`, `spawnType`, `entry`),
  CONSTRAINT `spawn_group_entry_chk_1` CHECK (`chance` BETWEEN 0 AND 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Entry limits of spawn group members';

ALTER TABLE `spawn_group` ADD COLUMN `chance` float NOT NULL DEFAULT 0 COMMENT 'Percent chance the member spawns, 0 = always' AFTER `spawnId`;

-- Move `creature_multispawn` over. It held only the alternatives, at equal odds with the spawn's own
-- `id`, so the own entry becomes Idx 0 and every row gets the same weight. Rows repeating the own
-- entry and rows of deleted spawns are left behind.
DELETE FROM `creature_spawn_entry` WHERE `guid` IN (SELECT `spawnId` FROM `creature_multispawn`);
INSERT INTO `creature_spawn_entry` (`guid`, `Idx`, `entry`, `Probability`)
SELECT `c`.`guid`, 0, `c`.`id`, 1
FROM `creature` `c`
WHERE EXISTS (SELECT 1 FROM `creature_multispawn` `m` WHERE `m`.`spawnId` = `c`.`guid` AND `m`.`entry` <> `c`.`id`)
UNION ALL
SELECT `m`.`spawnId`, (
  SELECT
    COUNT(*)
  FROM `creature_multispawn` `m2`
  WHERE `m2`.`spawnId` = `m`.`spawnId` AND `m2`.`entry` <> `c`.`id` AND `m2`.`entry` <= `m`.`entry`
), `m`.`entry`, 1
FROM `creature_multispawn` `m`
JOIN `creature` `c` ON `c`.`guid` = `m`.`spawnId`
WHERE `m`.`entry` <> `c`.`id`;

DROP TABLE IF EXISTS `creature_multispawn`;

-- .npc info / .npc guid: "Current Entry: X of (id1, id2, id3)" now prints the whole list in one argument
UPDATE `acore_string` SET `content_default` = REPLACE(`content_default`, '({}, {}, {})', '({})') WHERE `entry` = 539;
UPDATE `acore_string_locale` SET `content` = REPLACE(`content`, '({}, {}, {})', '({})') WHERE `entry` = 539;
