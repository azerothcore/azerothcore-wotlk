INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1605128047204479800');

-- SUMMARY: We edit the old table, then we create the new table, then we transfer the rows from the old table to the new table, then we remove no longer used columns from the old table, then we add foreign keys, then we add the strings, then update the .reload command

-- Add new column ID
ALTER TABLE `access_requirement`
ADD `id` tinyint(3) unsigned NOT NULL COMMENT 'The dungeon template ID' AUTO_INCREMENT UNIQUE FIRST;

-- Set new primary key
ALTER TABLE `access_requirement`
ADD PRIMARY KEY `id` (`id`),
DROP INDEX `PRIMARY`,
DROP INDEX `id`;

-- New table
CREATE TABLE `dungeon_access_requirements` (
  `dungeon_access_id` tinyint(3) unsigned NOT NULL COMMENT 'ID from dungeon_access_template',
  `requirement_type` tinyint(1) unsigned NOT NULL COMMENT '0 = achiev, 1 = quest, 2 = item',
  `requirement_id` mediumint(6) unsigned NOT NULL COMMENT 'Achiev/quest/item ID',
  `requirement_hint` varchar(255) COLLATE 'utf8_general_ci' NULL COMMENT 'Optional msg shown ingame to player if he cannot enter with extra info',
  `faction` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '0 = Alliance, 1 = Horde, 2 = both',
  PRIMARY KEY (`dungeon_access_id`, `requirement_type`, `requirement_id`)
) COMMENT='Add (multiple) requirements before being able to enter a dungeon/raid' ENGINE='MyISAM' COLLATE 'utf8_general_ci';

-- Transfer from old table to new table:
-- ------------------- ITEMS

INSERT INTO `dungeon_access_requirements` (`dungeon_access_id`, `requirement_type`, `requirement_id`, `requirement_hint`, `faction`)
    SELECT `id`,
            2 AS requirement_type,
            `item`,
            NULL,
            0
    FROM `access_requirement`
    WHERE `item` > 0 AND `item2` = 0
    UNION
    -- flamewrought key alliance
    SELECT `id`,
            2 AS requirement_type,
            `item2`,
            NULL,
            0 AS faction
    FROM `access_requirement`
    WHERE `item2` > 0
    UNION
    -- flamewrought key horde
    SELECT `id`,
            2 AS requirement_type,
            `item`,
            NULL,
            1 AS faction
    FROM `access_requirement`
    WHERE `item2` > 0
;

-- ------------------ ACHIEVS

INSERT INTO `dungeon_access_requirements` (`dungeon_access_id`, `requirement_type`, `requirement_id`)
    SELECT `id`,
            0 AS requirement_type,
            `completed_achievement`
    FROM `access_requirement`
    WHERE `completed_achievement` > 0
;

-- ------------------ QUESTS

INSERT INTO `dungeon_access_requirements` (`dungeon_access_id`, `requirement_type`, `requirement_id`, `faction`, `requirement_hint`)
    -- Alliance quests only
    SELECT `id`,
            1 AS requirement_type,
            `quest_done_A`,
            0 AS faction,
			quest_failed_text
    FROM `access_requirement`
    WHERE `quest_done_A` > 0 AND `quest_done_A` != `quest_done_H`
    UNION
    -- Horde quests only
    SELECT `id`,
            1 AS requirement_type,
            `quest_done_H`,
            1 AS faction,
			quest_failed_text
    FROM `access_requirement`
    WHERE `quest_done_H` > 0 AND `quest_done_A` != `quest_done_H`
    UNION
    -- Both factions
    SELECT `id`,
            1 AS requirement_type,
            `quest_done_H`,
            2 AS faction,
			quest_failed_text
    FROM `access_requirement`
    WHERE `quest_done_H` > 0 AND `quest_done_A` = `quest_done_H`
;

-- REORDER PRIMARY KEY
CREATE TEMPORARY TABLE IF NOT EXISTS `temp` select * from `dungeon_access_requirements` ORDER BY dungeon_access_id, faction;
TRUNCATE `dungeon_access_requirements`;
ALTER TABLE `dungeon_access_requirements`; 
INSERT INTO `dungeon_access_requirements` SELECT * FROM `temp`;

-- Verify result with this
-- SELECT `id`, `quest_failed_text` FROM `access_requirement` WHERE `quest_failed_text` IS NOT NULL;


-- Remove columns + rename table
ALTER TABLE `access_requirement`
DROP `item`,
DROP `item2`,
DROP `quest_done_A`,
DROP `quest_done_H`,
DROP `completed_achievement`,
DROP `quest_failed_text`,
RENAME TO `dungeon_access_template`,
COMMENT='Dungeon access template and single requirements';

-- Rename columns
ALTER TABLE `dungeon_access_template`
CHANGE `mapId` `instance_id` mediumint(8) unsigned NOT NULL COMMENT 'Map ID from instance_template' AFTER `id`,
CHANGE `difficulty` `difficulty` tinyint(1) unsigned NOT NULL DEFAULT 0 COMMENT '5 man: 0 = normal, 1 = heroic, 2 = epic (not implemented) | 10 man: 0 = normal, 2 = heroic | 25 man: 1 = normal, 3 = heroic' AFTER `instance_id`,
CHANGE `level_min` `min_level` tinyint(2) unsigned NOT NULL DEFAULT 0 AFTER `difficulty`,
CHANGE `level_max` `max_level` tinyint(2) unsigned NOT NULL DEFAULT 0 AFTER `min_level`,
CHANGE `item_level` `min_item_level` smallint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'Min ilvl required to enter' AFTER `max_level`,
CHANGE `comment` `comment` varchar(255) COLLATE 'utf8_general_ci' NULL COMMENT 'Dungeon Name 5/10/25/40 man - Normal/Heroic' AFTER `min_item_level`;

-- Add KEY CONSTRAINTS
ALTER TABLE `dungeon_access_template` ADD CONSTRAINT `FK_dungeon_access_template__instance_template` FOREIGN KEY (`instance_id`) REFERENCES `instance_template` (`map`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `dungeon_access_requirements` ADD CONSTRAINT `FK_dungeon_access_requirements__dungeon_access_template` FOREIGN KEY (`dungeon_access_id`) REFERENCES `dungeon_access_template` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;


-- Add the acore_strings

INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (882, 'To enter, you must complete the following quest(s):');
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (883, 'To enter, you must complete the following achievement(s):');
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (884, 'To enter, you must have the following item(s) in your inventory:');
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (885, '- Hint:');
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES (886, 'Requirements to enter not met');

-- Update old command
UPDATE `command` SET `name` = 'reload dungeon_access_template', `help` = 'Syntax: .reload dungeon_access_template\r Reload dungeon_access_template table.' WHERE `name` = 'reload access_requirement';
REPLACE INTO `command` (`name`, `security`, `help`) VALUES ('reload dungeon_access_requirements', 3, 'Syntax: .reload dungeon_access_requirements\r Reload dungeon_access_requirements table.');
