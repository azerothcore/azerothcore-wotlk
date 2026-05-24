-- ============================================================================
-- Black Rose module: DBC overrides + spell-script bindings
--
-- AzerothCore-side mirrors of the rows we ship via the client patch
-- (Spell.dbc, SpellDuration.dbc, SpellItemEnchantment.dbc,
-- GemProperties.dbc, ItemExtendedCost.dbc, QuestSort.dbc,
-- SkillLineAbility.dbc).
--
-- Companion to 2026_05_22_00_blackrose_data.sql, which holds the world
-- content (items, NPCs, quest, vendor, conditions). All inserts use
-- REPLACE INTO so re-running the file is idempotent.
--
-- Notable bakes-in (relative to the original incremental migration set):
--   * Spells 900900..900903 carry CastingTimeIndex = 1 and
--     EquippedItemClass = -1 from the start. With the old defaults
--     (CastingTimeIndex = 0, EquippedItemClass = 0) the cast-from-item
--     path failed server-side and the client rendered "The item was not
--     found" on every right-click of The Black Rose trinket.
--   * Spell 900903 (Rurik's Death Mobile) embeds the stock Mechano-hog
--     CreatureDisplayInfo ID directly into EffectMiscValue_1, so we
--     don't need a custom .m2 client asset.
--   * QuestSort.dbc row 9009 ("The Black Rose") is mirrored here so
--     quest_template.QuestSortID = -9009 resolves to a real header
--     instead of "Missing header!" in the in-game quest log.
-- ============================================================================

SET @BLACK_ROSE_AURA            := 900900;
SET @BLACK_ROSE_DURATION        := 900900;
SET @BLACK_ROSE_UPGRADE_USE     := 900901;
SET @BLACK_ROSE_BAG_UPGRADE_USE := 900902;
SET @BLACK_ROSE_MAULER_MOUNT    := 900903;
SET @BLACK_ROSE_SORT            := 9009;
SET @BLACK_MIASMA               := 900200;
SET @BLACK_PETALS               := 900201;
SET @MIA_EXT_BASE               := 900700;
SET @PETAL_EXT_BASE             := 900710;
SET @RED_GEM_BASE               := 900300;
SET @YELLOW_GEM_BASE            := 900400;
-- The mount visual reuses the stock 3.3.5a Mechano-hog. AC's
-- AuraEffect::HandleAuraMounted treats spell EffectMiscValue_1 as a
-- creature_template entry (NOT a CreatureDisplayInfo ID) and looks the
-- display up via creature_template_model at mount time. So we point at
-- the Mechano-hog creature directly.
SET @MECHANO_HOG_CREATURE       := 29929;

-- ----------------------------------------------------------------------------
-- Spell duration (custom 20s window for the trinket aura)
-- ----------------------------------------------------------------------------

REPLACE INTO `spellduration_dbc`
    (`ID`, `Duration`, `DurationPerLevel`, `MaxDuration`)
VALUES
    (@BLACK_ROSE_DURATION, 20000, 0, 20000);

-- ----------------------------------------------------------------------------
-- Spells (900900 trinket aura, 900901/2 upgrade triggers, 900903 mount)
-- ----------------------------------------------------------------------------

REPLACE INTO `spell_dbc`
    (`ID`, `Attributes`, `CastingTimeIndex`, `DurationIndex`, `RangeIndex`,
     `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`,
     `Effect_1`, `EffectDieSides_1`, `EffectBasePoints_1`,
     `ImplicitTargetA_1`, `EffectAura_1`, `SpellIconID`, `ActiveIconID`,
     `Name_Lang_enUS`, `Name_Lang_Mask`,
     `Description_Lang_enUS`, `Description_Lang_Mask`,
     `AuraDescription_Lang_enUS`, `AuraDescription_Lang_Mask`, `SchoolMask`)
VALUES
    (@BLACK_ROSE_AURA, 384, 1, @BLACK_ROSE_DURATION, 1,
     -1, 0, 0,
     6, 1, 0, 1, 4, 0, 0,
     'Power of the Black Rose', 1,
     'Increases Black Rose socketed gem effectiveness by 250%.', 1,
     'Black Rose socketed gem effectiveness increased by 250%.', 1, 1),
    (@BLACK_ROSE_UPGRADE_USE, 384, 1, 0, 1,
     -1, 0, 0,
     3, 1, 0, 1, 0, 0, 0,
     'Empower Black Rose Gem', 1,
     'Use to empower a socketed Black Rose gem.', 1,
     '', 0, 1),
    (@BLACK_ROSE_BAG_UPGRADE_USE, 384, 1, 0, 1,
     -1, 0, 0,
     3, 1, 0, 1, 0, 0, 0,
     'Upgrade Black Rose Bag', 1,
     'Use to upgrade an empty Bag of the Black Rose.', 1,
     '', 0, 1);

REPLACE INTO `spell_dbc`
    (`ID`, `Attributes`, `CastingTimeIndex`, `DurationIndex`, `RangeIndex`,
     `EquippedItemClass`, `EquippedItemSubclass`, `EquippedItemInvTypes`,
     `Effect_1`, `EffectDieSides_1`, `EffectBasePoints_1`,
     `ImplicitTargetA_1`, `EffectAura_1`, `EffectMiscValue_1`,
     `SpellIconID`, `ActiveIconID`, `Name_Lang_enUS`, `Name_Lang_Mask`,
     `Description_Lang_enUS`, `Description_Lang_Mask`,
     `AuraDescription_Lang_enUS`, `AuraDescription_Lang_Mask`, `SchoolMask`)
VALUES
    (@BLACK_ROSE_MAULER_MOUNT, 0, 1, 21, 1,
     -1, 0, 0,
     6, 1, 59, 1, 78, @MECHANO_HOG_CREATURE,
     0, 0, 'Rurik''s Death Mobile', 1,
     'Summons and dismisses a rideable Rurik''s Death Mobile.', 1,
     'Mounted.', 1, 1);

REPLACE INTO `skilllineability_dbc`
    (`ID`, `SkillLine`, `Spell`, `RaceMask`, `ClassMask`, `ExcludeRace`,
     `ExcludeClass`, `MinSkillLineRank`, `SupercededBySpell`,
     `AcquireMethod`, `TrivialSkillLineRankHigh`, `TrivialSkillLineRankLow`,
     `CharacterPoints_1`, `CharacterPoints_2`)
VALUES
    (@BLACK_ROSE_MAULER_MOUNT, 777, @BLACK_ROSE_MAULER_MOUNT,
     0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- ----------------------------------------------------------------------------
-- QuestSort header so quest_template.QuestSortID = -9009 displays as
-- "The Black Rose" instead of "Missing header!".
-- ----------------------------------------------------------------------------

REPLACE INTO `questsort_dbc`
    (`ID`, `SortName_Lang_enUS`, `SortName_Lang_Mask`)
VALUES
    (@BLACK_ROSE_SORT, 'The Black Rose', 1);

-- ----------------------------------------------------------------------------
-- Server-side spell script binding for the trinket aura
-- ----------------------------------------------------------------------------

DELETE FROM `spell_script_names` WHERE `spell_id` = @BLACK_ROSE_AURA;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES
    (@BLACK_ROSE_AURA, 'spell_black_rose_power');

-- ----------------------------------------------------------------------------
-- ItemExtendedCost rows for Rosy's gem purchases (Black Miasma for red,
-- Black Petals for yellow). Seven price tiers each.
-- ----------------------------------------------------------------------------

REPLACE INTO `itemextendedcost_dbc`
    (`ID`, `HonorPoints`, `ArenaPoints`, `ArenaBracket`, `ItemID_1`,
     `ItemID_2`, `ItemID_3`, `ItemID_4`, `ItemID_5`, `ItemCount_1`,
     `ItemCount_2`, `ItemCount_3`, `ItemCount_4`, `ItemCount_5`,
     `RequiredArenaRating`, `ItemPurchaseGroup`)
VALUES
    (@MIA_EXT_BASE + 0, 0, 0, 0, @BLACK_MIASMA, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0),
    (@MIA_EXT_BASE + 1, 0, 0, 0, @BLACK_MIASMA, 0, 0, 0, 0,
     10, 0, 0, 0, 0, 0, 0),
    (@MIA_EXT_BASE + 2, 0, 0, 0, @BLACK_MIASMA, 0, 0, 0, 0,
     50, 0, 0, 0, 0, 0, 0),
    (@MIA_EXT_BASE + 3, 0, 0, 0, @BLACK_MIASMA, 0, 0, 0, 0,
     500, 0, 0, 0, 0, 0, 0),
    (@MIA_EXT_BASE + 4, 0, 0, 0, @BLACK_MIASMA, 0, 0, 0, 0,
     1000, 0, 0, 0, 0, 0, 0),
    (@MIA_EXT_BASE + 5, 0, 0, 0, @BLACK_MIASMA, 0, 0, 0, 0,
     5000, 0, 0, 0, 0, 0, 0),
    (@MIA_EXT_BASE + 6, 0, 0, 0, @BLACK_MIASMA, 0, 0, 0, 0,
     10000, 0, 0, 0, 0, 0, 0),
    (@PETAL_EXT_BASE + 0, 0, 0, 0, @BLACK_PETALS, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0),
    (@PETAL_EXT_BASE + 1, 0, 0, 0, @BLACK_PETALS, 0, 0, 0, 0,
     10, 0, 0, 0, 0, 0, 0),
    (@PETAL_EXT_BASE + 2, 0, 0, 0, @BLACK_PETALS, 0, 0, 0, 0,
     50, 0, 0, 0, 0, 0, 0),
    (@PETAL_EXT_BASE + 3, 0, 0, 0, @BLACK_PETALS, 0, 0, 0, 0,
     500, 0, 0, 0, 0, 0, 0),
    (@PETAL_EXT_BASE + 4, 0, 0, 0, @BLACK_PETALS, 0, 0, 0, 0,
     1000, 0, 0, 0, 0, 0, 0),
    (@PETAL_EXT_BASE + 5, 0, 0, 0, @BLACK_PETALS, 0, 0, 0, 0,
     5000, 0, 0, 0, 0, 0, 0),
    (@PETAL_EXT_BASE + 6, 0, 0, 0, @BLACK_PETALS, 0, 0, 0, 0,
     10000, 0, 0, 0, 0, 0, 0);

-- ----------------------------------------------------------------------------
-- Gem enchantments: 9 red Ribbon families x 7 ranks + 5 yellow Mist
-- families x 7 ranks. Generated from the rank/family cross product.
-- ----------------------------------------------------------------------------

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
