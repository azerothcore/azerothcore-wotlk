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
VALUES
    (900300, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +2 strength when socketed.', -1, 900300, 0),
    (900301, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +22 strength when socketed.', -1, 900301, 0),
    (900302, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +42 strength when socketed.', -1, 900302, 0),
    (900303, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +62 strength when socketed.', -1, 900303, 0),
    (900304, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +82 strength when socketed.', -1, 900304, 0),
    (900305, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +102 strength when socketed.', -1, 900305, 0),
    (900306, 3, 0, -1, 'Stark Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +122 strength when socketed.', -1, 900306, 0),
    (900310, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +2 intellect when socketed.', -1, 900310, 0),
    (900311, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +22 intellect when socketed.', -1, 900311, 0),
    (900312, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +42 intellect when socketed.', -1, 900312, 0),
    (900313, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +62 intellect when socketed.', -1, 900313, 0),
    (900314, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +82 intellect when socketed.', -1, 900314, 0),
    (900315, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +102 intellect when socketed.', -1, 900315, 0),
    (900316, 3, 0, -1, 'Klug Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +122 intellect when socketed.', -1, 900316, 0),
    (900320, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +2 spirit when socketed.', -1, 900320, 0),
    (900321, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +22 spirit when socketed.', -1, 900321, 0),
    (900322, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +42 spirit when socketed.', -1, 900322, 0),
    (900323, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +62 spirit when socketed.', -1, 900323, 0),
    (900324, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +82 spirit when socketed.', -1, 900324, 0),
    (900325, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +102 spirit when socketed.', -1, 900325, 0),
    (900326, 3, 0, -1, 'Geist Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +122 spirit when socketed.', -1, 900326, 0),
    (900330, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +2 agility when socketed.', -1, 900330, 0),
    (900331, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +22 agility when socketed.', -1, 900331, 0),
    (900332, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +42 agility when socketed.', -1, 900332, 0),
    (900333, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +62 agility when socketed.', -1, 900333, 0),
    (900334, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +82 agility when socketed.', -1, 900334, 0),
    (900335, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +102 agility when socketed.', -1, 900335, 0),
    (900336, 3, 0, -1, 'Schnell Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +122 agility when socketed.', -1, 900336, 0),
    (900340, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +2 stamina when socketed.', -1, 900340, 0),
    (900341, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +22 stamina when socketed.', -1, 900341, 0),
    (900342, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +42 stamina when socketed.', -1, 900342, 0),
    (900343, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +62 stamina when socketed.', -1, 900343, 0),
    (900344, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +82 stamina when socketed.', -1, 900344, 0),
    (900345, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +102 stamina when socketed.', -1, 900345, 0),
    (900346, 3, 0, -1, 'Fett Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +122 stamina when socketed.', -1, 900346, 0),
    (900350, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +1 strength and +1 stamina when socketed.', -1, 900350, 0),
    (900351, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +11 strength and +11 stamina when socketed.', -1, 900351, 0),
    (900352, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +21 strength and +21 stamina when socketed.', -1, 900352, 0),
    (900353, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +31 strength and +31 stamina when socketed.', -1, 900353, 0),
    (900354, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +41 strength and +41 stamina when socketed.', -1, 900354, 0),
    (900355, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +51 strength and +51 stamina when socketed.', -1, 900355, 0),
    (900356, 3, 0, -1, 'Gross Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +61 strength and +61 stamina when socketed.', -1, 900356, 0),
    (900360, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +1 intellect and +1 spirit when socketed.', -1, 900360, 0),
    (900361, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +11 intellect and +11 spirit when socketed.', -1, 900361, 0),
    (900362, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +21 intellect and +21 spirit when socketed.', -1, 900362, 0),
    (900363, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +31 intellect and +31 spirit when socketed.', -1, 900363, 0),
    (900364, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +41 intellect and +41 spirit when socketed.', -1, 900364, 0),
    (900365, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +51 intellect and +51 spirit when socketed.', -1, 900365, 0),
    (900366, 3, 0, -1, 'Spinnst Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +61 intellect and +61 spirit when socketed.', -1, 900366, 0),
    (900370, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +1 strength and +1 agility when socketed.', -1, 900370, 0),
    (900371, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +11 strength and +11 agility when socketed.', -1, 900371, 0),
    (900372, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +21 strength and +21 agility when socketed.', -1, 900372, 0),
    (900373, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +31 strength and +31 agility when socketed.', -1, 900373, 0),
    (900374, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +41 strength and +41 agility when socketed.', -1, 900374, 0),
    (900375, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +51 strength and +51 agility when socketed.', -1, 900375, 0),
    (900376, 3, 0, -1, 'Scharf Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +61 strength and +61 agility when socketed.', -1, 900376, 0),
    (900380, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +1 intellect and +1 stamina when socketed.', -1, 900380, 0),
    (900381, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +11 intellect and +11 stamina when socketed.', -1, 900381, 0),
    (900382, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +21 intellect and +21 stamina when socketed.', -1, 900382, 0),
    (900383, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +31 intellect and +31 stamina when socketed.', -1, 900383, 0),
    (900384, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +41 intellect and +41 stamina when socketed.', -1, 900384, 0),
    (900385, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +51 intellect and +51 stamina when socketed.', -1, 900385, 0),
    (900386, 3, 0, -1, 'Weise Ribbon', 58601, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +61 intellect and +61 stamina when socketed.', -1, 900386, 0),
    (900400, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +6 spell power when socketed.', -1, 900400, 0),
    (900401, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +26 spell power when socketed.', -1, 900401, 0),
    (900402, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +86 spell power when socketed.', -1, 900402, 0),
    (900403, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +126 spell power when socketed.', -1, 900403, 0),
    (900404, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +166 spell power when socketed.', -1, 900404, 0),
    (900405, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +206 spell power when socketed.', -1, 900405, 0),
    (900406, 3, 2, -1, 'Pouvoir Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +246 spell power when socketed.', -1, 900406, 0),
    (900410, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +6 attack power when socketed.', -1, 900410, 0),
    (900411, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +26 attack power when socketed.', -1, 900411, 0),
    (900412, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +86 attack power when socketed.', -1, 900412, 0),
    (900413, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +126 attack power when socketed.', -1, 900413, 0),
    (900414, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +166 attack power when socketed.', -1, 900414, 0),
    (900415, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +206 attack power when socketed.', -1, 900415, 0),
    (900416, 3, 2, -1, 'Douleur Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +246 attack power when socketed.', -1, 900416, 0),
    (900420, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +6 crit rating when socketed.', -1, 900420, 0),
    (900421, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +26 crit rating when socketed.', -1, 900421, 0),
    (900422, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +86 crit rating when socketed.', -1, 900422, 0),
    (900423, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +126 crit rating when socketed.', -1, 900423, 0),
    (900424, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +166 crit rating when socketed.', -1, 900424, 0),
    (900425, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +206 crit rating when socketed.', -1, 900425, 0),
    (900426, 3, 2, -1, 'Pointe Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +246 crit rating when socketed.', -1, 900426, 0),
    (900430, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +6 haste rating when socketed.', -1, 900430, 0),
    (900431, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +26 haste rating when socketed.', -1, 900431, 0),
    (900432, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +86 haste rating when socketed.', -1, 900432, 0),
    (900433, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +126 haste rating when socketed.', -1, 900433, 0),
    (900434, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +166 haste rating when socketed.', -1, 900434, 0),
    (900435, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +206 haste rating when socketed.', -1, 900435, 0),
    (900436, 3, 2, -1, 'Vitesse Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +246 haste rating when socketed.', -1, 900436, 0),
    (900440, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +10 mana per 5 seconds when socketed.', -1, 900440, 0),
    (900441, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +25 mana per 5 seconds when socketed.', -1, 900441, 0),
    (900442, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +50 mana per 5 seconds when socketed.', -1, 900442, 0),
    (900443, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +75 mana per 5 seconds when socketed.', -1, 900443, 0),
    (900444, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +200 mana per 5 seconds when socketed.', -1, 900444, 0),
    (900445, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +325 mana per 5 seconds when socketed.', -1, 900445, 0),
    (900446, 3, 2, -1, 'Restaurer Mist', 54318, 4, 1, 0, 0, 0, -1, -1, 20, 20, 1, 1, 1, 'Grants The Black Rose +525 mana per 5 seconds when socketed.', -1, 900446, 0);

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
