-- Black Rose Ribbon/Mist naming and expanded yellow gem families.

SET @BLACK_ROSE_TRINKET := 900105;
SET @ROSY := 900140;
SET @RED_GEM_BASE := 900300;
SET @YELLOW_GEM_BASE := 900400;
SET @RED_UPGRADE_BASE := 900500;
SET @YELLOW_UPGRADE_BASE := 900600;
SET @PETAL_EXT_BASE := 900710;
SET @BLACK_ROSE_UPGRADE_USE := 900901;

REPLACE INTO `spellitemenchantment_dbc`
    (`ID`, `Charges`, `Effect_1`, `Effect_2`, `Effect_3`,
     `EffectPointsMin_1`, `EffectPointsMin_2`, `EffectPointsMin_3`,
     `EffectPointsMax_1`, `EffectPointsMax_2`, `EffectPointsMax_3`,
     `EffectArg_1`, `EffectArg_2`, `EffectArg_3`, `Name_Lang_enUS`,
     `Name_Lang_Mask`, `Src_ItemID`)
SELECT
    @RED_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1, 0,
    5, IF(`family`.`stat2` = 0, 0, 5), 0,
    IF(`family`.`stat2` = 0, `rank`.`single`, `rank`.`split`),
    IF(`family`.`stat2` = 0, 0, `rank`.`split`), 0,
    IF(`family`.`stat2` = 0, `rank`.`single`, `rank`.`split`),
    IF(`family`.`stat2` = 0, 0, `rank`.`split`), 0,
    `family`.`stat1`, `family`.`stat2`, 0,
    CONCAT('+', IF(`family`.`stat2` = 0, `rank`.`single`, `rank`.`split`),
           ' ', `family`.`stat1_name`,
           IF(`family`.`stat2` = 0, '',
              CONCAT(' and +', `rank`.`split`, ' ',
                     `family`.`stat2_name`))),
    1, @RED_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1
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
     UNION ALL SELECT 7, 122, 61) AS `rank`;

REPLACE INTO `spellitemenchantment_dbc`
    (`ID`, `Charges`, `Effect_1`, `Effect_2`, `Effect_3`,
     `EffectPointsMin_1`, `EffectPointsMin_2`, `EffectPointsMin_3`,
     `EffectPointsMax_1`, `EffectPointsMax_2`, `EffectPointsMax_3`,
     `EffectArg_1`, `EffectArg_2`, `EffectArg_3`, `Name_Lang_enUS`,
     `Name_Lang_Mask`, `Src_ItemID`)
SELECT
    @YELLOW_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1, 0,
    5, 0, 0,
    IF(`family`.`id` = 4, `rank`.`mp5`, `rank`.`value`), 0, 0,
    IF(`family`.`id` = 4, `rank`.`mp5`, `rank`.`value`), 0, 0,
    `family`.`stat1`, 0, 0,
    CONCAT('+', IF(`family`.`id` = 4, `rank`.`mp5`, `rank`.`value`),
           ' ', `family`.`stat1_name`),
    1, @YELLOW_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1
FROM
    (SELECT 0 AS `id`, 45 AS `stat1`, 'spell power' AS `stat1_name`
     UNION ALL SELECT 1, 38, 'attack power'
     UNION ALL SELECT 2, 32, 'crit rating'
     UNION ALL SELECT 3, 36, 'haste rating'
     UNION ALL SELECT 4, 43, 'mana per 5 seconds') AS `family`
JOIN
    (SELECT 1 AS `id`, 6 AS `value`, 10 AS `mp5`
     UNION ALL SELECT 2, 26, 25
     UNION ALL SELECT 3, 86, 50
     UNION ALL SELECT 4, 126, 75
     UNION ALL SELECT 5, 166, 200
     UNION ALL SELECT 6, 206, 325
     UNION ALL SELECT 7, 246, 525) AS `rank`;

REPLACE INTO `gemproperties_dbc`
    (`ID`, `Enchant_Id`, `Maxcount_Inv`, `Maxcount_Item`, `Type`)
SELECT
    @YELLOW_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1,
    @YELLOW_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1,
    0, 0, 4
FROM
    (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
     UNION ALL SELECT 3 UNION ALL SELECT 4) AS `family`
JOIN
    (SELECT 1 AS `id` UNION ALL SELECT 2 UNION ALL SELECT 3
     UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
     UNION ALL SELECT 7) AS `rank`;

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `bonding`, `description`,
     `Material`, `GemProperties`, `VerifiedBuild`)
SELECT
    @RED_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1,
    3, 0, -1, CONCAT(`family`.`name`, ' Ribbon'),
    58601, 4, 1, 0, 0,
    0, -1, -1, 20,
    20, 1, 1, 1,
    CONCAT('Grants The Black Rose +',
           IF(`family`.`stat2_name` = '', `rank`.`single`, `rank`.`split`),
           ' ', `family`.`stat1_name`,
           IF(`family`.`stat2_name` = '', ' when socketed.',
              CONCAT(' and +', `rank`.`split`, ' ',
                     `family`.`stat2_name`, ' when socketed.'))),
    -1, @RED_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1, 0
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
     UNION ALL SELECT 7, 122, 61) AS `rank`;

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `bonding`, `description`,
     `Material`, `GemProperties`, `VerifiedBuild`)
SELECT
    @YELLOW_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1,
    3, 2, -1, CONCAT(`family`.`name`, ' Mist'),
    54318, 4, 1, 0, 0,
    0, -1, -1, 20,
    20, 1, 1, 1,
    CONCAT('Grants The Black Rose +',
           IF(`family`.`id` = 4, `rank`.`mp5`, `rank`.`value`), ' ',
           `family`.`stat1_name`, ' when socketed.'),
    -1, @YELLOW_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1, 0
FROM
    (SELECT 0 AS `id`, 'Pouvoir' AS `name`,
            'spell power' AS `stat1_name`
     UNION ALL SELECT 1, 'Douleur', 'attack power'
     UNION ALL SELECT 2, 'Pointe', 'crit rating'
     UNION ALL SELECT 3, 'Vitesse', 'haste rating'
     UNION ALL SELECT 4, 'Restaurer', 'mana per 5 seconds') AS `family`
JOIN
    (SELECT 1 AS `id`, 6 AS `value`, 10 AS `mp5`
     UNION ALL SELECT 2, 26, 25
     UNION ALL SELECT 3, 86, 50
     UNION ALL SELECT 4, 126, 75
     UNION ALL SELECT 5, 166, 200
     UNION ALL SELECT 6, 206, 325
     UNION ALL SELECT 7, 246, 525) AS `rank`;

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `spellid_1`,
     `spelltrigger_1`, `spellcooldown_1`, `bonding`, `description`,
     `Material`, `ScriptName`, `VerifiedBuild`)
SELECT
    @RED_UPGRADE_BASE + `family`.`id` * 10 + `rank`.`id` - 2,
    12, 0, -1,
    CONCAT(`family`.`name`, ' Ribbon Upgrade Tier ', `rank`.`id`),
    58601, 4, 64, 1, 0, 0,
    0, -1, -1, 20,
    20, 0, 1, @BLACK_ROSE_UPGRADE_USE,
    0, 1000, 1,
    CONCAT('Use to empower ', `family`.`name`,
           ' Ribbon. Increases its bonus to +',
           IF(`family`.`stat2_name` = '', `rank`.`single`, `rank`.`split`),
           ' ', `family`.`stat1_name`,
           IF(`family`.`stat2_name` = '', '.',
              CONCAT(' and +', `rank`.`split`, ' ',
                     `family`.`stat2_name`, '.'))),
    -1, 'item_black_rose_gem_upgrade', 0
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
     UNION ALL SELECT 7, 122, 61) AS `rank`;

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `spellid_1`,
     `spelltrigger_1`, `spellcooldown_1`, `bonding`, `description`,
     `Material`, `ScriptName`, `VerifiedBuild`)
SELECT
    @YELLOW_UPGRADE_BASE + `family`.`id` * 10 + `rank`.`id` - 2,
    12, 0, -1,
    CONCAT(`family`.`name`, ' Mist Upgrade Tier ', `rank`.`id`),
    54318, 4, 64, 1, 0, 0,
    0, -1, -1, 20,
    20, 0, 1, @BLACK_ROSE_UPGRADE_USE,
    0, 1000, 1,
    CONCAT('Use to empower ', `family`.`name`,
           ' Mist. Increases its bonus to +',
           IF(`family`.`id` = 4, `rank`.`mp5`, `rank`.`value`), ' ',
           `family`.`stat1_name`, '.'),
    -1, 'item_black_rose_gem_upgrade', 0
FROM
    (SELECT 0 AS `id`, 'Pouvoir' AS `name`,
            'spell power' AS `stat1_name`
     UNION ALL SELECT 1, 'Douleur', 'attack power'
     UNION ALL SELECT 2, 'Pointe', 'crit rating'
     UNION ALL SELECT 3, 'Vitesse', 'haste rating'
     UNION ALL SELECT 4, 'Restaurer', 'mana per 5 seconds') AS `family`
JOIN
    (SELECT 2 AS `id`, 26 AS `value`, 25 AS `mp5`
     UNION ALL SELECT 3, 86, 50
     UNION ALL SELECT 4, 126, 75
     UNION ALL SELECT 5, 166, 200
     UNION ALL SELECT 6, 206, 325
     UNION ALL SELECT 7, 246, 525) AS `rank`;

REPLACE INTO `npc_vendor`
    (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`,
     `VerifiedBuild`)
SELECT
    @ROSY, 300 + `family`.`id`,
    @YELLOW_GEM_BASE + `family`.`id` * 10, 0, 0, @PETAL_EXT_BASE, 0
FROM
    (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
     UNION ALL SELECT 3 UNION ALL SELECT 4) AS `family`;

REPLACE INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`,
     `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
     `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
     `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT
    23, @ROSY, @YELLOW_GEM_BASE + `family`.`id` * 10, 0,
    0, 2, 0,
    @BLACK_ROSE_TRINKET, 1, 0,
    0, 0, 0, '',
    'Rosy sells Black Rose gems only to players with The Black Rose'
FROM
    (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
     UNION ALL SELECT 3 UNION ALL SELECT 4) AS `family`;
