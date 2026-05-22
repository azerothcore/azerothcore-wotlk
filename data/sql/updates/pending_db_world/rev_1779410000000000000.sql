-- Correct live Black Rose gem display data after first test pass.

SET @BLACK_ROSE_TRINKET := 900105;
SET @BLACK_ROSE_AURA := 900900;
SET @BLACK_ROSE_DURATION := 900900;
SET @BLACK_ROSE_UPGRADE_USE := 900901;
SET @RED_GEM_BASE := 900300;
SET @YELLOW_GEM_BASE := 900400;
SET @RED_UPGRADE_BASE := 900500;
SET @YELLOW_UPGRADE_BASE := 900600;

REPLACE INTO `spellduration_dbc`
    (`ID`, `Duration`, `DurationPerLevel`, `MaxDuration`)
VALUES
    (@BLACK_ROSE_DURATION, 20000, 0, 20000);

REPLACE INTO `spell_dbc`
    (`ID`, `Attributes`, `DurationIndex`, `RangeIndex`, `Effect_1`,
     `EffectDieSides_1`, `EffectBasePoints_1`, `ImplicitTargetA_1`,
     `EffectAura_1`, `SpellIconID`, `ActiveIconID`, `Name_Lang_enUS`,
     `Name_Lang_Mask`, `Description_Lang_enUS`, `Description_Lang_Mask`,
     `AuraDescription_Lang_enUS`, `AuraDescription_Lang_Mask`, `SchoolMask`)
VALUES
    (@BLACK_ROSE_AURA, 384, @BLACK_ROSE_DURATION, 1, 6,
     1, 0, 1,
     4, 0, 0, 'Power of the Black Rose',
     1, 'Increases Black Rose socketed gem effectiveness by 250%.', 1,
     'Black Rose socketed gem effectiveness increased by 250%.', 1, 1),
    (@BLACK_ROSE_UPGRADE_USE, 384, 0, 1, 3,
     1, 0, 1,
     0, 0, 0, 'Empower Black Rose Gem',
     1, 'Use to empower a socketed Black Rose gem.', 1,
     '', 0, 1);

DELETE FROM `spell_script_names` WHERE `spell_id` = @BLACK_ROSE_AURA;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
    (@BLACK_ROSE_AURA, 'spell_item_black_rose');

UPDATE `item_template` SET
    `spellid_1` = @BLACK_ROSE_AURA,
    `spelltrigger_1` = 0,
    `spellcooldown_1` = 180000,
    `stat_type1` = 5,
    `stat_value1` = 5,
    `stat_type2` = 4,
    `stat_value2` = 5,
    `stat_type3` = 6,
    `stat_value3` = 5,
    `stat_type4` = 3,
    `stat_value4` = 5,
    `stat_type5` = 7,
    `stat_value5` = 20,
    `description` = 'Channels the power of the Black Rose, increasing socketed gem''s effectiveness by 250% for 20 seconds.',
    `ScriptName` = 'item_black_rose_trinket'
WHERE `entry` = @BLACK_ROSE_TRINKET;

UPDATE `item_template` AS `item`
JOIN
    (SELECT
        @RED_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1 AS `entry`,
        CONCAT(`family`.`name`, ' Gem') AS `name`,
        CONCAT('Grants the Black Rose +',
               IF(`family`.`stat2_name` = '', `rank`.`single`,
                  `rank`.`split`),
               ' ', `family`.`stat1_name`,
               IF(`family`.`stat2_name` = '', '.',
                  CONCAT(' and +', `rank`.`split`, ' ',
                         `family`.`stat2_name`, '.'))) AS `description`
     FROM
        (SELECT 0 AS `id`, 'Stark' AS `name`, 'strength' AS `stat1_name`,
                '' AS `stat2_name`
         UNION ALL SELECT 1, 'Klug', 'intellect', ''
         UNION ALL SELECT 2, 'Geist', 'spirit', ''
         UNION ALL SELECT 3, 'Schnell', 'agility', ''
         UNION ALL SELECT 4, 'Fett', 'stamina', ''
         UNION ALL SELECT 5, 'Gross', 'strength', 'stamina'
         UNION ALL SELECT 6, 'Spinnst', 'intellect', 'spirit'
         UNION ALL SELECT 7, 'Scharf', 'strength', 'agility'
         UNION ALL SELECT 8, 'Weise', 'intellect', 'stamina') AS `family`
     JOIN
        (SELECT 1 AS `id`, 2 AS `single`, 1 AS `split`
         UNION ALL SELECT 2, 22, 11
         UNION ALL SELECT 3, 42, 21
         UNION ALL SELECT 4, 62, 31
         UNION ALL SELECT 5, 82, 41
         UNION ALL SELECT 6, 102, 51
         UNION ALL SELECT 7, 122, 61) AS `rank`) AS `fix`
ON `item`.`entry` = `fix`.`entry` SET
    `item`.`name` = `fix`.`name`,
    `item`.`description` = `fix`.`description`;

UPDATE `item_template` AS `item`
JOIN
    (SELECT
        @YELLOW_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1 AS `entry`,
        CONCAT(`family`.`name`, ' Gem') AS `name`,
        CONCAT('Grants the Black Rose +', `rank`.`value`, ' ',
               `family`.`stat1_name`, '.') AS `description`
     FROM
        (SELECT 0 AS `id`, 'pouvoir' AS `name`,
                'spell power' AS `stat1_name`
         UNION ALL SELECT 1, 'douleur', 'attack power') AS `family`
     JOIN
        (SELECT 1 AS `id`, 6 AS `value`
         UNION ALL SELECT 2, 26
         UNION ALL SELECT 3, 86
         UNION ALL SELECT 4, 126
         UNION ALL SELECT 5, 166
         UNION ALL SELECT 6, 206
         UNION ALL SELECT 7, 246) AS `rank`) AS `fix`
ON `item`.`entry` = `fix`.`entry` SET
    `item`.`name` = `fix`.`name`,
    `item`.`description` = `fix`.`description`;

UPDATE `item_template` AS `item`
JOIN
    (SELECT
        @RED_UPGRADE_BASE + `family`.`id` * 10 + `rank`.`id` - 2 AS `entry`,
        CONCAT(`family`.`name`, ' Upgrade Tier ', `rank`.`id`) AS `name`,
        CONCAT('Use to empower ', `family`.`name`, ' Gem. Increases the ',
               `family`.`name`, ' bonus to +',
               IF(`family`.`stat2_name` = '', `rank`.`single`,
                  `rank`.`split`),
               ' ', `family`.`stat1_name`,
               IF(`family`.`stat2_name` = '', '.',
                  CONCAT(' and +', `rank`.`split`, ' ',
                         `family`.`stat2_name`, '.'))) AS `description`
     FROM
        (SELECT 0 AS `id`, 'Stark' AS `name`, 'strength' AS `stat1_name`,
                '' AS `stat2_name`
         UNION ALL SELECT 1, 'Klug', 'intellect', ''
         UNION ALL SELECT 2, 'Geist', 'spirit', ''
         UNION ALL SELECT 3, 'Schnell', 'agility', ''
         UNION ALL SELECT 4, 'Fett', 'stamina', ''
         UNION ALL SELECT 5, 'Gross', 'strength', 'stamina'
         UNION ALL SELECT 6, 'Spinnst', 'intellect', 'spirit'
         UNION ALL SELECT 7, 'Scharf', 'strength', 'agility'
         UNION ALL SELECT 8, 'Weise', 'intellect', 'stamina') AS `family`
     JOIN
        (SELECT 2 AS `id`, 22 AS `single`, 11 AS `split`
         UNION ALL SELECT 3, 42, 21
         UNION ALL SELECT 4, 62, 31
         UNION ALL SELECT 5, 82, 41
         UNION ALL SELECT 6, 102, 51
         UNION ALL SELECT 7, 122, 61) AS `rank`) AS `fix`
ON `item`.`entry` = `fix`.`entry` SET
    `item`.`name` = `fix`.`name`,
    `item`.`description` = `fix`.`description`,
    `item`.`spellid_1` = @BLACK_ROSE_UPGRADE_USE,
    `item`.`spelltrigger_1` = 0,
    `item`.`spellcooldown_1` = 1000;

UPDATE `item_template` AS `item`
JOIN
    (SELECT
        @YELLOW_UPGRADE_BASE + `family`.`id` * 10 + `rank`.`id` - 2 AS `entry`,
        CONCAT(`family`.`name`, ' Upgrade Tier ', `rank`.`id`) AS `name`,
        CONCAT('Use to empower ', `family`.`name`, ' Gem. Increases the ',
               `family`.`name`, ' bonus to +', `rank`.`value`, ' ',
               `family`.`stat1_name`, '.') AS `description`
     FROM
        (SELECT 0 AS `id`, 'pouvoir' AS `name`,
                'spell power' AS `stat1_name`
         UNION ALL SELECT 1, 'douleur', 'attack power') AS `family`
     JOIN
        (SELECT 2 AS `id`, 26 AS `value`
         UNION ALL SELECT 3, 86
         UNION ALL SELECT 4, 126
         UNION ALL SELECT 5, 166
         UNION ALL SELECT 6, 206
         UNION ALL SELECT 7, 246) AS `rank`) AS `fix`
ON `item`.`entry` = `fix`.`entry` SET
    `item`.`name` = `fix`.`name`,
    `item`.`description` = `fix`.`description`,
    `item`.`spellid_1` = @BLACK_ROSE_UPGRADE_USE,
    `item`.`spelltrigger_1` = 0,
    `item`.`spellcooldown_1` = 1000;

UPDATE `spellitemenchantment_dbc` AS `enchant`
JOIN
    (SELECT
        @RED_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1 AS `entry`,
        CONCAT('+', IF(`family`.`stat2` = 0, `rank`.`single`,
                      `rank`.`split`),
               ' ', `family`.`stat1_name`,
               IF(`family`.`stat2` = 0, '',
                  CONCAT(' and +', `rank`.`split`, ' ',
                         `family`.`stat2_name`))) AS `name`
     FROM
        (SELECT 0 AS `id`, 4 AS `stat1`, 0 AS `stat2`,
                'strength' AS `stat1_name`, '' AS `stat2_name`
         UNION ALL SELECT 1, 5, 0, 'intellect', ''
         UNION ALL SELECT 2, 6, 0, 'spirit', ''
         UNION ALL SELECT 3, 3, 0, 'agility', ''
         UNION ALL SELECT 4, 7, 0, 'stamina', ''
         UNION ALL SELECT 5, 4, 7, 'strength', 'stamina'
         UNION ALL SELECT 6, 5, 6, 'intellect', 'spirit'
         UNION ALL SELECT 7, 4, 3, 'strength', 'agility'
         UNION ALL SELECT 8, 5, 7, 'intellect', 'stamina') AS `family`
     JOIN
        (SELECT 1 AS `id`, 2 AS `single`, 1 AS `split`
         UNION ALL SELECT 2, 22, 11
         UNION ALL SELECT 3, 42, 21
         UNION ALL SELECT 4, 62, 31
         UNION ALL SELECT 5, 82, 41
         UNION ALL SELECT 6, 102, 51
         UNION ALL SELECT 7, 122, 61) AS `rank`) AS `fix`
ON `enchant`.`ID` = `fix`.`entry`
SET `enchant`.`Name_Lang_enUS` = `fix`.`name`;

UPDATE `spellitemenchantment_dbc` AS `enchant`
JOIN
    (SELECT
        @YELLOW_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1 AS `entry`,
        CONCAT('+', `rank`.`value`, ' ', `family`.`stat1_name`) AS `name`
     FROM
        (SELECT 0 AS `id`, 'spell power' AS `stat1_name`
         UNION ALL SELECT 1, 'attack power') AS `family`
     JOIN
        (SELECT 1 AS `id`, 6 AS `value`
         UNION ALL SELECT 2, 26
         UNION ALL SELECT 3, 86
         UNION ALL SELECT 4, 126
         UNION ALL SELECT 5, 166
         UNION ALL SELECT 6, 206
         UNION ALL SELECT 7, 246) AS `rank`) AS `fix`
ON `enchant`.`ID` = `fix`.`entry`
SET `enchant`.`Name_Lang_enUS` = `fix`.`name`;
