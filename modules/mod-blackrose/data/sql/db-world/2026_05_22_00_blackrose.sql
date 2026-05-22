-- Black Rose quest, Rosy vendor, bag upgrades, trinket, and gem system.

SET @QUEST_ALLIANCE := 900100;
SET @QUEST_HORDE := 900101;
SET @BAG_26 := 900102;
SET @NORAH_HORDE := 900103;
SET @NORAH_ALLIANCE := 900104;
SET @BLACK_ROSE_TRINKET := 900105;
SET @BAG_28 := 900120;
SET @BAG_30 := 900121;
SET @BAG_32 := 900122;
SET @BAG_34 := 900123;
SET @BAG_36 := 900124;
SET @UPGRADE_28 := 900130;
SET @UPGRADE_30 := 900131;
SET @UPGRADE_32 := 900132;
SET @UPGRADE_34 := 900133;
SET @UPGRADE_36 := 900134;
SET @ROSY := 900140;
SET @NORAH_CGUID := 900110;
SET @ROSY_CGUID := 900150;
SET @BLACK_MIASMA := 900200;
SET @BLACK_PETALS := 900201;
SET @BLACK_THORNS := 900202;
SET @RED_GEM_BASE := 900300;
SET @YELLOW_GEM_BASE := 900400;
SET @RED_UPGRADE_BASE := 900500;
SET @YELLOW_UPGRADE_BASE := 900600;
SET @MIA_EXT_BASE := 900700;
SET @PETAL_EXT_BASE := 900710;
SET @BLACK_ROSE_AURA := 900900;
SET @BLACK_ROSE_DURATION := 900900;
SET @BLACK_ROSE_UPGRADE_USE := 900901;
SET @BLACK_ROSE_BAG_UPGRADE_USE := 900902;

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
     '', 0, 1),
    (@BLACK_ROSE_BAG_UPGRADE_USE, 384, 0, 1, 3,
     1, 0, 1,
     0, 0, 0, 'Upgrade Black Rose Bag',
     1, 'Use to upgrade an empty Bag of the Black Rose.', 1,
     '', 0, 1);

DELETE FROM `spell_script_names` WHERE `spell_id` = @BLACK_ROSE_AURA;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
    (@BLACK_ROSE_AURA, 'spell_black_rose_power');

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
     `RequiredLevel`, `maxcount`, `stackable`, `ContainerSlots`, `bonding`,
     `Material`, `VerifiedBuild`)
VALUES
    (@BAG_26, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 26, 1,
     8, 0),
    (@BAG_28, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 28, 1,
     8, 0),
    (@BAG_30, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 30, 1,
     8, 0),
    (@BAG_32, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 32, 1,
     8, 0),
    (@BAG_34, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 34, 1,
     8, 0),
    (@BAG_36, 1, 0, -1, 'Bag of the Black Rose',
     8861, 1, 1, 0, 0,
     18, -1, -1, 20,
     0, 0, 1, 36, 1,
     8, 0);

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `spellid_1`,
     `spelltrigger_1`, `spellcooldown_1`, `bonding`, `description`,
     `Material`, `ScriptName`, `VerifiedBuild`)
VALUES
    (@UPGRADE_28, 12, 0, -1, 'Black Rose Bag Upgrade I',
     8861, 1, 64, 1, 500, 0,
     0, -1, -1, 20,
     20, 1, 1, @BLACK_ROSE_BAG_UPGRADE_USE,
     0, 1000, 1, 'Upgrades an empty 26-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0),
    (@UPGRADE_30, 12, 0, -1, 'Black Rose Bag Upgrade II',
     8861, 1, 64, 1, 50000, 0,
     0, -1, -1, 20,
     20, 1, 1, @BLACK_ROSE_BAG_UPGRADE_USE,
     0, 1000, 1, 'Upgrades an empty 28-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0),
    (@UPGRADE_32, 12, 0, -1, 'Black Rose Bag Upgrade III',
     8861, 1, 64, 1, 500000, 0,
     0, -1, -1, 20,
     20, 1, 1, @BLACK_ROSE_BAG_UPGRADE_USE,
     0, 1000, 1, 'Upgrades an empty 30-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0),
    (@UPGRADE_34, 12, 0, -1, 'Black Rose Bag Upgrade IV',
     8861, 1, 64, 1, 5000000, 0,
     0, -1, -1, 20,
     20, 1, 1, @BLACK_ROSE_BAG_UPGRADE_USE,
     0, 1000, 1, 'Upgrades an empty 32-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0),
    (@UPGRADE_36, 12, 0, -1, 'Black Rose Bag Upgrade V',
     8861, 1, 64, 1, 500000000, 0,
     0, -1, -1, 20,
     20, 1, 1, @BLACK_ROSE_BAG_UPGRADE_USE,
     0, 1000, 1, 'Upgrades an empty 34-slot Bag of the Black Rose.',
     -1, 'item_black_rose_bag_upgrade', 0);

REPLACE INTO `item_template`
    (`entry`, `class`, `subclass`, `SoundOverrideSubclass`, `name`,
     `displayid`, `Quality`, `BuyCount`, `BuyPrice`, `SellPrice`,
     `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`,
     `RequiredLevel`, `maxcount`, `stackable`, `stat_type1`,
     `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`,
     `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`,
     `stat_value5`, `spellid_1`, `spelltrigger_1`, `spellcooldown_1`,
     `bonding`, `description`, `Material`, `socketColor_1`,
     `socketContent_1`, `socketColor_2`, `socketContent_2`,
     `socketColor_3`, `socketContent_3`, `socketBonus`, `VerifiedBuild`)
VALUES
    (@BLACK_ROSE_TRINKET, 4, 0, -1, 'The Black Rose',
     6483, 6, 1, 0, 0,
     12, -1, -1, 20,
     20, 0, 1, 5,
     5, 4, 5, 6,
     5, 3, 5, 7,
     20, @BLACK_ROSE_AURA, 0, 180000,
     1, 'Channels the power of the Black Rose, increasing socketed gem''s effectiveness by 250% for 20 seconds.',
     -1, 2, 0, 4, 0,
     8, 0, 0, 0);

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

REPLACE INTO `creature_template`
    (`entry`, `name`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`,
     `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`,
     `detection_range`, `rank`, `DamageModifier`, `BaseAttackTime`,
     `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`,
     `unit_flags`, `unit_flags2`, `type`, `MovementType`, `HoverHeight`,
     `HealthModifier`, `ManaModifier`, `ArmorModifier`, `RegenHealth`,
     `ScriptName`, `VerifiedBuild`)
VALUES
    (@NORAH_HORDE, 'Norah Rose', 20, 20, 0, 35, 2,
     1, 1.14286, 1, 1,
     20, 0, 1, 2000,
     2000, 1, 1, 1,
     0, 2048, 7, 0, 1,
     1, 1, 1, 1,
     '', 0),
    (@NORAH_ALLIANCE, 'Norah Rose', 20, 20, 0, 35, 2,
     1, 1.14286, 1, 1,
     20, 0, 1, 2000,
     2000, 1, 1, 1,
     0, 2048, 7, 0, 1,
     1, 1, 1, 1,
     '', 0),
    (@ROSY, 'Rosy', 20, 20, 0, 35, 129,
     1, 1.14286, 1, 1,
     20, 0, 1, 2000,
     2000, 1, 1, 1,
     0, 2048, 7, 0, 1,
     1, 1, 1, 1,
     'npc_black_rose_rosy', 0);

REPLACE INTO `creature_template_model`
    (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`,
     `Probability`, `VerifiedBuild`)
VALUES
    (@NORAH_HORDE, 0, 16695, 1, 1, 0),
    (@NORAH_ALLIANCE, 0, 14615, 1, 1, 0),
    (@ROSY, 0, 617, 1, 1, 0);

REPLACE INTO `creature`
    (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`,
     `position_x`, `position_y`, `position_z`, `orientation`,
     `spawntimesecs`, `wander_distance`, `MovementType`, `npcflag`,
     `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`,
     `CreateObject`, `Comment`)
VALUES
    (@NORAH_CGUID + 0, @NORAH_HORDE, 1, 1, 1, 0,
     1566.3, -4396.58, 7.36, 3.316,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Orgrimmar'),
    (@NORAH_CGUID + 1, @NORAH_HORDE, 0, 1, 1, 0,
     1553.8, 246, -43.1, 6.269,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Undercity'),
    (@NORAH_CGUID + 2, @NORAH_HORDE, 1, 1, 1, 0,
     -1254.5, 67, 127.5, 0.747,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Thunder Bluff'),
    (@NORAH_CGUID + 3, @NORAH_HORDE, 530, 1, 1, 0,
     9402.9, -7261.7, 14.19, 3.94,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Silvermoon'),
    (@NORAH_CGUID + 4, @NORAH_ALLIANCE, 0, 1, 1, 0,
     -8875.28, 598, 93.5, 4.6,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Stormwind'),
    (@NORAH_CGUID + 5, @NORAH_ALLIANCE, 1, 1, 1, 0,
     9948.4, 2491.7, 1317.1, 4.72,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Darnassus'),
    (@NORAH_CGUID + 6, @NORAH_ALLIANCE, 0, 1, 1, 0,
     -4913.5, -976.3, 501.5, 2.09,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Ironforge'),
    (@NORAH_CGUID + 7, @NORAH_ALLIANCE, 530, 1, 1, 0,
     -4006.3, -11846, 0.175, 4.693,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Norah Rose - Exodar'),
    (@ROSY_CGUID + 0, @ROSY, 1, 1, 1, 0,
     1567.5, -4395.4, 7.36, 3.316,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Orgrimmar'),
    (@ROSY_CGUID + 1, @ROSY, 0, 1, 1, 0,
     1555, 247.2, -43.1, 6.269,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Undercity'),
    (@ROSY_CGUID + 2, @ROSY, 1, 1, 1, 0,
     -1253.3, 68.2, 127.5, 0.747,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Thunder Bluff'),
    (@ROSY_CGUID + 3, @ROSY, 530, 1, 1, 0,
     9404.1, -7260.5, 14.19, 3.94,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Silvermoon'),
    (@ROSY_CGUID + 4, @ROSY, 0, 1, 1, 0,
     -8874.1, 599.2, 93.5, 4.6,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Stormwind'),
    (@ROSY_CGUID + 5, @ROSY, 1, 1, 1, 0,
     9949.6, 2492.9, 1317.1, 4.72,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Darnassus'),
    (@ROSY_CGUID + 6, @ROSY, 0, 1, 1, 0,
     -4912.3, -975.1, 501.5, 2.09,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Ironforge'),
    (@ROSY_CGUID + 7, @ROSY, 530, 1, 1, 0,
     -4005.1, -11844.8, 0.175, 4.693,
     120, 0, 0, 0,
     0, 0, '', 0,
     0, 'Rosy - Exodar');

REPLACE INTO `quest_template`
    (`ID`, `QuestType`, `QuestLevel`, `MinLevel`, `RewardXPDifficulty`,
     `RewardMoney`, `RewardMoneyDifficulty`, `RewardItem1`, `RewardAmount1`,
     `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`,
     `AllowableRaces`, `LogTitle`, `LogDescription`, `QuestDescription`,
     `QuestCompletionLog`, `VerifiedBuild`)
VALUES
    (@QUEST_ALLIANCE, 2, 20, 20, 1,
     50000, 0, @BAG_26, 1,
     44223, 1, @BLACK_ROSE_TRINKET, 1,
     1101, 'The Black Rose',
     'Speak with Norah Rose to receive the Black Rose''s gift.',
     'The Black Rose has watched your steps with interest, $N. You have '
     'reached the point where the road opens before you.$B$BIf you are ready, '
     'accept this token of our regard: a satchel marked with the black rose, '
     'and a set of reins to carry you farther than your own feet alone.',
     'Return to Norah Rose.', 0),
    (@QUEST_HORDE, 2, 20, 20, 1,
     50000, 0, @BAG_26, 1,
     44224, 1, @BLACK_ROSE_TRINKET, 1,
     690, 'The Black Rose',
     'Speak with Norah Rose to receive the Black Rose''s gift.',
     'The Black Rose has watched your steps with interest, $N. You have '
     'reached the point where the road opens before you.$B$BIf you are ready, '
     'accept this token of our regard: a satchel marked with the black rose, '
     'and a set of reins to carry you farther than your own feet alone.',
     'Return to Norah Rose.', 0);

REPLACE INTO `quest_template_addon` (`ID`, `SpecialFlags`)
VALUES
    (@QUEST_ALLIANCE, 0),
    (@QUEST_HORDE, 0);

REPLACE INTO `quest_request_items`
    (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `CompletionText`,
     `VerifiedBuild`)
VALUES
    (@QUEST_ALLIANCE, 1, 0,
     'Are you ready to accept the Black Rose''s gift?', 0),
    (@QUEST_HORDE, 1, 0,
     'Are you ready to accept the Black Rose''s gift?', 0);

REPLACE INTO `quest_offer_reward`
    (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`,
     `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`,
     `VerifiedBuild`)
VALUES
    (@QUEST_ALLIANCE, 1, 0, 0, 0, 0,
     0, 0, 0,
     'Carry the Black Rose with you, $N. May it mark the beginning of a '
     'longer road and a swifter ride.', 0),
    (@QUEST_HORDE, 1, 0, 0, 0, 0,
     0, 0, 0,
     'Carry the Black Rose with you, $N. May it mark the beginning of a '
     'longer road and a swifter ride.', 0);

REPLACE INTO `creature_queststarter` (`id`, `quest`)
VALUES
    (@NORAH_ALLIANCE, @QUEST_ALLIANCE),
    (@NORAH_HORDE, @QUEST_HORDE);

REPLACE INTO `creature_questender` (`id`, `quest`)
VALUES
    (@NORAH_ALLIANCE, @QUEST_ALLIANCE),
    (@NORAH_HORDE, @QUEST_HORDE);

DELETE FROM `npc_vendor` WHERE `entry` = @ROSY;
REPLACE INTO `npc_vendor`
    (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`,
     `VerifiedBuild`)
VALUES
    (@ROSY, 1, @UPGRADE_28, 0, 0, 0, 0),
    (@ROSY, 2, @UPGRADE_30, 0, 0, 0, 0),
    (@ROSY, 3, @UPGRADE_32, 0, 0, 0, 0),
    (@ROSY, 4, @UPGRADE_34, 0, 0, 0, 0),
    (@ROSY, 5, @UPGRADE_36, 0, 0, 0, 0);

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
    @ROSY, 300 + `family`.`id`,
    @YELLOW_GEM_BASE + `family`.`id` * 10, 0, 0, @PETAL_EXT_BASE, 0
FROM
    (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
     UNION ALL SELECT 3 UNION ALL SELECT 4) AS `family`;

DELETE FROM `conditions`
WHERE `SourceTypeOrReferenceId` = 23 AND `SourceGroup` = @ROSY;

REPLACE INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`,
     `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
     `ConditionValue1`, `ConditionValue2`, `ConditionValue3`,
     `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
    (23, @ROSY, @UPGRADE_28, 0,
     0, 2, 0,
     @BAG_26, 1, 0,
     0, 0, 0, '', 'Rosy sells upgrade I if the player has the 26-slot bag'),
    (23, @ROSY, @UPGRADE_30, 0,
     0, 2, 0,
     @BAG_28, 1, 0,
     0, 0, 0, '', 'Rosy sells upgrade II if the player has the 28-slot bag'),
    (23, @ROSY, @UPGRADE_32, 0,
     0, 2, 0,
     @BAG_30, 1, 0,
     0, 0, 0, '', 'Rosy sells upgrade III if the player has the 30-slot bag'),
    (23, @ROSY, @UPGRADE_34, 0,
     0, 2, 0,
     @BAG_32, 1, 0,
     0, 0, 0, '', 'Rosy sells upgrade IV if the player has the 32-slot bag'),
    (23, @ROSY, @UPGRADE_36, 0,
     0, 2, 0,
     @BAG_34, 1, 0,
     0, 0, 0, '', 'Rosy sells upgrade V if the player has the 34-slot bag');

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
     SELECT @YELLOW_GEM_BASE + `family`.`id` * 10
     FROM
        (SELECT 0 AS `id` UNION ALL SELECT 1 UNION ALL SELECT 2
         UNION ALL SELECT 3 UNION ALL SELECT 4) AS `family`) AS `vendor_items`;
