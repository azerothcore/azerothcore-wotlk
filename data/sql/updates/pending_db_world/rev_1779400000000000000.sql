-- Add Black Rose gem currencies, gems, upgrades, and trinket aura data.

SET @BLACK_ROSE_TRINKET := 900105;
SET @ROSY := 900140;
SET @BLACK_MIASMA := 900200;
SET @BLACK_PETALS := 900201;
SET @BLACK_THORNS := 900202;
SET @BLACK_ROSE_AURA := 900900;
SET @BLACK_ROSE_DURATION := 900900;
SET @BLACK_ROSE_UPGRADE_USE := 900901;
SET @RED_GEM_BASE := 900300;
SET @YELLOW_GEM_BASE := 900400;
SET @RED_UPGRADE_BASE := 900500;
SET @YELLOW_UPGRADE_BASE := 900600;
SET @MIA_EXT_BASE := 900700;
SET @PETAL_EXT_BASE := 900710;

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

REPLACE INTO `itemextendedcost_dbc`
    (`ID`, `HonorPoints`, `ArenaPoints`, `ArenaBracket`, `ItemID_1`,
     `ItemID_2`, `ItemID_3`, `ItemID_4`, `ItemID_5`, `ItemCount_1`,
     `ItemCount_2`, `ItemCount_3`, `ItemCount_4`, `ItemCount_5`,
     `RequiredArenaRating`, `ItemPurchaseGroup`)
VALUES
    (@MIA_EXT_BASE + 0, 0, 0, 0, @BLACK_MIASMA,
     0, 0, 0, 0, 1,
     0, 0, 0, 0,
     0, 0),
    (@MIA_EXT_BASE + 1, 0, 0, 0, @BLACK_MIASMA,
     0, 0, 0, 0, 10,
     0, 0, 0, 0,
     0, 0),
    (@MIA_EXT_BASE + 2, 0, 0, 0, @BLACK_MIASMA,
     0, 0, 0, 0, 50,
     0, 0, 0, 0,
     0, 0),
    (@MIA_EXT_BASE + 3, 0, 0, 0, @BLACK_MIASMA,
     0, 0, 0, 0, 500,
     0, 0, 0, 0,
     0, 0),
    (@MIA_EXT_BASE + 4, 0, 0, 0, @BLACK_MIASMA,
     0, 0, 0, 0, 1000,
     0, 0, 0, 0,
     0, 0),
    (@MIA_EXT_BASE + 5, 0, 0, 0, @BLACK_MIASMA,
     0, 0, 0, 0, 5000,
     0, 0, 0, 0,
     0, 0),
    (@MIA_EXT_BASE + 6, 0, 0, 0, @BLACK_MIASMA,
     0, 0, 0, 0, 10000,
     0, 0, 0, 0,
     0, 0),
    (@PETAL_EXT_BASE + 0, 0, 0, 0, @BLACK_PETALS,
     0, 0, 0, 0, 1,
     0, 0, 0, 0,
     0, 0),
    (@PETAL_EXT_BASE + 1, 0, 0, 0, @BLACK_PETALS,
     0, 0, 0, 0, 10,
     0, 0, 0, 0,
     0, 0),
    (@PETAL_EXT_BASE + 2, 0, 0, 0, @BLACK_PETALS,
     0, 0, 0, 0, 50,
     0, 0, 0, 0,
     0, 0),
    (@PETAL_EXT_BASE + 3, 0, 0, 0, @BLACK_PETALS,
     0, 0, 0, 0, 500,
     0, 0, 0, 0,
     0, 0),
    (@PETAL_EXT_BASE + 4, 0, 0, 0, @BLACK_PETALS,
     0, 0, 0, 0, 1000,
     0, 0, 0, 0,
     0, 0),
    (@PETAL_EXT_BASE + 5, 0, 0, 0, @BLACK_PETALS,
     0, 0, 0, 0, 5000,
     0, 0, 0, 0,
     0, 0),
    (@PETAL_EXT_BASE + 6, 0, 0, 0, @BLACK_PETALS,
     0, 0, 0, 0, 10000,
     0, 0, 0, 0,
     0, 0);

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `bonding`, `description`,
     `Material`, `VerifiedBuild`)
VALUES
    (@BLACK_MIASMA, 12, 0, -1, 'Black Miasma',
     41375, 1, 1, 0, 0,
     0, -1, -1, 20,
     0, 0, 10000, 0, 'Used by Rosy to shape red Black Rose gems.',
     -1, 0),
    (@BLACK_PETALS, 12, 0, -1, 'Black Petals',
     41376, 1, 1, 0, 0,
     0, -1, -1, 20,
     0, 0, 10000, 0, 'Used by Rosy to shape yellow Black Rose gems.',
     -1, 0),
    (@BLACK_THORNS, 12, 0, -1, 'Black Thorns',
     41377, 1, 1, 0, 0,
     0, -1, -1, 20,
     0, 0, 10000, 0, 'Reserved for future Black Rose class gems.',
     -1, 0);

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
    (SELECT 0 AS `id`, 'Stark' AS `name`, 4 AS `stat1`, 0 AS `stat2`,
            'strength' AS `stat1_name`, '' AS `stat2_name`
     UNION ALL SELECT 1, 'Klug', 5, 0, 'intellect', ''
     UNION ALL SELECT 2, 'Geist', 6, 0, 'spirit', ''
     UNION ALL SELECT 3, 'Schnell', 3, 0, 'agility', ''
     UNION ALL SELECT 4, 'Fett', 7, 0, 'stamina', ''
     UNION ALL SELECT 5, 'Gross', 4, 7, 'strength', 'stamina'
     UNION ALL SELECT 6, 'Spinnst', 5, 6, 'intellect', 'spirit'
     UNION ALL SELECT 7, 'Scharf', 4, 3, 'strength', 'agility'
     UNION ALL SELECT 8, 'Weise', 5, 7, 'intellect', 'stamina') AS `family`
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
    `rank`.`value`, 0, 0,
    `rank`.`value`, 0, 0,
    `family`.`stat1`, 0, 0,
    CONCAT('+', `rank`.`value`, ' ', `family`.`stat1_name`),
    1, @YELLOW_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1
FROM
    (SELECT 0 AS `id`, 'pouvoir' AS `name`, 45 AS `stat1`,
            'spell power' AS `stat1_name`
     UNION ALL SELECT 1, 'douleur', 38, 'attack power') AS `family`
JOIN
    (SELECT 1 AS `id`, 6 AS `value`
     UNION ALL SELECT 2, 26
     UNION ALL SELECT 3, 86
     UNION ALL SELECT 4, 126
     UNION ALL SELECT 5, 166
     UNION ALL SELECT 6, 206
     UNION ALL SELECT 7, 246) AS `rank`;

REPLACE INTO `gemproperties_dbc`
    (`ID`, `Enchant_Id`, `Maxcount_Inv`, `Maxcount_Item`, `Type`)
SELECT
    @RED_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1,
    @RED_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1,
    0, 0, 2
FROM
    (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
     UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8) AS `family`
JOIN
    (SELECT 1 AS `id` UNION ALL SELECT 2 UNION ALL SELECT 3
     UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
     UNION ALL SELECT 7) AS `rank`;

REPLACE INTO `gemproperties_dbc`
    (`ID`, `Enchant_Id`, `Maxcount_Inv`, `Maxcount_Item`, `Type`)
SELECT
    @YELLOW_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1,
    @YELLOW_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1,
    0, 0, 4
FROM
    (SELECT 0 AS `id` UNION ALL SELECT 1) AS `family`
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
    3, 0, -1, CONCAT(`family`.`name`, ' Gem'),
    58601, 4, 1, 0, 0,
    0, -1, -1, 20,
    20, 0, 1, 1,
    CONCAT('Grants the Black Rose +',
           IF(`family`.`stat2_name` = '', `rank`.`single`, `rank`.`split`),
           ' ', `family`.`stat1_name`,
           IF(`family`.`stat2_name` = '', '.',
              CONCAT(' and +', `rank`.`split`, ' ',
                     `family`.`stat2_name`, '.'))),
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
    3, 2, -1, CONCAT(`family`.`name`, ' Gem'),
    54318, 4, 1, 0, 0,
    0, -1, -1, 20,
    20, 0, 1, 1,
    CONCAT('Grants the Black Rose +', `rank`.`value`, ' ',
           `family`.`stat1_name`, '.'),
    -1, @YELLOW_GEM_BASE + `family`.`id` * 10 + `rank`.`id` - 1, 0
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
     UNION ALL SELECT 7, 246) AS `rank`;

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
    CONCAT(`family`.`name`, ' Upgrade Tier ', `rank`.`id`),
    58601, 4, 64, 1, 0, 0,
    0, -1, -1, 20,
    20, 0, 1, @BLACK_ROSE_UPGRADE_USE,
    0, 1000, 1,
    CONCAT('Use to empower ', `family`.`name`, ' Gem. Increases the ',
           `family`.`name`, ' bonus to +',
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
    CONCAT(`family`.`name`, ' Upgrade Tier ', `rank`.`id`),
    54318, 4, 64, 1, 0, 0,
    0, -1, -1, 20,
    20, 0, 1, @BLACK_ROSE_UPGRADE_USE,
    0, 1000, 1,
    CONCAT('Use to empower ', `family`.`name`, ' Gem. Increases the ',
           `family`.`name`, ' bonus to +', `rank`.`value`, ' ',
           `family`.`stat1_name`, '.'),
    -1, 'item_black_rose_gem_upgrade', 0
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
     UNION ALL SELECT 7, 246) AS `rank`;

REPLACE INTO `npc_vendor`
    (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`,
     `VerifiedBuild`)
SELECT
    @ROSY, 100 + `family`.`id`,
    @RED_GEM_BASE + `family`.`id` * 10, 0, 0, @MIA_EXT_BASE, 0
FROM
    (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
     UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8) AS `family`
UNION ALL
SELECT
    @ROSY, 120 + `family`.`id` * 10 + `rank`.`id`,
    @RED_UPGRADE_BASE + `family`.`id` * 10 + `rank`.`id` - 2,
    0, 0, @MIA_EXT_BASE + `rank`.`id` - 1, 0
FROM
    (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
     UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
     UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8) AS `family`
JOIN
    (SELECT 2 AS `id` UNION ALL SELECT 3 UNION ALL SELECT 4
     UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7) AS `rank`
UNION ALL
SELECT
    @ROSY, 300 + `family`.`id`,
    @YELLOW_GEM_BASE + `family`.`id` * 10, 0, 0, @PETAL_EXT_BASE, 0
FROM
    (SELECT 0 AS `id` UNION ALL SELECT 1) AS `family`
UNION ALL
SELECT
    @ROSY, 320 + `family`.`id` * 10 + `rank`.`id`,
    @YELLOW_UPGRADE_BASE + `family`.`id` * 10 + `rank`.`id` - 2,
    0, 0, @PETAL_EXT_BASE + `rank`.`id` - 1, 0
FROM
    (SELECT 0 AS `id` UNION ALL SELECT 1) AS `family`
JOIN
    (SELECT 2 AS `id` UNION ALL SELECT 3 UNION ALL SELECT 4
     UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7) AS `rank`;

REPLACE INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`,
     `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
     `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
     `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT
    23, @ROSY, `vendor_items`.`item`, 0,
    0, 2, 0,
    @BLACK_ROSE_TRINKET, 1, 0,
    0, 0, 0, '',
    'Rosy sells Black Rose gems only to players with The Black Rose'
FROM
    (SELECT @RED_GEM_BASE + `family`.`id` * 10 AS `item`
     FROM
        (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
         UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
         UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8) AS `family`
     UNION ALL
     SELECT @RED_UPGRADE_BASE + `family`.`id` * 10 + `rank`.`id` - 2
     FROM
        (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
         UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
         UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8) AS `family`
     JOIN
        (SELECT 2 AS `id` UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7) AS `rank`
     UNION ALL
     SELECT @YELLOW_GEM_BASE + `family`.`id` * 10
     FROM
        (SELECT 0 AS `id` UNION ALL SELECT 1) AS `family`
     UNION ALL
     SELECT @YELLOW_UPGRADE_BASE + `family`.`id` * 10 + `rank`.`id` - 2
     FROM
        (SELECT 0 AS `id` UNION ALL SELECT 1) AS `family`
     JOIN
        (SELECT 2 AS `id` UNION ALL SELECT 3 UNION ALL SELECT 4
         UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7) AS `rank`)
    AS `vendor_items`;
